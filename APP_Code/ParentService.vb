Imports BusinessLayer.BusinessLayer
Imports Microsoft.VisualBasic

Public Class ParentService
    Private Shared ReadOnly UserId As String = PublicFunctions.GetUserId
    Public Shared Function DeleteParent(ByVal ParentId As String) As Boolean
        Try
            If Not IsNumeric(ParentId) Then
                Return False
            End If
            Dim str As String = "Update TblParents Set isDeleted=1, DeletedBy ='" & UserId & "',DeletedDate=GetDate() where ID=" & ParentId & ";"
            If DBContext.ExcuteQuery(str) < 1 Then
                Return False
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
End Class
