
#Region "Import"
Imports System.Data
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports PGSample.Account

#End Region

Partial Class Login
    Inherits System.Web.UI.Page
#Region "Global Variables"
    Dim UserId As String = "0"
#End Region

#Region "Page Load"

    ''' <summary>
    ''' Handle page load event.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            If PublicFunctions.CheckLogged() Then
                Response.Redirect("Dashboard.aspx")
                Exit Sub
            End If

        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub

#End Region

#Region "Login"
    ''' <summary>
    ''' Set Password Enable if the user name exists
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub SetPassword()
        Try
            txtPassword.Enabled = False
            Dim username As String = txtUsername.Text.TrimStart
            txtUsername.Text = username.Trim

            'check if username is empty
            If username = String.Empty Then
                Exit Sub
            End If
            'Check user active
            Dim dt As DataTable = DBContext.Getdatatable("select Active from tblUsers where isnull(isdeleted,0)=0  and UserName=@Par1", username.Trim)
            If dt.Rows.Count > 0 Then
                If dt.Rows(0)("Active") Then
                    txtPassword.Enabled = True
                    txtPassword.Focus()
                Else
                    clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "This user is deactivated")
                End If
            Else
                txtPassword.Enabled = False
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Invalid Username")
            End If
        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub

    ''' <summary>
    ''' Check if user with entered username and password is exist or not.
    ''' </summary>
    Protected Sub CheckLogin(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim Username As String = txtUsername.Text
            Dim Password As String = txtPassword.Text
            If Username = String.Empty And Password = String.Empty Then
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Enter Username and Password")
                Exit Sub
            End If

            If Username = String.Empty Then
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Enter Username")
                Exit Sub
            End If
            If Password = String.Empty Then
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Enter Password")
                Exit Sub
            End If


            Dim dt As DataTable = DBContext.Getdatatable("select * from tblUsers where isnull(isDeleted,0)=0 and Active=1 and UserName=@Par1 ", Username)

            If dt.Rows.Count > 0 Then
                Dim CPUserId As String = dt.Rows(0).Item("UserId").ToString
                Dim CPUserPassword As String = PublicFunctions.Decrypt(dt.Rows(0).Item("Password").ToString)
                If Password = CPUserPassword Then
                    If CreateCookie(dt.Rows(0)) Then
                        Response.Redirect("Dashboard.aspx")
                    Else
                        clsMessages.ShowMessage(lblRes, MessageTypesEnum.CustomErr, Me, Nothing, "")
                        Exit Sub
                    End If
                Else
                    clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Invalid Password")
                End If

            End If
        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub


    ''' <summary>
    ''' If user exist then fill cookie based on user type (Employee or Manager) and return true.
    ''' If not exist return false.
    ''' </summary>
    Private Function CreateCookie(dr As DataRow) As Boolean
        Try
            Dim userCookie As HttpCookie = New HttpCookie("UpSkillsSchool")
            userCookie("Username") = PublicFunctions.Encrypt(txtUsername.Text)
            userCookie("UserId") = PublicFunctions.Encrypt(dr("UserId").ToString())
            userCookie("Name") = PublicFunctions.Encrypt(dr("FullName").ToString())
            userCookie("Email") = PublicFunctions.Encrypt(dr("Email").ToString())
            userCookie("OwnerType") = PublicFunctions.Encrypt(dr("OwnerType").ToString().ToLower)
            userCookie("OwnerId") = PublicFunctions.Encrypt(dr("OwnerId").ToString().ToLower)
            userCookie("UserType") = PublicFunctions.Encrypt(dr("UserType").ToString().ToLower)
            userCookie("Remember") = PublicFunctions.Encrypt(chkRememberMe.Checked)


            If chkRememberMe.Checked = True Then
                userCookie.Expires = Today.AddDays(30)

            End If
            Response.Cookies.Add(userCookie)
            Return True
        Catch ex As Exception
            Return False
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Function

#End Region


End Class

