<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" Inherits="ChangePassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Up Skills | Change Password</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png" />
    <!-- Normalize CSS -->
    <link rel="stylesheet" href="css/normalize.css" />
    <!-- Main CSS -->
    <link rel="stylesheet" href="css/main.css" />
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="css/all.min.css" />
    <!-- Flaticon CSS -->
    <link rel="stylesheet" href="fonts/flaticon.css" />
    <!-- Animate CSS -->
    <link rel="stylesheet" href="css/animate.min.css" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css" />
    <!-- Modernize js -->
    <script src="js/modernizr-3.6.0.min.js"></script>
    <style>
        .valid-inp[style="display: inline;"] + .valid-inp {
            bottom: -37px;
        }

        .valid-inp[style="display: inline;"] + 
        .valid-inp[style="display: inline;"] + 
        .margin-line {
            margin-bottom: 3.5rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off" defaultbutton="lbSubmit">
        <asp:ToolkitScriptManager ID="TKSM" runat="server" ScriptMode="Release">
            <Services>
                <asp:ServiceReference Path="~/WebService.asmx" />
            </Services>
        </asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="up" runat="server">
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
                <%--<!-- Preloader Start Here -->
                <div id="preloader"></div>
                <!-- Preloader End Here -->--%>
                <!-- Login Page Start Here -->
                <div class="login-page-wrap">
                    <div class="login-page-content">
                        <div class="login-box">
                            <div class="item-logo">
                                <h2>Change Password</h2>
                            </div>
                            <div class="login-form">
                                <asp:Label ID="lblRes" runat="server"></asp:Label>
                                <div class="form-group">
                                    <label class="mb-0">Old Password</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Old password" CssClass="form-control"></asp:TextBox>
                                    <i class="fas fa-lock"></i>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="reg" Text="Reuired Old Password" ControlToValidate="txtPassword" runat="server" ErrorMessage="Reuired Old Password" Display="Dynamic" CssClass="valid-inp"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender ID="Filteredtextboxextender2" runat="server"
                                        FilterType="Custom" FilterMode="InvalidChars" InvalidChars=" "
                                        TargetControlID="txtPassword">
                                    </asp:FilteredTextBoxExtender>
                                </div>
                                <div class="form-group">
                                    <label class="mb-0">New Password</label>
                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter new password" CssClass="form-control"></asp:TextBox>
                                    <i class="fas fa-lock"></i>
                                    <asp:RequiredFieldValidator ID="rfvNewPassword" ValidationGroup="reg" Text="Reuired New Password" ControlToValidate="txtNewPassword" runat="server" ErrorMessage="Reuired New Password 1" Display="Dynamic" CssClass="valid-inp"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender ID="RequiredFieldValidator2" runat="server"
                                        FilterType="Custom" FilterMode="InvalidChars" InvalidChars=" "
                                        TargetControlID="txtNewPassword">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:RegularExpressionValidator ValidationGroup="reg" ID="RegexVal" CssClass="valid-inp" ValidationExpression="^.{6,50}$" runat="server" ErrorMessage="Password should not be less than 6 digits" ControlToValidate="txtNewPassword" Display="Dynamic" />
                                    <asp:CompareValidator ControlToCompare="txtNewPassword" Display="Dynamic" ValidationGroup="reg" ControlToValidate="txtConfirmPassword"
                                        CssClass="valid-inp" runat="server" ErrorMessage="Password Not Matched"></asp:CompareValidator>
                                    <div class="margin-line"></div>
                                </div>
                                <div class="form-group">
                                    <label class="mb-0">Confirm Password</label>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Enter confirm password" CssClass="form-control"></asp:TextBox>
                                    <i class="fas fa-lock"></i>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="reg" Text="Reuired Confirm Password" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="Reuired New Password 2" Display="Dynamic" CssClass="valid-inp"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender ID="Filteredtextboxextender1" runat="server"
                                        FilterType="Custom" FilterMode="InvalidChars" InvalidChars=" "
                                        TargetControlID="txtConfirmPassword">
                                    </asp:FilteredTextBoxExtender>
                                </div>
                                <div class="form-group">
                                    <asp:LinkButton ID="lbSubmit" runat="server" CssClass="login-btn" ValidationGroup="reg" OnClick="ChangePassword">Change Password</asp:LinkButton>
                                </div>
                                <div class="form-group mb-0">
                                    <a href="Dashboard.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark w-100 text-center text-white">Back To Dashboard</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Login Page End Here -->
            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
    <!-- jquery-->
    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Scroll Up Js -->
    <script src="js/jquery.scrollUp.min.js"></script>
    <!-- Custom Js -->
    <script src="js/main.js"></script>
</body>
</html>
