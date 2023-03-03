#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Add_Student
    Inherits System.Web.UI.Page
#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_Id As String = "1"
    Dim FormQry As String = "Select * from vw_Teachers "
    Dim School_Id As String = "1"
    Dim FormQry As String = "Select * from vw_Teachers "
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
                lbEdit.Visible = False
                View()
            End If
            FillIcon()
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
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
            Dim dtTable As DataTable = DBContext.Getdatatable("select * from vw_Teachers where " + CollectConditions() + "")
            If dtTable.Rows.Count > 0 Then
                ' Initialize the sorting expression.
                If SortExpression.Value = String.Empty Then
                    SortExpression.Value = "Id ASC"
                End If
                ' Populate the GridView.
                ' Convert the DataTable to DataView.
                Dim dv As New DataView(dtTable)

                ' Set the sort column and sort order.
                dv.Sort = SortExpression.Value.ToString()

                _sqltrans.Commit()
                _sqlconn.Close()
                ShowMessage(lblRes, MessageTypesEnum.Update, Me.Page)
            End If

        Catch ex As Exception
            Throw ex
        End Try
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
            fu = fuIcon
            Dim type As String = fu.ContentType
            If type = "image/jpeg" OrElse type = "image/gif" OrElse type = "image/png" Then
                HiddenIcon.Text = "~/Users_Photos/" + fu.FileName
                fu.SaveAs(Path + fu.FileName)
            End If
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
