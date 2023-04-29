#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports AjaxControlToolkit.HTMLEditor
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Course
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
                txtCode.Text = GenerateCode.GenerateCodeFor(PublicFunctions.Stackholders.Course)
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
            'String.IsNullOrEmpty(Mode) Or String.IsNullOrEmpty(ID)
            Dim Mode As String = Request.QueryString("Mode")
            Dim ID As String = Request.QueryString("ID")
            Dim da As New TblCoursesFactory
            Dim dt As New TblCourses
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
                dt = da.GetAllBy(TblCourses.TblCoursesFields.Id, ID).FirstOrDefault
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

    Private Function FillDT(dt As TblCourses, Mode As String) As Boolean
        Try
            If Not isValidForm() Then
                Return False
            End If
            dt.Code = txtCode.Text.Trim
            dt.Name = txtName.Text.Trim
            dt.Fees = CDec(PublicFunctions.DecimalFormat(txtFees.Text))
            dt.SessionRate = CDec(PublicFunctions.DecimalFormat(txtRatePerSession.Text))
            dt.NoOfSessions = Val(txtNoOfSessions.Text)
            dt.Remarks = txtDescription.Text
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            If Mode = "Add" Then
                dt.CreatedBy = UserID
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
                txtCode.Text = dt.Rows(0).Item("Code").ToString
                txtName.Text = dt.Rows(0).Item("Name").ToString
                txtNoOfSessions.Text = dt.Rows(0).Item("NoOfSessions").ToString
                txtFees.Text = dt.Rows(0).Item("Fees").ToString
                txtRatePerSession.Text = dt.Rows(0).Item("SessionRate").ToString

                lbSave.CommandArgument = "Edit"
                pnlForm.Enabled = Mode = "Edit"
                divActions.Visible = Mode = "View"
            End If

            lblTitle.Text = IIf(String.IsNullOrEmpty(Mode), "Add New Course", Mode & " Course")
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
#Region "Cancel"
    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("~/Dashboard.aspx")
    End Sub
    Protected Sub Edit(sender As Object, e As EventArgs)
        pnlForm.Enabled = True
        sender.visible = False
        lbSave.CommandArgument = "Edit"
        lblTitle.Text = "Edit Course"
        divActions.Visible = False
    End Sub

    Protected Sub Clear()
        txtCode.Text = String.Empty
        txtName.Text = String.Empty
        txtFees.Text = String.Empty
        txtRatePerSession.Text = String.Empty
        txtNoOfSessions.Text = String.Empty
        txtDescription.Text = String.Empty

    End Sub
#End Region


End Class
