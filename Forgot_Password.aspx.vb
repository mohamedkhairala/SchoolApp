
#Region "Import"
Imports System.Data
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports PGSample.Account

#End Region

Partial Class Forgot_Password
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
                Response.Redirect("~/Dashboard.aspx")
                Exit Sub
            End If

        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub

#End Region


#Region "Email"
    Protected Sub SendEmail()
        Try

            Dim dtUserCheck As DataTable = DBContext.Getdatatable("SELECT * FROM tblUsers WHERE Active =1 and isnull(isDeleted,0)=0 and Email=@Par1 ", txtEmail.Text.Trim)
            If dtUserCheck.Rows.Count > 0 Then
                Dim CPUserId As String = dtUserCheck.Rows(0).Item("UserId").ToString
                Dim Password As String = PublicFunctions.Decrypt(dtUserCheck.Rows(0).Item("Password"))
                Dim Body As String = "Your Password : " + Password + ""
                If clsEmails.SendEmail("Forget Password", dtUserCheck.Rows(0).Item("Email"), Body, True) Then
                    clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMSuccess, Me, Nothing, "Email has been sent successfully")
                Else
                    clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Email Not Sent")
                End If


            Else
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Invalid Username")
            End If
        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub
#End Region
End Class

