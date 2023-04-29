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

#Region "Save User"
    ''' <summary>
    ''' Save User Data
    ''' </summary>
    Public Shared Function InsertUser(dtUsers As TblUsers, _sqlconn As SqlConnection, _sqltrans As SqlTransaction) As Boolean

        Dim daUsers As New TblUsersFactory
        Try
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
            'lblUserId.Text = String.Empty
            'HiddenIcon.Text = String.Empty
            'FillGrid()
            'Enabler(False)
        Catch ex As Exception
            _sqltrans.Rollback()
            _sqlconn.Close()
            Return False
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

            Return False
        End Try
    End Function



#End Region
End Class
