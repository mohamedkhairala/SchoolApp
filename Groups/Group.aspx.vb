#Region "Import"

Imports clsBindDDL
Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class Group
    Inherits Page

#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_ID As String = "1"
    ReadOnly _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction
    Dim lstSessions As New List(Of TblSessions)
    Dim lstStudents As New List(Of TblStudentsGroups)

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
            FillDropDownList(ddlTeacherID, "select ID, (Code + ' - ' + Name) as Teacher from vw_Teachers where SchoolID = " & School_ID & ";", "ID", "Teacher", True)
            FillDropDownList(ddlSupervisorID, "select ID, (Code + ' - ' + Name) as Supervisor from vw_Supervisors where SchoolID = " & School_ID & ";", "ID", "Supervisor", True)
            FillDropDownList(ddlStudentID, "select ID, (Code + ' - ' + Name) as Student from tblStudents where isnull(IsDeleted, 0) = 0 and SchoolID = " & School_ID & ";", "ID", "Student", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Try
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

#End Region

#Region "Save"

    Protected Sub Save()
        Try
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblGroupsFactory
            If lbSave.CommandArgument = "Add" Then
                Insert(da)
            ElseIf lbSave.CommandArgument = "Edit" Then
                Update(da, ID)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Sub Insert(da As TblGroupsFactory)
        Try
            Dim dt As New TblGroups
            If Not FillDT(dt, "Add") Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            If Not IsCodeUnique("tblGroups", "Code", Val(dt.Id), dt.Code, School_ID) Then
                ShowInfoMessgage(lblRes, "Code is not unique", Me)
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
            If Not SaveSessions(dt.Id, _sqlconn, _sqltrans) Then
                ShowErrorMessgage(lblRes, "Error", Me)
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

    Private Sub Update(da As TblGroupsFactory, ID As String)
        Try
            Dim dt As TblGroups = da.GetAllBy(TblGroups.TblGroupsFields.Id, ID).FirstOrDefault
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
            Dim daSessions As New TblSessionsFactory
            daSessions.DeleteTrans(TblSessions.TblSessionsFields.GroupId, ID, _sqlconn, _sqltrans)
            If Not SaveSessions(ID, _sqlconn, _sqltrans) Then
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            Dim daStudents As New TblStudentsGroupsFactory
            daStudents.DeleteTrans(TblStudentsGroups.TblStudentsGroupsFields.GroupId, ID, _sqlconn, _sqltrans)
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

    Private Function FillDT(dt As TblGroups, Mode As String) As Boolean
        Try
            If Not IsValidForm() Then
                Return False
            End If
            dt.Code = txtGroupCode.Text.Trim
            dt.Name = txtName.Text.Trim
            dt.CourseId = IntFormat(ddlCourseID.SelectedValue)
            dt.TeacherId = IntFormat(ddlTeacherID.SelectedValue)
            dt.TeacherRate = GetDecimalValue(txtTeacherRate.Text)
            dt.SupervisorId = IntFormat(ddlSupervisorID.SelectedValue)
            dt.SupervisorRate = GetDecimalValue(txtSupervisorRate.Text)
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            dt.IsDeleted = False
            dt.SchoolId = School_ID
            If Mode = "Add" Then
                dt.Code = GenerateCode.GenerateCodeFor(Stackholders.Group)
                dt.CreatedBy = UserID
                dt.CreatedDate = DateTime.Now
            End If
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

    Private Function SaveSessions(id As String, sqlconn As SqlConnection, sqltrans As SqlTransaction) As Boolean
        Try
            Dim new_session_id As Integer = 0
            Dim dt As DataTable = DBContext.GetdatatableTrans("select (max(ID) + 1) as NewID from tblSessions;", sqlconn, sqltrans)
            If dt.Rows.Count > 0 Then
                new_session_id = IntFormat(dt.Rows(0).Item("NewID").ToString)
            End If
            Dim dtDetails As New TblSessions
            Dim daDetails As New TblSessionsFactory
            For Each item As ListViewItem In lvSessions.Items
                dtDetails.GroupId = id
                dtDetails.Code = GenerateCode.GenerateCodeFor(Stackholders.Session, new_session_id, sqlconn, _sqltrans)
                dtDetails.Title = CType(item.FindControl("txtTitle"), TextBox).Text
                dtDetails.IssueDate = CType(item.FindControl("txtIssueDate"), TextBox).Text
                dtDetails.DefaultPeriodHour = GetDecimalValue(CType(item.FindControl("txtDefaultPeriodHour"), TextBox).Text)
                dtDetails.Remarks = CType(item.FindControl("txtRemarks"), TextBox).Text
                dtDetails.Status = IntFormat(CType(item.FindControl("lblStatus"), Label).Text)
                dtDetails.StatusRemarks = CType(item.FindControl("lblStatusRemarks"), Label).Text
                dtDetails.CreatedDate = DateTime.Now
                dtDetails.CreatedBy = UserID
                dtDetails.IsDeleted = False
                dtDetails.SchoolId = School_ID
                If Not daDetails.InsertTrans(dtDetails, sqlconn, sqltrans) Then
                    ShowErrorMessgage(lblRes, "Insert Error", Me)
                    Return False
                End If
                new_session_id += 1
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Function SaveStudents(id As String, sqlconn As SqlConnection, sqltrans As SqlTransaction) As Boolean
        Try
            Dim dtDetails As New TblStudentsGroups
            Dim daDetails As New TblStudentsGroupsFactory
            For Each item As ListViewItem In lvStudents.Items
                dtDetails.GroupId = id
                dtDetails.StudentId = IntFormat(CType(item.FindControl("lblStudentID"), Label).Text)
                dtDetails.CoursePrice = GetDecimalValue(CType(item.FindControl("txtCoursePrice"), TextBox).Text)
                dtDetails.DiscountRate = GetDecimalValue(CType(item.FindControl("txtDiscountRate"), TextBox).Text)
                dtDetails.DiscountAmount = GetDecimalValue(CType(item.FindControl("lblDiscountAmount"), Label).Text)
                dtDetails.NetAmount = GetDecimalValue(CType(item.FindControl("lblNetAmount"), Label).Text)
                dtDetails.DiscountReason = CType(item.FindControl("txtDiscountReason"), TextBox).Text
                dtDetails.CreatedDate = DateTime.Now
                dtDetails.CreatedBy = UserID
                dtDetails.IsDeleted = False
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
                Dim dt As DataTable = DBContext.Getdatatable("select * from vw_Groups where ID = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                ' group data
                txtGroupCode.Text = dt.Rows(0).Item("Code").ToString
                txtName.Text = dt.Rows(0).Item("Name").ToString
                SetDDLValue(ddlCourseID, dt.Rows(0).Item("CourseID").ToString)
                SetDDLValue(ddlTeacherID, dt.Rows(0).Item("TeacherID").ToString)
                txtTeacherRate.Text = DecimalFormat(dt.Rows(0).Item("TeacherRate").ToString)
                SetDDLValue(ddlSupervisorID, dt.Rows(0).Item("SupervisorID").ToString)
                txtSupervisorRate.Text = DecimalFormat(dt.Rows(0).Item("SupervisorRate").ToString)
                ' sessions data
                dt = DBContext.Getdatatable("select * from vw_Sessions where GroupID = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count > 0 Then
                    lvSessions.DataSource = dt
                    lvSessions.DataBind()
                End If
                ' students data
                dt = DBContext.Getdatatable("select * from vw_StudentsGroups where GroupID = '" & ID & "' and SchoolID = '" & School_ID & "';")
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
        Response.Redirect("~/Dashboard.aspx")
    End Sub

    Protected Sub Clear()
        ' group data
        txtGroupCode.Text = String.Empty
        txtName.Text = String.Empty
        ddlCourseID.SelectedIndex = -1
        hfCourseFees.Value = String.Empty
        ddlTeacherID.SelectedIndex = -1
        txtTeacherRate.Text = String.Empty
        ddlSupervisorID.SelectedIndex = -1
        txtSupervisorRate.Text = String.Empty
        ' session data
        txtTitle.Text = String.Empty
        txtIssueDate.Text = String.Empty
        txtDefaultPeriodHour.Text = String.Empty
        txtRemarks.Text = String.Empty
        hfSessionIndex.Value = String.Empty
        lvSessions.DataSource = New DataTable
        lvSessions.DataBind()
        ' student data
        ddlStudentID.SelectedIndex = -1
        hfStudentIndex.Value = String.Empty
        lvStudents.DataSource = New DataTable
        lvStudents.DataBind()
    End Sub

#End Region

#Region "Course"

    Protected Sub SelectCourse(sender As Object, e As EventArgs)
        Try
            Dim query As String = "select NoOfSessions, Fees from vw_Courses where SchoolID = " & School_ID & " and ID = " & IntFormat(ddlCourseID.SelectedValue) & ";"
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                Exit Sub
            End If
            hfCourseFees.Value = GetDecimalValue(dt.Rows(0).Item("Fees").ToString)
            txtCoursePrice.Text = hfCourseFees.Value
            lstSessions = New List(Of TblSessions)
            Dim session As New TblSessions
            Dim group_id As Integer = IntFormat(Request.QueryString("ID"))
            Dim status_id As Integer = GetLookupID("SessionStatus", "Pending", School_ID)
            For index = 1 To IntFormat(dt.Rows(0).Item("NoOfSessions").ToString)
                session = New TblSessions With {
                    .GroupId = group_id,
                    .Code = String.Empty,
                    .Title = "Session No. " & index,
                    .IssueDate = Date.Now.AddDays(index - 1),
                    .DefaultPeriodHour = 2,
                    .Remarks = String.Empty,
                    .Status = status_id,
                    .StatusRemarks = String.Empty
                }
                lstSessions.Add(session)
            Next
            BindLVSessions()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

#End Region

#Region "Sessions"

    Private Sub BindLVSessions()
        Try
            Try
                lvSessions.DataSource = lstSessions.OrderBy(Function(x) x.IssueDate).ToList()
                lvSessions.DataBind()
            Catch ex As Exception
                ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            End Try
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Function GetSessionsDT() As List(Of TblSessions)
        Try
            For Each item As ListViewItem In lvSessions.Items
                Dim dtDetails As New TblSessions
                dtDetails.GroupId = IntFormat(CType(item.FindControl("lblGroupID"), Label).Text)
                dtDetails.Code = CType(item.FindControl("lblCode"), Label).Text
                dtDetails.Title = CType(item.FindControl("txtTitle"), TextBox).Text
                dtDetails.IssueDate = CDate(CType(item.FindControl("txtIssueDate"), TextBox).Text)
                dtDetails.DefaultPeriodHour = GetDecimalValue(CType(item.FindControl("txtDefaultPeriodHour"), TextBox).Text)
                dtDetails.Remarks = CType(item.FindControl("txtRemarks"), TextBox).Text
                dtDetails.Status = IntFormat(CType(item.FindControl("lblStatus"), Label).Text)
                dtDetails.StatusRemarks = CType(item.FindControl("lblStatusRemarks"), Label).Text
                lstSessions.Add(dtDetails)
            Next
            Return lstSessions
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

    Protected Sub SubmitSession(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim dtDetails As New TblSessions
            lstSessions = GetSessionsDT()
            If hfSessionIndex.Value <> String.Empty Then
                If FillSessionDT(dtDetails, "Update") Then
                    CancelSession(Sender, New EventArgs)
                End If
            Else
                If FillSessionDT(dtDetails, "Insert") Then
                    CancelSession(Sender, New EventArgs)
                End If
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Function FillSessionDT(ByRef dtDetails As TblSessions, Operation As String) As Boolean
        Try
            If String.IsNullOrEmpty(txtTitle.Text) Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Session title is empty")
                Return False
            End If
            If Not IsDate(txtIssueDate.Text) Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Session date is invalid")
                Return False
            End If
            Dim group_id As Integer = IntFormat(Request.QueryString("ID"))
            dtDetails.Code = txtSessionCode.Text
            dtDetails.Title = txtTitle.Text
            dtDetails.IssueDate = txtIssueDate.Text
            dtDetails.DefaultPeriodHour = GetDecimalValue(txtDefaultPeriodHour.Text)
            dtDetails.GroupId = group_id
            dtDetails.Remarks = txtRemarks.Text
            dtDetails.Status = IntFormat(hfStatus.Value)
            dtDetails.StatusRemarks = hfStatusRemarks.Value
            dtDetails.CreatedBy = UserID
            dtDetails.CreatedDate = DateTime.Now
            dtDetails.IsDeleted = 0
            Dim index As Integer = Val(hfSessionIndex.Value)
            Select Case Operation.ToLower
                Case "insert"
                    dtDetails.Status = GetLookupID("SessionStatus", "Pending", School_ID)
                    lstSessions.Add(dtDetails)
                Case "update"
                    If index < lstSessions.Count Then
                        lstSessions.Remove(lstSessions.Item(index))
                        lstSessions.Add(dtDetails)
                    End If
            End Select
            BindLVSessions()
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return False
        End Try
    End Function

    Protected Sub CancelSession(Sender As Object, e As EventArgs)
        Try
            txtSessionCode.Text = String.Empty
            txtTitle.Text = String.Empty
            txtIssueDate.Text = String.Empty
            txtDefaultPeriodHour.Text = String.Empty
            txtRemarks.Text = String.Empty
            hfSessionIndex.Value = String.Empty
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub DeleteSession(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            Dim index As String = Val(CType(parent.FindControl("lblSerialNo"), Label).Text) - 1
            lstSessions = GetSessionsDT()
            lstSessions.Remove(lstSessions.Item(index))
            BindLVSessions()
            CancelSession(Sender, New EventArgs)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub EditSession(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            hfSessionIndex.Value = IntFormat((CType(parent.FindControl("lblSerialNo"), Label).Text) - 1)
            txtSessionCode.Text = CType(parent.FindControl("lblCode"), Label).Text
            txtTitle.Text = CType(parent.FindControl("txtTitle"), TextBox).Text
            txtIssueDate.Text = CType(parent.FindControl("txtIssueDate"), TextBox).Text
            txtDefaultPeriodHour.Text = DecimalFormat(CType(parent.FindControl("txtDefaultPeriodHour"), TextBox).Text)
            txtRemarks.Text = CType(parent.FindControl("txtRemarks"), TextBox).Text
            hfStatus.Value = CType(parent.FindControl("lblStatus"), Label).Text
            hfStatusRemarks.Value = CType(parent.FindControl("lblStatusRemarks"), Label).Text
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Students"

    Protected Sub CalculateNetAmount(sender As Object, e As EventArgs)
        Try
            Dim course_price As Decimal = GetDecimalValue(txtCoursePrice.Text), discount_rate As Decimal = GetDecimalValue(txtDiscountRate.Text),
                discount_amount As Decimal = 0, net_amount As Decimal = 0
            discount_amount = course_price * discount_rate / 100
            net_amount = course_price - discount_amount
            txtCoursePrice.Text = DecimalFormat(course_price)
            txtDiscountRate.Text = DecimalFormat(discount_rate)
            txtDiscountAmount.Text = DecimalFormat(discount_amount)
            txtNetAmount.Text = DecimalFormat(net_amount)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub CalculateNetAmountInLV(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            Dim text_box As TextBox = CType(Sender, TextBox)
            Dim course_price As Decimal = GetDecimalValue(CType(parent.FindControl("txtCoursePrice"), TextBox).Text),
                discount_rate As Decimal = GetDecimalValue(CType(parent.FindControl("txtDiscountRate"), TextBox).Text),
                discount_amount As Decimal = 0, net_amount As Decimal = 0
            discount_amount = course_price * discount_rate / 100
            net_amount = course_price - discount_amount
            CType(parent.FindControl("txtCoursePrice"), TextBox).Text = DecimalFormat(course_price)
            CType(parent.FindControl("txtDiscountRate"), TextBox).Text = DecimalFormat(discount_rate)
            CType(parent.FindControl("lblDiscountAmount"), Label).Text = DecimalFormat(discount_amount)
            CType(parent.FindControl("lblNetAmount"), Label).Text = DecimalFormat(net_amount)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub BindLVStudents()
        Try
            Try
                lvStudents.DataSource = lstStudents.OrderBy(Function(x) x.StudentId).ToList()
                lvStudents.DataBind()
            Catch ex As Exception
                ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            End Try
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub LVStudents_DataBound(sender As Object, e As EventArgs) Handles lvStudents.DataBound
        Try
            Dim i As Integer = 0
            While i < lvStudents.Items.Count
                CType(lvStudents.Items(i).FindControl("lblCode"), Label).Text = getValue("Code", "tblStudents", CType(lvStudents.Items(i).FindControl("lblStudentID"), Label).Text)
                CType(lvStudents.Items(i).FindControl("lblName"), Label).Text = getValue("Name", "tblStudents", CType(lvStudents.Items(i).FindControl("lblStudentID"), Label).Text)
                CType(lvStudents.Items(i).FindControl("lblMobile"), Label).Text = getValue("Mobile", "tblStudents", CType(lvStudents.Items(i).FindControl("lblStudentID"), Label).Text)
                i += 1
            End While
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Function GetStudentsDT() As List(Of TblStudentsGroups)
        Try
            For Each item As ListViewItem In lvStudents.Items
                Dim dtDetails As New TblStudentsGroups
                dtDetails.GroupId = IntFormat(CType(item.FindControl("lblGroupID"), Label).Text)
                dtDetails.StudentId = IntFormat(CType(item.FindControl("lblStudentID"), Label).Text)
                dtDetails.CoursePrice = GetDecimalValue(CType(item.FindControl("txtCoursePrice"), TextBox).Text)
                dtDetails.DiscountRate = GetDecimalValue(CType(item.FindControl("txtDiscountRate"), TextBox).Text)
                dtDetails.DiscountAmount = GetDecimalValue(CType(item.FindControl("lblDiscountAmount"), Label).Text)
                dtDetails.NetAmount = GetDecimalValue(CType(item.FindControl("lblNetAmount"), Label).Text)
                dtDetails.DiscountReason = CType(item.FindControl("txtDiscountReason"), TextBox).Text
                lstStudents.Add(dtDetails)
            Next
            Return lstStudents
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

    Protected Sub SubmitStudent(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim dtDetails As New TblStudentsGroups
            lstStudents = GetStudentsDT()
            If hfStudentIndex.Value <> String.Empty Then
                If FillStudentDT(dtDetails, "Update") Then
                    CancelStudent(Sender, New EventArgs)
                End If
            Else
                If FillStudentDT(dtDetails, "Insert") Then
                    CancelStudent(Sender, New EventArgs)
                End If
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Function FillStudentDT(ByRef dtDetails As TblStudentsGroups, Operation As String) As Boolean
        Try
            If IntFormat(ddlStudentID.SelectedValue) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Select student first")
                Return False
            End If
            Dim group_id As Integer = IntFormat(Request.QueryString("ID"))
            dtDetails.GroupId = group_id
            dtDetails.StudentId = IntFormat(ddlStudentID.SelectedValue)
            dtDetails.CoursePrice = GetDecimalValue(txtCoursePrice.Text)
            dtDetails.DiscountRate = GetDecimalValue(txtDiscountRate.Text)
            dtDetails.DiscountAmount = GetDecimalValue(txtDiscountAmount.Text)
            dtDetails.NetAmount = GetDecimalValue(txtNetAmount.Text)
            dtDetails.DiscountReason = txtDiscountReason.Text
            dtDetails.CreatedBy = UserID
            dtDetails.CreatedDate = DateTime.Now
            dtDetails.IsDeleted = 0
            Dim index As Integer = Val(hfStudentIndex.Value)
            Select Case Operation.ToLower
                Case "insert"
                    lstStudents.Add(dtDetails)
                Case "update"
                    If index < lstStudents.Count Then
                        lstStudents.Remove(lstStudents.Item(index))
                        lstStudents.Add(dtDetails)
                    End If
            End Select
            BindLVStudents()
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return False
        End Try
    End Function

    Protected Sub CancelStudent(Sender As Object, e As EventArgs)
        Try
            hfSessionIndex.Value = String.Empty
            ddlStudentID.SelectedIndex = -1
            txtCoursePrice.Text = hfCourseFees.Value
            txtDiscountRate.Text = String.Empty
            txtDiscountAmount.Text = String.Empty
            txtNetAmount.Text = String.Empty
            txtDiscountReason.Text = String.Empty
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub DeleteStudent(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            Dim index As String = Val(CType(parent.FindControl("lblSerialNo"), Label).Text) - 1
            lstStudents = GetStudentsDT()
            lstStudents.Remove(lstStudents.Item(index))
            BindLVStudents()
            CancelStudent(Sender, New EventArgs)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub EditStudent(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            hfStudentIndex.Value = IntFormat((CType(parent.FindControl("lblSerialNo"), Label).Text) - 1)
            SetDDLValue(ddlStudentID, IntFormat(CType(parent.FindControl("lblStudentID"), Label).Text))
            txtCoursePrice.Text = DecimalFormat(CType(parent.FindControl("txtCoursePrice"), TextBox).Text)
            txtDiscountRate.Text = DecimalFormat(CType(parent.FindControl("txtDiscountRate"), TextBox).Text)
            txtDiscountAmount.Text = DecimalFormat(CType(parent.FindControl("lblDiscountAmount"), Label).Text)
            txtNetAmount.Text = DecimalFormat(CType(parent.FindControl("lblNetAmount"), Label).Text)
            txtDiscountReason.Text = CType(parent.FindControl("txtDiscountReason"), TextBox).Text
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

End Class