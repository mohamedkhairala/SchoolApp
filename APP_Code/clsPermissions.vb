#Region "Imports"
Imports System.Data
Imports BusinessLayer.BusinessLayer

#End Region

Public Class Permissions
    Public Shared Function GetPermissions(ByVal page As Page, ByVal User_Id As String) As DataTable
        Try
            Dim pageName As String = PublicFunctions.GetPageName(page.Request.Url.ToString)

            Dim dt As DataTable = DBContext.Getdatatable("SELECT per.* FROM TblUserPermissions per, TblForms frm WHERE per.FormId = frm.Id and per.UserId='" + User_Id + "'  and frm.FormName='" + pageName + "' ")
            Return dt
        Catch ex As Exception
            Return Nothing
        End Try
    End Function
    Public Shared Function CheckPermisions(ByRef grid As GridView, ByRef Add As LinkButton, ByRef Edit As LinkButton, ByRef Delete As LinkButton, ByRef Search As TextBox, ByRef lbSearch As LinkButton, ByVal page As Page, ByVal pagename As String, ByVal User_Id As String) As Boolean
        Try

            'Get permissions datatable depend on user id of group id assigned
            Dim dt As DataTable = DBContext.Getdatatable("SELECT per.* FROM TblUserPermissions per, TblForms frm WHERE per.FormId = frm.Id and per.UserId='" + User_Id + "'  and frm.FormName='" + pagename + "' ")

            If dt.Rows.Count <> 0 Then
                Add.Visible = dt.Rows(0).Item("PAdd").ToString
                Edit.Visible = dt.Rows(0).Item("PUpdate").ToString
                Delete.Visible = dt.Rows(0).Item("PDelete").ToString

                Search.Visible = dt.Rows(0).Item("PSearch").ToString
                lbSearch.Visible = dt.Rows(0).Item("PSearch").ToString
                Dim P_Update As String = dt.Rows(0).Item("PUpdate").ToString
                Dim P_Delete As String = dt.Rows(0).Item("PDelete").ToString
                Dim P_Active As String = dt.Rows(0).Item("PActive").ToString
                Dim i As Integer
                While i < grid.Columns.Count
                    If grid.Columns(i).HeaderText = "تحديث" OrElse grid.Columns(i).HeaderText = "تعديل" Then
                        grid.Columns(i).Visible = P_Update
                    End If
                    If grid.Columns(i).HeaderText = "حذف" OrElse grid.Columns(i).HeaderText = "مسح" Then
                        grid.Columns(i).Visible = P_Delete
                    End If
                    If grid.Columns(i).HeaderText = "تفعيل" Then
                        grid.Columns(i).Visible = P_Active
                    End If
                    i += 1
                End While

                If (dt.Rows(0).Item("PAccess").ToString) Then
                    Return True
                Else
                    page.Response.Redirect("~/AccessDenied.aspx", False)
                    Return False
                End If
            Else
                page.Response.Redirect("~/AccessDenied.aspx", False)
                Return False
            End If

            Return True
        Catch ex As Exception
            page.Response.Redirect("~/AccessDenied.aspx", False)
            Return False
        End Try
    End Function
    'For Access, Gridview, Add, Edit, Delete buttons and search box
    Public Shared Function CheckPermisions(ByRef grid As GridView, ByRef Add As LinkButton, ByRef Edit As LinkButton, ByRef Delete As LinkButton, ByRef Search As TextBox, ByRef lbSearch As LinkButton, ByVal page As Page, ByVal User_Id As String) As Boolean
        Try

            'Get permissions datatable depend on user id of group id assigned
            Dim dt As DataTable = GetPermissions(page, User_Id)

            If dt.Rows.Count <> 0 Then
                Add.Visible = dt.Rows(0).Item("PAdd").ToString
                Edit.Visible = dt.Rows(0).Item("PUpdate").ToString
                Delete.Visible = dt.Rows(0).Item("PDelete").ToString

                Search.Visible = dt.Rows(0).Item("PSearch").ToString
                lbSearch.Visible = dt.Rows(0).Item("PSearch").ToString
                Dim P_Update As String = dt.Rows(0).Item("PUpdate").ToString
                Dim P_Delete As String = dt.Rows(0).Item("PDelete").ToString
                Dim P_Active As String = dt.Rows(0).Item("PActive").ToString
                Dim i As Integer
                While i < grid.Columns.Count
                    If grid.Columns(i).HeaderText = "تحديث" OrElse grid.Columns(i).HeaderText = "تعديل" Then
                        grid.Columns(i).Visible = P_Update
                    End If
                    If grid.Columns(i).HeaderText = "حذف" OrElse grid.Columns(i).HeaderText = "مسح" Then
                        grid.Columns(i).Visible = P_Delete
                    End If
                    If grid.Columns(i).HeaderText = "تفعيل" Then
                        grid.Columns(i).Visible = P_Active
                    End If
                    i += 1
                End While

                If (dt.Rows(0).Item("PAccess").ToString) Then
                    Return True
                Else
                    page.Response.Redirect("~/AccessDenied.aspx", False)
                    Return False
                End If
            Else
                page.Response.Redirect("~/AccessDenied.aspx", False)
                Return False
            End If

            Return True
        Catch ex As Exception
            page.Response.Redirect("~/AccessDenied.aspx", False)
            Return False
        End Try
    End Function
    'For Access, Gridview, Add button and search box
    Public Shared Function CheckPermisions(ByRef grid As GridView, ByRef Add As LinkButton, ByRef Search As TextBox, ByRef lbSearch As LinkButton, ByVal page As Page, ByVal User_Id As String) As Boolean
        Try

            'Get permissions datatable depend on user id of group id assigned
            Dim dt As DataTable = GetPermissions(page, User_Id)

            If dt.Rows.Count <> 0 Then
                Add.Visible = dt.Rows(0).Item("PAdd").ToString

                Search.Visible = dt.Rows(0).Item("PSearch").ToString
                lbSearch.Visible = dt.Rows(0).Item("PSearch").ToString
                Dim P_Update As String = dt.Rows(0).Item("PUpdate").ToString
                Dim P_Delete As String = dt.Rows(0).Item("PDelete").ToString
                Dim P_Active As String = dt.Rows(0).Item("PActive").ToString
                Dim i As Integer
                While i < grid.Columns.Count
                    If grid.Columns(i).HeaderText = "تحديث" OrElse grid.Columns(i).HeaderText = "تعديل" Then
                        grid.Columns(i).Visible = P_Update
                    End If
                    If grid.Columns(i).HeaderText = "حذف" OrElse grid.Columns(i).HeaderText = "مسح" Then
                        grid.Columns(i).Visible = P_Delete
                    End If
                    If grid.Columns(i).HeaderText = "تفعيل" Then
                        grid.Columns(i).Visible = P_Active
                    End If
                    i += 1
                End While

                If (dt.Rows(0).Item("PAccess").ToString) Then
                    Return True
                Else
                    page.Response.Redirect("~/AccessDenied.aspx", False)
                    Return False
                End If
            Else
                page.Response.Redirect("~/AccessDenied.aspx", False)
                Return False
            End If

            Return True
        Catch ex As Exception
            page.Response.Redirect("~/AccessDenied.aspx", False)
            Return False
        End Try
    End Function
    'For Access, Listview, Add button and search box
    Public Shared Function CheckPermisions(ByRef list As ListView, ByRef Add As LinkButton, ByRef Search As TextBox, ByRef lbSearch As LinkButton, ByVal page As Page, ByVal User_Id As String) As Boolean
        Try

            'Get permissions datatable depend on user id of group id assigned
            Dim dt As DataTable = GetPermissions(page, User_Id)


            If dt.Rows.Count <> 0 Then
                Add.Visible = dt.Rows(0).Item("PAdd").ToString

                Search.Visible = dt.Rows(0).Item("PSearch").ToString
                lbSearch.Visible = dt.Rows(0).Item("PSearch").ToString
                Dim P_Update As String = dt.Rows(0).Item("PUpdate").ToString
                Dim P_Delete As String = dt.Rows(0).Item("PDelete").ToString
                Dim P_Active As String = dt.Rows(0).Item("PActive").ToString
                If list.DataSource IsNot Nothing Then
                    Dim i As Integer
                    While i < list.Items.Count
                        'Apply permissions on header
                        Dim tdEdit As HtmlTableCell = CType(list.Items(i).FindControl("Edit"), HtmlTableCell)
                        If tdEdit IsNot Nothing Then
                            tdEdit.Visible = P_Update
                        End If
                        Dim tdEditHeader As HtmlTableCell = CType(list.FindControl("EditHeader"), HtmlTableCell)
                        If tdEditHeader IsNot Nothing Then
                            tdEditHeader.Visible = P_Update
                        End If
                        Dim tdDelete As HtmlTableCell = CType(list.Items(i).FindControl("Delete"), HtmlTableCell)
                        If tdDelete IsNot Nothing Then
                            tdDelete.Visible = P_Delete
                        End If
                        Dim tdDeleteHeader As HtmlTableCell = CType(list.FindControl("DeleteHeader"), HtmlTableCell)
                        If tdDeleteHeader IsNot Nothing Then
                            tdDeleteHeader.Visible = P_Delete
                        End If

                        Dim tdActive As HtmlTableCell = CType(list.Items(i).FindControl("Active"), HtmlTableCell)
                        If tdActive IsNot Nothing Then
                            tdActive.Visible = P_Active
                        End If
                        Dim tdActiveHeader As HtmlTableCell = CType(list.FindControl("ActiveHeader"), HtmlTableCell)
                        If tdActiveHeader IsNot Nothing Then
                            tdActiveHeader.Visible = P_Active
                        End If


                        Dim pnlEdit As Panel = CType(list.Items(i).FindControl("pnlEdit"), Panel)
                        If pnlEdit IsNot Nothing Then
                            pnlEdit.Visible = P_Update
                            pnlEdit.CssClass = "pull-left m-l-5"
                        End If
                        Dim pnlDelete As Panel = CType(list.Items(i).FindControl("pnlDelete"), Panel)
                        If pnlDelete IsNot Nothing Then
                            pnlDelete.Visible = P_Delete
                            pnlDelete.CssClass = "pull-left m-l-5"
                        End If
                        Dim pnlPrint As Panel = CType(list.Items(i).FindControl("pnlPrint"), Panel)
                        If pnlPrint IsNot Nothing Then
                            pnlPrint.Visible = P_Active
                            pnlPrint.CssClass = "pull-left m-l-5"
                        End If
                        i += 1
                    End While
                End If


                If (dt.Rows(0).Item("PAccess").ToString) Then
                    Return True
                Else
                    page.Response.Redirect("~/AccessDenied.aspx", False)
                    Return False
                End If
            Else
                page.Response.Redirect("~/AccessDenied.aspx", False)
                Return False
            End If

            Return True
        Catch ex As Exception
            page.Response.Redirect("~/AccessDenied.aspx", False)
            Return False
        End Try
    End Function
    'For Access, Listview, Add button and search box
    Public Shared Function CheckPermisions(ByRef list As ListView, ByRef Add As LinkButton, ByRef Search As TextBox, ByRef lbSearch As LinkButton, ByVal page As Page, ByVal pageName As String, ByVal User_Id As String) As Boolean
        Try

            'Get permissions datatable depend on user id of group id assigned
            Dim dt As DataTable = DBContext.Getdatatable("SELECT per.* FROM TblUserPermissions per, TblForms frm WHERE per.FormId = frm.Id and per.UserId='" + User_Id + "'  and frm.FormName='" + pageName + "' ")



            If dt.Rows.Count <> 0 Then
                Add.Visible = dt.Rows(0).Item("PAdd").ToString

                Search.Visible = dt.Rows(0).Item("PSearch").ToString
                lbSearch.Visible = dt.Rows(0).Item("PSearch").ToString
                Dim P_Update As String = dt.Rows(0).Item("PUpdate").ToString
                Dim P_Delete As String = dt.Rows(0).Item("PDelete").ToString
                Dim P_Active As String = dt.Rows(0).Item("PActive").ToString
                If list.DataSource IsNot Nothing Then
                    Dim i As Integer
                    While i < list.Items.Count
                        'Apply permissions on header
                        Dim tdEdit As HtmlTableCell = CType(list.Items(i).FindControl("Edit"), HtmlTableCell)
                        If tdEdit IsNot Nothing Then
                            tdEdit.Visible = P_Update
                        End If
                        Dim tdEditHeader As HtmlTableCell = CType(list.FindControl("EditHeader"), HtmlTableCell)
                        If tdEditHeader IsNot Nothing Then
                            tdEditHeader.Visible = P_Update
                        End If
                        Dim tdDelete As HtmlTableCell = CType(list.Items(i).FindControl("Delete"), HtmlTableCell)
                        If tdDelete IsNot Nothing Then
                            tdDelete.Visible = P_Delete
                        End If
                        Dim tdDeleteHeader As HtmlTableCell = CType(list.FindControl("DeleteHeader"), HtmlTableCell)
                        If tdDeleteHeader IsNot Nothing Then
                            tdDeleteHeader.Visible = P_Delete
                        End If

                        Dim tdActive As HtmlTableCell = CType(list.Items(i).FindControl("Active"), HtmlTableCell)
                        If tdActive IsNot Nothing Then
                            tdActive.Visible = P_Active
                        End If
                        Dim tdActiveHeader As HtmlTableCell = CType(list.FindControl("ActiveHeader"), HtmlTableCell)
                        If tdActiveHeader IsNot Nothing Then
                            tdActiveHeader.Visible = P_Active
                        End If


                        Dim pnlEdit As Panel = CType(list.Items(i).FindControl("pnlEdit"), Panel)
                        If pnlEdit IsNot Nothing Then
                            pnlEdit.Visible = P_Update
                            pnlEdit.CssClass = "pull-left m-l-5"
                        End If
                        Dim pnlDelete As Panel = CType(list.Items(i).FindControl("pnlDelete"), Panel)
                        If pnlDelete IsNot Nothing Then
                            pnlDelete.Visible = P_Delete
                            pnlDelete.CssClass = "pull-left m-l-5"
                        End If
                        Dim pnlPrint As Panel = CType(list.Items(i).FindControl("pnlPrint"), Panel)
                        If pnlPrint IsNot Nothing Then
                            pnlPrint.Visible = P_Active
                            pnlPrint.CssClass = "pull-left m-l-5"
                        End If
                        i += 1
                    End While
                End If


                If (dt.Rows(0).Item("PAccess").ToString) Then
                    Return True
                Else
                    page.Response.Redirect("~/AccessDenied.aspx", False)
                    Return False
                End If
            Else
                page.Response.Redirect("~/AccessDenied.aspx", False)
                Return False
            End If

            Return True
        Catch ex As Exception
            page.Response.Redirect("~/AccessDenied.aspx", False)
            Return False
        End Try
    End Function

End Class