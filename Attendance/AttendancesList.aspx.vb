#Region "Import"

Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class AttendancesList
    Inherits Page

#Region "Global Variable"

    Dim School_ID As String = "1"
    Dim UserID As String = "0"
    ReadOnly _sqlconn As New SqlConnection(DBContext.GetConnectionString)

#End Region

#Region "Page load"

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = PublicFunctions.GetUserId(Page)
            If Page.IsPostBack = False Then
                FillGrid(sender, e)
            Else
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ScriptPostback", "ScriptPostback();", True)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

#End Region

#Region "Fill Grid"

    ' Fill gridview with data from tblCandidates.
    Sub FillGrid(sender As Object, e As EventArgs)
        Try
            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Attendance where " & CollectConditions() & "")
            If dtTable.Rows.Count > 0 Then
                ' Initialize the sorting expression.
                If SortExpression.Value = String.Empty Then
                    SortExpression.Value = "ID ASC"
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

    ' Collect condition string to fill grid
    Public Function CollectConditions() As String
        Dim result As String = "1 = 1"
        Try
            Dim Search As String = IIf(txtSearch.Text = "", "1 = 1", " (Course like '%" & txtSearch.Text & "%' or Group like '%" & txtSearch.Text & "%' or Session like '%" & txtSearch.Text & "%' or Teacher like '%" & txtSearch.Text & "%' or Supervisor like '%" & txtSearch.Text & "%')")
            Return Search
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Delete"

    ' Handle Click Delete
    Protected Sub Delete(sender As Object, e As EventArgs)
        Try
            Dim attendance_id = Val(CType(sender.parent.FindControl("lblAttendance"), Label).Text)
            Dim session_id = getValue("SessionID", "tblAttendance", attendance_id)
            Dim status_id As Integer = GetLookupID("SessionStatus", "Pending", School_ID)
            Dim str As String = "update TblAttendance set IsDeleted = 1, DeletedBy = '" & UserID & "', DeletedDate = getdate() where ID = " & attendance_id & ";"
            str &= "update TblAttendanceDetails set IsDeleted = 1, DeletedBy = '" & UserID & "', DeletedDate = getdate() where AttendanceID = " & attendance_id & ";"
            str &= "update TblSessions set Status = " & status_id & " where ID = " & session_id & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                ShowErrorMessgage(lblRes, "Error", Me)
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

    Private Sub ListView_DataBound(sender As Object, e As EventArgs) Handles lvMaster.DataBound
        Try
            Permissions.CheckPermisions(lvMaster, lbAdd, txtSearch, lbSearch, Me.Page, UserID)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

End Class