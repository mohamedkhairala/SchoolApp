#Region "Import"
Imports clsMessages
#End Region
Partial Class Add_ReceiptVoucher
    Inherits System.Web.UI.Page
#Region "Page load"
    ''' <summary>
    ''' Handle page_load event
    ''' </summary>
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
End Class
