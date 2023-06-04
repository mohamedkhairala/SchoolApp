#Region "Import"

Imports clsBindDDL
Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class Students_Payments
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
            FillDropDownList(ddlStudent, "select ID, (Code + ' - ' + Name) as Student from vw_Students where SchoolID = " & School_ID & ";", "ID", "Student", True)
            FillDropDownList(ddlCourse, "select ID, (Code + ' - ' + Name) as Course from vw_Courses where SchoolID = " & School_ID & ";", "ID", "Course", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Try
            ' check student
            If IntFormat(ddlStudent.SelectedValue) = 0 Then
                ShowAlertMessgage(lblRes, "Should select student first", Me)
                Return False
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
            dt.TranType = "R"
            dt.ForType = "S"
            dt.ForId = IntFormat(ddlStudent.SelectedValue)
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
                dtDetails.SessionId = 0
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
                SetDDLValue(ddlStudent, dt.Rows(0).Item("ForId").ToString)
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

#Region "Cancel"

    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("~/Dashboard.aspx")
    End Sub

    Protected Sub Clear()
        ' master data
        txtCode.Text = String.Empty
        txtDate.Text = String.Empty
        ddlStudent.SelectedIndex = -1
        txtTotalAmount.Text = String.Empty
        txtDescription.Text = String.Empty
        ' details data
        hfDetailsIndex.Value = String.Empty
        ddlCourse.SelectedIndex = -1
        ddlGroup.SelectedIndex = -1
        txtCourseFullAmount.Text = String.Empty
        txtCourseRestAmount.Text = String.Empty
        txtAmount.Text = String.Empty
        txtRemarks.Text = String.Empty
        lvDetails.DataSource = New DataTable
        lvDetails.DataBind()
    End Sub

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
                CType(lvDetails.Items(i).FindControl("lblCourseName"), Label).Text = getValue("Name", "tblCourses", CType(lvDetails.Items(i).FindControl("lblCourseId"), Label).Text)
                CType(lvDetails.Items(i).FindControl("lblGroupName"), Label).Text = getValue("Name", "tblGroups", CType(lvDetails.Items(i).FindControl("lblGroupId"), Label).Text)
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
            If IsGroupExist() Then
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
            If IntFormat(ddlGroup.SelectedValue) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Should select group")
                Return False
            End If
            If GetDecimalValue(txtAmount.Text) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Amount is zero")
                Return False
            End If
            If GetDecimalValue(txtCourseRestAmount.Text) = 0 Then
                ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Course if fully paid")
                Return False
            End If
            dtDetails.CourseId = IntFormat(ddlCourse.SelectedValue)
            dtDetails.GroupId = IntFormat(ddlGroup.SelectedValue)
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

    Function IsGroupExist() As Boolean
        Try
            For Each item As ListViewItem In lvDetails.Items
                Dim group_id As String = CType(item.FindControl("lblGroupId"), Label).Text
                If group_id = IntFormat(ddlGroup.SelectedValue) And hfDetailsIndex.Value = String.Empty Then
                    ShowInfoMessgage(lblRes, "Group already exists in the list, Record No.(" & item.DataItemIndex + 1 & ")", Me)
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
            FillGroups(ddlCourse, New EventArgs)
            txtCourseFullAmount.Text = String.Empty
            txtCourseRestAmount.Text = String.Empty
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
            SetDDLValue(ddlCourse, IntFormat(CType(parent.FindControl("lblCourseId"), Label).Text))
            FillGroups(ddlCourse, New EventArgs)
            SetDDLValue(ddlGroup, IntFormat(CType(parent.FindControl("lblGroupId"), Label).Text))
            SelectGroup(ddlGroup, New EventArgs)
            txtAmount.Text = GetDecimalValue(CType(parent.FindControl("lblAmount"), Label).Text)
            txtRemarks.Text = CType(parent.FindControl("lblRemarks"), Label).Text
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Group"

    ' to be fixed to get only non fully paid groups
    Protected Sub FillGroups(sender As Object, e As EventArgs)
        Try
            ddlGroup.DataSource = New DataTable
            ddlGroup.DataBind()
            ddlGroup.Items.Add(New ListItem("Please Select Group", ""))
            Dim student_id As Integer = IntFormat(ddlStudent.SelectedValue),
                course_id As Integer = IntFormat(ddlCourse.SelectedValue),
                group_id As Integer = IntFormat(ddlGroup.SelectedValue)
            Dim query As String = "select GroupID, (GroupCode + ' - ' + GroupName) as GroupData " &
                "from vw_StudentsGroups where StudentId = " & student_id & " and CourseId = " & course_id & " and " &
                "SchoolID = " & School_ID & " and CourseRestAmount > 0;"
            FillDropDownList(ddlGroup, query, "GroupID", "GroupData", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Protected Sub SelectGroup(sender As Object, e As EventArgs)
        Try
            Dim student_id As Integer = IntFormat(ddlStudent.SelectedValue),
                course_id As Integer = IntFormat(ddlCourse.SelectedValue),
                group_id As Integer = IntFormat(ddlGroup.SelectedValue)
            Dim query As String = "select SG.NetAmount as CourseFullAmount, CourseRestAmount " &
                "from vw_StudentsGroups SG where SG.StudentId = " & student_id & " and SG.GroupId = " & group_id & " and " &
                "SchoolId = " & School_ID & ";"
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                ShowAlertMessgage(lblRes, "Invalid selected group", Me)
                Exit Sub
            End If
            txtCourseFullAmount.Text = DecimalFormat(dt.Rows(0).Item("CourseFullAmount").ToString)
            txtCourseRestAmount.Text = DecimalFormat(dt.Rows(0).Item("CourseRestAmount").ToString)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

End Class