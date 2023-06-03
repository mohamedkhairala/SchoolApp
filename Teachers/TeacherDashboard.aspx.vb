#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class TeacherDashboard
    Inherits System.Web.UI.Page
#Region "Global Variable"
    Dim UserID As String = "0"
    Dim School_Id As String = "1"
    Dim FormQry As String = "Select * from vw_Supervisors "
#End Region

#Region "Page load"
    ''' <summary>
    ''' Handle page_load event
    ''' </summary>
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = PublicFunctions.GetUserId(Page)
            If Page.IsPostBack = False Then

            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillMessages()
        Dim dt = DBContext.Getdatatable("Select TOP(10) * from vw_Messages")
        rpMessages.DataSource = dt
        rpMessages.DataBind()
    End Sub
#End Region
End Class
