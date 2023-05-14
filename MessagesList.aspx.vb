#Region "Import"
Imports System.Activities.Expressions
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Dashboard
    Inherits System.Web.UI.Page
#Region "Global Variable"
    Dim SchoolId As String = "1"
    Dim UserID As String = "0"
    Dim isAdmin As Boolean = False
#End Region

#Region "Page load"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            isAdmin = True
            If Page.IsPostBack = False Then
                UserID = PublicFunctions.GetUserId(Page)
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
            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Messages where  " + CollectConditions() + "")
            If dtTable.Rows.Count > 0 Then
                ' Initialize the sorting expression.
                'If SortExpression.Value = String.Empty Then
                '    SortExpression.Value = "Id ASC"
                'End If
                ' Populate the GridView.
                ' Convert the DataTable to DataView.
                Dim dv As New DataView(dtTable)

                '' Set the sort column and sort order.
                'dv.Sort = SortExpression.Value.ToString()

                ' Bind the GridView control.
                rbMessages.DataSource = dv
                rbMessages.DataBind()
            Else
                rbMessages.DataSource = Nothing
                rbMessages.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    ''' <summary>
    ''' Collect condition string to fill grid
    ''' </summary>
    Public Function CollectConditions() As String
        Try
            Dim Search As String = IIf(txtSearch.Text = "", "1=1", " (MessageTitle Like '%" + txtSearch.Text + "%')")
            Dim Owner = IIf(isAdmin, "1=1", "(ReceiverId='" & UserID & "' Or SenderId='" & UserID & "')")
            Return Owner & " and " & Search
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region


#Region "Delete"
    ''' <summary>
    ''' Handle Click Delete 
    ''' </summary>
    Protected Sub Delete(sender As LinkButton, e As EventArgs)
        Try
            Dim MsgNo = sender.CommandArgument
            If Not clsNotifications.Delete(MsgNo) Then
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

#Region "Permissions"
    Private Sub ListView_DataBound(sender As Object, e As EventArgs) Handles rbMessages.DataBound
        Try
            'Permissions.CheckPermisions(rbMessages, New LinkButton, txtSearch, lbSearchIcon, Me.Page, UserID)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
End Class
