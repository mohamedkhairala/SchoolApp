#Region "Import"

Imports System.Data
Imports clsMessages
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer
Imports System.Activities.Expressions
Imports System.IdentityModel.Protocols.WSTrust
Imports System.Web.Services.Description




#End Region

Partial Class SessionsList
    Inherits Page

#Region "Global Variable"

    Dim School_ID As String = "1"
    Dim UserID As String = "0"

#End Region

#Region "Page load"

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = PublicFunctions.GetUserId(Me)
            If Page.IsPostBack = False Then
                'Permissions.CheckPermisions(New GridView, New LinkButton, New TextBox, New LinkButton, Me.Page, UserID)

                clsBindDDL.BindCustomDDLs("Select Id,CourseName + ' - ' + Code + ' - ' + Name as groupCodeName from vw_Groups", "groupCodeName", "ID", ddlGroups, True)
                clsBindDDL.BindLookupDDLs("SessionStatus", ddlStatus, True, "All")
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

            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Sessions where " & CollectConditions() & "")
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
                lvMaster.DataSource = New DataTable
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
            Dim Search As String = IIf(txtSearch.Text = "", "1 = 1", " (Title like '%" & txtSearch.Text & "%' or CourseCode Like '%" & txtSearch.Text & "%' or CourseName Like '%" & txtSearch.Text & "%' or TeacherCode Like '%" & txtSearch.Text & "%' or TeacherName Like '%" & txtSearch.Text & "%' or SupervisorCode Like '%" & txtSearch.Text & "%' or SupervisorName Like '%" & txtSearch.Text & "%')")
            Dim Group As String = IIf(ddlGroups.SelectedValue = "0", "1<>1", "GroupId='" & ddlGroups.SelectedValue & "'")
            Dim Status As String = IIf(ddlStatus.SelectedValue = "0", "1=1", "Status='" & ddlStatus.SelectedValue & "'")
            Dim DateFrom As String = IIf(txtFilterFromDate.Text = "", "1=1", "  IssueDate >= '" + PublicFunctions.DateFormat(txtFilterFromDate.Text, "yyyy/MM/dd") + " 00:00:00'")
            Dim DateTo As String = IIf(txtFilterToDate.Text = "", "1=1", "  IssueDate <= '" + PublicFunctions.DateFormat(txtFilterToDate.Text, "yyyy/MM/dd") + " 23:59:59'")

            Return Search & " and " & Group & " and " & DateFrom & " and " & DateTo & " and " & Status
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Protected Sub Clear(sender As Object, e As EventArgs)
        txtFilterFromDate.Text = ""
        txtFilterToDate.Text = ""
        ddlStatus.SelectedIndex = -1
        FillGrid(sender, e)
    End Sub

#End Region


#Region "Add"
    Protected Sub Add(sender As Object, e As EventArgs)
        Dim url = "Session.aspx?GroupId=" & ddlGroups.SelectedValue
        Response.Redirect(url)
    End Sub

    Protected Sub SelectGroup(sender As Object, e As EventArgs)
        'divAdd.Visible = ddlGroups.SelectedValue <> 0
    End Sub
#End Region


#Region "Permissions"
    Private Sub ListView_DataBound(sender As Object, e As EventArgs) Handles lvMaster.DataBound
        Try
            Permissions.CheckPermisions(lvMaster, New LinkButton, txtSearch, lbSearch, Me.Page, UserID)

            'D 'im dtLookupValues As DataTable = DBContext.Getdatatable("select Id,value from tblLookupValue where lookupId=(select top 1 ID from tbllookup where TYPE='SessionStatus') and (ISNULL(IsDeleted, 0) = 0)")

            For Each r In lvMaster.Items
                Dim Status As String = Val(DirectCast(r.FindControl("lblSessionStatus"), Label).Text)
                Dim ddlStatus As DropDownList = DirectCast(r.FindControl("ddlStatus"), DropDownList)
                clsBindDDL.BindLookupDDLs("SessionStatus", ddlStatus, False,,, , Status)
                ddlStatus.Enabled = Not PublicFunctions.BoolFormat(DirectCast(r.FindControl("lblHasAttendance"), Label).Text)
            Next
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

End Class