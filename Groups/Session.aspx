<%@ Page Title="Up Skills | Add Session" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Session.aspx.vb" Inherits="Session" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="../css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="../css/datepicker.min.css">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Add Session</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>
                <a href="SessionsList.aspx">Sessions List</a>
            </li>
            <li>Add Session</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <asp:Label Text="" ID="lblRes" runat="server" />
    <asp:Panel runat="server" ID="pnlForm">
        <div class="card height-auto pb-4 ui-modal-box">
            <div class="card-body py-4 modal-box">
                <div class="heading-layout1 mb-0">
                    <div class="item-title">
                        <h3>Add New Session</h3>
                    </div>
                    <!-- Save & Cancel -->
                    <div class="">
                        <asp:Button ID="lbSave" runat="server" ValidationGroup="vsMaster" UseSubmitBehavior="false"
                            CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white mr-3"
                            CommandArgument="Add" OnClick="Save" OnClientClick="SaveClick(this,'vsMaster');" Text="Save" />
                        <%--<asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>--%>
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
                        <h3>Sessions</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <asp:ValidationSummary ID="VSMaster" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsMaster" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                    <asp:Panel ID="pnlSession" runat="server" CssClass="row">
                        <!-- GroupID -->
                        <div id="divGroupID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblGroupID" runat="server" for="txtGroupID">Group *</label>
                            <asp:TextBox ID="txtGroupID" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqGroupID" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtGroupID" Display="Dynamic" Text="Required Group"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="hfGroupID" runat="server" />
                        </div>
                        <!-- Code -->
                        <div id="divCode" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblCode" runat="server" for="txtCode">Code</label>
                            <asp:TextBox ID="txtCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <!-- Title -->
                        <div id="divTitle" runat="server" class="col-xl-6 col-lg-6 col-12 form-group">
                            <label id="lblTitle" runat="server" for="txtTitle">Title *</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTitle" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtTitle" Display="Dynamic" Text="Required Title"></asp:RequiredFieldValidator>
                        </div>
                        <!-- IssueDate -->
                        <div id="divIssueDate" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblIssueDate" runat="server" for="txtIssueDate">Issue Date *</label>
                            <asp:TextBox ID="txtIssueDate" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                data-position='bottom right'></asp:TextBox>
                            <i class="far fa-calendar-alt"></i>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqIssueDate" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtIssueDate" Display="Dynamic" Text="Required Issue Date"></asp:RequiredFieldValidator>
                        </div>
                        <!-- DefaultPeriodHour -->
                        <div id="divDefaultPeriodHour" runat="server" class="col-xl-3 col-lg-6 col-3 form-group">
                            <label id="lblDefaultPeriodHour" runat="server" for="txtDefaultPeriodHour">Period *</label>
                            <asp:TextBox ID="txtDefaultPeriodHour" runat="server" CssClass="form-control" MaxLength="2" TextMode="Number"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqDefaultPeriodHour" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtDefaultPeriodHour" Display="Dynamic" Text="Required Period"></asp:RequiredFieldValidator>
                            <asp:FilteredTextBoxExtender ID="fteDefaultPeriodHour" runat="server" TargetControlID="txtDefaultPeriodHour" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <!-- Remarks -->
                        <div id="divRemarks" runat="server" class="col-lg-12 col-12 form-group">
                            <label id="lblRemarks" runat="server" for="txtRemarks">Remarks</label>
                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="message" Rows="4"></asp:TextBox>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>
    <!-- Admit Form Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="../js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
</asp:Content>
