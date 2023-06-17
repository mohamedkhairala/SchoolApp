#Region "Import"
Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class StudentDashboard
    Inherits System.Web.UI.Page
#Region "Global Variable"

    Dim UserID As String = "0"
    Dim RelatedEntityId As String = "0"
    Dim School_Id As String = "1"
    Dim StudentCourses As String = "Select * from vw_StudentCourses "
    Dim FormQry As String = "Select * from vw_StudentDashoard "


#End Region

#Region "Page load"
    ''' <summary>
    ''' Handle page_load event
    ''' </summary>
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = PublicFunctions.GetUserId(Page)
            RelatedEntityId = 13 ' PublicFunctions.GetRelatedEntityId(Page)
            If Page.IsPostBack = False Then
                FillDashBoard()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
    Private Sub FillDashBoard()
        'Fill Counters
        FillCounters()

        'Fill Messages
        FillMessages()

        FillStudentCourses()
    End Sub
    Private Sub FillCounters()
        Dim dt = DBContext.Getdatatable(StudentCourses & " where StudentId=" & RelatedEntityId)
        rpCounters.DataSource = dt
        rpCounters.DataBind()
    End Sub
    Private Sub FillMessages()
        Dim dt = DBContext.Getdatatable("Select TOP(10) * from vw_Messages where SenderId='" & RelatedEntityId & "' Or ReceiverId='" & RelatedEntityId & "'")
        rpMessages.DataSource = dt
        rpMessages.DataBind()
    End Sub

    Private Sub FillStudentCourses()
        Dim qry = "select " &
            "STG.StudentId,c.Name as CourseName ,c.NoOfSessions, " &
            "(select COUNT(*) from vw_Sessions where CourseId=C.Id and SessionStatus='Completed') as CompletedSessions, " &
            "isnull(STG.NetAmount,0) as CoursePrice, " &
            "dbo.GetCourseRestAmount(STG.StudentId, STG.GroupId, STG.SchoolId) as CourseRestAmount " &
            "from TblStudentsGroups STG " &
            "inner join tblGroups G on G.Id = STG.GroupId " &
            "inner join TblCourses C on C.Id = G.CourseId " &
            "where isnull(STG.isdeleted,0)=0 and StudentId=" & RelatedEntityId
        Dim dt = DBContext.Getdatatable(qry)
        rpStudentCourses.DataSource = dt
        rpStudentCourses.DataBind()
    End Sub
#End Region
End Class
