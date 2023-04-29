<%@ Page Title="Up Skills | All Students" Language="VB" MasterPageFile="../Master.master" AutoEventWireup="false" CodeFile="~/Students/StudentsList.aspx.vb" Inherits="StudentsList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Students</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>All Students</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Student Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Students Data</h3>
                </div>
                <!--<div class="dropdown">
                    <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">...</a>

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
            <div class="mg-b-20" id="divSearch" runat="server" visible="false">
                <div class="row gutters-8">
                    <div class="col-6-xxxl col-xl-6 col-lg-4 col-12 form-group">
                    </div>
                    <div class="col-4-xxxl col-xl-4 col-lg-5 col-12 form-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Code, Name or Group ..." AutoPostBack="true" OnTextChanged="FillGrid"></asp:TextBox>
                    </div>
                    <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                        <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center" OnClick="FillGrid"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-12 px-0 text-right">
                <div class="d-inline-flex mb-3">
                    <a href="../Students/Student.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></a>
                </div>
            </div>

            <div class="table-responsive">
                <asp:HiddenField ID="SortExpression" runat="server" />
                <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                    <LayoutTemplate>
                        <table class="table display data-table text-nowrap">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Photo</th>
                                    <th>Name</th>
                                    <th>Gender</th>
                                    <%--<th>Group</th>--%>
                                    <th>Parents</th>
                                    <th>Address</th>
                                    <th>Date Of Birth</th>
                                    <th>Phone</th>
                                    <th>E-mail</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>

                        <tr>
                            <td>#<%# Eval("Code")%>
                                <asp:Label ID="lblStudentId" runat="server" Visible="false" Text='<%# Eval("Id")%>'></asp:Label>
                                <asp:Label ID="lblParentId" runat="server" Visible="false" Text='<%# Eval("ParentId")%>'></asp:Label>
                            </td>
                            <td class="text-center">
                                <img class="img-thumbnail" src='<%# IIf(String.IsNullOrEmpty(Eval("Photo")), "../img/figure/Photo.jpg", PublicFunctions.ServerURL & Eval("Photo").ToString.Replace("~/", ""))  %>' alt="student"></td>
                            <td>
                                <%--<a href="#Details_modal"  data-toggle="modal" data-url='<%# "Student_Details.aspx?Mode=View&ID=" & Eval("Id")%>'><%# Eval("Name")%></a>--%>
                                <a href='<%# "../Students/Student_Details.aspx?Mode=View&ID=" & Eval("Id")%>' target="_blank"><%# Eval("Name")%></a>
                            </td>
                            <td><%# Eval("FullGender")%></td>

                            <%--<td><%# Eval("GroupName")%></td>--%>
                            <td><%# Eval("ParentName")%> </td>
                            <td><%# Eval("Address")%></td>
                            <td><%# PublicFunctions.DateFormat(Eval("DateOfBirth"), "dd/MM/yyyy")%></td>
                            <td><%# Eval("Mobile")%></td>
                            <td><%# Eval("Email")%></td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">

                                        <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Students/Student.aspx?Mode=Edit&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" runat="server" CssClass="dropdown-item" OnClientClick="return confirm('Confirm Delete?')" OnClick="Delete">
                                              <i class="fas fa-times text-orange-red"></i>Delete
                                        </asp:LinkButton>


                                    </div>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <table style="width: 100%;">
                            <tr class="EmptyRowStyle">
                                <td>
                                    <div>No Data Found.</div>
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:ListView>

            </div>

        </div>
    </div>
    <!-- Student Table Area End Here -->

</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>
</asp:Content>
