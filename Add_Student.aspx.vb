#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports System.ServiceModel.PeerResolvers
Imports System.Threading.Tasks
Imports System.Web.ModelBinding
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports Microsoft.VisualBasic.ApplicationServices
#End Region
Partial Class Add_Student
    Inherits System.Web.UI.Page
#Region "Global Variable"

    Dim UserID As String = "0"
    Dim Client_Id As String = "1"
    Dim _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region
#Region "Page load"
    ''' <summary>
    ''' Handle page_load event
    ''' </summary>
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            'lblRes.Visible = False
            'UserId = PublicFunctions.GetUserId(Page)
            'Client_Id = PublicFunctions.GetClientId
            If Page.IsPostBack = False Then

                'clsLogs.AddSystemLogs("Access")
                'LoadBundles(Me)
                ''Permissions.CheckPermisions(New GridView, New LinkButton, New TextBox, New LinkButton, Me.Page, User_Id)
                'FillDDL()
                'Enabler(False)
            Else
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "AddScripts", "AddScripts();", True)
                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "load", "ViewlblMSG();", True)
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PreventAnimation", "PreventAnimation();", True)
            End If
            FillIcon()
        Catch ex As Exception
            'ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub


#End Region

#Region "Validation"
    Private Function isValidForm() As Boolean
        If Not String.IsNullOrEmpty(txtDateOfBirth.Text) Then
            If Not IsDate(txtDateOfBirth.Text) Then
                Return False
            End If
        End If
        Return True
    End Function
#End Region
#Region "Save"
    Protected Sub Save()
        Try
            Dim Mode As String = Request.QueryString("Mode")
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblStudentsFactory
            Dim dt As New TblStudents
            If String.IsNullOrEmpty(Mode) Or String.IsNullOrEmpty(ID) Then
                If Not FillDT(dt, Mode) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                _sqlconn.Open()
                _sqltrans = _sqlconn.BeginTransaction()

                If Not da.InsertTrans(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    _sqltrans.Rollback()
                    _sqlconn.Close()
                    Exit Sub
                End If
                If Not SaveStudentGroup(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    _sqltrans.Rollback()
                    _sqlconn.Close()
                    Exit Sub
                End If
                _sqltrans.Commit()
                _sqlconn.Close()
                ShowMessage(lblRes, MessageTypesEnum.Insert, Me.Page)
            Else
                dt = da.GetAllBy(TblStudents.TblStudentsFields.Id, ID).FirstOrDefault
                If dt Is Nothing Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                If Not FillDT(dt, Mode) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    Exit Sub
                End If
                If Not da.UpdateTrans(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
                    _sqltrans.Rollback()
                    _sqlconn.Close()
                    Exit Sub
                End If
                If Not SaveStudentGroup(dt, _sqlconn, _sqltrans) Then
                    clsMessages.ShowInfoMessgage(lblRes, "Error", Me)
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

    Private Function SaveStudentGroup(dtStudent As TblStudents, sqlconn As SqlConnection, sqltrans As SqlTransaction) As Boolean
        Try
            Dim da As New TblStudentsGroupsFactory
            Dim dt As New TblStudentsGroups
            dt.StudentId = dtStudent.Id
            dt.GroupId = Val(ddlGroups.SelectedValue)
            dt.CreatedBy = UserID
            dt.CreatedDate = DateTime.Now
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            dt.SchoolId = Client_Id
            da.DeleteTrans(TblStudentsGroups.TblStudentsGroupsFields.StudentId, dtStudent.Id, _sqlconn, _sqltrans)
            Return da.InsertTrans(dt, sqlconn, sqltrans)
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Function FillDT(dt As TblStudents, Mode As String) As Boolean
        Try
            If Not isValidForm() Then
                Return False
            End If
            dt.Code = txtCode.Text.Trim
            dt.Name = txtFirstName.Text.Trim & " " & txtLastName.Text.Trim
            dt.Mobile = txtPhone.Text
            dt.Email = txtEmail.Text
            dt.DateOfBirth = CDate(txtDateOfBirth.Text)
            dt.Gender = ddlGender.SelectedValue
            dt.Photo = HiddenIcon.Text
            dt.Remarks = txtBio.Text
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            If Mode = "Insert" Then
                dt.CreatedBy = UserID
                dt.CreatedDate = DateTime.Now
            End If
            dt.SchoolId = Client_Id
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
            If Mode = "View" And IsNumeric(ID) Then
                Dim dt As DataTable = DBContext.Getdatatable("Select * from TblStudents Where ID='" & ID & "' And SchoolId='" & Client_Id & "' and isnull(isdeleted,0)=0")
                If dt.Rows.Count = 0 Then
                    Exit Sub
                End If
                txtCode.Text = dt.Rows(0).Item("Code").ToString
                txtFirstName.Text = dt.Rows(0).Item("Name").ToString.Split(" ").First
                txtLastName.Text = dt.Rows(0).Item("Name").ToString.Split(" ").Last
                txtPhone.Text = dt.Rows(0).Item("Phone").ToString
                txtDateOfBirth.Text = dt.Rows(0).Item("DateOfBirth").ToString
                txtEmail.Text = dt.Rows(0).Item("Email").ToString
                ddlGender.SelectedValue = dt.Rows(0).Item("Gender").ToString
                txtBio.Text = dt.Rows(0).Item("Remarks").ToString
                imgIcon.ImageUrl = dt.Rows(0).Item("Photo").ToString
                HiddenIcon.Text = dt.Rows(0).Item("Photo").ToString
            End If

        Catch ex As Exception

        End Try
    End Sub
#End Region
#Region "Cancel"
    Protected Sub Cancel()
        txtCode.Text = String.Empty
        txtFirstName.Text = String.Empty
        txtLastName.Text = String.Empty
        txtPhone.Text = String.Empty
        txtEmail.Text = String.Empty
        txtDateOfBirth.Text = String.Empty
        txtBio.Text = String.Empty

        ddlGender.SelectedIndex = -1
        ddlGroups.SelectedIndex = -1
        'imgProfile.Src = "img/figure/Photo.jpg"
    End Sub
#End Region

#Region "Uploader"
    ''' <summary>
    ''' Save icon at Icons folder
    ''' </summary>
    Protected Sub IconUploaded(ByVal sender As AsyncFileUpload, ByVal e As System.EventArgs)
        Dim Path As String = Server.MapPath("~/Users_Photos/")
        Dim isPathExist As Boolean = System.IO.Directory.Exists(Path)
        If Not isPathExist Then
            System.IO.Directory.CreateDirectory(Path)
        End If

        Dim fu As New AjaxControlToolkit.AsyncFileUpload
        Try
            Select Case sender.ID
                Case "fuIcon"
                    fu = fuIcon
                    Dim type As String = fu.ContentType
                    If type = "image/jpeg" OrElse type = "image/gif" OrElse type = "image/png" Then
                        HiddenIcon.Text = "~/Users_Photos/" + fu.FileName
                        fu.SaveAs(Path + fu.FileName)
                    End If
                Case "fuSignature"

            End Select

        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub

    ''' <summary>
    ''' Fill icon image with saved path
    ''' </summary>
    Private Sub FillIcon()
        Try
            'Personal Photo
            If HiddenIcon.Text IsNot Nothing And HiddenIcon.Text <> "" Then
                imgIcon.ImageUrl = HiddenIcon.Text
            Else
                HiddenIcon.Text = ""
                imgIcon.ImageUrl = "~/img/figure/Photo.jpg"
            End If


        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub



#End Region
End Class
