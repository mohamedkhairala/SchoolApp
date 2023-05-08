<%@ Page Title="Up Skills | All Teachers" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="TeachersList.aspx.vb" Inherits="Teachers" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Teachers</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>All Teachers</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Teacher Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Teachers Data</h3>
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
                    <asp:LinkButton ID="lbAdd" runat="server" href="Teacher.aspx" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></asp:LinkButton>
                    <%--<a href="Teacher.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></a>--%>
                </div>
            </div>

            <div class="table-responsive">
                <asp:HiddenField ID="SortExpression" runat="server" />
                <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                    <LayoutTemplate>
                        <table id="tblTeachers" class="table display data-table text-nowrap">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Photo</th>
                                    <th>Name</th>
                                    <th>Gender</th>
                                    <th>Address</th>
                                    <th>Date Of Birth</th>
                                    <th>Phone</th>
                                    <th>E-mail</th>
                                    <th>Salary</th>
                                    <th style="width: 50px;"></th>
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
                                <asp:Label ID="lblTeacherId" runat="server" Visible="false" Text='<%# Eval("Id")%>'></asp:Label>
                            </td>
                            <td class="text-center">
                                <img class="img-thumbnail" src='<%#   Eval("Photo").ToString.Replace("~", "")%>' alt="Teacher"></td>
                            <td>
                                <a href='<%# "Teacher_Details.aspx?Mode=View&ID=" & Eval("Id")%>' target="_blank"><%# Eval("Name")%></a>
                            </td>
                            <td><%# Eval("FullGender")%></td>
                            <td><%# Eval("Address")%></td>
                            <td><%# PublicFunctions.DateFormat(Eval("DateOfBirth"), "dd/MM/yyyy")%></td>
                            <td><%# Eval("Mobile")%></td>
                            <td><%# Eval("Email")%></td>
                            <td><%# PublicFunctions.DecimalFormat(Eval("Salary"))%></td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <asp:Panel ID="pnlEdit" runat="server">
                                            <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Teacher.aspx?Mode=Edit&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                            </asp:LinkButton>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlDelete" runat="server">
                                            <asp:LinkButton ID="lbDelete" runat="server" CssClass="dropdown-item"
                                                OnClientClick="return confirm('Confirm Delete?')" OnClick="Delete">
                                              <i class="fas fa-times text-orange-red"></i>Delete
                                            </asp:LinkButton>
                                        </asp:Panel>

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
    <!-- Teacher Table Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#tblTeachers').DataTable({
            bLengthChange: false,
            language: {
                searchPlaceholder: "Search by Code, Name, Phone or E-mail ...",

            },
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
