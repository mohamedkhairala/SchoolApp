<%@ Page Title="Up Skills | Attachments" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Attachment.aspx.vb" Inherits="Course" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="css/datepicker.min.css">
    <!-- Upload Photo CSS -->
    <link rel="stylesheet" href="css/upload-photo.css" />
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:UpdatePanel ID="UP" runat="server" ClientIDMode="Static" RenderMode="Inline">
        <ContentTemplate>
            <div class="page-load">
                <asp:UpdateProgress ID="upLoader" runat="server" ClientIDMode="Static" AssociatedUpdatePanelID="UP">
                    <ProgressTemplate>
                        <div class="loader-container">
                            <div class="lds-ripple">
                                <div></div>
                                <div></div>
                            </div>
                            <h3>Loading</h3>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
            <!-- Breadcubs Area Start Here -->
            <div class="breadcrumbs-area">

                <ul>
                    <li>
                        <a href="../Dashboard.aspx">Home</a>
                    </li>
                    <li>Attachments</li>
                </ul>
            </div>
            <!-- Breadcubs Area End Here -->
            <!-- Admit Form Area Start Here -->
            <div class="card height-auto ui-modal-box">
                <div class="card-body modal-box">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <h3>
                                <asp:Label Text="" runat="server" ID="lblTitle" /></h3>


                            <asp:Label Text="" ID="lblUserRole" Visible="false" runat="server" />
                            <asp:Label Text="" ID="lblRes" runat="server" />
                        </div>
                        <asp:Panel CssClass="dropdown" runat="server" ID="divActions">
                            <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                                aria-expanded="false">...</a>

                            <div class="dropdown-menu dropdown-menu-right">

                                <asp:LinkButton ID="lbEdit" CssClass="dropdown-item" runat="server" OnClick="Edit"><i class="fas fa-cogs text-dark-pastel-green"></i>Edit</asp:LinkButton>

                            </div>
                        </asp:Panel>
                    </div>
                    <div class="new-added-form">
                        <asp:Panel runat="server" ID="pnlForm">
                            <div class="row">

                                <div class="col-xl-12 col-lg-12">
                                    <asp:ValidationSummary ID="vsAttachments" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vgAttachments" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />

                                    <div class="row">
                                        <!-- Course -->
                                        <div id="divCourseID" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label id="lblCourseID" runat="server" for="ddlCourseID">Course</label>
                                            <asp:DropDownList ID="ddlCourse" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectCourse">
                                                <asp:ListItem Value="">Please Select Course</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCourseID" runat="server" ValidationGroup="vgAttachments"
                                                ControlToValidate="ddlCourse" InitialValue="" Display="Dynamic" Text="Required Course"></asp:RequiredFieldValidator>
                                        </div>
                                        <!-- Group -->
                                        <div id="divGroupID" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label id="lblGroupID" runat="server" for="ddlGroupID">Group</label>
                                            <asp:DropDownList ID="ddlGroup" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectGroup">
                                                <asp:ListItem Value="">Please Select Group</asp:ListItem>
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqGroupID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlGroupID" InitialValue="" Display="Dynamic" Text="Required Group"></asp:RequiredFieldValidator>--%>
                                        </div>
                                        <!-- Session -->
                                        <div id="divSessionID" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label id="lblSessionID" runat="server" for="ddlSessionID">Session *</label>
                                            <asp:DropDownList ID="ddlSession" runat="server" CssClass="select2"
                                                AutoPostBack="true" OnSelectedIndexChanged="SelectSession">
                                                <asp:ListItem Value="">Please Select Session *</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>

                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <div class="file-upload-container">
                                                <div class="file-upload-wrapper">
                                                    <asp:FileUpload runat="server" ID="fuAttachments" AllowMultiple="true" />
                                                </div>
                                                <asp:Button runat="server" ID="uploadedFile" CssClass="btn-file-upload" Text="Upload" OnClick="UploadFile" />
                                            </div>
                                            <asp:Label ID="listofuploadedfiles" runat="server" />
                                        </div>
                                        <asp:Panel ID="pnlTeacherFiles" runat="server" CssClass="col-md-12 mt-4" Visible="false">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5 class="card-title">Teacher Files</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <div class="dataTables_wrapper no-footer">
                                                            <asp:GridView ID="gvTeacherFiles" runat="server" CssClass="table display data-table text-nowrap dataTable no-footer"
                                                                HeaderStyle-CssClass="header-row" RowStyle-CssClass="odd" AlternatingRowStyle-CssClass="even" AutoGenerateColumns="false">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="srialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File ">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID").ToString %>' Visible="false"></asp:Label>
                                                                            <asp:Panel ID="pnlImage" runat="server">
                                                                                <asp:Image CssClass="displayNone" ID="file" runat="server" ImageUrl='<%# Eval("URL")%>' Height="70px" Width="70px" Visible="false" />
                                                                                <asp:Label ID="lblURL" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblFileType" runat="server" Text='<%# Eval("FileType").ToString %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblDocumentCopy" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                                                <%--<img src='<%# Eval("DocumentCopy").ToString %>' runat="server" />--%>
                                                                                <asp:HyperLink ID="linkView" runat="server" NavigateUrl='<%# Eval("URL").ToString %>' onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                                                                    <asp:Image ID="fileIcon" runat="server" ImageUrl='<%# Eval("URL").ToString %>' CssClass="img-thumbnail" Height="45px" />
                                                                                </asp:HyperLink>
                                                                            </asp:Panel>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="File Name">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("FileName").ToString %>' ToolTip="Attachment Name" placeholder="Attachment Name"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File Description">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Text='<%# Eval("Description").ToString %>' ToolTip="Attachment Description" placeholder="Attachment Description"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Type">
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control"></asp:DropDownList>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Download" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:HyperLink ID="lbDownload" runat="server" CssClass="icons file-download" Visible="false" NavigateUrl='<%# Eval("URL").ToString  %>' title="Download" download='<%# System.DateTime.Now.ToShortDateString() + " - " + Eval("URL").ToString.Split("/").Last%>'><span onclick="ForceDownload"></span></asp:HyperLink>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                        <ItemTemplate>
                                                                            <%--<asp:LinkButton Text="Delete" OnClientClick="return confirm('Are you sure!');" OnClick="DeleteMultiFiles" runat="server" />--%>
                                                                            <a class="btn btn-danger text-white"
                                                                                onclick="ShowConfirmModal('<%# CType(Container, GridViewRow).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, GridViewRow).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
                                                                                <i class="fas fa-trash"></i>
                                                                            </a>
                                                                            <asp:HiddenField ID="hfDelete" runat="server" />
                                                                            <asp:ModalPopupExtender ID="mpConfirmDelete" runat="server" PopupControlID="pnlConfirmExtenderDelete" TargetControlID="hfDelete"
                                                                                CancelControlID="lbNoDelete" BackgroundCssClass="modal-backdrop fade show">
                                                                            </asp:ModalPopupExtender>
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
                                                                                            <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteMultiFiles">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                                                            <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </asp:Panel>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataTemplate>
                                                                    <table style="width: 100%;">
                                                                        <tr class="EmptyRowStyle">
                                                                            <td class="p-0">
                                                                                <div>No Attachments Found.</div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlStudentFiles" runat="server" CssClass="col-md-12 mt-4" Visible="false">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5 class="card-title">Student Files</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <div class="dataTables_wrapper no-footer">
                                                            <asp:GridView ID="gvStudentFiles" runat="server" CssClass="table display data-table text-nowrap dataTable no-footer"
                                                                HeaderStyle-CssClass="header-row" RowStyle-CssClass="odd" AlternatingRowStyle-CssClass="even" AutoGenerateColumns="false">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="srialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File ">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID").ToString %>' Visible="false"></asp:Label>
                                                                            <asp:Panel ID="pnlImage" runat="server">
                                                                                <asp:Image CssClass="displayNone" ID="file" runat="server" ImageUrl='<%# Eval("URL")%>' Height="70px" Width="70px" Visible="false" />
                                                                                <asp:Label ID="lblURL" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblFileType" runat="server" Text='<%# Eval("FileType").ToString %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblDocumentCopy" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                                                <%--<img src='<%# Eval("DocumentCopy").ToString %>' runat="server" />--%>
                                                                                <asp:HyperLink ID="linkView" runat="server" NavigateUrl='<%# Eval("URL").ToString %>' onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                                                                    <asp:Image ID="fileIcon" runat="server" ImageUrl='<%# Eval("URL").ToString %>' CssClass="img-thumbnail" Height="45px" />
                                                                                </asp:HyperLink>
                                                                            </asp:Panel>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File Name">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("FileName").ToString %>' ToolTip="Attachment Name" placeholder="Attachment Name"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File Description">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Text='<%# Eval("Description").ToString %>' ToolTip="Attachment Description" placeholder="Attachment Description"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Type">
                                                                        <ItemTemplate>
                                                                            <%--                                                    <asp:Label ID="lblFileCategory" runat="server" Text='<%# Eval("FileCat").ToString %>' Visible="false"></asp:Label>--%>
                                                                            <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control"></asp:DropDownList>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Download" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:HyperLink ID="lbDownload" runat="server" CssClass="icons file-download" Visible="false" NavigateUrl='<%# Eval("URL").ToString  %>' title="Download" download='<%# System.DateTime.Now.ToShortDateString() + " - " + Eval("URL").ToString.Split("/").Last%>'><span onclick="ForceDownload"></span></asp:HyperLink>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                        <ItemTemplate>
                                                                            <%--<asp:LinkButton Text="Delete" OnClientClick="return confirm('Are you sure!');" OnClick="DeleteMultiFiles" runat="server" />--%>
                                                                            <a class="btn btn-danger text-white"
                                                                                onclick="ShowConfirmModal('<%# CType(Container, GridViewRow).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, GridViewRow).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
                                                                                <i class="fas fa-trash"></i>
                                                                            </a>
                                                                            <asp:HiddenField ID="hfDelete" runat="server" />
                                                                            <asp:ModalPopupExtender ID="mpConfirmDelete" runat="server" PopupControlID="pnlConfirmExtenderDelete" TargetControlID="hfDelete"
                                                                                CancelControlID="lbNoDelete" BackgroundCssClass="modal-backdrop fade show">
                                                                            </asp:ModalPopupExtender>
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
                                                                                            <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteMultiFiles">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                                                            <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </asp:Panel>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataTemplate>
                                                                    <table style="width: 100%;">
                                                                        <tr class="EmptyRowStyle">
                                                                            <td class="p-0">
                                                                                <div>No Attachments Found.</div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <div class="col-12 form-group mg-t-8">
                                            <asp:Button ID="lbSave" runat="server" ValidationGroup="vgAttachments" UseSubmitBehavior="false"
                                                CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                                CommandArgument="Add" OnClick="Save" OnClientClick="SaveClick(this,'vgAttachments');" Text="Save" />
                                            <%--<asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>--%>
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
                                                            <asp:LinkButton ID="lbYesCancel" runat="server" CssClass="footer-btn btn-success" OnClick="Cancel">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                            <asp:LinkButton ID="lbNoCancel" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <!-- Admit Form Area End Here -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="js/UploadPhoto.js"></script>
</asp:Content>
