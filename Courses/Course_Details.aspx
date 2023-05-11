<%@ Page Title="Up Skills | Course Details" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Course_Details.aspx.vb" Inherits="Student_Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server"></asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Course Details</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
             <li>
                <a href="CourseList.aspx">Courses List</a>
            </li>
            <li>Course Details</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Student Details Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <asp:Label Text="" ID="lblRes" runat="server" />
                </div>

            </div>
            <asp:ListView  runat="server" ID="rpDetails">
                <ItemTemplate>
                    <div class="single-info-details">
                         
                        <div class="item-content">
                            <div class="header-inline item-header">
                                <h3 class="text-dark-medium font-medium"><%# Eval("Name")%></h3>

                                <div class="header-actions">
                                    <ul>
                                        <li>
                                            <asp:Panel ID="pnlEdit" runat="server">
                                                <a id="lbEdit" class="action-green" runat="server" href='<%# "Course.aspx?Mode=Edit&ID=" & Eval("Id")%>'><i class="far fa-edit"></i></a>
                                            </asp:Panel>
                                        </li>
                                        <li>
                                            <asp:Panel ID="pnlPrint" runat="server">
                                                <a id="lbPrint" class="action-blue" onclick="PrintDetails();"><i class="fas fa-print"></i></a>
                                            </asp:Panel>
                                        </li>
                                        <li>
                                            <asp:Panel ID="pnlDelete" runat="server">
                                                <asp:LinkButton ID="lbDelete" CssClass="action-red" runat="server" OnClientClick="return confirm('Confirm Delete?')" OnClick="Delete"><i class="far fa-trash-alt"></i></asp:LinkButton>
                                            </asp:Panel>
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
                                            <td>Title:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("Name")%></td>
                                        </tr>
                                        <tr>
                                            <td>No Of Sessions:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("NoOfSessions")%></td>
                                        </tr>
                                         <tr>
                                            <td>Session Rate:</td>
                                            <td class="font-medium text-dark-medium"><%# Eval("SessionRate")%></td>
                                        </tr>
                                         <tr>
                                            <td>Fees:</td>
                                            <td class="font-medium text-dark-medium"><%# PublicFunctions.DecimalFormat(Eval("Fees"))%></td>
                                        </tr>
                                        <tr>
                                            <td>Created Date:</td>
                                            <td class="font-medium text-dark-medium"><%#  PublicFunctions.DateFormat(Eval("CreatedDate"), "dd/MM/yyyy")%></td>
                                        </tr>

                                       
                                        <tr>
                                            <td>Group:</td>
                                            <td><asp:GridView runat="server" ID="rpGroups" ClientIDMode="AutoID">
                                            </asp:GridView></td>
                                            
                                        </tr>
                                       
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <!-- Student Details Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
