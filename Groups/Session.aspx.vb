﻿#Region "Import"

Imports clsBindDDL
Imports System.Data
Imports clsMessages
Imports PublicFunctions
Imports System.Data.SqlClient
Imports BusinessLayer.BusinessLayer

#End Region

Partial Class Session
    Inherits Page

#Region "Global Variable"

    Dim UserID As String = "0"
    Dim School_ID As String = "1"
    ReadOnly _sqlconn As New SqlConnection(DBContext.GetConnectionString)
    Dim _sqltrans As SqlTransaction

#End Region

#Region "Page load"

    ' Handle page_load event
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            lblRes.Visible = False
            UserID = GetUserId(Page)
            'School_ID = PublicFunctions.GetClientId
            If Page.IsPostBack = False Then
                Permissions.CheckPermisions(New GridView, New LinkButton, New TextBox, New LinkButton, Me.Page, UserID)
                CheckQueryString()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    Private Sub CheckQueryString()
        Try
            Dim group_id As Integer = IntFormat(Request.QueryString("GroupID"))
            If group_id <> 0 Then
                txtGroupID.Text = getValue("Name", "tblGroups", group_id)
                hfGroupID.Value = group_id
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

#Region "Validation"

    Private Function IsValidForm() As Boolean
        Try
            ' validate group id
            If IntFormat(hfGroupID.Value) = 0 Then
                ShowInfoMessgage(lblRes, "Group is not valid", Me)
                Return False
            End If
            ' validate session date
            If IsDate(txtIssueDate.Text) Then
                ShowInfoMessgage(lblRes, "Session Date is not valid", Me)
                Return False
            End If
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

#End Region

#Region "Save"

    Protected Sub Save()
        Try
            Dim da As New TblSessionsFactory
            If lbSave.CommandArgument = "Add" Then
                Insert(da)
            End If
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Sub Insert(da As TblSessionsFactory)
        Try
            Dim dt As New TblSessions
            If Not FillDT(dt, "Add") Then
                ShowInfoMessgage(lblRes, "Error", Me)
                Exit Sub
            End If
            If Not IsCodeUnique("tblSessions", "Code", Val(dt.Id), dt.Code, School_ID) Then
                ShowInfoMessgage(lblRes, "Code is not unique", Me)
                Exit Sub
            End If
            _sqlconn.Open()
            _sqltrans = _sqlconn.BeginTransaction()
            If Not da.InsertTrans(dt, _sqlconn, _sqltrans) Then
                ShowInfoMessgage(lblRes, "Error", Me)
                _sqltrans.Rollback()
                _sqlconn.Close()
                Exit Sub
            End If
            _sqltrans.Commit()
            _sqlconn.Close()
            Clear()
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
        End Try
    End Sub

    Private Function FillDT(dt As TblSessions, Mode As String) As Boolean
        Try
            If Not IsValidForm() Then
                Return False
            End If
            dt.GroupId = IntFormat(hfGroupID.Value)
            dt.Code = txtCode.Text.Trim
            dt.Title = txtTitle.Text.Trim
            dt.IssueDate = txtIssueDate.Text
            dt.DefaultPeriodHour = GetDecimalValue(txtDefaultPeriodHour.Text)
            dt.Remarks = txtRemarks.Text
            dt.Status = GetLookupID("SessionStatus", "Pending", School_ID)
            dt.StatusRemarks = String.Empty
            dt.UpdatedBy = UserID
            dt.UpdatedDate = DateTime.Now
            dt.IsDeleted = False
            dt.SchoolId = School_ID
            If Mode = "Add" Then
                dt.Code = GenerateCode.GenerateCodeFor(Stackholders.Group)
                dt.CreatedBy = UserID
                dt.CreatedDate = DateTime.Now
            End If
            Return True
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.Insert, Page)
            Return False
        End Try
    End Function

#End Region

#Region "Cancel"

    Protected Sub Cancel(sender As Object, e As EventArgs)
        Response.Redirect("~/Dashboard.aspx")
    End Sub

    Protected Sub Clear()
        Try
            txtCode.Text = String.Empty
            txtTitle.Text = String.Empty
            txtIssueDate.Text = String.Empty
            txtDefaultPeriodHour.Text = String.Empty
            txtRemarks.Text = String.Empty
        Catch ex As Exception
            ShowMessage(lblRes, MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

#End Region

End Class