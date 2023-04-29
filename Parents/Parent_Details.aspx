<%@ Page Title="Up Skills | StuParentdent Details" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Parent_Details.aspx.vb" Inherits="Student_Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Parent Details</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>
                <a href="ParentsList.aspx">Parents List</a>
            </li>
            <li>Parent Details</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Student Details Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <asp:Label Text="" ID="lblRes" runat="server" />
                    <h3>About</h3>
                </div>

            </div>
            <asp:Repeater runat="server" ID="rpDetails">
                <ItemTemplate>
                    <div class="single-info-details">
                        <div class="item-img">
                            <img src='<%# IIf(String.IsNullOrEmpty(Eval("Photo")), "img/figure/Photo.jpg", PublicFunctions.ServerURL & Eval("Photo").ToString.Replace("~/", ""))  %>' alt="student">
                        </div>
                        <div class="item-content">
                            <div class="header-inline item-header">
                                <h3 class="text-dark-medium font-medium"><%# Eval("Name")%></h3>

                                <div class="header-actions">
                                    <ul>
                                        <li>
                                            <a id="lbEdit" class="action-green" runat="server" href='<%# "Parent.aspx?Mode=Edit&ID=" & Eval("Id")%>'><i class="far fa-edit"></i></a>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="lbPrint" CssClass="action-blue" runat="server"><i class="fas fa-print"></i></asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="lbDelete" CssClass="action-red" runat="server" OnClientClick="return confirm('Confirm Delete?')" OnClick="Delete"><i class="far fa-trash-alt"></i></asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <p>
                                <%# Eval("Remarks")%>
                            </p>
                            <div class="info-table table-responsive">
                                <table class="table text-nowrap">
                                    <tbody>
                                        <tr>
                                            <td>Code:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("Code")%></td>
                                        </tr>
                                        <tr>
                                            <td>Name:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("Name")%></td>
                                        </tr>
                                        <tr>
                                            <td>Gender:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("FullGender")%></td>
                                        </tr>

                                       <%-- <tr>
                                            <td>Date Of Birth:</td>
                                            <td class="font-medium text-dark-medium"><%#  PublicFunctions.DateFormat(Eval("DateOfBirth"), "dd/MM/yyyy")%></td>
                                        </tr>--%>

                                        <tr>
                                            <td>E-mail:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("Email")%></td>
                                        </tr>
                                       <%-- <tr>
                                            <td>Admission Date:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("CreatedDate")%></td>
                                        </tr>--%>
                                        <tr>
                                            <td>Children:</td>
                                            <td><asp:GridView runat="server" ID="rpGroups" ClientIDMode="AutoID">
                                            </asp:GridView></td>
                                            
                                        </tr>
                                        <tr>
                                            <td>Address:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("Address")%></td>
                                        </tr>
                                        <tr>
                                            <td>Mobile:</td>
                                            <td><i class="fa-telegram"></i><a href="tel:<%# Eval("Mobile")%>"><%# Eval("Mobile")%></a></td>
                                            <td><i class="fa-whatsapp"></i><a target="_blank" href="https://wa.me/<%# Eval("Mobile")%>"><%# Eval("Mobile")%></a></td>
                                        </tr>
                                        <tr>
                                            <td>Phone:</td>
                                            <td class="font-medium text-dark-medium"><a href="tel:<%# Eval("Tel")%>"><%# Eval("Tel")%></a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <!-- Student Details Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>
</asp:Content>
