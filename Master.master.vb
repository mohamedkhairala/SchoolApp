
#Region "Imports"
Imports System.Data
Imports BusinessLayer.BusinessLayer
Imports clsMessages
#End Region
Partial Class Master
    Inherits System.Web.UI.MasterPage
#Region "Global Variables"
    Dim UserId As String = "0"
    Dim Client_Id As String = "1001"
#End Region

#Region "Page Load"
    ''' <summary>
    ''' Handle page load event.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        lblRes.Visible = False
        UserId = PublicFunctions.GetUserId(Page)
        Try
            If Page.IsPostBack = False Then
                If Not PublicFunctions.CheckLogged() Then
                    Response.Redirect("~/Login.aspx")
                End If
                LoadUserData()
                FillMenu()
            End If
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
    Private Sub LoadUserData()
        Try

            Dim dtUsers As DataTable = DBContext.Getdatatable("select FullName,Photo,GroupId from tblUsers where isnull(isDeleted,0)=0 and UserId='" + UserId + "'")
            If dtUsers.Rows.Count > 0 Then
                'lblFullName.Text = dtUsers.Rows(0).Item("FullName").ToString
                'lblFullName2.Text = dtUsers.Rows(0).Item("FullName").ToString
                'ImgUser.Src = dtUsers.Rows(0).Item("Photo").ToString
                'ImgUser2.Src = dtUsers.Rows(0).Item("Photo").ToString
                'lblUserGroup.Text = dtUsers.Rows(0).Item("GroupId").ToString
            End If
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub
#End Region

