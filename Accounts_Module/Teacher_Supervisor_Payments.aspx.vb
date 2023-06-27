#Region "Import"

Imports clsBindDDL
Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class Teacher_Supervisor_Payments
    Inherits Page

#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_ID As String = "1"
    ReadOnly _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction
    Dim lstDetails As New List(Of TblTransactionDetails)

#End Region

#Region "Page load"

    ' Handle page_load event
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = GetUserId(Page)
            'School_ID = GetClientId
            If Page.IsPostBack = False Then
                Permissions.CheckPermisions(New GridView, New LinkButton, New TextBox, New LinkButton, Me.Page, UserID)
                FillDDL()
                SelectForType(rplTypes, New EventArgs)
                View()
            Else
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ScriptPostback", "ScriptPostback();", True)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillDDL()
        Try
            FillDropDownList(ddlTeacher, "select ID, (Code + ' - ' + Name) as Teacher from vw_Teachers where SchoolID = " & School_ID & ";", "ID", "Teacher", True)
            FillDropDownList(ddlSupervisor, "select ID, (Code + ' - ' + Name) as Supervisor from vw_Supervisors where SchoolID = " & School_ID & ";", "ID", "Supervisor", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "View"

    Protected Sub View()
        Try
            Dim Mode As String = Request.QueryString("Mode")
            Dim ID As String = Request.QueryString("ID")
            If (Mode = "View" Or Mode = "Edit") And IsNumeric(ID) Then
                Dim dt As DataTable = DBContext.Getdatatable("select * from vw_Transactions where ID = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                ' master data
                txtCode.Text = dt.Rows(0).Item("Code").ToString
                txtDate.Text = DateFormat(dt.Rows(0).Item("TranDate").ToString)
                rplTypes.SelectedValue = dt.Rows(0).Item("ForType").ToString
                SelectForType(rplTypes, New EventArgs)
                If rplTypes.SelectedValue = "T" Then
                    SetDDLValue(ddlTeacher, dt.Rows(0).Item("ForId").ToString)
                    SelectTeacher(ddlTeacher, New EventArgs)
                ElseIf rplTypes.SelectedValue = "V" Then
                    SetDDLValue(ddlSupervisor, dt.Rows(0).Item("ForId").ToString)
                    SelectSupervisor(ddlSupervisor, New EventArgs)
                End If
                txtTotalAmount.Text = DecimalFormat(dt.Rows(0).Item("Amount").ToString)
                txtDescription.Text = dt.Rows(0).Item("Description").ToString
                ' details data
                dt = DBContext.Getdatatable("select * from vw_TransactionDetails where TransactionId = '" & ID & "' and SchoolID = '" & School_ID & "';")
                If dt.Rows.Count > 0 Then
                    lvDetails.DataSource = dt
                    lvDetails.DataBind()
                End If
                lbSave.CommandArgument = "Edit"
                pnlForm.Enabled = Mode = "Edit"
            Else
                Mode = "Add"
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "For Type"

    Protected Sub SelectForType(sender As Object, e As EventArgs)
        Try
            divTeacher.Visible = False
            divSupervisor.Visible = False
            If rplTypes.SelectedValue = "T" Then
                divTeacher.Visible = True
            ElseIf rplTypes.SelectedValue = "V" Then
                divSupervisor.Visible = True
            End If
            ddlCourse.Items.Clear()
            CancelDetails(lbYesCancelSessions, New EventArgs)
            lvDetails.DataSource = New DataTable
            lvDetails.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "DropDownLists"

    Protected Sub SelectTeacher(sender As Object, e As EventArgs)
        Try
            Dim teacher_id As Integer = IntFormat(ddlTeacher.SelectedValue)
            Dim query As String = "select ATT.CourseId, ATT.Course from vw_Attendance ATT where ATT.TeacherId = " & teacher_id & " and " &
                "ATT.SchoolId = " & School_ID & " and ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN " &
                "where TRN.ForType = 'T' and TRN.ForId = " & teacher_id & " and TRN.SchoolId = " & School_ID & ");"
            ddlCourse.Items.Add(New ListItem("Please Select Course", ""))
            FillDropDownList(ddlCourse, query, "CourseId", "Course", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub SelectSupervisor(sender As Object, e As EventArgs)
        Try
            Dim supervisor_id As Integer = IntFormat(ddlSupervisor.SelectedValue)
            Dim query As String = "select ATT.CourseId, ATT.Course from vw_Attendance ATT where ATT.SupervisorId = " & supervisor_id & " and " &
                "ATT.SchoolId = " & School_ID & " and ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN " &
                "where TRN.ForType = 'V' and TRN.ForId = " & supervisor_id & " and TRN.SchoolId = " & School_ID & ");"
            ddlCourse.Items.Add(New ListItem("Please Select Course", ""))
            FillDropDownList(ddlCourse, query, "CourseId", "Course", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub SelectCourse(sender As Object, e As EventArgs)
        Try
            If IntFormat(ddlCourse.SelectedValue) = 0 Then
                ddlGroup.Items.Clear()
                ddlSession.Items.Clear()
                txtAmount.Text = String.Empty
                Exit Sub
            End If
            Dim course_id As Integer = IntFormat(ddlCourse.SelectedValue), teacher_id As Integer = IntFormat(ddlTeacher.SelectedValue),
                supervisor_id As Integer = IntFormat(ddlSupervisor.SelectedValue)
            Dim query As String = String.Empty
            If rplTypes.SelectedValue = "T" Then
                query = "select ATT.GroupId, ATT.[Group] from vw_Attendance ATT where ATT.CourseId = " & course_id & " and " &
                    "ATT.TeacherId = " & teacher_id & " and ATT.SchoolId = " & School_ID & " and " &
                    "ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN where TRN.ForType = 'T' and " &
                    "TRN.ForId = " & teacher_id & " and TRN.SchoolId = " & School_ID & ");"
            ElseIf rplTypes.SelectedValue = "V" Then
                query = "select ATT.GroupId, ATT.[Group] from vw_Attendance ATT where ATT.CourseId = " & course_id & " and " &
                    "ATT.SupervisorId = " & supervisor_id & " and ATT.SchoolId = " & School_ID & " and " &
                    "ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN where TRN.ForType = 'V' and " &
                    "TRN.ForId = " & supervisor_id & " and TRN.SchoolId = " & School_ID & ");"
            End If
            ddlGroup.Items.Add(New ListItem("Please Select Group", ""))
            FillDropDownList(ddlGroup, query, "GroupId", "Group", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub SelectGroup(sender As Object, e As EventArgs)
        Try
            If IntFormat(ddlGroup.SelectedValue) = 0 Then
                ddlSession.DataSource = New DataTable
                ddlSession.DataBind()
                txtAmount.Text = String.Empty
                Exit Sub
            End If
            Dim course_id As Integer = IntFormat(ddlCourse.SelectedValue), group_id As Integer = IntFormat(ddlGroup.SelectedValue),
                teacher_id As Integer = IntFormat(ddlTeacher.SelectedValue), supervisor_id As Integer = IntFormat(ddlSupervisor.SelectedValue)
            Dim query As String = String.Empty
            If rplTypes.SelectedValue = "T" Then
                query = "select ATT.SessionId, ATT.[Session] from vw_Attendance ATT where ATT.CourseId = " & course_id & " and " &
                    "ATT.GroupId = " & group_id & " and ATT.TeacherId = " & teacher_id & " and ATT.SchoolId = " & School_ID & " and " &
                    "ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN where TRN.ForType = 'T' and " &
                    "TRN.ForId = " & teacher_id & " and TRN.SchoolId = " & School_ID & ");"
            ElseIf rplTypes.SelectedValue = "V" Then
                query = "select ATT.SessionId, ATT.[Session] from vw_Attendance ATT where ATT.CourseId = " & course_id & " and " &
                    "ATT.GroupId = " & group_id & " and ATT.SupervisorId = " & supervisor_id & " and ATT.SchoolId = " & School_ID & " and " &
                    "ATT.SessionId not in (select TRN.SessionId from vw_TransactionDetails TRN where TRN.ForType = 'V' and " &
                    "TRN.ForId = " & supervisor_id & " and TRN.SchoolId = " & School_ID & ");"
            End If
            ddlSession.Items.Add(New ListItem("Please Select Session", ""))
            FillDropDownList(ddlSession, query, "SessionId", "Session", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub SelectSession(sender As Object, e As EventArgs)
        Try
            If IntFormat(ddlSession.SelectedValue) = 0 Then
                txtAmount.Text = String.Empty
                Exit Sub
            End If
            Dim session_id As Integer = IntFormat(ddlSession.SelectedValue), group_id As Integer = IntFormat(ddlGroup.SelectedValue),
                teacher_id As Integer = IntFormat(ddlTeacher.SelectedValue), supervisor_id As Integer = IntFormat(ddlSupervisor.SelectedValue)
            Dim query As String = String.Empty
            If rplTypes.SelectedValue = "T" Then
                query = "select isnull((select isnull([Period], 0) from vw_Attendance where SchoolId = " & School_ID & " and " &
                    "SessionId = " & session_id & " and TeacherId = " & teacher_id & "), 0) * isnull((select isnull(TeacherRate, 0) " &
                    "from vw_Groups where SchoolId = " & School_ID & " and Id = " & group_id & "), 0) as Amount "
            ElseIf rplTypes.SelectedValue = "V" Then
                query = "select isnull((select isnull([Period], 0) from vw_Attendance where SchoolId = " & School_ID & " and " &
                    "SessionId = " & session_id & " and SupervisorId = " & supervisor_id & "), 0) * isnull((select isnull(SupervisorRate, 0) " &
                    "from vw_Groups where SchoolId = " & School_ID & " and Id = " & group_id & "), 0) as Amount "
            End If
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                txtAmount.Text = 0
                Exit Sub
            End If
            txtAmount.Text = GetDecimalValue(dt.Rows(0).Item("Amount").ToString)
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
        Try
            ' master data
            txtCode.Text = String.Empty
            txtDate.Text = String.Empty
            rplTypes.SelectedValue = "T"
            SelectForType(rplTypes, New EventArgs)
            ddlTeacher.SelectedIndex = -1
            ddlSupervisor.SelectedIndex = -1
            txtTotalAmount.Text = String.Empty
            txtDescription.Text = String.Empty
            ' details data
            hfDetailsIndex.Value = String.Empty
            ddlCourse.SelectedIndex = -1
            ddlGroup.SelectedIndex = -1
            txtRemarks.Text = String.Empty
            lvDetails.DataSource = New DataTable
            lvDetails.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Try
            ' check teacher / supervisor
            If rplTypes.SelectedValue = "T" Then
                If IntFormat(ddlTeacher.SelectedValue) = 0 Then
                    ShowAlertMessgage(lblRes, "Should select teacher first", Me)
                    Return False
                End If
            ElseIf rplTypes.SelectedValue = "V" Then
                If IntFormat(ddlSupervisor.SelectedValue) = 0 Then
                    ShowAlertMessgage(lblRes, "Should select supervisor first", Me)
                    Return False
                End If
            End If
            ' validate details
            If lvDetails.Items.Count = 0 Then
                ShowAlertMessgage(lblRes, "Add one details at least", Me)
                Return False
            End If
            ' check if total amount is equal to sum of details amounts
            Dim sum_details As Decimal = 0
            For Each item As ListViewItem In lvDetails.Items
                Dim amount As Decimal = GetDecimalValue(CType(item.FindControl("lblAmount"), Label).Text)
                sum_details += amount
            Next
            If GetDecimalValue(txtTotalAmount.Text) <> sum_details Then
                ShowAlertMessgage(lblRes, "Total amount should be equal to sum of details amounts", Me)
                Return False
            End If
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

#End Region

#Region "Save"

    Protected Sub Save(sender As Object, e As EventArgs)
        Try
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblTransactionsFactory
            If lbSave.CommandArgument = "Add" Then
                Insert(da)
            ElseIf lbSave.CommandArgument = "Edit" Then
                Update(da, ID)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Sub Insert(da As TblTransactionsFactory)
        Try
            Dim dt As New TblTransactions
            If Not FillDT(dt, "Add") Then
                Exit Sub
            End If
            If Not IsCodeUnique("TblTransactions", "Code", Val(dt.Id), dt.Code, School_ID) Then
                ShowInfoMessgage(lblRes, "Transaction Code is not unique", Me)
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
            If Not SaveDetails(dt.Id, _sqlconn, _sqltrans) Then
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

    Private Sub Update(da As TblTransactionsFactory, ID As String)
        Try
            Dim dt As TblTransactions = da.GetAllBy(TblTransactions.TblTransactionsFields.Id, ID).FirstOrDefault
            If dt Is Nothing Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            If Not FillDT(dt, "Edit") Then
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
            Dim daDetails As New TblTransactionDetailsFactory
            daDetails.DeleteTrans(TblTransactionDetails.TblTransactionDetailsFields.TransactionId, ID, _sqlconn, _sqltrans)
            If Not SaveDetails(ID, _sqlconn, _sqltrans) Then
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

    Private Function FillDT(dt As TblTransactions, Mode As String) As Boolean
        Try
            If Not IsValidForm() Then
                Return False
            End If
            dt.Code = txtCode.Text.Trim
            dt.TranDate = CDate(txtDate.Text)
            dt.TranType = "P"
            dt.ForType = rplTypes.SelectedValue
            If rplTypes.SelectedValue = "T" Then
                dt.ForId = IntFormat(ddlTeacher.SelectedValue)
            ElseIf rplTypes.SelectedValue = "V" Then
                dt.ForId = IntFormat(ddlSupervisor.SelectedValue)
            End If
            dt.Amount = GetDecimalValue(txtTotalAmount.Text)
            dt.Description = txtDescription.Text
            dt.UpdatedBy = UserID
            dt.UpdatedDate = Now
            dt.IsDeleted = False
            dt.SchoolId = School_ID
            If Mode = "Add" Then
                dt.Code = GenerateCode.GenerateCodeFor(Stackholders.Transaction)
                dt.CreatedBy = UserID
                dt.CreatedDate = Now
            End If
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

    Private Function SaveDetails(id As String, sqlconn As SqlConnection, sqltrans As SqlTransaction) As Boolean
        Try
            Dim dtDetails As New TblTransactionDetails
            Dim daDetails As New TblTransactionDetailsFactory
            For Each item As ListViewItem In lvDetails.Items
                Dim index As Integer = IntFormat(CType(item.FindControl("lblSerialNo"), Label).Text)
                dtDetails.TransactionId = id
                dtDetails.Item = String.Empty
                dtDetails.CourseId = IntFormat(CType(item.FindControl("lblCourseId"), Label).Text)
                dtDetails.GroupId = IntFormat(CType(item.FindControl("lblGroupId"), Label).Text)
                dtDetails.SessionId = IntFormat(CType(item.FindControl("lblSessionId"), Label).Text)
                dtDetails.Amount = GetDecimalValue(CType(item.FindControl("lblAmount"), Label).Text)
                dtDetails.Remarks = CType(item.FindControl("lblRemarks"), Label).Text
                dtDetails.CreatedDate = Now
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

#Region "Details"

    Private Sub BindLVDetails()
        Try
            Try
                lvDetails.DataSource = lstDetails.OrderBy(Function(x) x.GroupId).ToList()
                lvDetails.DataBind()
            Catch ex As Exception
                ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            End Try
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub LVDetails_DataBound(sender As Object, e As EventArgs) Handles lvDetails.DataBound
        Try
            Dim i As Integer = 0
            While i < lvDetails.Items.Count
                CType(lvDetails.Items(i).FindControl("lblCourse"), Label).Text = getValue("Name", "tblCourses", CType(lvDetails.Items(i).FindControl("lblCourseId"), Label).Text)
                CType(lvDetails.Items(i).FindControl("lblGroup"), Label).Text = getValue("Name", "tblGroups", CType(lvDetails.Items(i).FindControl("lblGroupId"), Label).Text)
                CType(lvDetails.Items(i).FindControl("lblSession"), Label).Text = getValue("Title", "tblSessions", CType(lvDetails.Items(i).FindControl("lblSessionId"), Label).Text)
                i += 1
            End While
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Function GetDetailsDT() As List(Of TblTransactionDetails)
        Try
            For Each item As ListViewItem In lvDetails.Items
                Dim dtDetails As New TblTransactionDetails
                dtDetails.CourseId = IntFormat(CType(item.FindControl("lblCourseId"), Label).Text)
                dtDetails.GroupId = IntFormat(CType(item.FindControl("lblGroupId"), Label).Text)
                dtDetails.SessionId = IntFormat(CType(item.FindControl("lblSessionId"), Label).Text)
                dtDetails.Amount = GetDecimalValue(CType(item.FindControl("lblAmount"), Label).Text)
                dtDetails.Remarks = CType(item.FindControl("lblRemarks"), Label).Text
                lstDetails.Add(dtDetails)
            Next
            Return lstDetails
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

    Protected Sub SubmitDetails(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim dtDetails As New TblTransactionDetails
            If IsSessionExist() Then
                Exit Sub
            End If
            lstDetails = GetDetailsDT()
            If hfDetailsIndex.Value <> String.Empty Then
                If FillDetailsDT(dtDetails, "Update") Then
                    CancelDetails(Sender, New EventArgs)
                End If
            Else
                If FillDetailsDT(dtDetails, "Insert") Then
                    CancelDetails(Sender, New EventArgs)
                End If
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Function FillDetailsDT(ByRef dtDetails As TblTransactionDetails, Operation As String) As Boolean
        Try
            If IntFormat(ddlSession.SelectedValue) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Should select session")
                Return False
            End If
            If GetDecimalValue(txtAmount.Text) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Amount is zero")
                Return False
            End If
            dtDetails.CourseId = IntFormat(ddlCourse.SelectedValue)
            dtDetails.GroupId = IntFormat(ddlGroup.SelectedValue)
            dtDetails.SessionId = IntFormat(ddlSession.SelectedValue)
            dtDetails.Amount = GetDecimalValue(txtAmount.Text)
            dtDetails.Remarks = txtRemarks.Text
            dtDetails.CreatedBy = UserID
            dtDetails.CreatedDate = Now
            dtDetails.IsDeleted = 0
            Dim index As Integer = Val(hfDetailsIndex.Value)
            Select Case Operation.ToLower
                Case "insert"
                    lstDetails.Add(dtDetails)
                Case "update"
                    If index < lstDetails.Count Then
                        lstDetails.Remove(lstDetails.Item(index))
                        lstDetails.Add(dtDetails)
                    End If
            End Select
            BindLVDetails()
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return False
        End Try
    End Function

    Function IsSessionExist() As Boolean
        Try
            For Each item As ListViewItem In lvDetails.Items
                Dim session_id As String = CType(item.FindControl("lblSessionId"), Label).Text
                If session_id = IntFormat(ddlSession.SelectedValue) And hfDetailsIndex.Value = String.Empty Then
                    ShowInfoMessgage(lblRes, "Session already exists in the list, Record No.(" & item.DataItemIndex + 1 & ")", Me)
                    Return True
                End If
            Next
            Return False
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
            Return False
        End Try
    End Function

    Protected Sub CancelDetails(Sender As Object, e As EventArgs)
        Try
            ddlCourse.SelectedIndex = -1
            ddlGroup.Items.Clear()
            ddlSession.Items.Clear()
            txtAmount.Text = String.Empty
            txtRemarks.Text = String.Empty
            hfDetailsIndex.Value = String.Empty
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub DeleteDetails(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            Dim index As String = Val(CType(parent.FindControl("lblSerialNo"), Label).Text) - 1
            lstDetails = GetDetailsDT()
            lstDetails.Remove(lstDetails.Item(index))
            BindLVDetails()
            CancelDetails(Sender, New EventArgs)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Protected Sub EditDetails(ByVal Sender As Object, ByVal e As EventArgs)
        Try
            Dim parent As Object = Sender.parent
            hfDetailsIndex.Value = IntFormat(CType(parent.FindControl("lblSerialNo"), Label).Text) - 1
            If rplTypes.SelectedValue = "T" Then
                SelectTeacher(ddlTeacher, New EventArgs)
            ElseIf rplTypes.SelectedValue = "V" Then
                SelectSupervisor(ddlSupervisor, New EventArgs)
            End If
            SetDDLValue(ddlCourse, IntFormat(CType(parent.FindControl("lblCourseId"), Label).Text))
            SelectCourse(ddlCourse, New EventArgs)
            SetDDLValue(ddlGroup, IntFormat(CType(parent.FindControl("lblGroupId"), Label).Text))
            SelectGroup(ddlGroup, New EventArgs)
            SetDDLValue(ddlSession, IntFormat(CType(parent.FindControl("lblSessionId"), Label).Text))
            txtAmount.Text = GetDecimalValue(CType(parent.FindControl("lblAmount"), Label).Text)
            txtRemarks.Text = CType(parent.FindControl("lblRemarks"), Label).Text
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

End Class