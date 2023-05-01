#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports AjaxControlToolkit.HTMLEditor
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Message
    Inherits System.Web.UI.Page
#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_Id As String = "1"
    Dim FormQry As String = "Select * from vw_Courses "
    Dim _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region
#Region "Page load"
    ''' <summary>
    ''' Handle page_load event
    ''' </summary>
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            'UserId = PublicFunctions.GetUserId(Page)
            'School_Id = PublicFunctions.GetClientId
            If Page.IsPostBack = False Then
                divActions.Visible = False
                FillGroups()
                View()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"
    Private Function isValidForm() As Boolean

        Return True
    End Function
#End Region
#Region "Save"
    Protected Sub Save()
        Try
            _sqlconn.Open()
            _sqltrans = _sqlconn.BeginTransaction()
            Dim isOKay As Boolean = True
            'If Student ID = 0 --- > Send To All Students in That Group
            'If Supervisor ID = 0 --- > Send To All Supervisor  
            'If Teacher ID = 0 --- > Send To All Teachers  
            Dim TYP As String = rplTypes.SelectedValue
            Select Case TYP
                Case "Student"
                    isOKay = MessageStudents()
                Case "Teacher"
                    isOKay = MessageTeachers()
                Case "Supervisor"
                    isOKay = MessageSupervisors()
            End Select
            If Not isOKay Then
                clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            Clear()
            ShowSuccessMessgage(lblRes, "Sent Successfully!", Me.Page)

        Catch ex As Exception
            _sqltrans.Rollback()
            _sqlconn.Close()
            Throw ex
        End Try

    End Sub



    Private Function MessageSupervisors() As Boolean
        Try
            Dim Condition As String = IIf(Val(ddlSupervisors.SelectedValue) = 0, "1=1", "Id=" & Val(ddlSupervisors.SelectedValue))
            Dim da As New TblMessagesFactory
            'Send To All Group Students Or selected Student
            Dim dtGroupStudent As DataTable = ExecuteQuery.ExecuteQueryAndReturnDataTable("Select * from vw_Supervisors where SchoolId='" & School_Id & "' And " & Condition, _sqlconn, _sqltrans)
            For Each dr As DataRow In dtGroupStudent.Rows
                Dim SupervisorUserId = Val(dr("SupervisorUserId").ToString)
                Dim msg As New TblMessages
                msg.MessageTitle = txtMessageTitle.Text.Trim
                msg.MessageBody = txtDescription.Text
                msg.SenderId = UserID
                msg.ReceiverId = SupervisorUserId
                msg.SenderId = UserID
                msg.CreatedDate = DateTime.Now
                msg.SchoolId = School_Id
                If Not da.InsertTrans(msg, _sqlconn, _sqltrans) Then
                    Return False
                End If
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Function MessageTeachers() As Boolean
        Try
            Dim Condition As String = IIf(Val(ddlTeachers.SelectedValue) = 0, "1=1", "Id=" & Val(ddlTeachers.SelectedValue))
            Dim da As New TblMessagesFactory
            'Send To All Group Students Or selected Student
            Dim dtGroupStudent As DataTable = ExecuteQuery.ExecuteQueryAndReturnDataTable("Select * from vw_Teachers where SchoolId='" & School_Id & "' And " & Condition, _sqlconn, _sqltrans)
            For Each dr As DataRow In dtGroupStudent.Rows
                Dim TeacherUserID = Val(dr("TeacherUserID").ToString)
                Dim msg As New TblMessages
                msg.MessageTitle = txtMessageTitle.Text.Trim
                msg.MessageBody = txtDescription.Text
                msg.SenderId = UserID
                msg.ReceiverId = TeacherUserID
                msg.SenderId = UserID
                msg.CreatedDate = DateTime.Now
                msg.SchoolId = School_Id
                If Not da.InsertTrans(msg, _sqlconn, _sqltrans) Then
                    Return False
                End If
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Function MessageStudents() As Boolean
        Try
            Dim Condition As String = IIf(Val(ddlStudent.SelectedValue) = 0, "1=1", "StudentID=" & Val(ddlStudent.SelectedValue))
            Dim da As New TblMessagesFactory
            'Send To All Group Students Or selected Student
            Dim dtGroupStudent As DataTable = ExecuteQuery.ExecuteQueryAndReturnDataTable("Select * from vw_StudentsGroups where SchoolId='" & School_Id & "' And " & Condition, _sqlconn, _sqltrans)
            For Each dr As DataRow In dtGroupStudent.Rows
                Dim StudentUserID = PublicFunctions.IntFormat(dr("StudentUserID").ToString)
                Dim msg As New TblMessages
                msg.MessageTitle = txtMessageTitle.Text.Trim
                msg.MessageBody = txtDescription.Text
                msg.SenderId = UserID
                msg.ReceiverId = StudentUserID
                msg.SenderId = UserID
                msg.CreatedDate = DateTime.Now
                msg.SchoolId = School_Id
                If Not da.InsertTrans(msg, _sqlconn, _sqltrans) Then
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
                Dim dt As DataTable = DBContext.Getdatatable(FormQry & "Where ID='" & ID & "' And SchoolId='" & School_Id & "'")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                txtMessageTitle.Text = dt.Rows(0).Item("Name").ToString
                txtDescription.Text = dt.Rows(0).Item("NoOfSessions").ToString

                lbSave.CommandArgument = "Edit"
                pnlForm.Enabled = Mode = "Edit"
                divActions.Visible = Mode = "View"
            End If

            lblTitle.Text = IIf(String.IsNullOrEmpty(Mode), "Add New Message", Mode & " Message")
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
#Region "Cancel"
    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("Dashboard.aspx")
    End Sub
    Protected Sub Edit(sender As Object, e As EventArgs)
        pnlForm.Enabled = True
        sender.visible = False
        lbSave.CommandArgument = "Edit"
        lblTitle.Text = "Edit Message"
        divActions.Visible = False
    End Sub

    Protected Sub Clear()
        txtMessageTitle.Text = String.Empty
        txtDescription.Text = String.Empty
    End Sub
#End Region

#Region "Types"
    Protected Sub SelectType(sender As Object, e As EventArgs)
        Try
            Dim TYP As String = rplTypes.SelectedValue
            Select Case TYP
                Case "Student"
                    FillGroups()
                Case "Teacher"
                    FillTeachers()
                Case "Supervisor"
                    FillSupervisors()
            End Select

            pnlStudent.Visible = TYP = "Student"
            pnlSupervisors.Visible = TYP = "Supervisor"
            pnlTeachers.Visible = TYP = "Teacher"

        Catch ex As Exception

        End Try
    End Sub
    Private Sub FillGroups()
        Try
            'Fill Groups
            Dim dt = DBContext.Getdatatable("Select ID,Name from TblGroups where Isnull(isdeleted,0)=0 and SchoolId='" & School_Id & "'")
            ddlGroups.DataValueField = "ID"
            ddlGroups.DataTextField = "Name"
            ddlGroups.AppendDataBoundItems = True
            ddlGroups.DataSource = dt
            ddlGroups.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
    Protected Sub FillGroupStudent(sender As Object, e As EventArgs)
        Try
            ddlStudent.Items.Clear()
            Dim itm As New ListItem("Select Student", "0")
            ddlStudent.Items.Add(itm)

            If ddlGroups.SelectedValue = 0 Then
                ddlStudent.SelectedIndex = -1
                Exit Sub
            End If

            'Fill Students
            Dim dt = DBContext.Getdatatable("Select StudentID,  Name from vw_StudentsGroups where GroupId=" & ddlGroups.SelectedValue.ToString & " and SchoolId='" & School_Id & "'")
            ddlStudent.DataValueField = "StudentID"
            ddlStudent.DataTextField = "Name"
            ddlStudent.DataSource = dt
            ddlStudent.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillTeachers()
        Try
            'Fill Groups
            Dim dt = DBContext.Getdatatable("Select ID,Name from vw_Teachers where SchoolId='" & School_Id & "'")
            ddlTeachers.DataValueField = "ID"
            ddlTeachers.DataTextField = "Name"
            ddlTeachers.AppendDataBoundItems = True
            ddlTeachers.DataSource = dt
            ddlTeachers.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
    Private Sub FillSupervisors()
        Try
            'Fill Supervisors
            Dim dt = DBContext.Getdatatable("Select ID,Name from vw_Supervisors where SchoolId='" & School_Id & "'")
            ddlSupervisors.DataValueField = "ID"
            ddlSupervisors.DataTextField = "Name"
            ddlSupervisors.AppendDataBoundItems = True
            ddlSupervisors.DataSource = dt
            ddlSupervisors.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

End Class
