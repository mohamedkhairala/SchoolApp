Imports Microsoft.VisualBasic
Imports BusinessLayer.BusinessLayer
Public Class GenerateCode

    Public Shared Function GenerateCodeFor(type As PublicFunctions.Stackholders) As String
        Try
            Dim qry = ""
            Select Case type
                Case PublicFunctions.Stackholders.Student
                    qry = "SELECT ('STD'+FORMAT(Max(Id)+1, '000000')) FROM TblStudents"
                Case PublicFunctions.Stackholders.Teacher
                    qry = "SELECT ('TCH'+FORMAT(Max(Id)+1, '000000')) FROM TblStudents"
                Case PublicFunctions.Stackholders.Supervisor
                    qry = "SELECT ('SUP'+FORMAT(Max(Id)+1, '000000')) FROM TblSupervisors"
                Case PublicFunctions.Stackholders.Parent
                    qry = "SELECT ('PNT'+FORMAT(Max(Id)+1, '000000')) FROM TblParents"
            End Select
            If qry = "" Then
                Return ""
            End If
            Return DBContext.Getdatatable(qry).Rows(0).Item(0).ToString
        Catch ex As Exception
            Throw ex
            Return ""
        End Try
    End Function
End Class