#Region "Menu"

    ''' <summary>
    ''' Get Menus, sub menus and forms.
    ''' </summary>
    Sub FillMenu()
        Try
            Dim dtMenu As DataTable = DBContext.Getdatatable("SELECT * from vw_UserMenuPerm where UserId = '" + UserId + "'  ORDER BY  ParentMenuOrderID,MenuOrderID,FormOrderId")



            Dim dtParentMenu As New DataTable
            Dim dtSubMenu As New DataTable
            Dim dtForms As DataTable

            dtParentMenu = dtMenu.Copy : GetParentMenudatatable(dtParentMenu)
            dtParentMenu = RemoveNullColumnFromDataTable(dtParentMenu)
            dtSubMenu = dtMenu.Copy : GetMenudatatable(dtSubMenu)
            dtSubMenu = RemoveNullColumnFromDataTable(dtSubMenu)
            dtForms = dtMenu.Copy
            FillParentMenus(dtParentMenu, dtSubMenu, dtForms)

        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    ''' <summary>
    ''' Draw Parent Menus.
    ''' </summary>
    Sub FillParentMenus(ByVal dtParentMenu As DataTable, ByVal dtSubMenu As DataTable, ByVal dtForms As DataTable)
        Try
            If dtParentMenu.Rows.Count > 1 Or dtSubMenu.Rows.Count > 1 Then
                For Each dr As DataRow In dtParentMenu.Rows
                    Dim ParentId As String = dr.Item("Id").ToString
                    Dim MenuName As String = dr.Item("MenuName").ToString
                    Dim MenuIcon As String = dr.Item("MenuIcon").ToString
                    Dim dtSubParentMenus As DataTable = DBContext.Getdatatable("select Id from tblMenus where ParentId='" + ParentId + "'")
                    'menu with one form
                    If dtSubParentMenus.Rows.Count = 1 Then
                        Dim SubMenuId = dtSubParentMenus.Rows(0).Item("Id").ToString
                        FillForms(SubMenuId, dtForms)
                    Else
                        'menu that have sub menu
                        ''''''''''''''''''''''' V Menu''''''''''''''''''''''
                        Dim liMenu As New LiteralControl("<li class='nav-item sidebar-nav-item'><a href='#' class='nav-link'> <i class='" + MenuIcon + "'></i> <span>" + MenuName + "</span></a> <ul id='" + MenuName + "' class='nav sub-group-menu'>")
                        UlMenu.Controls.Add(liMenu)
                        ''''''''''''''''''''''' End ''''''''''''''''''''''

                        FillSubMenus(ParentId, dtSubMenu, dtForms)
                        ''''''''''''''''''''''' V Menu''''''''''''''''''''''
                        Dim ulSubMenuClose As New LiteralControl("</ul></li>")
                        UlMenu.Controls.Add(ulSubMenuClose)
                        ''''''''''''''''''''''' End''''''''''''''''''''''
                    End If



                Next
            Else
                'menu with many forms
                If dtSubMenu.Rows.Count > 0 Then
                    Dim SubMenuId = dtSubMenu.Rows(0).Item("Id").ToString
                    FillForms(SubMenuId, dtForms)
                End If
            End If

        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    ''' <summary>
    ''' Draw Sub Menus.
    ''' </summary>
    Sub FillSubMenus(ByVal ParentId As String, ByVal dtSubMenu As DataTable, ByVal dtForms As DataTable)
        Try
            Dim dvSubMenu As New DataView(dtSubMenu)
            dvSubMenu.RowFilter = "ParentId = '" + ParentId + "'"
                        For Each dr As DataRowView In dvSubMenu
                Dim SubMenuName As String = dr.Item("Name").ToString
                Dim SubMenuId As String = dr.Item("Id").ToString
                Dim SubMenuIcon As String = dr.Item("Icon").ToString
                Dim dvForms As New DataView(dtForms)
                dvForms.RowFilter = "MenuId = '" + SubMenuId + "'"
                If dvSubMenu.Count > 1 Then
                    If dvForms.Count > 1 Then
                        ''''''''''''''''''''''' V Menu''''''''''''''''''''''
                        Dim liSubMenu As New LiteralControl("<li class='nav-item'><a class='nav-link'> <i class='" + SubMenuIcon + "'></i> " + SubMenuName + " </a> <ul>")
                        UlMenu.Controls.Add(liSubMenu)
                        ''''''''''''''''''''''' End''''''''''''''''''''''


                        FillForms(SubMenuId, dtForms)
                        ''''''''''''''''''''''' V Menu''''''''''''''''''''''
                        Dim liSubMenuClose As New LiteralControl("</ul></li>")
                        UlMenu.Controls.Add(liSubMenuClose)
                        ''''''''''''''''''''''' End''''''''''''''''''''''


                    Else
                        FillForms(SubMenuId, dtForms)
                    End If
                Else
                    FillForms(SubMenuId, dtForms)
                End If
            Next
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    ''' <summary>
    ''' Draw Forms name and its links.
    ''' </summary>
    Sub FillForms(ByVal SubMenuId As String, ByVal dtForms As DataTable)
        Try
            Dim dvForms As New DataView(dtForms)
            dvForms.RowFilter = "MenuId = '" & SubMenuId & "'"
            For Each dr As DataRowView In dvForms
                Dim FormTitle As String = dr.Item("FormTitle").ToString
                Dim Formname As String = dr.Item("Formname").ToString
                Dim FormId As String = dr.Item("FormId").ToString
                Dim FormUrl As String = dr.Item("formUrl").ToString
                Dim FormIcon As String = dr.Item("FormIcon").ToString


                ''''''''''''''''''''''' V Menu''''''''''''''''''''''
                Dim liForm As New LiteralControl("<li class='nav-item'>")
                UlMenu.Controls.Add(liForm)
                Dim lb As New HyperLink
                lb.ID = Formname
                Dim spanName As New LiteralControl("<i class='" + FormIcon + " ' ></i> " + FormTitle + " ")
                lb.Controls.Add(spanName)
                lb.Attributes.Add("class", "nav-link")




                lb.ClientIDMode = UI.ClientIDMode.Static
                lb.NavigateUrl = "~/" & FormUrl
                'lb.Attributes.Add("href", FormUrl)
                'lb.Attributes.Add("onclick", "LoadFrame(this);return false;")

                UlMenu.Controls.Add(lb)
                Dim liFormClose As New LiteralControl("</li>")
                UlMenu.Controls.Add(liFormClose)
                ''''''''''''''''''''''' End''''''''''''''''''''''
            Next
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
        End Try
    End Sub

    ''' <summary>
    ''' Return Datatable of parent menus.
    ''' </summary>
    Private Function GetParentMenudatatable(ByRef dt As DataTable) As DataTable
        Try
            For i As Integer = dt.Columns.Count - 1 To 0 Step -1
                If Not dt.Columns(i).ColumnName.StartsWith("Parent") Then
                    dt.Columns.RemoveAt(i)
                End If
            Next
            For i As Integer = dt.Columns.Count - 1 To 0 Step -1
                dt.Columns(i).ColumnName = dt.Columns(i).ColumnName.Replace("Parent", "")
            Next
            Dim dv As New DataView(dt)
            dt = dv.ToTable(True)
            Return dt
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

    ''' <summary>
    ''' Return Datatable of sub menus.
    ''' </summary>
    Private Function GetMenudatatable(ByRef dt As DataTable) As DataTable
        Try
            For i As Integer = dt.Columns.Count - 1 To 0 Step -1
                If Not dt.Columns(i).ColumnName.StartsWith("Menu") Then
                    dt.Columns.RemoveAt(i)
                End If
            Next
            For i As Integer = dt.Columns.Count - 1 To 0 Step -1
                dt.Columns(i).ColumnName = dt.Columns(i).ColumnName.Replace("Menu", "")
            Next
            Dim dv As New DataView(dt)
            dt = dv.ToTable(True)
            Return dt
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

    ''' <summary>
    ''' Return Datatable of without null coulmns.
    ''' </summary>
    Function RemoveNullColumnFromDataTable(ByRef dt As DataTable) As DataTable
        Try
            For i As Integer = dt.Rows.Count - 1 To 0 Step -1
                If dt.Rows(i)(0).ToString = "" Then
                    dt.Rows(i).Delete()
                End If
            Next
            Return dt
        Catch ex As Exception
            ShowMessage(lblRes, clsMessages.MessageTypesEnum.ERR, Page, ex)
            Return Nothing
        End Try
    End Function

#End Region
End Class

