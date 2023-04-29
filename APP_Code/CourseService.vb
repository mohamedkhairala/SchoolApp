Imports BusinessLayer.BusinessLayer
Imports Microsoft.VisualBasic

Public Class CourseService
    Private Shared ReadOnly UserId As String = PublicFunctions.GetUserId
    Public Shared Function DeleteCourse(ByVal CourseId As String) As Boolean
        Try
            If Not IsNumeric(CourseId) Then
                Return False
            End If

            Dim str As String = "Update TblCourses Set isDeleted=1, DeletedBy ='" & UserId & "',DeletedDate=GetDate() where ID=" & CourseId & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                Return False
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
End Class
