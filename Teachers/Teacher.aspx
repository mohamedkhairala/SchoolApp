<%@ Page Title="Up Skills | Add Teacher" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Teacher.aspx.vb" Inherits="Add_Student" %>

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
                        <a href="../Dashboard.aspx">Home</a>
                    </li>
                    <li><a href="TeachersList.aspx">Teachers List</a></li>
                    <li>Teacher</li>
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
                        <asp:Panel runat="server" ID="divActions" CssClass="header-actions">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="lbEdit" CssClass="action-green" runat="server" OnClick="Edit"><i class="far fa-edit"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="lbDelete" CssClass="action-red" Visible="false" runat="server"><i class="far fa-trash-alt"></i></asp:LinkButton>
                                </li>
                            </ul>
                        </asp:Panel>
                    </div>
                    <div class="new-added-form ui-modal-box">
                        <asp:Panel runat="server" ID="pnlForm">
                            <div class="row modal-box">
                                <div class="col-xl-3 col-lg-6">
                                    <div class="row">
                                        <div class="col-xl-12 col-lg-12 col-12 form-group mg-t-30">
                                            <div class="upload-profile">
                                                <asp:AsyncFileUpload ID="fuIcon" runat="server" CssClass="form-control-file"
                                                    OnUploadedComplete="IconUploaded"
                                                    OnClientUploadComplete="UploadIconCompleted" OnClientUploadError="UploadIconError"
                                                    OnClientUploadStarted="UploadIconStarted" FailedValidation="False" />
                                                <asp:TextBox ID="HiddenIcon" runat="server" ClientIDMode="Static" Style="display: none"></asp:TextBox>

                                                <div class="dashes">
                                                    <asp:Image ID="imgIcon" runat="server" CssClass="userPhoto" ClientIDMode="Static" ImageUrl="img/figure/Photo.jpg" />
                                                </div>
                                                <asp:Image ID="imgIconLoader" runat="server" CssClass="img-loader-upload" ClientIDMode="Static" ImageUrl="~/img/preloader-2.gif" Style="display: none;" />
                                                <label class="btn-upload btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white">Upload Photo</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-9 col-lg-6">
                                    <asp:ValidationSummary ID="vsTeacher" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vgTeacher" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />

                                    <div class="row">
                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Code *</label>
                                            <asp:TextBox ID="txtCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCode" runat="server" ValidationGroup="vgTeacher"
                                        ControlToValidate="txtCode" Display="Dynamic" Text="Required Code"></asp:RequiredFieldValidator>--%>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Name *</label>
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqFnAME" runat="server" ValidationGroup="vgTeacher"
                                                ControlToValidate="txtFirstName" Display="Dynamic" Text="Required Name"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Gender *</label>
                                            <asp:DropDownList ID="ddlGender" runat="server" CssClass="select2">
                                                <asp:ListItem Value="">Please Select Gender *</asp:ListItem>
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator2" runat="server" ValidationGroup="vgTeacher"
                                                ControlToValidate="ddlGender" InitialValue="" Display="Dynamic" Text="Required Gender"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-3 form-group">
                                            <label>Salary</label>
                                            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator6" runat="server" ValidationGroup="vgTeacher"
                                        ControlToValidate="txtSalary" Display="Dynamic" Text="Required Salary"></asp:RequiredFieldValidator>--%>
                                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtSalary" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-3 form-group">
                                            <label>Rate Per Hour</label>
                                            <asp:TextBox ID="txtRatePerHour" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator6" runat="server" ValidationGroup="vgTeacher"
                                        ControlToValidate="txtHourRate" Display="Dynamic" Text="Required Hour Rate"></asp:RequiredFieldValidator>--%>
                                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtRatePerHour" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-3 form-group">
                                            <label>Rate Per Student</label>
                                            <asp:TextBox ID="txtRatePerStudent" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator7" runat="server" ValidationGroup="vgTeacher"
                                        ControlToValidate="txtRatePerStudent" Display="Dynamic" Text="Required Student Rate"></asp:RequiredFieldValidator>--%>
                                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtRatePerStudent" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Date Of Birth</label>
                                            <asp:TextBox ID="txtDateOfBirth" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                                data-position='bottom right'></asp:TextBox>
                                            <i class="far fa-calendar-alt"></i>
                                        </div>

                                        <div class="col-xl-8 col-lg-6 col-12 form-group">
                                            <label>E-Mail *</label>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator3" runat="server" ValidationGroup="vgTeacher"
                                                ControlToValidate="txtEmail" Display="Dynamic" Text="Required Email"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revEmail" ValidationGroup="vgTeacher" CssClass="valid-inp" runat="server" ControlToValidate="txtEmail"
                                                ErrorMessage="InValidEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Phone *</label>
                                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator4" runat="server" ValidationGroup="vgTeacher"
                                        ControlToValidate="txtPhone" Display="Dynamic" Text="Required Phone"></asp:RequiredFieldValidator>--%>

                                            <asp:FilteredTextBoxExtender runat="server" ID="ftmobile" TargetControlID="txtPhone" ValidChars="+0123456789"></asp:FilteredTextBoxExtender>
                                        </div>
                                        <div class="col-xl-4 col-lg-6 col-12 form-group">
                                            <label>Mobile *</label>
                                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator5" runat="server" ValidationGroup="vgTeacher"
                                                ControlToValidate="txtMobile" Display="Dynamic" Text="Required Mobile"></asp:RequiredFieldValidator>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtMobile" ValidChars="+0123456789"></asp:FilteredTextBoxExtender>

                                        </div>
                                        <div class="col-lg-12 col-12 form-group">
                                            <label>Short BIO</label>
                                            <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="message" Rows="9"></asp:TextBox>
                                        </div>
                                        <div class="col-12 form-group mg-t-8">
                                            <asp:Button ID="lbSave" runat="server" ValidationGroup="vgTeacher" UseSubmitBehavior="false"
                                                CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                                CommandArgument="Add" OnClick="Save" OnClientClick="SaveClick(this,'vgTeacher');" Text="Save" />
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
    <script src="../js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="../js/UploadPhoto.js"></script>
</asp:Content>
