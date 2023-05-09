Imports BusinessLayer.BusinessLayer
Imports Microsoft.VisualBasic

Public Class clsNotifications

    Public Shared ReadOnly UserId As String = 1
    Public Shared ReadOnly SchoolId As String = 1
    Public Shared Function SetTimeAgo(ByVal CreatedDate As String, ByVal TotalSeconds As Integer) As String
        Try
            Dim H As Integer = TotalSeconds / 3600
            Dim M As Integer = TotalSeconds / 60

            If TotalSeconds < 60 Then
                Return TotalSeconds & " seconds ago"
            End If
            If M > 0 AndAlso M < 60 Then
                Return M & " minute ago"
            End If
            If H > 0 AndAlso H < 23 Then
                Return H & " hours ago"
            End If
            Return PublicFunctions.DateFormat(CreatedDate, "dd MMM yyyy HH:MM:ss")
        Catch ex As Exception
            Return ""
        End Try
    End Function

    Public Shared Function SetRandomColor() As String
        Try
            Dim colorsList As New List(Of String) From {"bg-skyblue", "bg-yellow", "bg-pink"}
            Dim random As New Random()
            Dim randomIndex As Integer = random.Next(0, colorsList.Count)
            Dim randomValue As String = colorsList(randomIndex)
            Return randomValue
        Catch ex As Exception
            Return ""
        End Try
    End Function


    Public Shared Function SendMessage(ByVal SenderId As Integer, ByVal ReceiverId As Integer, ByVal Title As String, ByVal Body As String) As Boolean
        Try
            Dim daMessage As New TblMessagesFactory
            Dim dt As New TblMessages With {
            .MsgNo = GenerateCode.GenerateCodeFor(PublicFunctions.Stackholders.Messages),
            .SenderId = SenderId,
            .ReceiverId = ReceiverId,
            .MessageTitle = Title,
            .MessageBody = Body,
            .CreatedBy = UserId,
            .CreatedDate = DateTime.Now,
            .SchoolId = SchoolId
            }
            Return daMessage.Insert(dt)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function Delete(ByVal MsgNo As String) As Boolean
        Try
            Return DBContext.ExcuteQuery("Update tblMessages set isDeleted=1,DeletedDate=getdate(),DeletedBy='" & UserId & "' where MsgNo='" & MsgNo & "'") > 0
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class
