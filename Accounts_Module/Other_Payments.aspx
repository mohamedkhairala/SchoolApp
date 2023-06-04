<%@ Page Title="Up Skills | Add Other Payment" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Other_Payments.aspx.vb" Inherits="Other_Payments" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="../css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="../css/datepicker.min.css">
    <!-- Upload Photo CSS -->
    <link rel="stylesheet" href="../css/upload-photo.css" />
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
                        <a href="Dashboard.aspx">Home</a>
                    </li>
                    <li>Add Other Payment</li>
                </ul>
            </div>
            <!-- Breadcubs Area End Here -->
            <asp:Label Text="" ID="lblRes" runat="server" />
            <!-- Admit Form Area Start Here -->
            <asp:Panel ID="pnlForm" runat="server">
                <div class="card height-auto pb-4 ui-modal-box">
                    <div class="card-body py-4 modal-box">
                        <div class="heading-layout1 mb-0">
                            <div class="item-title">
                                <h3>Add New Payment</h3>
                            </div>
                            <!-- Save & Cancel -->
                            <div class="">
                                <asp:Button ID="lbSave" runat="server" ValidationGroup="vgAddPayment" UseSubmitBehavior="false"
                                    CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white mr-3"
                                    CommandArgument="Add" OnClientClick="SaveClick(this,'vgAddPayment');" Text="Save" OnClick="Save" />
                                <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                                    onclick="ShowConfirmModal('mpConfirmCancel','pnlConfirmExtenderCancel');return false;">Cancel</a>
                                <asp:HiddenField ID="hfCancel" runat="server" />
                                <asp:ModalPopupExtender ID="mpConfirmCancel" runat="server" PopupControlID="pnlConfirmExtenderCancel" TargetControlID="hfCancel"
                                    CancelControlID="lbNoCancel" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlConfirmExtenderCancel" runat="server" ClientIDMode="Static" CssClass="modal pnl-1 fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
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
                                                <asp:LinkButton ID="lbNoCancel" runat="server" CssClass="footer-btn btn-danger" OnClientClick="CloseConfirmPopup('mpConfirmCancel');return false;">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card height-auto pb-3 ui-modal-box">
                    <div class="card-body modal-box">
                        <div class="heading-layout1">
                            <div class="item-title">
                                <h3>General</h3>
                            </div>
                            <asp:Panel CssClass="dropdown" runat="server" ID="divActions" Visible="false">
                                <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                                    aria-expanded="false">...</a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <asp:LinkButton ID="lbEdit" CssClass="dropdown-item" runat="server"><i class="fas fa-cogs text-dark-pastel-green"></i>Edit</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="new-added-form">
                            <asp:ValidationSummary ID="vsAddPayment" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vgAddPayment" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                            <div class="row">
                                <div class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label>Code</label>
                                    <asp:TextBox ID="txtCode" runat="server" Enabled="false" CssClass="form-control" MaxLength="200"></asp:TextBox>
                                </div>
                                <div class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label>Date *</label>
                                    <asp:TextBox ID="txtDate" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                        data-position='bottom right'></asp:TextBox>
                                    <i class="far fa-calendar-alt"></i>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqDate" runat="server" ValidationGroup="vgAddPayment"
                                        ControlToValidate="txtDate" Display="Dynamic" Text="Required Date"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label>Type</label>
                                    <div class="radio-list">
                                        <asp:RadioButtonList ID="rplTypes" runat="server" RepeatLayout="UnorderedList">
                                            <asp:ListItem Value="P" Selected="True">Payment</asp:ListItem>
                                            <asp:ListItem Value="R">Receipt</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label>Total Amount</label>
                                    <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="fteTotalAmount" runat="server" TargetControlID="txtTotalAmount" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <div class="col-xl-12 col-lg-12 col-12 form-group mb-4">
                                    <label>Description</label>
                                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="Description" Rows="3"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card height-auto pb-3 ui-modal-box">
                    <div class="card-body modal-box">
                        <div class="heading-layout1">
                            <div class="item-title">
                                <h3>Details</h3>
                            </div>
                        </div>
                        <div class="new-added-form">
                            <div class="row">
                                <div class="col-xl-6 col-lg-6 col-12 form-group">
                                    <label>Item Name</label>
                                    <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                                </div>
                                <div class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label>Amount</label>
                                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="fteAmount" runat="server" TargetControlID="txtAmount" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <div class="col-xl-12 col-lg-12 col-12 form-group">
                                    <label>Remarks</label>
                                    <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="textarea form-control" MaxLength="1000" Rows="3"></asp:TextBox>
                                </div>
                                <!-- Submit & Cancel -->
                                <div class="col-12 form-group mg-t-8">
                                    <asp:LinkButton ID="lbSubmitSession" runat="server" ValidationGroup="vsSessions"
                                        CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                        CommandArgument="Add" OnClick="SubmitDetails">Submit</asp:LinkButton>
                                    <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                                        onclick="ShowConfirmModal('mpConfirmCancelSessions','pnlConfirmExtenderCancelSessions');return false;">Clear</a>
                                    <asp:HiddenField ID="hfCancelSessions" runat="server" />
                                    <asp:ModalPopupExtender ID="mpConfirmCancelSessions" runat="server" PopupControlID="pnlConfirmExtenderCancelSessions" TargetControlID="hfCancelSessions"
                                        CancelControlID="lbNoCancelSessions" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="pnlConfirmExtenderCancelSessions" runat="server" ClientIDMode="Static" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
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
                                                        <h3 class="item-title">You want to clear details ?</h3>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:LinkButton ID="lbYesCancelSessions" runat="server" CssClass="footer-btn btn-success" OnClick="CancelDetails">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="lbNoCancelSessions" runat="server" CssClass="footer-btn btn-danger" OnClientClick="CloseConfirmPopup('mpConfirmCancelSessions');return false;">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                            <!-- lvDetails -->
                            <div class="col-xl-12 col-lg-12 px-0 mb-3">
                                <div class="table-responsive">
                                    <asp:HiddenField ID="hfDetailsIndex" runat="server" />
                                    <asp:ListView ID="lvDetails" runat="server" ClientIDMode="AutoID">
                                        <LayoutTemplate>
                                            <table id="tblDetails" class="table display data-table text-nowrap">
                                                <thead>
                                                    <tr>
                                                        <th>No.</th>
                                                        <th>Item Name</th>
                                                        <th>Amount</th>
                                                        <th>Remarks</th>
                                                        <th>Edit</th>
                                                        <th>Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr id="itemPlaceholder" runat="server">
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("Item")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lbEdit" runat="server" CssClass="btn btn-info text-white" CommandArgument='<%# Eval("ID") %>' OnClick="EditDetails">
                                                    <i class="fas fa-edit"></i>
                                                    </asp:LinkButton>
                                                </td>
                                                <td>
                                                    <a class="btn btn-danger text-white"
                                                        onclick="ShowConfirmModal('<%# CType(Container, ListViewItem).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, ListViewItem).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
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
                                                                    <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteDetails">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                                    <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <table style="width: 100%;">
                                                <tr class="EmptyRowStyle">
                                                    <td>
                                                        <div>No Data Found.</div>
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
            </asp:Panel>
            <!-- Admit Form Area End Here -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="../js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="../js/UploadPhoto.js"></script>
</asp:Content>
