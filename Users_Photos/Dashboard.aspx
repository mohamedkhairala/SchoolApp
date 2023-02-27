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
                            <div class="item-number"><span class="counter" data-num="150000">1,50,000</span></div>
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
                            <div class="item-number"><span class="counter" data-num="2250">2,250</span></div>
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
                            <div class="item-title">Parents</div>
                            <div class="item-number"><span class="counter" data-num="5690">5,690</span></div>
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
                            <div class="item-number"><span class="counter" data-num="1200">1200</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                        <div class="student-count pseudo-bg-blue">
                            <h4 class="item-title">Female Students</h4>
                            <div class="item-number">45,000</div>
                        </div>
                        <div class="student-count pseudo-bg-yellow">
                            <h4 class="item-title">Male Students</h4>
                            <div class="item-number">1,05,000</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-xl-6 col-9-xxxl">
            <div class="card dashboard-card-five pd-b-20">
                <div class="card-body pd-b-14">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <h3>Daily Traffic</h3>
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
                    <h6 class="traffic-title">Unique Visitors</h6>
                    <div class="traffic-number">2,590</div>
                    <div class="traffic-bar">
                        <div class="direct" data-toggle="tooltip" data-placement="top" title="Direct">
                        </div>
                        <div class="search" data-toggle="tooltip" data-placement="top" title="Search">
                        </div>
                        <div class="referrals" data-toggle="tooltip" data-placement="top" title="Referrals">
                        </div>
                        <div class="social" data-toggle="tooltip" data-placement="top" title="Social">
                        </div>
                    </div>
                    <div class="traffic-table table-responsive">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td class="t-title pseudo-bg-Aquamarine">Students</td>
                                    <td>12,890</td>
                                    <td>50%</td>
                                </tr>
                                <tr>
                                    <td class="t-title pseudo-bg-blue">Teachers</td>
                                    <td>7,245</td>
                                    <td>27%</td>
                                </tr>
                                <tr>
                                    <td class="t-title pseudo-bg-yellow">Parents</td>
                                    <td>4,256</td>
                                    <td>8%</td>
                                </tr>
                                <tr>
                                    <td class="t-title pseudo-bg-red">Supervisors</td>
                                    <td>500</td>
                                    <td>7%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
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
                        <div class="notice-list">
                            <div class="post-date bg-skyblue">16 June, 2019</div>
                            <h6 class="notice-title">
                                <a href="#">
                                    Great School manag mene esom text of the
                                    printing.
                                </a>
                            </h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
                        <div class="notice-list">
                            <div class="post-date bg-yellow">16 June, 2019</div>
                            <h6 class="notice-title"><a href="#">Great School manag printing.</a></h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
                        <div class="notice-list">
                            <div class="post-date bg-pink">16 June, 2019</div>
                            <h6 class="notice-title"><a href="#">Great School manag meneesom.</a></h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
                        <div class="notice-list">
                            <div class="post-date bg-skyblue">16 June, 2019</div>
                            <h6 class="notice-title">
                                <a href="#">
                                    Great School manag mene esom text of the
                                    printing.
                                </a>
                            </h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
                        <div class="notice-list">
                            <div class="post-date bg-yellow">16 June, 2019</div>
                            <h6 class="notice-title"><a href="#">Great School manag printing.</a></h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
                        <div class="notice-list">
                            <div class="post-date bg-pink">16 June, 2019</div>
                            <h6 class="notice-title"><a href="#">Great School manag meneesom.</a></h6>
                            <div class="entry-meta"> Jennyfar Lopez / <span>5 min ago</span></div>
                        </div>
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