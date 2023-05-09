﻿Imports BusinessLayer.BusinessLayer

Public Class GenerateCode

    Public Shared Function GenerateCodeFor(type As PublicFunctions.Stackholders) As String
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
                Case PublicFunctions.Stackholders.Messages
                    query = "select max(ID) + 1 from TblMessages"
            End Select
            If String.IsNullOrEmpty(query) Then
                Return String.Empty
            End If
            Return DBContext.Getdatatable(query).Rows(0).Item(0).ToString
        Catch ex As Exception
            Throw ex
            Return String.Empty
        End Try
    End Function

End Class