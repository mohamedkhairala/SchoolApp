<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Forgot_Password.aspx.vb" Inherits="Forgot_Password" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Up Skills | Forgot Password</title>
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
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Modernize js -->
    <script src="js/modernizr-3.6.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off" defaultbutton="lbResetPassword">
        <!-- Preloader Start Here -->
        <div id="preloader"></div>
        <!-- Preloader End Here -->
        <!-- Login Page Start Here -->
        <div class="login-page-wrap">
            <div class="login-page-content">
                <div class="login-box">
                    <div class="item-logo">
                        <img src="img/logo2.png" alt="logo" />
                    </div>
                    <div class="login-form">
                        <div class="form-group">
                            <asp:Label ID="lblRes" CssClass="res-label-info" runat="server"></asp:Label>
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email" CssClass="form-control"></asp:TextBox>
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="form-group">
                            <asp:LinkButton ID="lbResetPassword" runat="server" CssClass="login-btn" OnClick ="SendEmail">Reset Password</asp:LinkButton>
                        </div>
                        <div class="form-group">
                            <a href="Login.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark w-100 text-center text-white">Back To Login</a>
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
    <!-- Scroll Up Js -->
    <script src="js/jquery.scrollUp.min.js"></script>
    <!-- Custom Js -->
    <script src="js/main.js"></script>
</body>
</html>
