
#Region "Import"
Imports System.Data
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports PGSample.Account

#End Region

Partial Class ChangePassword
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
            UserId = PublicFunctions.GetUserId(Page)


        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)

        End Try
    End Sub

#End Region

#Region "Change Password"
    Sub ChangePassword()
        Try
            Dim dtUser As DataTable = DBContext.Getdatatable("select * from tblusers where Userid='" & UserId & "' and Password='" & PublicFunctions.Encrypt(txtPassword.Text) & "'")
            If dtUser.Rows.Count > 0 Then
                If DBContext.ExcuteQuery("update tblusers set Password='" & PublicFunctions.Encrypt(txtNewPassword.Text) & "' where Userid='" & UserId & "'  ") = 1 Then
                    clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMSuccess, Me, Nothing, "Passowrd updated successfully")
                    Response.Redirect("~/Dashboard.aspx")
                End If
            Else
                clsMessages.ShowMessage(lblRes, MessageTypesEnum.CUSTOMInfo, Me, Nothing, "Old password not correct")
            End If
        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

End Class

