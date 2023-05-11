<%@ Page Title="Up Skills | All Receipt Voucher" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="ReceiptVoucher.aspx.vb" Inherits="ReceiptVoucher" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>All Receipt Voucher</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Teacher Table Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>All Receipt Voucher</h3>
                </div>
            </div>
            
            <div class="table-responsive">
                <table id="tblReceiptVoucher" class="table display data-table text-nowrap">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Date</th>
                            <th>Type</th>
                            <th>Amount</th>
                            <th>Description</th>
                            <th style="width: 50px;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#5430</td>
                            <td>17/4/2023</td>
                            <td>Teacher</td>
                            <td>10,000</td>
                            <td></td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">

                                        <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Add_ReceiptVoucher.aspx?Mode=Edit&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" runat="server" CssClass="dropdown-item">
                                              <i class="fas fa-times text-orange-red"></i>Delete
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#9784</td>
                            <td>15/4/2023</td>
                            <td>Supervisor</td>
                            <td>8,500</td>
                            <td></td>
                            <td>
                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <span class="flaticon-more-button-of-three-dots"></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">

                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="dropdown-item" target="_blank" href='<%# "Add_ReceiptVoucher.aspx?Mode=Edit&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="dropdown-item">
                                              <i class="fas fa-times text-orange-red"></i>Delete
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Teacher Table Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#tblReceiptVoucher').DataTable({
            bLengthChange: false,
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
