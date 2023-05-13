<%@ Page Title="Up Skills | All Sessions" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="SessionsList.aspx.vb" Inherits="SessionsList" %>

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
            <div class="col-md-12">
                <div class="row">
                    <div class="form-group col-md-2 pl-0 pr-2">
                        <label>Group</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlGroups" 
                            onchange="SelectGroup(this.value)" ></asp:DropDownList>
                    </div>
                    <div class="form-group col-md-2 px-2">
                        <label>From</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtFilterFromDate" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-2 px-2">
                        <label>To</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtFilterToDate" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-2 px-2">
                        <label>Status</label>
                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group d-inline-flex flex-column px-2">
                        <label>&nbsp;</label>
                        <asp:LinkButton runat="server" CssClass="btn-fill-sm btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill" ID="lbFilter" OnClick="FillGrid">Filter<i class="fa fa-filter ml-3"></i></asp:LinkButton>
                    </div>
                    <div class="form-group d-inline-flex flex-column px-2">
                        <label>&nbsp;</label>
                        <asp:LinkButton runat="server" CssClass="btn-fill-sm bg-danger text-white fw-btn-fill" ID="lbClear" OnClick="Clear">Clear<i class="fa fa-trash ml-3"></i></asp:LinkButton>
                    </div>
                     <div class="form-group d-inline-flex flex-column px-2" id="divAdd" style="display:none !important;">
                        <label>&nbsp;</label>
                         <a href="#" target="_blank" class="btn-fill-sm bg-success text-white fw-btn-fill" ID="lbAdd">Add<i class="fa fa-plus ml-3"></i></a>
                         <%--<asp:LinkButton runat="server" CssClass="btn-fill-sm bg-success text-white fw-btn-fill" ID="lbAdd" OnClick="Add">Add<i class="fa fa-plus ml-3"></i></asp:LinkButton>--%>
                    </div>
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
                                <asp:TextBox ID="txtSessionID" runat="server" style="display:none;" Text='<%# Eval("ID")%>'></asp:TextBox>
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
                                <asp:TextBox runat="server" ID="txtIssueDate" onchange="UpdateSession(this)"
                                    Enabled='<%#Not PublicFunctions.BoolFormat(Eval("HasAttendance")) %>' CssClass="form-control"
                                    TextMode="DateTimeLocal" Text='<%# DateTime.Parse(Eval("IssueDate")).ToString("yyyy-MM-ddTHH:mm:ss.fff") %>' data-position='bottom right'></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox runat="server" onchange="UpdateSession(this)" MaxLength="6"
                                    ID="txtPeriod" Text='<%# Eval("DefaultPeriodHour") %>' CssClass="form-control"
                                    Enabled='<%#Not PublicFunctions.BoolFormat(Eval("HasAttendance")) %>'></asp:TextBox>
                                <asp:FilteredTextBoxExtender TargetControlID="txtPeriod" runat="server" FilterMode="ValidChars" ValidChars=".0123456789"></asp:FilteredTextBoxExtender>
                            </td>
                            <td>
                                <asp:TextBox runat="server" onchange="UpdateSession(this)" CssClass="form-control"
                                    ID="txtRemarks" MaxLength="500" Text='<%# Eval("Remarks") %>' Style="min-width: 200px;"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblSessionStatus" Text='<%# Eval("Status") %>' runat="server" Visible="false" />
                                <asp:Label ID="lblHasAttendance" Text='<%# Eval("HasAttendance") %>' runat="server" Visible="false" />
                                <asp:DropDownList runat="server" ClientIDMode="AutoID" CssClass="form-control" Style="min-width: 100px;"
                                    ID="ddlStatus" onchange="UpdateSession(this)" >
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:TextBox runat="server" MaxLength="500" onchange="UpdateSession(this)" CssClass="form-control"
                                    ID="txtStatusRemarks" Text='<%# Eval("StatusRemarks") %>' Style="min-width: 200px;"></asp:TextBox>
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
    <script src="../JSCode/jsSession.js"></script>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#DataTables').DataTable({
            bLengthChange: false,
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
