<%@ Page Title="Up Skills | Add Student" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Add_Student.aspx.vb" Inherits="Add_Student" %>

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
        <h3>Add Student</h3>
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Add Student</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>Add New Student</h3>
                    <asp:Label Text="" ID="lblRes" runat="server" />
                </div>
                <!--<div class="dropdown">
                                <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                                   aria-expanded="false">...</a>

                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-times text-orange-red"></i>Close
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-redo-alt text-orange-peel"></i>Refresh
                                    </a>
                                </div>
                            </div>-->
            </div>
            <div class="new-added-form">
                <div class="row">
                    <div class="col-xl-3 col-lg-6">
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-12 form-group mg-t-30">
                                <%--<label class="text-dark-medium">Upload Student Photo (150px X 150px)</label>--%>
                                <%--<input id="mediaFile" type="file" class="form-control-file">--%>
                                <asp:AsyncFileUpload ID="fuIcon" runat="server" CssClass="form-control-file"
                                    OnUploadedComplete="IconUploaded"
                                    OnClientUploadComplete="UploadIconCompleted" OnClientUploadError="UploadIconError"
                                    OnClientUploadStarted="UploadIconStarted" FailedValidation="False" />
                                <asp:TextBox ID="HiddenIcon" runat="server" ClientIDMode="Static" Style="display: none"></asp:TextBox>

                                <div id="profile">
                                    <div class="dashes">
                                        <%--<img id="imgProfile" runat="server" src="img/figure/Photo.jpg" />--%>
                                        <asp:Image ID="imgIcon" CssClass="userPhoto" ClientIDMode="Static"
                                            runat="server" ImageUrl="img/figure/Photo.jpg" Width="100%" />

                                    </div>
                                    <asp:Image ID="imgIconLoader" runat="server" CssClass="img-loader-upload" ClientIDMode="Static" ImageUrl="img/preloader.gif" Style="display: none; width: 50px" />

                                    <label class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white">Upload Photo</label>
                                </div>

                                
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-6">
                        <div class="d-flex">
                            <asp:ValidationSummary ID="ValidationSummary" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vUsers" EnableClientScript="true" runat="server" CssClass="ValidationSummary" />
                        </div>
                        <div class="row">
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Code</label>
                                <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCode" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="txtCode"
                                    ErrorMessage=" Required Code " Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>First Name *</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqFnAME" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="txtFirstName"
                                    ErrorMessage=" Required First Name " Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Last Name *</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator1" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="txtLastName"
                                    ErrorMessage=" Required Last Name " Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Gender *</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="select2">
                                    <asp:ListItem Value="">Please Select Gender *</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator2" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="ddlGender" InitialValue=""
                                    ErrorMessage=" Required Gender " Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Date Of Birth *</label>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                    data-position='bottom right'></asp:TextBox>
                                <i class="far fa-calendar-alt"></i>


                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Groups *</label>
                                <asp:DropDownList ID="ddlGroups" runat="server" CssClass="select2">
                                    <asp:ListItem Value="">Please Select Section *</asp:ListItem>
                                    <asp:ListItem Value="A">A</asp:ListItem>
                                    <asp:ListItem Value="B">B</asp:ListItem>
                                    <asp:ListItem Value="C">C</asp:ListItem>
                                    <asp:ListItem Value="D">D</asp:ListItem>
                                    <asp:ListItem Value="E">E</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xl-8 col-lg-6 col-12 form-group">
                                <label>E-Mail</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator3" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage=" Required Email" Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" ValidationGroup="vUsers" CssClass="valid-inp" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="InValidEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                            </div>
                            <div class="col-xl-4 col-lg-6 col-12 form-group">
                                <label>Phone</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="RequiredFieldValidator4" runat="server" ValidationGroup="vUsers"
                                    ControlToValidate="txtPhone"
                                    ErrorMessage=" Required Phone" Display="Dynamic" Text=" *"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-lg-12 col-12 form-group">
                                <label>Short BIO</label>
                                <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine"
                                    CssClass="textarea form-control" name="message" Rows="9"></asp:TextBox>

                            </div>
                            <div class="col-12 form-group mg-t-8">
                                <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vUsers" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white" OnClick="Save">Save</asp:LinkButton>
                                <asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
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
    <script src="js/upload-photo.js"></script>
    <script src="js/UploadPhoto.js"></script>

</asp:Content>
