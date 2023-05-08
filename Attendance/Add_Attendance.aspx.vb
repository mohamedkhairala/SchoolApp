#Region "Import"

Imports System.Data
Imports clsMessages
Imports clsBindDDL
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer


#End Region

Partial Class Add_Attendance
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
            UserID = PublicFunctions.GetUserId(Page)
            'School_ID = PublicFunctions.GetClientId
            If Page.IsPostBack = False Then
                Permissions.CheckPermisions(New GridView, New LinkButton, New TextBox, New LinkButton, Me.Page, UserID)
                FillDDL()
                View()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillDDL()
        Try
            FillDropDownList(ddlCourseID, "select ID, (Code + ' - ' + Name) as Course from vw_Courses where SchoolID = " & School_ID & ";", "ID", "Course", True)
            FillDropDownList(ddlGroupID, "select ID, Name as [Group] from vw_Groups where SchoolID = " & School_ID & ";", "ID", "Group", True)
            FillDropDownList(ddlSessionID, "select ID, Title as Session from vw_Sessions where SchoolID = " & School_ID & ";", "ID", "Session", True)
            FillDropDownList(ddlTeacherID, "select ID, (Code + ' - ' + Name) as Teacher from vw_Teachers where SchoolID = " & School_ID & ";", "ID", "Teacher", True)
            FillDropDownList(ddlSupervisorID, "select ID, (Code + ' - ' + Name) as Supervisor from vw_Supervisors where SchoolID = " & School_ID & ";", "ID", "Supervisor", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Try
            If Not IsDate(txtDate.Text) Then
                ShowInfoMessgage(lblRes, "Date is not correct", Me)
                Return False
            End If
            If GetDecimalValue(txtActualPeriodHour.Text) = 0 Then
                ShowInfoMessgage(lblRes, "Period in Hours is not correct or can not be 0", Me)
                Return False
            End If
            Return True
        Catch ex As Exception
            Throw ex
        End Try
        Return False
    End Function

#End Region

#Region "Save"

    Protected Sub Save()
        Try
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblAttendanceFactory
            If lbSave.CommandArgument = "Add" Then
                Insert(da)
            ElseIf lbSave.CommandArgument = "Edit" Then
                Update(da, ID)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Sub Insert(da As TblAttendanceFactory)
        Try
            Dim dt As New TblAttendance
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
            If Not SaveStudents(dt.Id, _sqlconn, _sqltrans) Then
                ShowErrorMessgage(lblRes, "Error", Me)
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            Clear()
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Sub Update(da As TblAttendanceFactory, ID As String)
        Try
            Dim dt As TblAttendance = da.GetAllBy(TblAttendance.TblAttendanceFields.Id, ID).FirstOrDefault
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
            Dim daStudents As New TblAttendanceDetailsFactory
            daStudents.DeleteTrans(TblAttendanceDetails.TblAttendanceDetailsFields.AttendanceId, ID, _sqlconn, _sqltrans)
            If Not SaveStudents(ID, _sqlconn, _sqltrans) Then
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            ShowMessage(lblRes, MessageTypesEnum.Update, Page)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Function FillDT(dt As TblAttendance, Mode As String) As Boolean
        Try
            If Not IsValidForm() Then
                Return False
            End If
            dt.Date = txtDate.Text
            dt.SessionId = IntFormat(ddlSessionID.SelectedValue)
            dt.TeacherId = IntFormat(ddlTeacherID.SelectedValue)
            dt.SupervisorId = IntFormat(ddlSupervisorID.SelectedValue)
            dt.ActualPeriodHour = GetDecimalValue(txtActualPeriodHour.Text)
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            If Mode = "Add" Then
                'dt.CreatedBy = UserID
                dt.CreatedDate = DateTime.Now
            End If
            dt.SchoolId = School_ID
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

    Private Function SaveStudents(id As String, sqlconn As SqlConnection, sqltrans As SqlTransaction) As Boolean
        Try
            Dim dtDetails As New TblAttendanceDetails
            Dim daDetails As New TblAttendanceDetailsFactory
            For Each item As ListViewItem In lvStudents.Items
                dtDetails.AttendanceId = IntFormat(id)
                dtDetails.StudentId = IntFormat(CType(item.FindControl("lblStudentID"), Label).Text)
                dtDetails.IsAbsent = CType(item.FindControl("chkIsAttend"), CheckBox).Checked
                dtDetails.CreatedDate = DateTime.Now
                'dtDetails.CreatedBy = UserID
                dtDetails.SchoolId = School_ID
                If Not daDetails.InsertTrans(dtDetails, sqlconn, sqltrans) Then
                    ShowErrorMessgage(lblRes, "Insert Error", Me)
                    Return False
                End If
            Next
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
                Dim dt As DataTable = DBContext.Getdatatable("select * from vw_Attendance where ID = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                ' attendance master data
                txtDate.Text = CDate(dt.Rows(0).Item("Date")).ToShortDateString
                SetDDLValue(ddlCourseID, dt.Rows(0).Item("CourseID").ToString)
                SetDDLValue(ddlGroupID, dt.Rows(0).Item("GroupID").ToString)
                SetDDLValue(ddlSessionID, dt.Rows(0).Item("SessionID").ToString)
                txtActualPeriodHour.Text = dt.Rows(0).Item("Period").ToString
                SetDDLValue(ddlTeacherID, dt.Rows(0).Item("TeacherID").ToString)
                SetDDLValue(ddlSupervisorID, dt.Rows(0).Item("SupervisorID").ToString)
                ' students data
                dt = DBContext.Getdatatable("select * from vw_AttendanceDetails where AttendanceID = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count > 0 Then
                    lvStudents.DataSource = dt
                    lvStudents.DataBind()
                End If
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
        ' attendance master data
        txtDate.Text = String.Empty
        ddlCourseID.SelectedIndex = -1
        ddlGroupID.SelectedIndex = -1
        ddlSessionID.SelectedIndex = -1
        txtActualPeriodHour.Text = String.Empty
        ddlTeacherID.SelectedIndex = -1
        ddlSupervisorID.SelectedIndex = -1
    End Sub

#End Region

#Region "DDL Actions"

    Protected Sub SelectCourse(sender As Object, e As EventArgs)
        Try
            ddlGroupID.Items.Clear()
            If IntFormat(ddlCourseID.SelectedValue) = 0 Then
                FillDropDownList(ddlGroupID, "select 0 as ID, 'Please Select Group' as [Group] union select ID, Name as [Group] from vw_Groups where SchoolID = " & School_ID & ";", "ID", "Group", True)
            Else
                FillDropDownList(ddlGroupID, "select 0 as ID, 'Please Select Group' as [Group] union select ID, Name as [Group] from vw_Groups where CourseID = " & IntFormat(ddlCourseID.SelectedValue) & " and SchoolID = " & School_ID & ";", "ID", "Group", False)
            End If
            ddlGroupID.SelectedIndex = -1
            ddlSessionID.SelectedIndex = -1
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Protected Sub SelectGroup(sender As Object, e As EventArgs)
        Try
            ddlSessionID.Items.Clear()
            If IntFormat(ddlGroupID.SelectedValue) = 0 Then
                FillDropDownList(ddlSessionID, "select 0 as ID, 'Please Select Session' as [Session] union select ID, Title as Session from vw_Sessions where SchoolID = " & School_ID & ";", "ID", "Session", True)
            Else
                FillDropDownList(ddlSessionID, "select 0 as ID, 'Please Select Session' as [Session] union select ID, Title as Session from vw_Sessions where GroupID = " & IntFormat(ddlGroupID.SelectedValue) & " and SchoolID = " & School_ID & ";", "ID", "Session", False)
            End If
            Dim query As String = "select CourseID from vw_Groups where ID = " & IntFormat(ddlGroupID.SelectedValue) & " and SchoolID = " & School_ID & ";"
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count > 0 Then
                SetDDLValue(ddlCourseID, dt.Rows(0).Item("CourseID").ToString)
            End If
            ddlSessionID.SelectedIndex = -1
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Protected Sub SelectSession(sender As Object, e As EventArgs)
        Try
            ' fill master data
            Dim query As String = "select CourseID, GroupID, DefaultPeriodHour, TeacherID, SupervisorID from vw_Sessions " &
                "where ID = " & IntFormat(ddlSessionID.SelectedValue) & " and SchoolID = " & School_ID & ";"
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                Exit Sub
            End If
            SetDDLValue(ddlCourseID, dt.Rows(0).Item("CourseID").ToString)
            SetDDLValue(ddlGroupID, dt.Rows(0).Item("GroupID").ToString)
            txtActualPeriodHour.Text = dt.Rows(0).Item("DefaultPeriodHour").ToString
            SetDDLValue(ddlTeacherID, dt.Rows(0).Item("TeacherID").ToString)
            SetDDLValue(ddlSupervisorID, dt.Rows(0).Item("SupervisorID").ToString)
            ' fill details data
            query = "select *, 0 as AttendanceID, 0 as IsAbsent from vw_StudentsGroups where SchoolID = " & School_ID & " and GroupID = " & IntFormat(ddlGroupID.SelectedValue) & ";"
            dt = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                Exit Sub
            End If
            lvStudents.DataSource = dt
            lvStudents.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

#End Region

End Class