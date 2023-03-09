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
            Exit Sub
            Dim Mode As String = Request.QueryString("Mode")
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblMessagesFactory
            Dim dt As New TblMessages
            If lbSave.CommandArgument = "Add" Then
                If Not FillDT(dt, "Add") Then
                    clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                _sqlconn.Open()
                _sqltrans = _sqlconn.BeginTransaction()

                If Not da.InsertTrans(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                    _sqltrans.Rollback()
                    _sqlconn.Close()
                    Exit Sub
                End If
                _sqltrans.Commit()
                _sqlconn.Close()
                Clear()
                ShowMessage(lblRes, MessageTypesEnum.Insert, Me.Page)
            ElseIf lbSave.CommandArgument = "Edit" Then
                dt = da.GetAllBy(TblMessages.TblMessagesFields.Id, ID).FirstOrDefault
                If dt Is Nothing Then
                    clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                If Not FillDT(dt, "Edit") Then
                    clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                _sqlconn.Open()
                _sqltrans = _sqlconn.BeginTransaction()
                If Not da.UpdateTrans(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowErrorMessgage(lblRes, "Error", Me)
                    _sqltrans.Rollback()
                    _sqlconn.Close()
                    Exit Sub
                End If
                _sqltrans.Commit()
                _sqlconn.Close()
                ShowMessage(lblRes, MessageTypesEnum.Update, Me.Page)
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Private Function FillDT(dt As TblMessages, Mode As String) As Boolean
        Try
            If Not isValidForm() Then
                Return False
            End If
            dt.MessageTitle = txtMessageTitle.Text.Trim
            dt.MessageBody = txtDescription.Text
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            If Mode = "Add" Then
                dt.SenderId = UserID
                dt.CreatedDate = DateTime.Now
            End If
            dt.SchoolId = School_Id
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
            Dim dt = DBContext.Getdatatable("Select ID,FirstName + ' ' + LastName as Name from vw_Students where GroupId=" & ddlGroups.SelectedValue.ToString & " and SchoolId='" & School_Id & "'")
            ddlStudent.DataValueField = "ID"
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
