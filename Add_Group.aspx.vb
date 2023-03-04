#Region "Import"

Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class Add_Group
    Inherits Page

#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_ID As String = "1"
    ReadOnly _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region

#Region "Page load"

    ' Handle page_load event
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            'UserId = PublicFunctions.GetUserId(Page)
            'School_ID = PublicFunctions.GetClientId
            If Page.IsPostBack = False Then
                FillDDL()
                View()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillDDL()
        Try
            FillDropDownList(ddlCourseID, "select ID, (Code + ' - ' + Name) as Course from tblCourses where isnull(IsDeleted, 0) = 0 and SchoolID = " & School_ID & ";", "ID", "Course", True)
            FillDropDownList(ddlTeacherID, "select ID, (Code + ' - ' + Name) as Teacher from tblTeachers where isnull(IsDeleted, 0) = 0 and SchoolID = " & School_ID & ";", "ID", "Teacher", True)
            FillDropDownList(ddlSupervisorID, "select ID, (Code + ' - ' + Name) as Supervisor from tblSupervisors where isnull(IsDeleted, 0) = 0 and SchoolID = " & School_ID & ";", "ID", "Supervisor", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Return True
    End Function

#End Region

#Region "Save"

    Protected Sub Save()
        Try
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblGroupsFactory
            Dim dt As New TblGroups
            If lbSave.CommandArgument = "Add" Then
                Insert(da, dt)
            ElseIf lbSave.CommandArgument = "Edit" Then
                Update(da, dt, ID)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub Insert(da As TblGroupsFactory, dt As TblGroups)
        Try
            If Not FillDT(dt, "Add") Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            _sqlconn.Open()
            _sqltrans = _sqlconn.BeginTransaction()
            If Not da.InsertTrans(dt, _sqlconn, _sqltrans) Then
                ShowInfoMessgage(lblRes, "Error", Me)
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            Clear()
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub Update(da As TblGroupsFactory, dt As TblGroups, ID As String)
        Try
            dt = da.GetAllBy(TblGroups.TblGroupsFields.Id, ID).FirstOrDefault
            If dt Is Nothing Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            If Not FillDT(dt, "Edit") Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            _sqlconn.Open()
            _sqltrans = _sqlconn.BeginTransaction()
            If Not da.UpdateTrans(dt, _sqlconn, _sqltrans) Then
                ShowInfoMessgage(lblRes, "Error", Me)
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            ShowMessage(lblRes, MessageTypesEnum.Update, Page)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Function FillDT(dt As TblGroups, Mode As String) As Boolean
        Try
            If Not IsValidForm() Then
                Return False
            End If
            dt.Name = txtName.Text.Trim
            dt.CourseId = IntFormat(ddlCourseID.SelectedValue)
            dt.TeacherId = IntFormat(ddlTeacherID.SelectedValue)
            dt.SupervisorId = IntFormat(ddlSupervisorID.SelectedValue)
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            If Mode = "Add" Then
                dt.CreatedBy = UserID
                dt.CreatedDate = DateTime.Now
            End If
            dt.SchoolId = School_ID
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

#End Region

#Region "View"

    Protected Sub View()
        Try
            Dim Mode As String = Request.QueryString("Mode")
            Dim ID As String = Request.QueryString("ID")
            If (Mode = "View" Or Mode = "Edit") And IsNumeric(ID) Then
                Dim dt As DataTable = DBContext.Getdatatable("select * from vw_Groups where ID = '" & ID & "' and SchoolID = '" & School_ID & "'")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                txtName.Text = dt.Rows(0).Item("Name").ToString
                ddlCourseID.SelectedValue = dt.Rows(0).Item("CourseID").ToString
                ddlTeacherID.SelectedValue = dt.Rows(0).Item("TeacherID").ToString
                ddlSupervisorID.SelectedValue = dt.Rows(0).Item("SupervisorID").ToString
                lbSave.CommandArgument = "Edit"
                pnlForm.Enabled = Mode = "Edit"
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Cancel"

    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("Dashboard.aspx")
    End Sub

    Protected Sub Clear()
        txtName.Text = String.Empty
        ddlCourseID.SelectedIndex = -1
        ddlTeacherID.SelectedIndex = -1
        ddlSupervisorID.SelectedIndex = -1
    End Sub

#End Region

End Class