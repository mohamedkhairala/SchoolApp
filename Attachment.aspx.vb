#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports AjaxControlToolkit.HTMLEditor
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports PublicFunctions

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
                FillDDL()
                View()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub FillDDL()
        Try
            FillDropDownList(ddlCourse, "select ID, (Code + ' - ' + Name) as Course from vw_Courses where SchoolID = " & School_Id & ";", "ID", "Course", True)
            'FillDropDownList(ddlGroup, "select ID, Name as [Group] from vw_Groups where SchoolID = " & School_Id & ";", "ID", "Group", True)
            'FillDropDownList(ddlSession, "select ID, Title as Session from vw_Sessions where SchoolID = " & School_Id & ";", "ID", "Session", True)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
#Region "DDL Actions"

    Protected Sub SelectCourse(sender As Object, e As EventArgs)
        Try
            ddlGroup.Items.Clear()
            If IntFormat(ddlCourse.SelectedValue) = 0 Then
                FillDropDownList(ddlGroup, "select 0 as ID, 'Please Select Group' as [Group] union select ID, Name as [Group] from vw_Groups where SchoolID = " & School_Id & ";", "ID", "Group", True)
            Else
                FillDropDownList(ddlGroup, "select 0 as ID, 'Please Select Group' as [Group] union select ID, Name as [Group] from vw_Groups where CourseID = " & IntFormat(ddlCourse.SelectedValue) & " and SchoolID = " & School_Id & ";", "ID", "Group", False)
            End If
            ddlGroup.SelectedIndex = -1
            ddlSession.SelectedIndex = -1
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Protected Sub SelectGroup(sender As Object, e As EventArgs)
        Try
            ddlSession.Items.Clear()
            If IntFormat(ddlGroup.SelectedValue) = 0 Then
                FillDropDownList(ddlSession, "select 0 as ID, 'Please Select Session' as [Session] union select ID, Title as Session from vw_Sessions where SchoolID = " & School_Id & ";", "ID", "Session", True)
            Else
                FillDropDownList(ddlSession, "select 0 as ID, 'Please Select Session' as [Session] union select ID, Title as Session from vw_Sessions where GroupID = " & IntFormat(ddlGroup.SelectedValue) & " and SchoolID = " & School_Id & ";", "ID", "Session", False)
            End If
            ddlSession.SelectedIndex = -1
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Protected Sub SelectSession(sender As Object, e As EventArgs)
        Try
            Dim query As String = "select CourseID, GroupID, DefaultPeriodHour, TeacherID, SupervisorID from vw_Sessions " &
                "where ID = " & IntFormat(ddlSession.SelectedValue) & " and SchoolID = " & School_Id & ";"
            Dim dt As DataTable = DBContext.Getdatatable(query)
            If dt.Rows.Count = 0 Then
                Exit Sub
            End If
            SetDDLValue(ddlCourse, dt.Rows(0).Item("CourseID").ToString)
            SetDDLValue(ddlGroup, dt.Rows(0).Item("GroupID").ToString)

        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
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

                lbSave.CommandArgument = "Edit"
                pnlForm.Enabled = Mode = "Edit"
                divActions.Visible = Mode = "View"
            End If

            lblTitle.Text = IIf(String.IsNullOrEmpty(Mode), "Add New Attachments", Mode & " Attachments")
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region
#Region "Cancel"
    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("Dashboard.aspx")
    End Sub
    Protected Sub Edit(sender As Object, e As EventArgs)
        pnlForm.Enabled = True
        sender.visible = False
        lbSave.CommandArgument = "Edit"
        lblTitle.Text = "Edit Attachments"
        divActions.Visible = False
    End Sub

    Protected Sub Clear()


    End Sub

#End Region


