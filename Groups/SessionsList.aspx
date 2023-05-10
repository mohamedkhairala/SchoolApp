<%@ Page Title="Up Skills | All Groups" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="SessionsList.aspx.vb" Inherits="SessionsList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="../css/datepicker.min.css">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Sessions</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>All Sessions</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Groups Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Sessions</h3>
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
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..." AutoPostBack="true" OnTextChanged="FillGrid"></asp:TextBox>
                    </div>
                    <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                        <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center" OnClick="FillGrid"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-12 px-0 text-right">
                <div class="d-inline-flex mb-3">
                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlGroups" AutoPostBack="true" OnSelectedIndexChanged="FillGrid">
                        
                    </asp:DropDownList>
                 </div>
            </div>

            <div class="table-responsive">
                <asp:HiddenField ID="SortExpression" runat="server" />
                <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                    <LayoutTemplate>
                        <table id="DataTables" class="table display data-table text-nowrap">
                            <thead>
                                <tr>
                                    <th>Session</th>
                                    <th>Group</th>
                                    <th>Course</th>
                                    <th>Teacher</th>
                                    <th>Teacher Rate</th>
                                    <th>Supervisor</th>
                                    <th>Date/Time</th>
                                    <th>Period</th>
                                    <th>Remarks</th>
                                    <th>Status</th>
                                    <th>Status Remarks</th>
                                    
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
                                <%# Eval("Code") + " - " + Eval("Title")%>
                                <asp:Label ID="lblSessionID" runat="server" Visible="false" Text='<%# Eval("ID")%>'></asp:Label>
                                <asp:Label ID="lblCourseID" runat="server" Visible="false" Text='<%# Eval("CourseID")%>'></asp:Label>
                                <asp:Label ID="lblTeacherID" runat="server" Visible="false" Text='<%# Eval("TeacherID")%>'></asp:Label>
                                <asp:Label ID="lblSupervisorID" runat="server" Visible="false" Text='<%# Eval("SupervisorID")%>'></asp:Label>
                            </td>
                            <td><%# Eval("GroupCode") + " - " + Eval("GroupName") %></td>
                            <td><%# Eval("CourseCode") + " - " + Eval("CourseName") %></td>
                            <td><%# Eval("TeacherCode") + " - " + Eval("TeacherName") %> </td>
                            <td><%# PublicFunctions.DecimalFormat(Eval("TeacherHourRate").ToString) %> / H </td>
                            <td><%# Eval("SupervisorCode") + " - " + Eval("SupervisorName") %></td>
                             <td>
                                <asp:TextBox runat="server" ID="txtIssueDate" CssClass="air-datepicker" TextMode="DateTime" Text='<%# Eval("IssueDate")%>' data-position='bottom right'></asp:TextBox>
                            </td>
                           <td>
                                <asp:TextBox runat="server" ID="txtPeriod" Text='<%# Eval("DefaultPeriodHour") %>' />
                            </td>
                             <td>
                                <asp:TextBox runat="server" ID="txtRemarks" Text='<%# Eval("Remarks") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblSessionStatus" Text='<%# Eval("Status") %>' runat="server" Visible="false"  />
                                <asp:DropDownList runat="server" ID="ddlStatus">
                                     
                                </asp:DropDownList>
                            </td>
                             <td>
                                <asp:TextBox runat="server" ID="txtStatusRemarks" Text='<%# Eval("StatusRemarks") %>' />
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
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#DataTables').DataTable({
            bLengthChange: false,
            language: {
                searchPlaceholder: "Search...",
                
            },
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
