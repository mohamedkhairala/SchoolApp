<%@ Page Title="Up Skills | Add Attendance" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Attendance.aspx.vb" Inherits="Attendance" %>

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
        <h3>Add Attendance</h3>
        <ul>
            <li>
                <a href="../Dashboard.aspx">Home</a>
            </li>
            <li>
                <a href="Attendance.aspx">Attendance List</a>
            </li>
            <li>Add Attendance</li>
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
                        <h3>Add New Attendance</h3>
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
                        <h3>Attendance</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <div class="row w-100">
                        <asp:ValidationSummary ID="VSMaster" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsMaster" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                        <!-- Attendance Master Data -->
                        <asp:Panel ID="pnlAttendance" runat="server" CssClass="d-contents">
                            <!-- Code -->
                            <div id="divCode" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                <label id="lblCode" runat="server" for="txtCode">Code</label>
                                <asp:TextBox ID="txtCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            </div>
                            <!-- Date -->
                            <div id="divDate" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblDate" runat="server" for="txtDate">Date *</label>
                                <asp:TextBox ID="txtDate" runat="server" placeholder="dd/mm/yyyy" CssClass="form-control air-datepicker"
                                    data-position='bottom right'></asp:TextBox>
                                <i class="far fa-calendar-alt"></i>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqDate" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="txtDate" Display="Dynamic" Text="Required Date"></asp:RequiredFieldValidator>
                            </div>
                            <!-- CourseID -->
                            <div id="divCourseID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblCourseID" runat="server" for="ddlCourseID">Course</label>
                                <asp:DropDownList ID="ddlCourseID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectCourse">
                                    <asp:ListItem Value="">Please Select Course</asp:ListItem>
                                </asp:DropDownList>
                                <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCourseID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlCourseID" InitialValue="" Display="Dynamic" Text="Required Course"></asp:RequiredFieldValidator>--%>
                            </div>
                            <!-- GroupID -->
                            <div id="divGroupID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblGroupID" runat="server" for="ddlGroupID">Group</label>
                                <asp:DropDownList ID="ddlGroupID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectGroup">
                                    <asp:ListItem Value="">Please Select Group</asp:ListItem>
                                </asp:DropDownList>
                                <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqGroupID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlGroupID" InitialValue="" Display="Dynamic" Text="Required Group"></asp:RequiredFieldValidator>--%>
                            </div>
                            <!-- SessionID -->
                            <div id="divSessionID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblSessionID" runat="server" for="ddlSessionID">Session *</label>
                                <asp:DropDownList ID="ddlSessionID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectSession">
                                    <asp:ListItem Value="">Please Select Session *</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSessionID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlSessionID" InitialValue="" Display="Dynamic" Text="Required Session"></asp:RequiredFieldValidator>
                            </div>
                            <!-- ActualPeriodHour -->
                            <div id="divActualPeriodHour" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblActualPeriodHour" runat="server" for="txtActualPeriodHour">Period *</label>
                                <asp:TextBox ID="txtActualPeriodHour" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqActualPeriodHour" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="txtActualPeriodHour" Display="Dynamic" Text="Required Period *"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="fteActualPeriodHour" runat="server" TargetControlID="txtActualPeriodHour" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
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
                                <label id="lblSupervisorID" runat="server" for="ddlSupervisorID">Supervisor *</label>
                                <asp:DropDownList ID="ddlSupervisorID" runat="server" CssClass="select2">
                                    <asp:ListItem Value="">Please Select Supervisor *</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlSupervisorID" InitialValue="" Display="Dynamic" Text="Required Supervisor"></asp:RequiredFieldValidator>
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
                                                        <th>Attend</th>
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
                                                    <asp:Label ID="lblAttendanceID" runat="server" Visible="false" Text='<%# Eval("AttendanceID")%>'></asp:Label>
                                                    <asp:Label ID="lblStudentID" runat="server" Visible="false" Text='<%# Eval("StudentID")%>'></asp:Label>
                                                    <asp:Label ID="lblGroupID" runat="server" Visible="false" Text='<%# Eval("GroupID")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkIsAttend" runat="server" Checked='<%# Not PublicFunctions.BoolFormat(Eval("IsAbsent").ToString)%>' />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile")%>'></asp:Label>
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
</asp:Content>
