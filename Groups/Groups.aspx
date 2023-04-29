<%@ Page Title="Up Skills | All Groups" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Groups.aspx.vb" Inherits="Groups" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Groups</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>All Groups</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Groups Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Groups Data</h3>
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
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Group, Course, Teacher or Supervisor ..." AutoPostBack="true" OnTextChanged="FillGrid"></asp:TextBox>
                    </div>
                    <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                        <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center" OnClick="FillGrid"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-12 px-0 text-right">
                <div class="d-inline-flex mb-3">
                    <a href="Add_Group.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></a>
                </div>
            </div>

            <div class="table-responsive">
                <asp:HiddenField ID="SortExpression" runat="server" />
                <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                    <LayoutTemplate>
                        <table id="DataTables" class="table display data-table text-nowrap">
                            <thead>
                                <tr>
                                    <th>Group Name</th>
                                    <th>Course Code</th>
                                    <th>Course Name</th>
                                    <th>Teacher Code</th>
                                    <th>Teacher Name</th>
                                    <th>Supervisor Code</th>
                                    <th>Supervisor Name</th>
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
                            <td>
                                <a href='<%# "Add_Group.aspx?Mode=View&ID=" & Eval("ID")%>' target="_blank"><%# Eval("Name")%></a>
                                <asp:Label ID="lblGroupID" runat="server" Visible="false" Text='<%# Eval("ID")%>'></asp:Label>
                                <asp:Label ID="lblCourseID" runat="server" Visible="false" Text='<%# Eval("CourseID")%>'></asp:Label>
                                <asp:Label ID="lblTeacherID" runat="server" Visible="false" Text='<%# Eval("TeacherID")%>'></asp:Label>
                                <asp:Label ID="lblSupervisorID" runat="server" Visible="false" Text='<%# Eval("SupervisorID")%>'></asp:Label>
                            </td>
                            <td><%# Eval("CourseCode")%></td>
                            <td><%# Eval("CourseName")%></td>
                            <td><%# Eval("TeacherCode")%> </td>
                            <td><%# Eval("TeacherName")%></td>
                            <td><%# Eval("SupervisorCode")%></td>
                            <td><%# Eval("SupervisorName")%></td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Add_Group.aspx?Mode=Edit&ID=" & Eval("ID")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" runat="server" CssClass="dropdown-item" OnClick="Delete">
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
    <!-- Groups Table Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#DataTables').DataTable({
            bLengthChange: false,
            language: {
                searchPlaceholder: "Search by Group Name, Course Code, Course Name or Teahcer ...",
                
            },
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
