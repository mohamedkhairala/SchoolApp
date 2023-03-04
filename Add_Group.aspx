<%@ Page Title="Up Skills | Add Group" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Add_Group.aspx.vb" Inherits="Add_Group" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="css/datepicker.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Add Group</h3>
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Add Group</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>Add New Group</h3>
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
                <asp:Panel runat="server" ID="pnlForm">
                    <div class="row">
                        <div class="col-xl-9 col-lg-6">
                            <asp:ValidationSummary ID="VSMaster" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsMaster" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                            <div class="row">
                                <!-- Name -->
                                <div id="divName" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblName" runat="server" for="txtName">Name *</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqName" runat="server" ValidationGroup="vsMaster"
                                        ControlToValidate="txtName" Display="Dynamic" Text="Required Name"></asp:RequiredFieldValidator>
                                </div>
                                <!-- CourseID -->
                                <div id="divCourseID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblCourseID" runat="server" for="ddlCourseID">Course *</label>
                                    <asp:DropDownList ID="ddlCourseID" runat="server" CssClass="select2">
                                        <asp:ListItem Value="">Please Select Course *</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCourseID" runat="server" ValidationGroup="vsMaster"
                                        ControlToValidate="ddlCourseID" InitialValue="" Display="Dynamic" Text="Required Course"></asp:RequiredFieldValidator>
                                </div>
                                <!-- TeacherID -->
                                <div id="divTeacherID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblTeacherID" runat="server" for="ddlTeacherID">Teacher *</label>
                                    <asp:DropDownList ID="ddlTeacherID" runat="server" CssClass="select2">
                                        <asp:ListItem Value="">Please Select Teacher *</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTeacherID" runat="server" ValidationGroup="vsMaster"
                                        ControlToValidate="ddlTeacherID" InitialValue="" Display="Dynamic" Text="Required Teacher"></asp:RequiredFieldValidator>
                                </div>
                                <!-- SupervisorID -->
                                <div id="divSupervisorID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblSupervisorID" runat="server" for="ddlSupervisorID">Course *</label>
                                    <asp:DropDownList ID="ddlSupervisorID" runat="server" CssClass="select2">
                                        <asp:ListItem Value="">Please Select Supervisor *</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorID" runat="server" ValidationGroup="vsMaster"
                                        ControlToValidate="ddlSupervisorID" InitialValue="" Display="Dynamic" Text="Required Supervisor"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-12 form-group mg-t-8">
                                    <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vsMaster"
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
</asp:Content>
