<%@ Page Title="Up Skills | Supervisor Details" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Supervisor_Details.aspx.vb" Inherits="Student_Details" %>

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
                <h3>Supervisor Details</h3>
                <ul>
                    <li>
                        <a href="Dashboard.aspx">Home</a>
                    </li>
                    <li>
                        <a href="SupervisorsList.aspx">Supervisors List</a>
                    </li>
                    <li>Supervisor Details</li>
                </ul>
            </div>
            <!-- Breadcubs Area End Here -->
            <!-- Student Details Area Start Here -->
            <div class="card height-auto ui-modal-box">
                <div class="card-body modal-box">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <asp:Label Text="" ID="lblRes" runat="server" />
                        </div>

                    </div>
                    <asp:ListView runat="server" ID="rpDetails">
                        <ItemTemplate>
                            <div class="single-info-details">
                                <div class="item-img">
                                    <img src='<%# IIf(String.IsNullOrEmpty(Eval("Photo")), "../img/figure/Photo.jpg", PublicFunctions.ServerURL & Eval("Photo").ToString.Replace("../", ""))  %>' alt="student">
                                </div>
                                <div class="item-content">
                                    <div class="header-inline item-header">
                                        <h3 class="text-dark-medium font-medium"><%# Eval("Name")%></h3>

                                        <div class="header-actions">
                                            <ul>
                                                <li>
                                                    <asp:Panel ID="pnlEdit" runat="server">
                                                        <a id="lbEdit" class="action-green" runat="server" href='<%# "../Supervisors/Supervisor.aspx?Mode=Edit&ID=" & Eval("Id")%>'><i class="far fa-edit"></i></a>
                                                    </asp:Panel>
                                                </li>
                                                <li>
                                                    <asp:Panel ID="pnlPrint" runat="server">
                                                        <a id="lbPrint" class="action-blue" onclick="PrintDetails();"><i class="fas fa-print"></i></a>
                                                    </asp:Panel>
                                                </li>
                                                <li>
                                                    <asp:Panel ID="pnlDelete" runat="server">
                                                        <a class="action-red"
                                                            onclick="ShowConfirmModal('<%# CType(Container, ListViewItem).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, ListViewItem).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
                                                            <i class="far fa-trash-alt"></i></a>
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
                                                                            <h3 class="item-title">You want to delete this supervisor ?</h3>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("Id") %>' OnClick="Delete">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                                        <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </asp:Panel>
                                                    </asp:Panel>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <p>
                                        <%# Eval("Remarks")%>
                                    </p>
                                    <div class="info-table table-responsive">
                                        <table class="table text-nowrap">
                                            <tbody>
                                                <tr>
                                                    <td>Code:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("Code")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Name:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("Name")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Gender:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("FullGender")%></td>
                                                </tr>

                                                <tr>
                                                    <td>Date Of Birth:</td>
                                                    <td class="font-medium text-dark-medium"><%#  PublicFunctions.DateFormat(Eval("DateOfBirth"), "dd/MM/yyyy")%></td>
                                                </tr>

                                                <tr>
                                                    <td>E-mail:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("Email")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Admission Date:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("CreatedDate")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Group:</td>
                                                    <td>
                                                        <div class="dataTables_wrapper no-footer">
                                                            <asp:GridView runat="server" ID="rpGroups" ClientIDMode="AutoID" CssClass="table display data-table text-nowrap dataTable no-footer"
                                                                HeaderStyle-CssClass="header-row" RowStyle-CssClass="odd" AlternatingRowStyle-CssClass="even">
                                                            </asp:GridView>
                                                        </div>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>Address:</td>
                                                    <td class="font-medium text-dark-medium"><%# Eval("Address")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Mobile:</td>
                                                    <td><i class="fa fa-mobile-alt mr-2"></i><a href="tel:<%# Eval("Mobile")%>"><%# Eval("Mobile")%></a></td>
                                                    <td><i class="fab fa-whatsapp mr-2"></i><a target="_blank" href="https://wa.me/<%# Eval("Mobile")%>"><%# Eval("Mobile")%></a></td>
                                                </tr>
                                                <tr>
                                                    <td>Phone:</td>
                                                    <td class="font-medium text-dark-medium"><a href="tel:<%# Eval("Tel")%>"><%# Eval("Tel")%></a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
            <!-- Student Details Area End Here -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
