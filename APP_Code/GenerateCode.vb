Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

Public Class GenerateCode

    Public Shared Function GenerateCodeFor(type As PublicFunctions.Stackholders, Optional _sqlconn As SqlConnection = Nothing, Optional _sqltrans As SqlTransaction = Nothing) As String
        Try
            Dim query = ""
            Select Case type
                Case PublicFunctions.Stackholders.Student
                    query = "select ('STD' + format(max(ID) + 1, '000000')) from TblStudents"
                Case PublicFunctions.Stackholders.Teacher
                    query = "select ('TCH' + format(max(ID) + 1, '000000')) from TblStudents"
                Case PublicFunctions.Stackholders.Supervisor
                    query = "select ('SUP' + format(max(ID) + 1, '000000')) from TblSupervisors"
                Case PublicFunctions.Stackholders.Parent
                    query = "select ('PNT' + format(max(ID) + 1, '000000')) from TblParents"
                Case PublicFunctions.Stackholders.Course
                    query = "select ('CRS' + format(max(ID) + 1, '000000')) from TblCourses"
                Case PublicFunctions.Stackholders.Group
                    query = "select ('GRP' + format(max(ID) + 1, '000000')) from TblGroups"
                Case PublicFunctions.Stackholders.Session
                    query = "select ('SEN' + format(max(ID) + 1, '000000')) from TblSessions"
                Case PublicFunctions.Stackholders.Attendance
                    query = "select ('ATD' + format(max(ID) + 1, '000000')) from TblAttendance"
                Case PublicFunctions.Stackholders.Messages
                    query = "select max(ID) + 1 from TblMessages"
            End Select
            If String.IsNullOrEmpty(query) Then
                Return String.Empty
            End If
            If _sqlconn Is Nothing AndAlso _sqltrans Is Nothing Then
                Return DBContext.Getdatatable(query).Rows(0).Item(0).ToString
            Else
                Return DBContext.GetdatatableTrans(query, _sqlconn, _sqltrans).Rows(0).Item(0).ToString
            End If
        Catch ex As Exception
            Throw ex
            Return String.Empty
        End Try
    End Function

    Public Shared Function GenerateCodeFor(type As PublicFunctions.Stackholders, new_id As Integer, Optional _sqlconn As SqlConnection = Nothing, Optional _sqltrans As SqlTransaction = Nothing) As String
        Try
            Dim query = ""
            Select Case type
                Case PublicFunctions.Stackholders.Student
                    query = "select ('STD' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Teacher
                    query = "select ('TCH' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Supervisor
                    query = "select ('SUP' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Parent
                    query = "select ('PNT' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Course
                    query = "select ('CRS' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Group
                    query = "select ('GRP' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Session
                    query = "select ('SEN' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Attendance
                    query = "select ('ATD' + format(" & new_id & ", '000000'))"
                Case PublicFunctions.Stackholders.Messages
                    query = "select " & new_id & ""
            End Select
            If String.IsNullOrEmpty(query) Then
                Return String.Empty
            End If
            If _sqlconn Is Nothing AndAlso _sqltrans Is Nothing Then
                Return DBContext.Getdatatable(query).Rows(0).Item(0).ToString
            Else
                Return DBContext.GetdatatableTrans(query, _sqlconn, _sqltrans).Rows(0).Item(0).ToString
            End If
        Catch ex As Exception
            Throw ex
            Return String.Empty
        End Try
    End Function

End Class