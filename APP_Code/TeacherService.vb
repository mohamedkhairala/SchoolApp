Imports BusinessLayer.BusinessLayer
Imports Microsoft.VisualBasic

Public Class TeacherService
    Private Shared ReadOnly UserId As String = PublicFunctions.GetUserId
    Public Shared Function DeleteTeacher(ByVal TeacherId As String) As Boolean
        Try
            If Not IsNumeric(TeacherId) Then
                Return False
            End If
            Dim str As String = "Update TblTeachers Set isDeleted=1, DeletedBy ='" & UserId & "',DeletedDate=GetDate() where ID=" & TeacherId & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                Return False
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
End Class
