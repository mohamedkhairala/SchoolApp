#Region "Import"
Imports clsMessages
#End Region
Partial Class ReceiptVoucher
    Inherits System.Web.UI.Page
#Region "Page load"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
#End Region
End Class
