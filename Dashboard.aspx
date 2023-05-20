<%@ Page Title="Up Skills | Dashboard" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="Dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server"></asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Dashboard</h3>
        <ul>
            <li>Dashboard</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Dashboard summery Start Here -->
    <div class="row gutters-20">
        <asp:Label Text="" ID="lblRes" runat="server" />
        <asp:Repeater runat="server" ID="rpCounters">
            <ItemTemplate>
                <div class="col-xl-3 col-sm-6 col-12">
                    <div class="dashboard-summery-one mg-b-20">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <div class="item-icon bg-light-green ">
                                    <i class="flaticon-classmates text-green"></i>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="item-content">
                                    <div class="item-title">Students</div>
                                    <div class="item-number"><span class="counter" data-num='<%# Eval("StudentsCount") %>'><%# Eval("StudentsCount") %></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-sm-6 col-12">
                    <div class="dashboard-summery-one mg-b-20">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <div class="item-icon bg-light-blue">
                                    <i class="flaticon-multiple-users-silhouette text-blue"></i>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="item-content">
                                    <div class="item-title">Teachers</div>
                                    <div class="item-number"><span class="counter" data-num='<%# Eval("TeachersCount") %>'><%# Eval("TeachersCount") %></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-sm-6 col-12">
                    <div class="dashboard-summery-one mg-b-20">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <div class="item-icon bg-light-yellow">
                                    <i class="flaticon-couple text-orange"></i>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="item-content">
                                    <div class="item-title">Group</div>
                                    <div class="item-number"><span class="counter" data-num='<%# Eval("GroupsCount") %>'><%# Eval("GroupsCount") %></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-sm-6 col-12">
                    <div class="dashboard-summery-one mg-b-20">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <div class="item-icon bg-light-red">
                                    <i class="flaticon-user text-red"></i>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="item-content">
                                    <div class="item-title">Supervisors</div>
                                    <div class="item-number"><span class="counter" data-num='<%# Eval("SupervisorsCount") %>'><%# Eval("SupervisorsCount") %></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <!-- Dashboard summery End Here -->
    <!-- Dashboard Content Start Here -->
    <div class="row gutters-20">
        <div class="col-12 col-xl-6 col-3-xxxl">
            <div class="card dashboard-card-three pd-b-20">
                <div class="card-body">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <h3>Students</h3>
                        </div>
                        <!--<div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">...</a>

                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-times text-orange-red"></i>Close</a>
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-cogs text-dark-pastel-green"></i>Edit</a>
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-redo-alt text-orange-peel"></i>Refresh</a>
                            </div>
                        </div>-->
                    </div>
                    <div class="doughnut-chart-wrap">
                        <canvas id="student-doughnut-chart" width="100" height="300"></canvas>
                    </div>
                    <div class="student-report">
                        <asp:Repeater runat="server" ID="rpGenderChart">
                            <ItemTemplate>
                                <div class="student-count pseudo-bg-blue">
                                    <h4 class="item-title">Female Students</h4>
                                    <div class="item-number" id="divFemaleCount"><%# Eval("FemaleStudentsCount") %></div>
                                </div>
                                <div class="student-count pseudo-bg-yellow">
                                    <h4 class="item-title">Male Students</h4>
                                    <div class="item-number" id="divMaleCount"><%# Eval("MaleStudentsCount") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-xl-6 col-9-xxxl">
            <div class="card dashboard-card-five pd-b-20">
                <asp:Repeater runat="server" ID="rpSessions">
                    <ItemTemplate>
                        <div class="card-body pd-b-14">
                            <div class="heading-layout1">
                                <div class="item-title">
                                    <h3>Sessions Status</h3>
                                </div>

                            </div>
                            <h6 class="traffic-title">Total Sessions</h6>
                            <div class="traffic-number"><%# PublicFunctions.IntFormat(Eval("TotalSession")) %></div>
                            <div class="traffic-bar">
                                <div class="status-1" data-toggle="tooltip" data-placement="top" title="Completed" style="--status-1: <%# (Eval("CompletedCount")/Eval("TotalSession"))*100 %>%;">
                                </div>
                                <div class="status-2" data-toggle="tooltip" data-placement="top" title="Pending" style="--status-2: <%# (Eval("PendingCount")/Eval("TotalSession"))*100 %>%;">
                                </div>                          
                                <div class="status-3" data-toggle="tooltip" data-placement="top" title="Postponed" style="--status-3: <%# (Eval("PostponedCount")/Eval("TotalSession"))*100 %>%;">
                                </div>
                                <div class="status-4" data-toggle="tooltip" data-placement="top" title="Cancelled" style="--status-4: <%# (Eval("CancelledCount")/Eval("TotalSession"))*100 %>%;">
                                </div>
                            </div>
                            <div class="traffic-table table-responsive">
                                <table class="table">
                                    <tbody>
                                         <tr>
                                            <td class="t-title pseudo-bg-Aquamarine">Completed</td>
                                            <td><%# PublicFunctions.IntFormat(Eval("CompletedCount")) %></td>
                                            <td><%# PublicFunctions.DecimalFormat((Eval("CompletedCount") / Eval("TotalSession")) * 100) %>%</td>
                                        </tr>
                                        <tr>
                                            <td class="t-title pseudo-bg-blue">Pending</td>
                                            <td><%# PublicFunctions.IntFormat(Eval("PendingCount")) %></td>
                                            <td><%# PublicFunctions.DecimalFormat((Eval("PendingCount") / Eval("TotalSession")) * 100) %>%</td>
                                        </tr>
                                       
                                        <tr>
                                            <td class="t-title pseudo-bg-yellow">Postpond</td>
                                            <td><%# PublicFunctions.IntFormat(Eval("PostponedCount")) %></td>
                                            <td><%# PublicFunctions.DecimalFormat((Eval("PostponedCount") / Eval("TotalSession")) * 100) %>%</td>
                                        </tr>
                                        <tr>
                                            <td class="t-title pseudo-bg-red">Cancelled</td>
                                            <td><%# PublicFunctions.IntFormat(Eval("CancelledCount")) %></td>
                                            <td><%# PublicFunctions.DecimalFormat((Eval("CancelledCount") / Eval("TotalSession")) * 100) %>%</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div class="col-lg-12 col-xl-12 col-12-xxxl">
            <div class="card dashboard-card-six pd-b-20">
                <div class="card-body">
                    <div class="heading-layout1 mg-b-17">
                        <div class="item-title">
                            <h3>Messages</h3>
                        </div>
                        <!--<div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">...</a>

                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-times text-orange-red"></i>Close</a>
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-cogs text-dark-pastel-green"></i>Edit</a>
                                <a class="dropdown-item" href="#"><i
                                        class="fas fa-redo-alt text-orange-peel"></i>Refresh</a>
                            </div>
                        </div>-->
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

                        <a href="MessagesList.aspx">See more</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Dashboard Content End Here -->
    <!-- Social Media Start Here -->
    <!--<div class="row gutters-20">
        <div class="col-lg-3 col-sm-6 col-12">
            <div class="card dashboard-card-seven">
                <div class="social-media bg-fb hover-fb">
                    <div class="media media-none--lg">
                        <div class="social-icon">
                            <i class="fab fa-facebook-f"></i>
                        </div>
                        <div class="media-body space-sm">
                            <h6 class="item-title">Like us on facebook</h6>
                        </div>
                    </div>
                    <div class="social-like">30,000</div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6 col-12">
            <div class="card dashboard-card-seven">
                <div class="social-media bg-twitter hover-twitter">
                    <div class="media media-none--lg">
                        <div class="social-icon">
                            <i class="fab fa-twitter"></i>
                        </div>
                        <div class="media-body space-sm">
                            <h6 class="item-title">Follow us on twitter</h6>
                        </div>
                    </div>
                    <div class="social-like">1,11,000</div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6 col-12">
            <div class="card dashboard-card-seven">
                <div class="social-media bg-gplus hover-gplus">
                    <div class="media media-none--lg">
                        <div class="social-icon">
                            <i class="fab fa-google-plus-g"></i>
                        </div>
                        <div class="media-body space-sm">
                            <h6 class="item-title">Follow us on googleplus</h6>
                        </div>
                    </div>
                    <div class="social-like">19,000</div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6 col-12">
            <div class="card dashboard-card-seven">
                <div class="social-media bg-linkedin hover-linked">
                    <div class="media media-none--lg">
                        <div class="social-icon">
                            <i class="fab fa-linkedin-in"></i>
                        </div>
                        <div class="media-body space-sm">
                            <h6 class="item-title">Follow us on linked</h6>
                        </div>
                    </div>
                    <div class="social-like">45,000</div>
                </div>
            </div>
        </div>
    </div>-->
    <!-- Social Media End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
