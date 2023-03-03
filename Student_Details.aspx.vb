#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Student_Details
    Inherits System.Web.UI.Page
#Region "Global Variable"
    Dim SchoolId As String = "1"
    Dim UserID As String = "0"
    Dim _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region

#Region "Page load"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            If Page.IsPostBack = False Then
                FillGrid(sender, e)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Sub FillGrid(sender As Object, e As EventArgs)
        Try
            Dim StudentID = Request.QueryString("ID")
            If Not IsNumeric(StudentID) Then
                Exit Sub
            End If
            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Students where ID=" & StudentID)
            rpStudent.DataSource = dtTable
            rpStudent.DataBind()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
End Class
