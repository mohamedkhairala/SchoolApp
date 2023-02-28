#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Students
    Inherits System.Web.UI.Page
#Region "Global Variable"
    Dim SchoolId As String = "1"
    Dim UserID As String = "0"
    Dim _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region

#Region "Page load"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            If Page.IsPostBack = False Then
                FillGrid(sender, e)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

#End Region

#Region "Fill Grid"

    ''' <summary>
    ''' Fill gridview with data from tblCandidates.
    ''' </summary>
    Sub FillGrid(sender As Object, e As EventArgs)
        Try
            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Students where " + CollectConditions() + "")
            If dtTable.Rows.Count > 0 Then
                ' Initialize the sorting expression.
                If SortExpression.Value = String.Empty Then
                    SortExpression.Value = "Id ASC"
                End If
                ' Populate the GridView.
                ' Convert the DataTable to DataView.
                Dim dv As New DataView(dtTable)

                ' Set the sort column and sort order.
                dv.Sort = SortExpression.Value.ToString()

                ' Bind the GridView control.
                lvMaster.DataSource = dv
                lvMaster.DataBind()
            Else
                lvMaster.DataSource = Nothing
                lvMaster.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    ''' <summary>
    ''' Collect condition string to fill grid
    ''' </summary>
    Public Function CollectConditions() As String
        Dim result As String = "1=1"
        Try
            Dim Search As String = IIf(txtSearch.Text = "", "1=1", " (Code Like '%" + txtSearch.Text + "%' or Name Like '%" + txtSearch.Text + "%' or GroupName Like '%" + txtSearch.Text + "%')")
            Return Search
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

#Region "Delete"
    ''' <summary>
    ''' Handle Click Delete 
    ''' </summary>
    Protected Sub Delete(sender As Object, e As EventArgs)
        Try
            Dim StudentId = Val(CType(sender.parent.FindControl("lblStudentId"), Label).Text)
            Dim ParentId = Val(CType(sender.parent.FindControl("lblParentId"), Label).Text)
            Dim str As String = "Update TblStudents Set isDeleted=1, DeletedBy ='" & UserID & "',DeletedDate=GetDate() where ID=" & StudentId & ";"
            str += "update TblParents set IsDeleted = 1, DeletedBy = '" & UserID & "', DeletedDate = GetDate() where  ID = " & ParentId & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                ShowErrorMessgage(lblRes, "حدث خطأ", Me)
                Exit Sub
            End If
            ShowMessage(lblRes, MessageTypesEnum.Delete, Me)
            FillGrid(sender, e)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
End Class
