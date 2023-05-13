<%@ Page Title="Up Skills | Users" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="users.aspx.vb" Inherits="ControlPanel_users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="css/datepicker.min.css">
    <!-- Upload Photo CSS -->
    <link rel="stylesheet" href="css/upload-photo.css" />
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
    <style>
        .dataTables_wrapper .table tbody tr.header-row th,
        .dataTables_wrapper .table tbody tr td {
            border-left: 0;
            border-right: 0;
        }

            .dataTables_wrapper .table tbody tr.header-row th a {
                color: inherit;
            }
    </style>
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Users</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <asp:UpdatePanel ID="upUsers" runat="server" ClientIDMode="Static" RenderMode="Inline" ScriptMode="Release">
        <ContentTemplate>
            <asp:UpdateProgress ID="upgg" runat="server" AssociatedUpdatePanelID="upUsers">
                <ProgressTemplate>
                    <asp:Image runat="server" ImageUrl="~/img/preloader.gif" />
                </ProgressTemplate>
            </asp:UpdateProgress>

            <asp:Panel ID="pnlConfirm" runat="server" Visible="false" CssClass="card height-auto pb-4 ui-modal-box">
                <div class="card-body py-4 modal-box">
                    <div class="heading-layout1 mb-0">
                        <div class="item-title">
                            <h3>Add New User</h3>
                        </div>
                        <div class="">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white" ValidationGroup="vgMain"
                                OnClick="Save" UseSubmitBehavior="false" OnClientClick="SaveClick(this,'vgMain');" Text="Save" />
                            <asp:Panel runat="server" ID="pnlCancel" CssClass="d-inline-block ml-3">
                                <%--<asp:LinkButton ID="lbYesCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel" CausesValidation="false">Cancel</asp:LinkButton>--%>
                                <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                                    onclick="ShowConfirmModal('mpConfirmCancel','pnlConfirmExtenderCancel');return false;">Cancel</a>

                                <asp:HiddenField ID="hfCancel" runat="server" />
                                <asp:ModalPopupExtender ID="mpConfirmCancel" runat="server" PopupControlID="pnlConfirmExtenderCancel" TargetControlID="hfCancel"
                                    CancelControlID="lbNoCancel" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlConfirmExtenderCancel" runat="server" ClientIDMode="Static" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
                                    <div class="modal-dialog success-modal-content" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirmation Message</h5>
                                            </div>
                                            <div class="modal-body">
                                                <div class="success-message">
                                                    <div class="item-icon">
                                                        <i class="fas fa-exclamation icon-modal"></i>
                                                    </div>
                                                    <h3 class="item-title">You want to Cancel ?</h3>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="footer-btn btn-success" CausesValidation="false" OnClick="Cancel">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lbNoCancel" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <div class="card height-auto ui-modal-box">
                <div class="card-body modal-box">
                    <div class="item-title">
                        <h3>All Users</h3>
                    </div>
                    <div class="col-md-12 p-0">
                        <asp:Label runat="server" ID="lblRes"></asp:Label>
                    </div>

                    <div style="display: none;">
                        <asp:Label ID="lblUserId" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>

                    <asp:Panel ID="pnlOps" runat="server">
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Panel ID="pgPanel" CssClass="d-inline-block mb-3" runat="server">
                                    <div class="input-group form-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text btn-gradient-yellow text-white">Entries / page</span>
                                        </div>
                                        <asp:DropDownList runat="server" CssClass="form-control ltr" ID="ddlPager" OnSelectedIndexChanged="PageSize_Changed" AutoPostBack="true">
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="25">25</asp:ListItem>
                                            <asp:ListItem Value="50">50</asp:ListItem>
                                            <asp:ListItem Value="100">100</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </asp:Panel>
                            </div>
                            <div class="col-md-8 text-right">
                                <div class="d-inline-flex mb-3">
                                    <asp:LinkButton ID="lbAdd" OnClick="Add" runat="server" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill" ToolTip="New User">New<i class="fa fa-plus ml-3"></i></asp:LinkButton>
                                </div>
                                <div class="input-group form-group mb-3 d-inline-flex col-md-6 px-0 ml-3">
                                    <div class="input-group form-group">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" type="text" placeholder="Search" AutoPostBack="true" OnTextChanged="FillGrid" onkeypress="return isString(event);" onkeyup="ValidateChars(this);ShowHideClearSearch(this.value);" ToolTip="Search"></asp:TextBox>

                                        <asp:LinkButton runat="server" CssClass="clear-search" ID="cmdClear" title="Clear" OnClientClick="$('#txtSearch').val('');" Style="display: none;">&times;</asp:LinkButton>
                                        <asp:Button ID="btnSearch" runat="server" Style="display: none" ClientIDMode="Static" OnClick="FillGrid" />
                                        <span class="input-group-append">
                                            <asp:LinkButton ID="lbSearchIcon" runat="server" type="button" OnClick="FillGrid"><i class="fas fa-search icon-search" style="z-index: 10;"></i></asp:LinkButton>
                                        </span>
                                        <asp:AutoCompleteExtender ID="aclSearch" CompletionListCssClass="acl" CompletionListHighlightedItemCssClass="li-hover" CompletionListItemCssClass="li" runat="server" ServiceMethod="GetUserNames" ServicePath="~/WebService.asmx" MinimumPrefixLength="1"
                                            TargetControlID="txtSearch">
                                        </asp:AutoCompleteExtender>
                                    </div>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlGV" runat="server">
                        <div class="table-responsive">
                            <div class="dataTables_wrapper no-footer">
                                <asp:HiddenField ID="SortExpression" runat="server" />
                                <asp:GridView ID="gvUsers" CssClass="table display data-table text-nowrap dataTable no-footer" HeaderStyle-CssClass="header-row" RowStyle-CssClass="odd" AlternatingRowStyle-CssClass="even"
                                    runat="server" AutoGenerateColumns="false" AllowSorting="true" OnPageIndexChanging="gvUser_PageIndexChanged" AllowPaging="true" PageSize='<%# ddlPager.Text%>' OnSorting="gv_Sorting">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Name" SortExpression="FullName" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFullName" Text='<%# Eval("FullName")%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Username" SortExpression="UserName" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUserName" Text='<%# Eval("UserName")%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email" SortExpression="Email" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmail" Text='<%# Eval("Email")%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Password" SortExpression="Password" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPassword" Text='<%# PublicFunctions.Decrypt(Eval("Password"))%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type" SortExpression="OType" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOwnerType" Text='<%# Eval("OType")%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Modified Date" SortExpression="ModifiedDate" HeaderStyle-CssClass="sorting">
                                            <ItemTemplate>
                                                <asp:Label ID="lblModifiedDate" Text='<%# Eval("ModifiedDate")%>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Panel ID="pnlActons" runat ="server"  CssClass="dropdown" Enabled ='<%# IIf(PublicFunctions.BoolFormat(Eval("SystemUser")) = True, False, True)%>'>
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                        <span class="flaticon-more-button-of-three-dots"></span>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-right">
                                                        <asp:LinkButton ID="lbPermission" CssClass="dropdown-item" CommandArgument='<%#Eval("UserID")%>' runat="server" ToolTip="Permissions" OnClick="ShowPermission" Visible='<%# False %>'><i class="fas fa-user-lock text-blue"></i>User Permissions</asp:LinkButton>
                                                        <asp:LinkButton ID="lbUpdate" CssClass="dropdown-item" OnClick="Edit" ToolTip="Edit" runat="server" CommandArgument='<%#Eval("UserID")%>' Visible='<%# IIf(Eval("UserName").ToString = "system", False, True) %>'><i class="fas fa-cogs text-dark-pastel-green"></i>Edit</asp:LinkButton>
                                                        <asp:Panel ID="pnlDelete" runat="server" Visible='<%# IIf(Eval("UserName").ToString = "system", False, True) %>'>
                                                            <%--<asp:LinkButton ID="lbDelete" CssClass="dropdown-item" OnClick="Delete" ToolTip="Delete" runat="server" CommandArgument='<%#Eval("UserID")%>' Visible='<%# IIf(Eval("UserName").ToString = "system", False, True) %>'><i class="fas fa-times text-orange-red"></i>Delete</asp:LinkButton>--%>
                                                            <a class="dropdown-item"
                                                                onclick="ShowConfirmModal('<%# CType(Container, GridViewRow).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, GridViewRow).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
                                                                <i class="fas fa-times text-orange-red"></i>Delete
                                                            </a>
                                                            <asp:HiddenField ID="hfDelete" runat="server" />
                                                            <asp:ModalPopupExtender ID="mpConfirmDelete" runat="server" PopupControlID="pnlConfirmExtenderDelete" TargetControlID="hfDelete"
                                                                CancelControlID="lbNoDelete" BackgroundCssClass="modal-backdrop fade show">
                                                            </asp:ModalPopupExtender>
                                                        </asp:Panel>

                                                         <a class="dropdown-item"
                                                             href='<%# "https://wa.me/2" & Eval("MobileNo") & "?text=UpSkills User --> Username : " & Eval("Username") & " ... Password : " & PublicFunctions.Decrypt(Eval("Password"))  %>'>
                                                                <i class="fas fa-user-lock text-blue"></i>Send Credentials
                                                            </a>
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlConfirmExtenderDelete" runat="server" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
                                                    <div class="modal-dialog success-modal-content" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Confirmation Message</h5>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="success-message">
                                                                    <div class="item-icon">
                                                                        <i class="fas fa-exclamation icon-modal"></i>
                                                                    </div>
                                                                    <h3 class="item-title">You want to delete this record ?</h3>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("UserID") %>' OnClick="Delete">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                                <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center">
                                            Not Data Found
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>

                        <asp:Button ID="btnPerm" runat="server" Style="display: none" />
                        <asp:ModalPopupExtender ID="mpePermissionPopup" runat="server" PopupControlID="pnlPermissionPopup" ClientIDMode="AutoID" TargetControlID="btnPerm" BackgroundCssClass="modalBackground" CancelControlID="btnClose">
                        </asp:ModalPopupExtender>

                        <asp:Panel ID="pnlPermissionPopup" runat="server" CssClass="rodal rodal-fade-enter" Style="display: none;">
                            <div class="rodal-mask"></div>
                            <div class="rodal-dialog rodal-slideUp-enter" style="width: 80vw; height: 240px;">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5 class="card-title">User Permissions</h5>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="pull-right">
                                                    <asp:LinkButton runat="server" ID="btnClose" CssClass="text-danger"><i class="fa fa-times"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <asp:GridView ID="gvUserPermissionPopup" CssClass="table table-striped table-bordered table-hover" ClientIDMode="Static" runat="server" AutoGenerateColumns="False" Style="opacity: 10;">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Form Title">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFormTitle" Text='<%#Eval("FormTitle")%>' runat="server"></asp:Label>
                                                            <asp:Label ID="lblFormId" runat="server" Text='<%# Eval("FormId")%>' Visible="False"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllAccess" ClientIDMode="Static" Text="Access" runat="server" onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAccess" onclick="Select(this);" ClientIDMode="Static" Text=" " runat="server" Checked='<%#Eval("PAccess")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllAdd" Text="Add" runat="server"
                                                                onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAdd" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PAdd")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllUpdate" Text="Update" runat="server"
                                                                onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkUpdate" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PUpdate")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllDelete" Text="Delete" runat="server"
                                                                onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkDelete" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PDelete")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllSearch" Text="Search" runat="server"
                                                                onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSearch" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PSearch")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAllActive" Text="Print" runat="server"
                                                                onclick="CheckAll(this);" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkActive" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PActive")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <div class="text-center">
                                                        Not Data Found
                                                    </div>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:Panel ID="pnlPopupSave" runat="server" CssClass="pull-right">
                                                    <span class="frame-btn">
                                                        <asp:Button CssClass="btn btn-success" ID="btnSavePermissionPopup" OnClick="SavePermission" runat="server" Text="Save" UseSubmitBehavior="false" OnClientClick="SaveClick(this,'');" />
                                                        <label class="fa fa-check" for="btnSave"></label>
                                                    </span>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="pnlForm" Visible="false" runat="server">
                        <div class="row new-added-form">
                            <div class="col-xl-3 col-lg-6">
                                <div class="row">
                                    <div class="col-xl-12 col-lg-12 col-12 form-group mg-t-30">
                                        <div class="upload-profile">
                                            <asp:Panel ID="pnlfuLogo" runat="server">
                                                <asp:AsyncFileUpload ID="fuPhoto" ClientIDMode="Static" runat="server" CssClass="form-control-file" OnUploadedComplete="PhotoUploaded"
                                                    OnClientUploadComplete="UploadPhotoCompleted" OnClientUploadError="UploadError" OnClientUploadStarted="UploadStarted" FailedValidation="False" />
                                                <input type="hidden" name="MAX_FILE_SIZE" value="10485760" />
                                            </asp:Panel>
                                            <asp:TextBox ID="txtHiddenPassword" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                                            <asp:TextBox ID="HiddenIcon" runat="server" ClientIDMode="Static" Style="display: none"></asp:TextBox>

                                            <div class="dashes" runat="server" id="previewDiv">
                                                <asp:Image ID="imgIcon" ClientIDMode="Static" CssClass="userPhoto" runat="server" ImageUrl="img/figure/Photo.jpg" />
                                            </div>
                                            <asp:Image ID="imgIconLoader" runat="server" CssClass="img-loader-upload" ClientIDMode="Static" ImageUrl="~/img/preloader.gif" Style="display: none;" />
                                            <label class="btn-upload btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white">Upload Photo</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-9 col-lg-6">
                                <asp:ValidationSummary ID="vsMain" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vgMain" EnableClientScript="true" runat="server" Visible="false" />

                                <div class="row">
                                    <div class="form-group col-md-8 input-in">
                                        <label class="form-label required">Full Name</label>
                                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" MaxLength="50" onkeypress="return isString(event);" onkeyup="ValidateChars(this);"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="valid-inp" ValidationGroup="vgMain" ControlToValidate="txtFullName"
                                            Text="Enter Full Name" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label required">E-mail</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="200" onkeypress="return isString(event);" onkeyup="ValidateChars(this);"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" CssClass="valid-inp" ValidationGroup="vgMain" ControlToValidate="txtEmail"
                                            Text="Enter E-mail" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <%--<asp:CustomValidator ID="cvEmail" runat="server" ValidationGroup="vgMain" Display="Dynamic" ControlToValidate="txtEmail" ErrorMessage="Email already exist" EnableViewState="false" ValidateEmptyText="true"
                                            EnableClientScript="true" Enabled="true" ClientValidationFunction="CheckEmail"></asp:CustomValidator>--%>
                                        <asp:RegularExpressionValidator ID="revEmail" ValidationGroup="vgMain" CssClass="valid-inp" runat="server" ControlToValidate="txtEmail"
                                            ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <span id="display" style="color: red; font-size: 10px;"></span>
                                        <label class="form-label required">Username</label>
                                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" MaxLength="20" onkeypress="return isString(event);" onkeyup="ValidateChars(this);"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvUserName" runat="server" CssClass="valid-inp" ValidationGroup="vgMain" ControlToValidate="txtUsername"
                                            Text="Enter Username" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <%-- <asp:CustomValidator ID="cvUserName" runat="server" ValidationGroup="vgMain" Display="Dynamic" ControlToValidate="txtUsername" ErrorMessage="Username already exist" EnableViewState="false" ValidateEmptyText="true"
                                            EnableClientScript="true" Enabled="true" ClientValidationFunction="CheckUserName"></asp:CustomValidator>--%>
                                        <asp:RegularExpressionValidator ID="valtxtUsername" runat="server" CssClass="valid-inp"
                                            ControlToValidate="txtUsername" ErrorMessage="Minimum UserName length is 5" ValidationExpression=".{5}.*" />
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label required">Password</label>
                                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15" ClientIDMode="Static" onchange="ValidatePass();" autocomplete="new-password"></asp:TextBox>
                                        <asp:Label ID="lblPassStatus" runat="server" ClientIDMode="Static"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" CssClass="valid-inp" ValidationGroup="vgMain" ControlToValidate="txtPassword"
                                            Text="Enter Password" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="vgMain" CssClass="inp-validate" runat="server" ControlToValidate="txtPassword"
                                                                                ErrorMessage="Password must contain: Minimum 6 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\d]{6,}$">*</asp:RegularExpressionValidator>--%>
                                        <%-- ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$  --%>
                                        <%--<asp:CustomValidator ID="cfvPassword" CssClass="custmValidator" runat="server" ValidationGroup="vgMain" Display="Dynamic" ControlToValidate="txtPassword" ErrorMessage="Password Very Week" EnableViewState="false" ValidateEmptyText="true"
                                                                                    EnableClientScript="true" Enabled="true" ClientValidationFunction="ValidatePassword" ForeColor="Red">*</asp:CustomValidator>--%>
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label required">Confirm Password</label>
                                        <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15" autocomplete="new-password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" CssClass="valid-inp" ValidationGroup="vgMain" ControlToValidate="txtPasswordConfirm"
                                            Text="Enter Confirm Password" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ValidationGroup="vgMain" ForeColor="Red"
                                            ControlToValidate="txtPasswordConfirm" ErrorMessage="Password Not Matched" Text="Password Not Matched" Style="position: absolute; font-size: 10px;"></asp:CompareValidator>
                                    </div>

                                    <%-- <div class="form-group col-md-4 input-in">
                                                <label class="form-label">User Group</label>
                                                <asp:DropDownList ID="ddlUserGroup" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FillPermissions">
                                                </asp:DropDownList>
                                            </div>--%>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label d-block">&nbsp;</label>
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkUserActivation" runat="server" Checked="true" Text="Active" />
                                        </div>
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label">User Type</label>
                                        <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="User">User</asp:ListItem>
                                            <asp:ListItem Value="Admin">Admin</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-md-4 input-in">
                                        <label class="form-label">Mobile</label>
                                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" MaxLength="15" onkeypress="return isNumber(event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Panel ID="pnlUserDt" runat="server" CssClass="row">
                            <div class="col-md-12 mt-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title">User Permissions</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="p-lr-3">
                                            <div class="col-md-12">
                                                <div class="row">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="gvUserPermissions" CssClass="table table-striped table-bordered table-hover tbl-header-checkbox" ClientIDMode="Static" runat="server" AutoGenerateColumns="False">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Form Title">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFormTitle" Text='<%#Eval("FormTitle")%>' runat="server"></asp:Label>
                                                                        <asp:Label ID="lblFormId" runat="server" Text='<%# Eval("FormId")%>' Visible="False"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllAccess" ClientIDMode="Static" Text="Access" runat="server" onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkAccess" onclick="Select(this);" ClientIDMode="Static" Text=" " runat="server" Checked='<%#Eval("PAccess")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllAdd" Text="Add" runat="server"
                                                                            onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkAdd" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PAdd")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllUpdate" Text="Update" runat="server"
                                                                            onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkUpdate" onclick="Select(this);" runat="server" Text=" " Checked='<%#Eval("PUpdate")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllDelete" Text="Delete" runat="server"
                                                                            onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkDelete" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PDelete")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllSearch" Text="Search" runat="server"
                                                                            onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSearch" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PSearch")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-CssClass="gvPermissionCheckBox">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAllActive" Text="Print" runat="server"
                                                                            onclick="CheckAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkActive" onclick="Select(this);" Text=" " runat="server" Checked='<%#Eval("PActive")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataTemplate>
                                                                <div class="text-center">
                                                                    Not Data Found
                                                                </div>
                                                            </EmptyDataTemplate>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </asp:Panel>

                    <!--============================ Page-content =============================-->
                    <div class="page-load">
                        <asp:UpdateProgress ID="upg" runat="server" AssociatedUpdatePanelID="upUsers" ClientIDMode="AutoID">
                            <ProgressTemplate>
                                <div class="d-flex justify-content-center align-items-center h-100">
                                    <div class="spinner-border text-success" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Admit Form Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="js/uploaduserimg.js"></script>
    <!-- Data Table Js -->
    <%--<script src="js/jquery.dataTables.min.js"></script>--%>
    <script src="js/Users.js"></script>
</asp:Content>