#Region "Attachments"
    Protected Sub UploadFile()
        Try
            Dim Attachments As DataTable
            Dim gvFiles As GridView
            Dim isTeacher As Boolean = False
            If isTeacher Then
                Attachments = GetTeacherUploadedFilesDT()
                gvFiles = gvTeacherFiles
            Else
                Attachments = GetStudentUploadedFilesDT()
                gvFiles = gvStudentFiles
            End If

            If fuAttachments.HasFiles Then
                Dim Path As String = Server.MapPath("~/Attachments/")
                For Each f As HttpPostedFile In fuAttachments.PostedFiles

                    Dim FName As String = DateTime.Now.ToString.Replace("/", "_").Replace(":", "_").Replace(" ", "_") & "_" & f.FileName
                    Dim FileURl = System.IO.Path.Combine(Path, FName)
                    fuAttachments.SaveAs(FileURl)

                    Dim dr As DataRow = Attachments.NewRow
                    dr("ID") = fuAttachments.PostedFiles.IndexOf(f) + 1
                    dr("URL") = "~/Attachments/" + FName
                    dr("FileName") = f.FileName
                    dr("Description") = ""
                    Attachments.Rows.Add(dr)
                Next

            End If
            gvFiles.DataSource = Attachments
            gvFiles.DataBind()
            ShowNewFileTypes(gvFiles)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try

    End Sub
    Protected Function AttachmentSchema(ByRef dt As DataTable) As DataTable
        Try
            dt.Columns.Add("ID", GetType(String))
            dt.Columns.Add("FileName", GetType(String))
            dt.Columns.Add("Description", GetType(String))
            dt.Columns.Add("FileType", GetType(String))
            dt.Columns.Add("URL", GetType(String))
            Return dt
        Catch ex As Exception
            Return Nothing
        End Try
    End Function
    Protected Function GetTeacherUploadedFilesDT() As DataTable
        Dim dt As New DataTable
        Try
            dt = AttachmentSchema(dt)

            If gvTeacherFiles.Rows.Count > 0 Then
                Dim i As Integer = 0
                While i < gvTeacherFiles.Rows.Count
                    Dim dr As DataRow = dt.NewRow
                    dr("FileName") = CType(gvTeacherFiles.Rows(i).FindControl("txtName"), TextBox).Text
                    dr("Description") = CType(gvTeacherFiles.Rows(i).FindControl("txtDescription"), TextBox).Text
                    If CType(gvTeacherFiles.Rows(i).FindControl("ddlFileType"), DropDownList).SelectedValue <> vbNullString Then
                        dr("FileType") = CType(gvTeacherFiles.Rows(i).FindControl("ddlFileType"), DropDownList).SelectedValue
                    End If
                    dr("URL") = CType(gvTeacherFiles.Rows(i).FindControl("lblDocumentCopy"), Label).Text
                    dt.Rows.Add(dr)
                    i += 1
                End While
            End If
            Return dt
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Function

    Protected Function GetStudentUploadedFilesDT() As DataTable
        Dim dt As New DataTable
        Try
            dt = AttachmentSchema(dt)

            If gvStudentFiles.Rows.Count > 0 Then
                Dim i As Integer = 0
                While i < gvStudentFiles.Rows.Count
                    Dim dr As DataRow = dt.NewRow
                    dr("FileName") = CType(gvStudentFiles.Rows(i).FindControl("txtName"), TextBox).Text
                    dr("Description") = CType(gvStudentFiles.Rows(i).FindControl("txtDescription"), TextBox).Text
                    If CType(gvStudentFiles.Rows(i).FindControl("ddlFileType"), DropDownList).SelectedValue <> vbNullString Then
                        dr("FileType") = CType(gvStudentFiles.Rows(i).FindControl("ddlFileType"), DropDownList).SelectedValue
                    End If
                    dr("URL") = CType(gvStudentFiles.Rows(i).FindControl("lblDocumentCopy"), Label).Text
                    dt.Rows.Add(dr)
                    i += 1
                End While
            End If
            Return dt
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Function

    Protected Sub DeleteMultiFiles(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim parent As GridViewRow = sender.parent.parent
        Dim dt As New DataTable
        Try
            Dim gvFiles As GridView
            Dim SenderId As String = parent.Parent.Parent.ID
            If SenderId = "gvTeacherFiles" Then
                dt = GetTeacherUploadedFilesDT()
                gvFiles = gvTeacherFiles
            Else
                dt = GetStudentUploadedFilesDT()
                gvFiles = gvStudentFiles
            End If

            If dt.Rows.Count > 0 Then
                dt.Rows.RemoveAt(parent.RowIndex)
            End If
            gvFiles.DataSource = dt
            gvFiles.DataBind()
            ShowNewFileTypes(gvFiles)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub ShowNewFileTypes(ByRef gvFiles As GridView)
        Try
            For Each row As GridViewRow In gvFiles.Rows
                Dim imgDoc As System.Web.UI.WebControls.Image = DirectCast(row.FindControl("file"), System.Web.UI.WebControls.Image)
                Dim imgIcon As System.Web.UI.WebControls.Image = DirectCast(row.FindControl("fileIcon"), System.Web.UI.WebControls.Image)
                If imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "doc" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "docx" Then
                    imgIcon.ImageUrl = "~/images/word.png"
                ElseIf imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "xls" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "xlsx" Then
                    imgIcon.ImageUrl = "~/images/icon-xlsx.png"
                ElseIf imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "ppt" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "pptx" Then
                    imgIcon.ImageUrl = "~/images/powerpoint.png"
                ElseIf imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "pdf" Then
                    imgIcon.ImageUrl = "~/images/pdf_icon.jpg"
                ElseIf imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "txt" Then
                    imgIcon.ImageUrl = "~/images/icon-text.png"
                ElseIf imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "jpg" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "jpeg" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "jpeg" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "png" Or imgDoc.ImageUrl.ToString.Split(".").Last.ToLower = "gif" Then
                    Dim img = imgDoc.ImageUrl.Split("/").Last
                    imgIcon.ImageUrl = "/Attachments/" + img '"/Accounts_Module/Accounts_Upload/" + lblClientFolderName.Text + "/" + img
                Else
                    imgIcon.ImageUrl = "~/images/doc_photo.png"
                End If
            Next
        Catch ex As Exception
            clsMessages.ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub gvTeacherFiles_ItemDataBound(sender As Object, e As EventArgs) Handles gvTeacherFiles.DataBound

        Dim Types As String = "Select tblLookupValue.Id,Value from tblLookupValue inner join tblLookup on tblLookup.ID = tblLookupValue.lookupid  where tblLookup.Type='FileType' and isnull(tblLookupValue.isDeleted,0)=0 and tblLookupValue.schoolId='" + School_Id + "'"
        Dim dt As DataTable = DBContext.Getdatatable(Types)
        For Each row As GridViewRow In gvTeacherFiles.Rows
            Dim FileType As String = CType(row.FindControl("lblFileType"), Label).Text
            Dim ddlTypes As DropDownList = CType(row.FindControl("ddlFileType"), DropDownList)
            clsBindDDL.BindCustomDDLs(dt, "Value", "Id", ddlTypes, True,,, FileType)
            'ddlTypes.SelectedValue = FileCategory ' PublicFunctions.GetLockupId("Pending", "RequisitionStatus")
        Next
    End Sub

    Private Sub gvStudentFiles_ItemDataBound(sender As Object, e As EventArgs) Handles gvStudentFiles.DataBound

        Dim Types As String = "Select tblLookupValue.Id,Value from tblLookupValue inner join tblLookup on tblLookup.ID = tblLookupValue.lookupid  where tblLookup.Type='FileType' and isnull(tblLookupValue.isDeleted,0)=0 and tblLookupValue.schoolId='" + School_Id + "'"
        Dim dt As DataTable = DBContext.Getdatatable(Types)
        For Each row As GridViewRow In gvStudentFiles.Rows
            Dim FileType As String = CType(row.FindControl("lblFileType"), Label).Text

            Dim ddlTypes As DropDownList = CType(row.FindControl("ddlFileType"), DropDownList)
            clsBindDDL.BindCustomDDLs(dt, "Value", "Id", ddlTypes, True,,, FileType)
        Next
    End Sub
#End Region
End Class
