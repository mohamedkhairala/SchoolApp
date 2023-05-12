Imports AjaxControlToolkit.HTMLEditor.ToolbarButton
Imports System.Net
Imports System.Reflection
Imports BusinessLayer.BusinessLayer
Imports clsMessages
Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.ApplicationServices
Imports Microsoft.Web.Services3.Addressing
Imports System.Web.Services.Description
Imports System.Data.SqlClient
Imports System.Data
Imports System.CodeDom

Public Class StudentService
    Private Shared ReadOnly UserId As String = PublicFunctions.Decrypt(PublicFunctions.GetUserId)
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

#Region "Save User"
    ''' <summary>
    ''' Save User Data
    ''' </summary>
    Public Shared Function InsertUser(dtOwner As Object, ByVal OwnerType As String, _sqlconn As SqlConnection, _sqltrans As SqlTransaction) As Boolean
        Dim dtUsers As New TblUsers
        Dim daUsers As New TblUsersFactory
        Try
            'fill dtUsers 
            If Not FillUserDt(dtUsers, dtOwner, OwnerType) Then
                Return False
            End If

            'Insert Case
            If Not daUsers.InsertTrans(dtUsers, _sqlconn, _sqltrans) Then
                _sqltrans.Rollback()
                _sqlconn.Close()
                Return False
            End If

            'Save User Permissions
            Dim newUserId As String = dtUsers.UserID
            If Not SaveUserPermission(newUserId, _sqlconn, _sqltrans) Then
                _sqltrans.Rollback()
                _sqlconn.Close()
                Return False
            End If

            Return True

        Catch ex As Exception
            _sqltrans.Rollback()
            _sqlconn.Close()
            Return False
        End Try
    End Function

    ''' <summary>
    ''' Fill User Object
    ''' </summary>
    Private Shared Function FillUserDt(ByRef dtUsers As TblUsers, ByRef dtOwner As Object, ByVal OwnerType As String) As Boolean
        Try
            dtUsers.OwnerType = OwnerType
            dtUsers.OwnerId = dtOwner.Id
            dtUsers.FullName = dtOwner.Name
            dtUsers.UserName = dtOwner.Email
            dtUsers.Email = dtOwner.Email
            dtUsers.Active = True
            dtUsers.UserType = "User"
            dtUsers.Password = PublicFunctions.Encrypt(GetPassword)

            dtUsers.MobileNo = dtOwner.Mobile


            dtUsers.Photo = dtOwner.Photo

            dtUsers.CreatedBy = UserId
            dtUsers.CreatedDate = DateTime.Now

            dtUsers.ModifiedBy = UserId
            dtUsers.ModifiedDate = DateTime.Now

            dtUsers.IsDeleted = False

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Shared Function GetPassword() As String
        Try
            ''Dim s As String = "a0!1LMbNOPQ@2#3GHdIJ$4%UVWlmneXYZ5^f6CDEF&gh7*8(9)Aijk_B+KRowxyzST"
            'Dim s As String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+abcdefghijklmnopqrstuwxyz"
            'Dim r As New Random
            'Dim sb As New StringBuilder
            'For i As Integer = 1 To 8
            '    Dim idx As Integer = r.Next(0, 73)
            '    sb.Append(s.Substring(idx, 1))
            'Next
            'Return sb.ToString

            Dim Letters As New List(Of Integer)
            For i As Integer = 32 To 47
                Letters.Add(i)
            Next
            'add ASCII codes for numbers & special chars
            For i As Integer = 48 To 57
                Letters.Add(i)
            Next
            'lowercase letters
            For i As Integer = 97 To 122
                Letters.Add(i)
            Next
            'uppercase letters
            For i As Integer = 65 To 90
                Letters.Add(i)
            Next
            'select 8 random integers from number of items in Letters
            'then convert those random integers to characters and
            'add each to a string and display in Textbox
            Dim Rnd As New Random
            Dim SB As New System.Text.StringBuilder
            Dim Temp As Integer
            For count As Integer = 1 To 8
                Temp = Rnd.Next(0, Letters.Count)
                SB.Append(Chr(Letters(Temp)))
            Next

            Return SB.ToString
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Shared Function SaveUserPermission(ObjId As String, _sqlconn As SqlConnection, _sqltrans As SqlTransaction) As Boolean
        Try
            Dim UPObj As New TblUserPermissions
            Dim UPDa As New TblUserPermissionsFactory()
            Dim dt As DataTable = DBContext.Getdatatable("select ID as FormID ,FormTitle as FormTitle,0 as PAccess,0 as PAdd,0 as PUpdate,0 as PDelete,0 as PSearch,0 as PActive from tblForms where ISNULL(isDeleted,0)=0 ")

            For Each dr As DataRow In dt.Rows
                UPObj = New TblUserPermissions
                UPObj.CreatedBy = UserId
                UPObj.CreatedDate = DateTime.Now
                UPObj.IsDeleted = False

                UPObj.UserId = ObjId
                UPObj.FormID = dr("FormID")
                UPObj.PAccess = False
                UPObj.PAdd = False
                UPObj.PUpdate = False
                UPObj.PDelete = False
                UPObj.PSearch = False
                UPObj.PActive = False
                If Not UPDa.InsertTrans(UPObj, _sqlconn, _sqltrans) Then
                    Return False
                End If
            Next
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function



#End Region
End Class
