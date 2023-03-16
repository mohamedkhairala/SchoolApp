<%@ Page Title="Up Skills | Message" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Message.aspx.vb" Inherits="Message" %>

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
            <li>Message</li>
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
                    <asp:ValidationSummary ID="ValidationSummary" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vUsers" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />

                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-12 form-group">
                            <label>Title *</label>
                            <asp:TextBox ID="txtMessageTitle" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqFnAME" runat="server" ValidationGroup="vUsers"
                                ControlToValidate="txtMessageTitle" Display="Dynamic" Text="Required Title"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-xl-4 col-lg-4 col-4 form-group">
                            <label>Stack Holder</label>
                            <div class="radio-list">
                                <asp:RadioButtonList ID="rplTypes" runat="server" AutoPostBack="true" RepeatLayout="UnorderedList" OnSelectedIndexChanged="SelectType">
                                    <asp:ListItem Value="Student" Selected="True">Student</asp:ListItem>
                                    <asp:ListItem Value="Supervisor">Supervisors</asp:ListItem>
                                    <asp:ListItem Value="Teacher">Teacher</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <asp:Panel runat="server" ID="pnlStudent" CssClass="d-contents">
                            <div class="col-xl-4 col-lg-4 col-4 form-group">
                                <label>Groups</label>
                                <asp:DropDownList ID="ddlGroups" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="FillGroupStudent">
                                    <asp:ListItem Value="0">Select Group</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xl-4 col-lg-4 col-4 form-group">
                                <label>Students</label>
                                <asp:DropDownList ID="ddlStudent" runat="server" CssClass="select2">
                                    <asp:ListItem Value="0">Select Student</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pnlTeachers" CssClass="d-contents" Visible="false">
                            <div class="col-xl-4 col-lg-4 col-4 form-group">
                                <label>Teachers</label>
                                <asp:DropDownList ID="ddlTeachers" runat="server" CssClass="select2">
                                    <asp:ListItem Value="0">Select Teacher</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pnlSupervisors" CssClass="d-contents" Visible="false">
                            <div class="col-xl-4 col-lg-4 col-4 form-group">
                                <label>Supervisors</label>
                                <asp:DropDownList ID="ddlSupervisors" runat="server" CssClass="select2">
                                    <asp:ListItem Value="0">Select Supervisor</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </asp:Panel>
                        <div class="col-xl-12 col-lg-12 col-12 form-group">
                            <label>Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="Description" Rows="5"></asp:TextBox>
                        </div>
                        <div class="col-12 form-group mg-t-8">
                            <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vUsers"
                                CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                CommandArgument="Add" OnClick="Save">Send</asp:LinkButton>
                            <asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>
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
