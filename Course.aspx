<%@ Page Title="Up Skills | Courses" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Course.aspx.vb" Inherits="Course" %>

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
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">

        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Course</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>
                        <asp:Label Text="" runat="server" ID="lblTitle" /></h3>


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

                        <div class="col-xl-9 col-lg-6">
                            <asp:ValidationSummary ID="ValidationSummary" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vUsers" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />

                            <div class="row">
                                <div class="col-xl-4 col-lg-6 col-12 form-group">
                                    <label>Code *</label>
                                    <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCode" runat="server" ValidationGroup="vUsers"
                                        ControlToValidate="txtCode" Display="Dynamic" Text="Required Code"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xl-8 col-lg-6 col-6 form-group">
                                    <label>Title *</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqFnAME" runat="server" ValidationGroup="vUsers"
                                        ControlToValidate="txtName" Display="Dynamic" Text="Required Title"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label>Number of Sessions</label>
                                    <asp:TextBox ID="txtNoOfSessions" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator6" runat="server" ValidationGroup="vUsers"
                                        ControlToValidate="txtNoOfSessions" Display="Dynamic" Text="Required Number of Sessions"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtNoOfSessions" ValidChars="0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <div class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label>Rate Per Session</label>
                                    <asp:TextBox ID="txtRatePerSession" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator7" runat="server" ValidationGroup="vUsers"
                                        ControlToValidate="txtRatePerSession" Display="Dynamic" Text="Required Hour Rate"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtRatePerSession" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <div class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label>Fees</label>
                                    <asp:TextBox ID="txtFees" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator86" runat="server" ValidationGroup="vUsers"
                                        ControlToValidate="txtFees" Display="Dynamic" Text="Required Hour Rate"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtFees" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>


                                <div class="col-lg-12 col-12 form-group">
                                    <label>Description</label>
                                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="Description" Rows="9"></asp:TextBox>
                                </div>
                                <div class="col-12 form-group mg-t-8">
                                    <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vUsers"
                                        CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                        CommandArgument="Add" OnClick="Save">Save</asp:LinkButton>
                                    <asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
    <!-- Admit Form Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="js/UploadPhoto.js"></script>
</asp:Content>
