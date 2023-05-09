<%@ Page Title="Up Skills | Add Group" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Group.aspx.vb" Inherits="Group" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="../css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="../css/datepicker.min.css">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Add Group</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>
                <a href="Groups.aspx">Groups List</a>
            </li>
            <li>Add Group</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <asp:Label Text="" ID="lblRes" runat="server" />
    <asp:Panel runat="server" ID="pnlForm">
        <div class="card height-auto">
            <div class="card-body py-4">
                <div class="heading-layout1 mb-0">
                    <div class="item-title">
                        <h3>Add New Group</h3>
                    </div>
                    <!-- Save & Cancel -->
                    <div class="">
                        <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vsMaster"
                            CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white mr-3"
                            CommandArgument="Add" OnClick="Save">Save</asp:LinkButton>
                        <asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <div class="card height-auto">
            <div class="card-body">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Groups</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <div class="row w-100">
                        <asp:ValidationSummary ID="VSMaster" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsMaster" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                        <!-- Group Master Data -->
                        <asp:Panel ID="pnlGroup" runat="server" CssClass="d-contents">
                            <!-- GroupCode -->
                            <div id="divGroupCode" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                <label id="lblGroupCode" runat="server" for="txtGroupCode">Group Code *</label>
                                <asp:TextBox ID="txtGroupCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqGroupCode" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="txtGroupCode" Display="Dynamic" Text="Required Group Code"></asp:RequiredFieldValidator>
                            </div>
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
                                <asp:DropDownList ID="ddlCourseID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectCourse">
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
                            <!-- TeacherRate -->
                            <div id="divTeacherRate" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                <label id="lblTeacherRate" runat="server" for="txtTeacherRate">Teacher Rate *</label>
                                <asp:TextBox ID="txtTeacherRate" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTeacherRate" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="txtTeacherRate" Display="Dynamic" Text="Required Teacher Rate"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="fteTeacherRate" runat="server" TargetControlID="txtTeacherRate" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>
                            <!-- SupervisorID -->
                            <div id="divSupervisorID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblSupervisorID" runat="server" for="ddlSupervisorID">Supervisor *</label>
                                <asp:DropDownList ID="ddlSupervisorID" runat="server" CssClass="select2">
                                    <asp:ListItem Value="">Please Select Supervisor *</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlSupervisorID" InitialValue="" Display="Dynamic" Text="Required Supervisor"></asp:RequiredFieldValidator>
                            </div>
                            <!-- SupervisorRate -->
                            <div id="diSupervisorRate" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                <label id="lblSupervisorRate" runat="server" for="txtSupervisorRate">Supervisor Rate *</label>
                                <asp:TextBox ID="txtSupervisorRate" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorRate" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="txtSupervisorRate" Display="Dynamic" Text="Required Supervisor Rate"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="fteSupervisorRate" runat="server" TargetControlID="txtSupervisorRate" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>

        <div class="card height-auto">
            <div class="card-body">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Sessions</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <div class="row w-100">
                        <!-- Sessions Data -->
                        <asp:ValidationSummary ID="VSSessions" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsSessions" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                        <asp:Panel ID="pnlSessions" runat="server" CssClass="d-contents">
                            <!-- SessionCode -->
                            <div id="divSessionCode" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <asp:HiddenField ID="hfSessionCode" runat="server" />
                            </div>
                            <!-- Status -->
                            <div id="divStatus" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <asp:HiddenField ID="hfStatus" runat="server" />
                            </div>
                            <!-- Title -->
                            <div id="divTitle" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblTitle" runat="server" for="txtTitle">Title *</label>
                                <asp:TextBox autocomplete="off" ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTitle" runat="server" ValidationGroup="vsSessions"
                                    ControlToValidate="txtTitle" Display="Dynamic" Text="Required Title"></asp:RequiredFieldValidator>
                            </div>
                            <!-- IssueDate -->
                            <div id="divIssueDate" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblIssueDate" runat="server" for="txtIssueDate">Issue Date *</label>
                                <asp:TextBox ID="txtIssueDate" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                    data-position='bottom right'></asp:TextBox>
                                <i class="far fa-calendar-alt"></i>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqIssueDate" runat="server" ValidationGroup="vsSessions"
                                    ControlToValidate="txtIssueDate" Display="Dynamic" Text="Required Issue Date"></asp:RequiredFieldValidator>
                            </div>
                            <!-- DefaultPeriodHour -->
                            <div id="divDefaultPeriodHour" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                <label id="lblDefaultPeriodHour" runat="server" for="txtDefaultPeriodHour">Period *</label>
                                <asp:TextBox ID="txtDefaultPeriodHour" runat="server" CssClass="form-control" MaxLength="2"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqDefaultPeriodHour" runat="server" ValidationGroup="vsSessions"
                                    ControlToValidate="txtDefaultPeriodHour" Display="Dynamic" Text="Required Period"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="fteDefaultPeriodHour" runat="server" TargetControlID="txtDefaultPeriodHour" ValidChars="0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>
                            <!-- Remarks -->
                            <div id="divRemarks" runat="server" class="col-lg-12 col-12 form-group">
                                <label id="lblRemarks" runat="server" for="txtRemarks">Remarks</label>
                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="message" Rows="4"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqRemarks" runat="server" ValidationGroup="vsSessions" Visible="false"
                                    ControlToValidate="txtRemarks" Display="Dynamic" Text="Required Remarks"></asp:RequiredFieldValidator>
                            </div>
                            <!-- lvSessions -->
                            <div class="col-xl-12 col-lg-12">
                                <div class="table-responsive">
                                    <asp:HiddenField ID="hfSessionIndex" runat="server" />
                                    <asp:ListView ID="lvSessions" runat="server" ClientIDMode="AutoID">
                                        <LayoutTemplate>
                                            <table id="tblSessions" class="table display data-table text-nowrap">
                                                <thead>
                                                    <tr>
                                                        <th>No.</th>
                                                        <th>Code</th>
                                                        <th>Title</th>
                                                        <th>Issue Date</th>
                                                        <th>Period</th>
                                                        <th>Remarks</th>
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
                                                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                    <asp:Label ID="lblSessionID" runat="server" Visible="false" Text='<%# Eval("ID")%>'></asp:Label>
                                                    <asp:Label ID="lblGroupID" runat="server" Visible="false" Text='<%# Eval("GroupID")%>'></asp:Label>
                                                    <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%# Eval("Status")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox autocomplete="off" ID="txtTitle" runat="server" Text='<%# Eval("Title")%>'></asp:TextBox>
                                                    <%--<asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title")%>'></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtIssueDate" runat="server" Text='<%# PublicFunctions.DateFormat(Eval("IssueDate").ToString)%>' placeholder="dd/mm/yyyy" CssClass="air-datepicker"
                                                        data-position='bottom right'></asp:TextBox>
                                                    <i class="far fa-calendar-alt"></i>
                                                    <%--<asp:Label ID="lblIssueDate" runat="server" Text='<%# PublicFunctions.DateFormat(Eval("IssueDate").ToString)%>'></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDefaultPeriodHour" runat="server" Text='<%# PublicFunctions.DecimalFormat(Eval("DefaultPeriodHour").ToString)%>' TextMode="Number" MaxLength="2"></asp:TextBox>
                                                    <%--<asp:Label ID="lblDefaultPeriodHour" runat="server" Text='<%# PublicFunctions.DecimalFormat(Eval("DefaultPeriodHour").ToString)%>'></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Eval("Remarks")%>' TextMode="MultiLine" CssClass="textarea" name="message" Rows="2"></asp:TextBox>
                                                    <%--<asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks")%>'></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <div class="dropdown">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            <span class="flaticon-more-button-of-three-dots"></span>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-right">
                                                            <asp:LinkButton ID="lbEditSession" runat="server" CssClass="dropdown-item" OnClick="EditSession">
                                                                        <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lbDeleteSession" runat="server" CssClass="dropdown-item" OnClick="DeleteSession">
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
                            <!-- Submit & Cancel -->
                            <div class="col-12 form-group mg-t-8">
                                <asp:LinkButton ID="lbSubmitSession" runat="server" ValidationGroup="vsSessions"
                                    CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                    CommandArgument="Add" OnClick="SubmitSession">Submit Session</asp:LinkButton>
                                <asp:LinkButton ID="lbCancelSession" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="CancelSession">Cancel</asp:LinkButton>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>

        <div class="card height-auto">
            <div class="card-body">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Students</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <div class="row w-100">
                        <!-- Students Data -->
                        <asp:ValidationSummary ID="VSStudents" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsStudents" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                        <asp:Panel ID="pnlStudents" runat="server" CssClass="d-contents">
                            <!-- StudentID -->
                            <div id="divStudentID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblStudentID" runat="server" for="ddlStudentID">Student *</label>
                                <asp:DropDownList ID="ddlStudentID" runat="server" CssClass="select2">
                                    <asp:ListItem Value="">Please Select Student *</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqStudentID" runat="server" ValidationGroup="vsStudents"
                                    ControlToValidate="ddlStudentID" InitialValue="" Display="Dynamic" Text="Required Student"></asp:RequiredFieldValidator>
                            </div>
                            <!-- lvStudents -->
                            <div class="col-xl-12 col-lg-12">
                                <div class="table-responsive">
                                    <asp:HiddenField ID="hfStudentIndex" runat="server" />
                                    <asp:ListView ID="lvStudents" runat="server" ClientIDMode="AutoID">
                                        <LayoutTemplate>
                                            <table id="tblStudents" class="table display data-table text-nowrap">
                                                <thead>
                                                    <tr>
                                                        <th>No.</th>
                                                        <th>Code</th>
                                                        <th>Name</th>
                                                        <th>Mobile</th>
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
                                                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                    <asp:Label ID="lblStudentID" runat="server" Visible="false" Text='<%# Eval("StudentID")%>'></asp:Label>
                                                    <asp:Label ID="lblGroupID" runat="server" Visible="false" Text='<%# Eval("GroupID")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCode" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblName" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <div class="dropdown">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            <span class="flaticon-more-button-of-three-dots"></span>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-right">
                                                            <asp:LinkButton ID="lbEditStudent" runat="server" CssClass="dropdown-item" OnClick="EditStudent">
                                                                        <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lbDeleteStudent" runat="server" CssClass="dropdown-item" OnClick="DeleteStudent">
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
                            <!-- Submit & Cancel -->
                            <div class="col-12 form-group mg-t-8">
                                <asp:LinkButton ID="lbSubmitStudent" runat="server" ValidationGroup="vsStudents"
                                    CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                    CommandArgument="Add" OnClick="SubmitStudent">Submit Student</asp:LinkButton>
                                <asp:LinkButton ID="lbCancelStudent" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="CancelStudent">Cancel</asp:LinkButton>
                            </div>
                        </asp:Panel>
                        <!-- Action Buttons -->
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <!-- Admit Form Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="../js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="../js/datepicker.min.js"></script>
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#tblSessions, #tblStudents').DataTable({
            bLengthChange: false,
            searching: false,
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
