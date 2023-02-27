<%@ Page Title="Up Skills | Student Details" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Student_Details.aspx.vb" Inherits="Student_Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server"></asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Student Details</h3>
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Student Details</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Student Details Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>About Me</h3>
                </div>
                <!--<div class="dropdown">
                                <a class="dropdown-toggle" href="#" role="button"
                                   data-toggle="dropdown" aria-expanded="false">...</a>

                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#"><i class="fas fa-times text-orange-red"></i>Close</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-cogs text-dark-pastel-green"></i>Edit</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-redo-alt text-orange-peel"></i>Refresh</a>
                                </div>
                            </div>-->
            </div>
            <div class="single-info-details">
                <div class="item-img">
                    <img src="img/figure/student1.jpg" alt="student">
                </div>
                <div class="item-content">
                    <div class="header-inline item-header">
                        <h3 class="text-dark-medium font-medium">Jessia Rose</h3>
                        <div class="header-elements">
                            <ul>
                                <li><a href="#"><i class="far fa-edit"></i></a></li>
                                <li><a href="#"><i class="fas fa-print"></i></a></li>
                                <li><a href="#"><i class="fas fa-download"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <p>
                        Aliquam erat volutpat. Curabiene natis massa sedde lacu stiquen sodale
                                    word moun taiery.Aliquam erat volutpaturabiene natis massa sedde  sodale
                                    word moun taiery.
                    </p>
                    <div class="info-table table-responsive">
                        <table class="table text-nowrap">
                            <tbody>
                                <tr>
                                    <td>Code:</td>
                                    <td class="font-medium text-dark-medium">10005</td>
                                </tr>
                                <tr>
                                    <td>Name:</td>
                                    <td class="font-medium text-dark-medium">Jessia Rose</td>
                                </tr>
                                <tr>
                                    <td>Gender:</td>
                                    <td class="font-medium text-dark-medium">Female</td>
                                </tr>
                                <tr>
                                    <td>Father Name:</td>
                                    <td class="font-medium text-dark-medium">Steve Jones</td>
                                </tr>
                                <tr>
                                    <td>Mother Name:</td>
                                    <td class="font-medium text-dark-medium">Naomi Rose</td>
                                </tr>
                                <tr>
                                    <td>Date Of Birth:</td>
                                    <td class="font-medium text-dark-medium">07.08.2016</td>
                                </tr>
                                <tr>
                                    <td>Father Occupation:</td>
                                    <td class="font-medium text-dark-medium">Graphic Designer</td>
                                </tr>
                                <tr>
                                    <td>E-mail:</td>
                                    <td class="font-medium text-dark-medium">jessiarose@gmail.com</td>
                                </tr>
                                <tr>
                                    <td>Admission Date:</td>
                                    <td class="font-medium text-dark-medium">07.08.2019</td>
                                </tr>
                                <tr>
                                    <td>Group:</td>
                                    <td class="font-medium text-dark-medium">A</td>
                                </tr>
                                <tr>
                                    <td>Address:</td>
                                    <td class="font-medium text-dark-medium">House #10, Road #6, Australia</td>
                                </tr>
                                <tr>
                                    <td>Phone:</td>
                                    <td class="font-medium text-dark-medium">+ 88 98568888418</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Student Details Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
