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
                <a href="GroupsList.aspx">Groups List</a>
            </li>
            <li>Add Group</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <asp:Label Text="" ID="lblRes" runat="server" />
    <asp:Panel runat="server" ID="pnlForm">
        <div class="card height-auto pb-4 ui-modal-box">
            <div class="card-body py-4 modal-box">
                <div class="heading-layout1 mb-0">
                    <div class="item-title">
                        <h3>Add New Group</h3>
                    </div>
                    <!-- Save & Cancel -->
                    <div class="">
                        <asp:Button ID="lbSave" runat="server" ValidationGroup="vsMaster" UseSubmitBehavior="false"
                            CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white mr-3"
                            CommandArgument="Add" OnClick="Save" OnClientClick="SaveClick(this,'vsMaster');" Text="Save" />
                        <%--<asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>--%>
                        <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                            onclick="ShowConfirmModal('mpConfirmCancel','pnlConfirmExtenderCancel');return false;">Cancel</a>

                        <asp:HiddenField ID="hfCancel" runat="server" />
                        <asp:ModalPopupExtender ID="mpConfirmCancel" runat="server" PopupControlID="pnlConfirmExtenderCancel" TargetControlID="hfCancel"
                            CancelControlID="lbNoCancel" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                        </asp:ModalPopupExtender>
                        <asp:Panel ID="pnlConfirmExtenderCancel" runat="server" ClientIDMode="Static" CssClass="modal pnl-1 fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
                            <div class="modal-dialog success-modal-content" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Confirmation Message</h5>
                                    </div>
                                    <div class="modal-body">
                                        <div class="success-message">
                                            <div class="item-icon">
                                                <i class="fas fa-exclamation icon-modal"></i>
                                            </div>
                                            <h3 class="item-title">You want to Cancel ?</h3>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:LinkButton ID="lbYesCancel" runat="server" CssClass="footer-btn btn-success" OnClick="Cancel">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lbNoCancel" runat="server" CssClass="footer-btn btn-danger" OnClientClick="CloseConfirmPopup('mpConfirmCancel');return false;">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
        <div class="card height-auto pb-3 ui-modal-box">
            <div class="card-body modal-box">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Groups</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <asp:ValidationSummary ID="VSMaster" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsMaster" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                    <!-- Group Master Data -->
                    <asp:Panel ID="pnlGroup" runat="server" CssClass="row">
                        <!-- GroupCode -->
                        <div id="divGroupCode" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblGroupCode" runat="server" for="txtGroupCode">Group Code</label>
                            <asp:TextBox ID="txtGroupCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <!-- Name -->
                        <div id="divName" runat="server" class="col-xl-6 col-lg-6 col-12 form-group">
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
                            <asp:HiddenField ID="hfCourseFees" runat="server" />
                        </div>
                        <!-- TeacherID -->
                        <div id="divTeacherID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblTeacherID" runat="server" for="ddlTeacherID">Teacher *</label>
                            <asp:DropDownList ID="ddlTeacherID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectTeacher">
                                <asp:ListItem Value="">Please Select Teacher *</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTeacherID" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="ddlTeacherID" InitialValue="" Display="Dynamic" Text="Required Teacher"></asp:RequiredFieldValidator>
                        </div>
                        <!-- TeacherRate -->
                        <div id="divTeacherRate" runat="server" class="col-xl-3 col-lg-6 col-3 form-group">
                            <label id="lblTeacherRate" runat="server" for="txtTeacherRate">Teacher Rate/H *</label>
                            <asp:TextBox ID="txtTeacherRate" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqTeacherRate" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtTeacherRate" Display="Dynamic" Text="Required Teacher Rate"></asp:RequiredFieldValidator>
                            <asp:FilteredTextBoxExtender ID="fteTeacherRate" runat="server" TargetControlID="txtTeacherRate" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <!-- SupervisorID -->
                        <div id="divSupervisorID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                            <label id="lblSupervisorID" runat="server" for="ddlSupervisorID">Supervisor *</label>
                            <asp:DropDownList ID="ddlSupervisorID" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectSupervisor">
                                <asp:ListItem Value="">Please Select Supervisor *</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorID" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="ddlSupervisorID" InitialValue="" Display="Dynamic" Text="Required Supervisor"></asp:RequiredFieldValidator>
                        </div>
                        <!-- SupervisorRate -->
                        <div id="diSupervisorRate" runat="server" class="col-xl-3 col-lg-6 col-3 form-group">
                            <label id="lblSupervisorRate" runat="server" for="txtSupervisorRate">Supervisor Rate/H *</label>
                            <asp:TextBox ID="txtSupervisorRate" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqSupervisorRate" runat="server" ValidationGroup="vsMaster"
                                ControlToValidate="txtSupervisorRate" Display="Dynamic" Text="Required Supervisor Rate"></asp:RequiredFieldValidator>
                            <asp:FilteredTextBoxExtender ID="fteSupervisorRate" runat="server" TargetControlID="txtSupervisorRate" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="card height-auto pb-3 ui-modal-box">
            <div class="card-body modal-box">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Sessions</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <!-- Sessions Data -->
                    <asp:ValidationSummary ID="VSSessions" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsSessions" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                    <asp:Panel ID="pnlSessions" runat="server" CssClass="row">
                        <asp:Panel runat="server" ID="pnlSessionControls" CssClass="row">
                            <!-- SessionCode -->
                            <div id="divSessionCode" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                <label id="lblSessionCode" runat="server" for="txtSessionCode">Session Code</label>
                                <asp:TextBox ID="txtSessionCode" Enabled="false" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            </div>
                            <!-- Status -->
                            <div id="divStatus" runat="server">
                                <asp:HiddenField ID="hfStatus" runat="server" />
                                <asp:HiddenField ID="hfStatusRemarks" runat="server" />
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
                                <asp:TextBox ID="txtIssueDate" runat="server" TextMode="DateTimeLocal"
                                    placeholder="dd/mm/yyyy" CssClass="form-control"
                                    data-position='bottom right'></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqIssueDate" runat="server" ValidationGroup="vsSessions"
                                    ControlToValidate="txtIssueDate" Display="Dynamic" Text="Required Issue Date"></asp:RequiredFieldValidator>
                            </div>
                            <!-- DefaultPeriodHour -->
                            <div id="divDefaultPeriodHour" runat="server" class="col-xl-3 col-lg-6 col-3 form-group">
                                <label id="lblDefaultPeriodHour" runat="server" for="txtDefaultPeriodHour">Period *</label>
                                <asp:TextBox ID="txtDefaultPeriodHour" runat="server" CssClass="form-control" MaxLength="2" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqDefaultPeriodHour" runat="server" ValidationGroup="vsSessions"
                                    ControlToValidate="txtDefaultPeriodHour" Display="Dynamic" Text="Required Period"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="fteDefaultPeriodHour" runat="server" TargetControlID="txtDefaultPeriodHour" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>
                            <!-- Remarks -->
                            <div id="divRemarks" runat="server" class="col-lg-12 col-12 form-group">
                                <label id="lblRemarks" runat="server" for="txtRemarks">Remarks</label>
                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="message" Rows="4"></asp:TextBox>
                            </div>

                            <!-- Submit & Cancel -->
                            <div class="col-12 form-group mg-t-8">
                                <asp:LinkButton ID="lbSubmitSession" runat="server" ValidationGroup="vsSessions"
                                    CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                    CommandArgument="Add" OnClick="SubmitSession">Submit Session</asp:LinkButton>
                                <%--<asp:LinkButton ID="lbCancelSession" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="CancelSession">Cancel</asp:LinkButton>--%>
                                <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                                    onclick="ShowConfirmModal('mpConfirmCancelSessions','pnlConfirmExtenderCancelSessions');return false;">Clear</a>

                                <asp:HiddenField ID="hfCancelSessions" runat="server" />
                                <asp:ModalPopupExtender ID="mpConfirmCancelSessions" runat="server" PopupControlID="pnlConfirmExtenderCancelSessions" TargetControlID="hfCancelSessions"
                                    CancelControlID="lbNoCancelSessions" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlConfirmExtenderCancelSessions" runat="server" ClientIDMode="Static" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
                                    <div class="modal-dialog success-modal-content" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirmation Message</h5>
                                            </div>
                                            <div class="modal-body">
                                                <div class="success-message">
                                                    <div class="item-icon">
                                                        <i class="fas fa-exclamation icon-modal"></i>
                                                    </div>
                                                    <h3 class="item-title">You want to clear sessions ?</h3>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:LinkButton ID="lbYesCancelSessions" runat="server" CssClass="footer-btn btn-success" OnClick="CancelSession">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lbNoCancelSessions" runat="server" CssClass="footer-btn btn-danger" OnClientClick="CloseConfirmPopup('mpConfirmCancelSessions');return false;">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </asp:Panel>
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
                                                <asp:Label ID="lblStatusRemarks" runat="server" Visible="false" Text='<%# Eval("StatusRemarks")%>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code")%>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox autocomplete="off" ID="txtTitle" runat="server" Text='<%# Eval("Title")%>'></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtIssueDate" runat="server"
                                                    TextMode="DateTimeLocal"
                                                    Text='<%# DateTime.Parse(Eval("IssueDate")).ToString("yyyy-MM-ddTHH:mm") %>'
                                                    placeholder="dd/mm/yyyy"
                                                    data-position='bottom right'></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDefaultPeriodHour" runat="server" Text='<%# PublicFunctions.GetDecimalValue(Eval("DefaultPeriodHour").ToString)%>' TextMode="Number" MaxLength="2"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Eval("Remarks")%>' TextMode="MultiLine" CssClass="vertical-align-middle" name="message" Rows="1"></asp:TextBox>
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

                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="card height-auto ui-modal-box">
            <div class="card-body modal-box">
                <div class="heading-layout1">
                    <div class="item-title">
                        <h3>Students</h3>
                    </div>
                </div>
                <div class="new-added-form">
                    <!-- Students Data -->
                    <asp:ValidationSummary ID="VSStudents" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vsStudents" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />
                    <asp:Panel ID="pnlStudents" runat="server" CssClass="row">
                        <div class="col-md-12">
                            <div class="row">
                                <!-- StudentID -->
                                <div id="divStudentID" runat="server" class="col-xl-4 col-lg-6 col-12 form-group">
                                    <label id="lblStudentID" runat="server" for="ddlStudentID">Student *</label>
                                    <asp:DropDownList ID="ddlStudentID" runat="server" CssClass="select2">
                                        <asp:ListItem Value="">Please Select Student *</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqStudentID" runat="server" ValidationGroup="vsStudents"
                                        ControlToValidate="ddlStudentID" InitialValue="" Display="Dynamic" Text="Required Student"></asp:RequiredFieldValidator>
                                </div>
                                <!-- CoursePrice -->
                                <div id="divCoursePrice" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label id="lblCoursePrice" runat="server" for="txtCoursePrice">Course Price *</label>
                                    <asp:TextBox ID="txtCoursePrice" runat="server" CssClass="form-control" MaxLength="12" AutoPostBack="true" OnTextChanged="CalculateNetAmount"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCoursePrice" runat="server" ValidationGroup="vsStudents"
                                        ControlToValidate="txtCoursePrice" Display="Dynamic" Text="Required Course Price"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender ID="fteCoursePrice" runat="server" TargetControlID="txtCoursePrice" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                            </div>
                            <div class="row">
                                <!-- DiscountRate -->
                                <div id="divDiscountRate" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label id="lblDiscountRate" runat="server" for="txtDiscountRate">Discount Rate</label>
                                    <asp:TextBox ID="txtDiscountRate" runat="server" CssClass="form-control" MaxLength="12" AutoPostBack="true" OnTextChanged="CalculateNetAmount"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="fteDiscountRate" runat="server" TargetControlID="txtDiscountRate" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <!-- DiscountAmount -->
                                <div id="divDiscountAmount" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label id="lblDiscountAmount" runat="server" for="txtDiscountAmount">Discount Amount</label>
                                    <asp:TextBox ID="txtDiscountAmount" Enabled="false" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="fteDiscountAmount" runat="server" TargetControlID="txtDiscountAmount" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <!-- NetAmount -->
                                <div id="divNetAmount" runat="server" class="col-xl-4 col-lg-6 col-3 form-group">
                                    <label id="lblNetAmount" runat="server" for="txtNetAmount">Net Amount *</label>
                                    <asp:TextBox ID="txtNetAmount" Enabled="false" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="valid-inp" ID="reqNetAmount" runat="server" ValidationGroup="vsStudents"
                                        ControlToValidate="txtNetAmount" Display="Dynamic" Text="Required Net Amount"></asp:RequiredFieldValidator>
                                    <asp:FilteredTextBoxExtender ID="fteNetAmount" runat="server" TargetControlID="txtNetAmount" ValidChars=".0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                                </div>
                                <!-- DiscountReason -->
                                <div id="divDiscountReason" runat="server" class="col-lg-12 col-12 form-group">
                                    <label id="lblDiscountReason" runat="server" for="txtDiscountReason">Discount Reason</label>
                                    <asp:TextBox ID="txtDiscountReason" runat="server" TextMode="MultiLine" CssClass="textarea form-control" name="message" Rows="4"></asp:TextBox>
                                </div>
                                <!-- Submit & Cancel -->
                                <div class="col-12 form-group mg-t-8">
                                    <asp:LinkButton ID="lbSubmitStudent" runat="server" ValidationGroup="vsStudents"
                                        CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                        CommandArgument="Add" OnClick="SubmitStudent">Submit Student</asp:LinkButton>
                                    <%--<asp:LinkButton ID="lbCancelStudent" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="CancelStudent">Cancel</asp:LinkButton>--%>
                                    <a href="#" class="btn-fill-lg bg-blue-dark btn-hover-yellow text-white"
                                        onclick="ShowConfirmModal('mpConfirmCancelStudents','pnlConfirmExtenderCancelStudents');return false;">Clear</a>

                                    <asp:HiddenField ID="hfCancelStudents" runat="server" />
                                    <asp:ModalPopupExtender ID="mpConfirmCancelStudents" runat="server" PopupControlID="pnlConfirmExtenderCancelStudents" TargetControlID="hfCancelStudents"
                                        CancelControlID="lbNoCancelStudents" ClientIDMode="Static" BackgroundCssClass="modal-backdrop fade show">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="pnlConfirmExtenderCancelStudents" runat="server" ClientIDMode="Static" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
                                        <div class="modal-dialog success-modal-content" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Confirmation Message</h5>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="success-message">
                                                        <div class="item-icon">
                                                            <i class="fas fa-exclamation icon-modal"></i>
                                                        </div>
                                                        <h3 class="item-title">You want to clear students ?</h3>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:LinkButton ID="lbYesCancelStudents" runat="server" CssClass="footer-btn btn-success" OnClick="CancelStudent">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="lbNoCancelStudents" runat="server" CssClass="footer-btn btn-danger" OnClientClick="CloseConfirmPopup('mpConfirmCancelStudents');return false;">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
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
                                                            <th>Course Price</th>
                                                            <th>Discount %</th>
                                                            <th>Discount</th>
                                                            <th>Net Amount</th>
                                                            <th>Discount Reason</th>
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
                                                        <asp:TextBox ID="txtCoursePrice" runat="server" Text='<%# PublicFunctions.GetDecimalValue(Eval("CoursePrice").ToString)%>' TextMode="Number" AutoPostBack="true" OnTextChanged="CalculateNetAmountInLV"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDiscountRate" runat="server" Text='<%# PublicFunctions.GetDecimalValue(Eval("DiscountRate").ToString)%>' TextMode="Number" AutoPostBack="true" OnTextChanged="CalculateNetAmountInLV"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDiscountAmount" runat="server" Text='<%# PublicFunctions.GetDecimalValue(Eval("DiscountAmount").ToString)%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblNetAmount" runat="server" Text='<%# PublicFunctions.GetDecimalValue(Eval("NetAmount").ToString)%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDiscountReason" runat="server" Text='<%# Eval("DiscountReason")%>' TextMode="MultiLine" CssClass="vertical-align-middle" name="message" Rows="1"></asp:TextBox>
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

                            </div>
                        </div>
                    </asp:Panel>
                    <!-- Action Buttons -->
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
            bPaginate: false,
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });
        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
