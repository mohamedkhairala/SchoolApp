<%@ Page Title="Up Skills | Messages" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="MessagesList.aspx.vb" Inherits="Dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server"></asp:Content>
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
                <h3>Messages</h3>
                <ul>
                    <li>
                        <a href="../Dashboard.aspx">Home</a>
                    </li>
                    <li>Messages</li>
                </ul>
            </div>
            <div class="row gutters-20 ui-modal-box" style="flex: 1;">
                <div class="col-lg-12 col-xl-12 col-12-xxxl modal-box">
                    <div class="card dashboard-card-six pd-b-20">
                        <div class="card-body">
                            <div class="heading-layout1 mg-b-17">
                                <div class="item-title">
                                    <h3>Messages</h3>
                                </div>
                                <asp:Label Text="" ID="lblRes" runat="server" />
                            </div>
                            <div class="col-md-12 px-0 text-right">
                                <div class="d-inline-flex mb-3">
                                    <asp:LinkButton ID="lbAdd" runat="server" href="Message.aspx" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></asp:LinkButton>
                                    <%--<a href="../Students/Student.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></a>--%>
                                </div>
                            </div>
                            <div class="input-group form-group">
                                <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control" placeholder="Search By Message"></asp:TextBox>
                                <span class="input-group-append">
                                    <asp:LinkButton ID="lbSearchIcon" runat="server" type="button" OnClick="FillGrid"><i class="fas fa-search icon-search" style="z-index: 10;"></i></asp:LinkButton>
                                </span>
                            </div>
                            <div class="notice-box-wrap">
                                <asp:ListView runat="server" ID="rbMessages">
                                    <ItemTemplate>
                                        <div class="notice-list">
                                            <div class="d-flex justify-content-between">
                                                <div class="post-date  <%# clsNotifications.SetRandomColor() %>"><%# PublicFunctions.DateFormat(Eval("CreatedDate"), "dd MMM yyyy") %></div>
                                                <div class="header-actions">
                                                    <ul>
                                                        <li>
                                                            <asp:Panel ID="pnlEdit" runat="server">
                                                                <a href="#" class="action-red"
                                                                    onclick="ShowConfirmModal('<%# CType(Container, ListViewItem).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, ListViewItem).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;"><i class="far fa-trash-alt"></i></a>

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
                                                                                        <i class="fas fa-exclamation"></i>
                                                                                    </div>
                                                                                    <h3 class="item-title">You want to delete this message ?</h3>
                                                                                </div>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("MsgNo") %>' OnClick="Delete">Yes<i class="fa fa-check ml-2"></i></asp:LinkButton>
                                                                                <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times ml-2"></i></asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </asp:Panel>
                                                            </asp:Panel>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <h6 class="notice-title">
                                                <a href="#">
                                                    <%# Eval("MessageTitle") %>
                                                </a>
                                                <p><%# Eval("MessageBody") %></p>
                                            </h6>
                                            <div class="entry-meta"><%# Eval("CreatedByUserName") %> / <span><%# clsNotifications.SetTimeAgo(Eval("CreatedDate"), Eval("time_ago")) %></span></div>
                                        </div>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <table style="width: 100%;">
                                            <tr class="EmptyRowStyle">
                                                <td>
                                                    <div>No Messages Found.</div>
                                                </td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
