Imports BusinessLayer.BusinessLayer
Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.ApplicationServices

Public Class StudentService
    Private Shared ReadOnly UserId As String = PublicFunctions.GetUserId
    Public Shared Function DeleteStudent(ByVal StudentId As String) As Boolean
        Try
            If Not IsNumeric(StudentId) Then
                Return False
            End If
            Dim str As String = "Update TblStudents Set isDeleted=1, DeletedBy ='" & UserId & "',DeletedDate=GetDate() where ID=" & StudentId & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                Return False
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
End Class
