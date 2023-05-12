#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Student_Details
    Inherits System.Web.UI.Page
#Region "Global Variable"
    Dim SchoolId As String = "1"
    Dim UserID As String = "0"
    Dim FormQuery As String = "Select * from vw_Supervisors"


#End Region

#Region "Page load"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = PublicFunctions.GetUserId(Page)
            If Page.IsPostBack = False Then
                FillGrid(sender, e)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Sub FillGrid(sender As Object, e As EventArgs)
        Try
            Dim ID = Request.QueryString("ID")
            If Not IsNumeric(ID) Then
                Exit Sub
            End If
            Dim dtTable As DataTable = DBContext.Getdatatable(FormQuery & " where ID=" & ID)
            rpDetails.DataSource = dtTable
            rpDetails.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub rp_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles rpDetails.ItemDataBound
        Try
            If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim rbGroups As GridView = DirectCast(e.Item.FindControl("rpGroups"), GridView)
                Dim SupervisorId = Request.QueryString("ID")
                rbGroups.DataSource = DBContext.Getdatatable("Select Name,TeacherName,CourseName from vw_Groups where SupervisorId=" & SupervisorId)
                rbGroups.DataBind()
            End If

        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

#Region "Delete"
    ''' <summary>
    ''' Handle Click Delete 
    ''' </summary>
    Protected Sub Delete(sender As Object, e As EventArgs)
        Try
            Dim SupervisorId = Request.QueryString("ID")

            If Not SupervisorService.DeleteSupervisor(SupervisorId) Then
                ShowErrorMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            'Dim ParentId = Val(CType(sender.parent.FindControl("lblParentId"), Label).Text)
            'Dim str As String = "Update TblStudents Set isDeleted=1, DeletedBy ='" & UserID & "',DeletedDate=GetDate() where ID=" & StudentId & ";"
            ''str += "update TblParents set IsDeleted = 1, DeletedBy = '" & UserID & "', DeletedDate = GetDate() where  ID = " & ParentId & ";"
            'If DBContext.ExcuteQuery(str) < 1 Then
            '    ShowErrorMessgage(lblRes, "حدث خطأ", Me)
            '    Exit Sub
            'End If
            ShowMessage(lblRes, MessageTypesEnum.Delete, Me)
            Response.Redirect("SupervisorsList.aspx")
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

#Region "Permissions"
    Private Sub ListView_DataBound(sender As Object, e As EventArgs) Handles rpDetails.DataBound
        Try
            Permissions.CheckPermisions(rpDetails, New LinkButton, New TextBox, New LinkButton, Me.Page, "Supervisor", UserID)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
End Class
