<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Signup.aspx.vb" Inherits="Signup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Up Skills | Sing Up</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
    <!-- Normalize CSS -->
    <link rel="stylesheet" href="css/normalize.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="css/main.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="css/all.min.css">
    <!-- Flaticon CSS -->
    <link rel="stylesheet" href="fonts/flaticon.css">
    <!-- Animate CSS -->
    <link rel="stylesheet" href="css/animate.min.css">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Modernize js -->
    <script src="js/modernizr-3.6.0.min.js"></script>

    <style>
        .select2-container .select2-selection--single {
            background-color: #fff;
            border-color: #aaa;
        }

        .login-page-content .login-box .login-form .form-group .btn-fill-lg {
            padding: 16px 45px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <!-- Preloader Start Here -->
        <div id="preloader"></div>
        <!-- Preloader End Here -->
        <!-- Login Page Start Here -->
        <div class="login-page-wrap">
            <div class="login-page-content">
                <div class="login-box">
                    <div class="item-logo">
                        <img src="img/logo2.png" alt="logo">
                    </div>
                    <div class="login-form">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter Full Name" CssClass="form-control"></asp:TextBox>
                                        <i class="far fa-user"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Username</label>
                                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter Usrename" CssClass="form-control"></asp:TextBox>
                                        <i class="far fa-user"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email" CssClass="form-control"></asp:TextBox>
                                        <i class="far fa-envelope"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Gender</label>
                                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="select2">
                                            <asp:ListItem value="">Select Gender</asp:ListItem>
                                            <asp:ListItem value="1">Male</asp:ListItem>
                                            <asp:ListItem value="2">Female</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Password</label>
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Password" CssClass="form-control"></asp:TextBox>
                                        <i class="fas fa-lock"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Confirm Password</label>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Enter Confirm Password" CssClass="form-control"></asp:TextBox>
                                        <i class="fas fa-lock"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Phone</label>
                                        <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter Phone" CssClass="form-control"></asp:TextBox>
                                        <i class="fas fa-phone"></i>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:LinkButton ID="lbSingUp" runat="server" CssClass="login-btn mt-0">Sing Up</asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <a href="Login.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark w-100 text-center text-white">Back To Login</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Login Page End Here -->
    </form>
    <!-- jquery-->
    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Select 2 Js -->
    <script src="js/select2.min.js"></script>
    <!-- Scroll Up Js -->
    <script src="js/jquery.scrollUp.min.js"></script>
    <!-- Custom Js -->
    <script src="js/main.js"></script>
</body>
</html>
