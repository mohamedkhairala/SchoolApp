<%@ Page Title="Up Skills | Teacher Dashboard" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="TeacherDashboard.aspx.vb" Inherits="TeacherDashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .progress-bar-card .card-body .gradient-progress-bar:not(:last-child) {
            border-bottom: 1px dashed #e1e1e1;
        }

        .progress-bar-card .card-body .gradient-progress-bar .progress {
            height: 15px !important;
        }

            .progress-bar-card .card-body .gradient-progress-bar .progress .progress-bar {
                font-size: 13px !important;
            }
    </style>
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Teacher Dashboard</h3>
        <ul>
            <li>Teacher Dashboard</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Dashboard summery Start Here -->
    <div class="row gutters-20">
        <asp:Label Text="" ID="lblRes" runat="server" />
        <div class="col-xl-4 col-sm-6 col-12">
            <div class="dashboard-summery-one mg-b-20">
                <div class="row align-items-center">
                    <div class="col-6">
                        <div class="item-icon bg-light-green">
                            <i class="flaticon-mortarboard text-green"></i>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="item-content">
                            <div class="item-title">Courses</div>
                            <div class="item-number"><span class="counter" data-num='6'>6</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-sm-6 col-12">
            <div class="dashboard-summery-one mg-b-20">
                <div class="row align-items-center">
                    <div class="col-6">
                        <div class="item-icon bg-light-blue">
                            <i class="flaticon-couple text-blue"></i>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="item-content">
                            <div class="item-title">Groups</div>
                            <div class="item-number"><span class="counter" data-num='10'>10</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-sm-6 col-12">
            <div class="dashboard-summery-one mg-b-20">
                <div class="row align-items-center">
                    <div class="col-6">
                        <div class="item-icon bg-light-yellow">
                            <i class="flaticon-classmates text-orange"></i>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="item-content">
                            <div class="item-title">Students</div>
                            <div class="item-number"><span class="counter" data-num='30'>30</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Dashboard summery End Here -->
    <!-- Dashboard Content Start Here -->
    <div class="row gutters-20">
        <div class="col-lg-12 col-xl-12 col-12-xxxl">
            <div class="card dashboard-card-six pd-b-20">
                <div class="card-body">
                    <div class="heading-layout1 mg-b-17">
                        <div class="item-title">
                            <h3>Messages</h3>
                        </div>
                    </div>
                    <div class="notice-box-wrap">
                        <asp:ListView runat="server" ID="rpMessages">
                            <ItemTemplate>
                                <div class="notice-list">
                                    <div class="post-date  <%# clsNotifications.SetRandomColor() %>"><%# PublicFunctions.DateFormat(Eval("CreatedDate"), "dd MMM yyyy") %></div>
                                    <h6 class="notice-title">
                                        <a href="#">
                                            <%# Eval("MessageTitle") %>
                                        </a>
                                        <p><%# Eval("MessageBody") %></p>
                                    </h6>
                                    <div class="entry-meta"><%# Eval("CreatedByUserName") %> / <span><%# clsNotifications.SetTimeAgo(Eval("CreatedDate")) %></span></div>

                                </div>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table style="width: 100%;">
                                    <tr class="EmptyRowStyle">
                                        <td>
                                            <div>No Messages Found.</div>
                                        </td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>

                        <a href="../MessagesList.aspx">See more</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-xl-12 col-12-xxxl">
            <div class="card dashboard-card-five progress-bar-card pd-b-20">
                <div class="card-body pd-b-14">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <h3>Courses Status</h3>
                        </div>
                        <div class="traffic-table">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td class="t-title pseudo-bg-Aquamarine py-1">Completed Sessions</td>
                                        <td class="t-title dodger-bg-blue py-1 pr-0">Paid Sessions</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <h6 class="traffic-title">Course Name 1</h6>
                    <div class="gradient-progress-bar mb-4">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-skyblue" role="progressbar" style="width: 90%;" aria-valuenow="9" aria-valuemin="0" aria-valuemax="10">9 Completed</div>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-dodger-blue" role="progressbar" style="width: 90%;" aria-valuenow="9" aria-valuemin="0" aria-valuemax="10">9 Paid</div>
                        </div>
                    </div>
                    <h6 class="traffic-title">Course Name 2</h6>
                    <div class="gradient-progress-bar mb-4">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-skyblue" role="progressbar" style="width: 90%;" aria-valuenow="9" aria-valuemin="0" aria-valuemax="10">9 Completed</div>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-dodger-blue" role="progressbar" style="width: 90%;" aria-valuenow="9" aria-valuemin="0" aria-valuemax="10">9 Paid</div>
                        </div>
                    </div>
                    <h6 class="traffic-title">Course Name 3</h6>
                    <div class="gradient-progress-bar mb-4">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-skyblue" role="progressbar" style="width: 70%;" aria-valuenow="7" aria-valuemin="0" aria-valuemax="10">7 Completed</div>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-dodger-blue" role="progressbar" style="width: 70%;" aria-valuenow="7" aria-valuemin="0" aria-valuemax="10">7 Paid</div>
                        </div>
                    </div>
                    <h6 class="traffic-title">Course Name 4</h6>
                    <div class="gradient-progress-bar mb-4">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-skyblue" role="progressbar" style="width: 60%;" aria-valuenow="6" aria-valuemin="0" aria-valuemax="10">6 Completed</div>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-dodger-blue" role="progressbar" style="width: 60%;" aria-valuenow="6" aria-valuemin="0" aria-valuemax="10">6 Paid</div>
                        </div>
                    </div>
                    <h6 class="traffic-title">Course Name 5</h6>
                    <div class="gradient-progress-bar mb-4">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-skyblue" role="progressbar" style="width: 10%;" aria-valuenow="1" aria-valuemin="0" aria-valuemax="10">1 Completed</div>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped font-bold bg-dodger-blue" role="progressbar" style="width: 10%;" aria-valuenow="1" aria-valuemin="0" aria-valuemax="10">1 Paid</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Dashboard Content End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
