<%@ Page Title="Up Skills | All Students" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Students.aspx.vb" Inherits="Students" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Students</h3>
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>All Students</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Student Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Students Data</h3>
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
            <div class="mg-b-20">
                <div class="row gutters-8">
                    <div class="col-6-xxxl col-xl-6 col-lg-4 col-12 form-group">
                    </div>
                    <div class="col-4-xxxl col-xl-4 col-lg-5 col-12 form-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Code, Name or Group ..."></asp:TextBox>
                    </div>
                    <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                        <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table display data-table text-nowrap">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Photo</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Group</th>
                            <th>Parents</th>
                            <th>Address</th>
                            <th>Date Of Birth</th>
                            <th>Phone</th>
                            <th>E-mail</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#0021</td>
                            <td class="text-center"><img src="img/figure/student2.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0022</td>
                            <td class="text-center"><img src="img/figure/student3.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Jessia Rose</a>
                            </td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0023</td>
                            <td class="text-center"><img src="img/figure/student4.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0024</td>
                            <td class="text-center"><img src="img/figure/student5.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Jessia Rose</a>
                            </td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0025</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0026</td>
                            <td class="text-center"><img src="img/figure/student7.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Jessia Rose</a>
                            </td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0027</td>
                            <td class="text-center"><img src="img/figure/student8.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0028</td>
                            <td class="text-center"><img src="img/figure/student9.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Jessia Rose</a>
                            </td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0029</td>
                            <td class="text-center"><img src="img/figure/student10.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0030</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Jessia Rose</a>
                            </td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0021</td>
                            <td class="text-center"><img src="img/figure/student2.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0022</td>
                            <td class="text-center"><img src="img/figure/student3.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0023</td>
                            <td class="text-center"><img src="img/figure/student4.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0024</td>
                            <td class="text-center"><img src="img/figure/student5.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0025</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0026</td>
                            <td class="text-center"><img src="img/figure/student7.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0027</td>
                            <td class="text-center"><img src="img/figure/student8.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0028</td>
                            <td class="text-center"><img src="img/figure/student9.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0029</td>
                            <td class="text-center"><img src="img/figure/student10.png" alt="student"></td>
                            <td>
                                <a href="Student_Details.aspx" target="_blank">Mark Willy</a>
                            </td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0030</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0021</td>
                            <td class="text-center"><img src="img/figure/student2.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Mark Willy</a></td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0022</td>
                            <td class="text-center"><img src="img/figure/student3.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0023</td>
                            <td class="text-center"><img src="img/figure/student4.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Mark Willy</a></td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0024</td>
                            <td class="text-center"><img src="img/figure/student5.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0025</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Mark Willy</a></td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0026</td>
                            <td class="text-center"><img src="img/figure/student7.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0027</td>
                            <td class="text-center"><img src="img/figure/student8.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Mark Willy</a></td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0028</td>
                            <td class="text-center"><img src="img/figure/student9.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Jessia Rose</a></td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0029</td>
                            <td class="text-center"><img src="img/figure/student10.png" alt="student"></td>
                            <td><a href="Student_Details.aspx" target="_blank">Mark Willy</a></td>
                            <td>Male</td>

                            <td>A</td>
                            <td>Jack Sparrow </td>
                            <td>TA-107 Newyork</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#0030</td>
                            <td class="text-center"><img src="img/figure/student6.png" alt="student"></td>
                            <td>Jessia Rose</td>
                            <td>Female</td>

                            <td>A</td>
                            <td>Maria Jamans</td>
                            <td>59 Australia, Sydney</td>
                            <td>02/05/2001</td>
                            <td>+ 123 9988568</td>
                            <td>kazifahim93@gmail.com</td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
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
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Student Table Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="js/jquery.dataTables.min.js"></script>
</asp:Content>