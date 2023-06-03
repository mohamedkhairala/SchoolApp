Imports System.Data.SqlClient
Imports System.Runtime.InteropServices.ComTypes
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

    Public Shared Function SetTimeAgo(ByVal CreatedDate As String) As String
        Try
            If Not IsDate(CreatedDate) Then
                Return ""
            End If
            'if createddate not in today --> return the date , else (in today) calc it
            If CDate(CreatedDate).Date <> DateTime.Now.Date Then
                Return PublicFunctions.DateFormat(CreatedDate, "dd MMM yyyy HH:MM:ss")
            End If

            Dim timeDiff As TimeSpan = DateTime.Now.Subtract(Convert.ToDateTime(CreatedDate))
            Dim hoursDiff As Integer = CInt(timeDiff.TotalHours)
            Dim minuteDiff As Integer = CInt(timeDiff.TotalMinutes)
            Dim secondsDiff As Integer = CInt(timeDiff.TotalSeconds)

            If hoursDiff > 0 And hoursDiff < 24 Then
                Return hoursDiff & " Hour Ago"
            End If
            If minuteDiff > 0 And minuteDiff < 60 Then
                Return minuteDiff & " minute ago"
            End If
            If secondsDiff > 0 And secondsDiff < 60 Then
                Return secondsDiff & " seconds ago"
            End If

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


    Public Shared Function SendMessage(ByVal SenderId As Integer, ByVal ReceiverId As Integer, ByVal Title As String, ByVal Body As String, Optional _sqlconn As SqlConnection = Nothing, Optional _sqltrans As SqlTransaction = Nothing) As Boolean
        Try
            Dim daMessage As New TblMessagesFactory
            Dim msgNo = ""
            If _sqlconn Is Nothing AndAlso _sqltrans Is Nothing Then
                msgNo = GenerateCode.GenerateCodeFor(PublicFunctions.Stackholders.Messages)
            Else
                msgNo = GenerateCode.GenerateCodeFor(PublicFunctions.Stackholders.Messages, _sqlconn, _sqltrans)
            End If
            Dim dt As New TblMessages With {
            .MsgNo = msgNo,
            .SenderId = SenderId,
            .ReceiverId = ReceiverId,
            .MessageTitle = Title,
            .MessageBody = Body,
            .CreatedBy = UserId,
            .CreatedDate = DateTime.Now,
            .SchoolId = SchoolId
            }
            If _sqlconn Is Nothing AndAlso _sqltrans Is Nothing Then
                Return daMessage.Insert(dt)
            Else
                Return daMessage.InsertTrans(dt, _sqlconn, _sqltrans)
            End If
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
