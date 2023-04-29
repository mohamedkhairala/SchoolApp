<%@ Page Title="Up Skills | All Courses" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="CourseList.aspx.vb" Inherits="CourseList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>All Courses</h3>
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>All Courses</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Course Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Courses Data</h3>
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
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Code, Name or Group ..." AutoPostBack="true" OnTextChanged="FillGrid"></asp:TextBox>
                    </div>
                    <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                        <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center" OnClick="FillGrid"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                                <a href="Course.aspx" class="btn btn-success">   <i class="fa fa-plus" ></i>Add</a>

                <asp:HiddenField ID="SortExpression" runat="server" />
                <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                    <LayoutTemplate>
                        <table id="tblCourses" class="table display data-table text-nowrap">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Name</th>
                                    <th>NO Of Sessions</th>
                                    <th>Session Rate</th>
                                    <th>Fees</th>
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
                            <td>#<%# Eval("Code")%>
                                <asp:Label ID="lblCourseId" runat="server" Visible="false" Text='<%# Eval("Id")%>'></asp:Label>
                            </td>
                                               
                            <td>
                                <a href='<%# "Course_Details.aspx?Mode=View&ID=" & Eval("Id")%>' target="_blank"><%# Eval("Name")%></a>
                            </td>
                            <td><%# Eval("NoOfSessions")%></td>
                            <td><%# Eval("SessionRate")%></td>
                            <td><%# Eval("Fees")%></td>
                            <td><%# Eval("Remarks")%></td>

                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">

                                        <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Course.aspx?Mode=Edit&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" runat="server" CssClass="dropdown-item"
                                           OnClientClick="return confirm('Confirm Delete?')" OnClick="Delete">
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
                <%--        <table class="table display data-table text-nowrap">

                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Photo</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Group</th>
                            <th>Courses</th>
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
                            <td class="text-center">
                                <img src="img/figure/Course2.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course3.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Jessia Rose</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course4.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course5.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Jessia Rose</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course7.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Jessia Rose</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course8.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course9.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Jessia Rose</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course10.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Jessia Rose</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course2.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course3.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course4.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course5.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course7.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course8.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course9.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course10.png" alt="Course"></td>
                            <td>
                                <a href="Course_Details.aspx" target="_blank">Mark Willy</a>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course2.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Mark Willy</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course3.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course4.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Mark Willy</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course5.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Mark Willy</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course7.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course8.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Mark Willy</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course9.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Jessia Rose</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course10.png" alt="Course"></td>
                            <td><a href="Course_Details.aspx" target="_blank">Mark Willy</a></td>
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
                            <td class="text-center">
                                <img src="img/figure/Course6.png" alt="Course"></td>
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
                </table>--%>
            </div>
        </div>
    </div>
    <!-- Course Table Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="js/jquery.dataTables.min.js"></script>

    <script>
        $('#tblCourses').DataTable({
            bLengthChange: false,
            language: {
                searchPlaceholder: "Search by Code, Name, Phone or E-mail ...",
                
            },
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
