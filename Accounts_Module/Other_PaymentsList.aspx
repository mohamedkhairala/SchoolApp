﻿<%@ Page Title="Up Skills | All Other Payments" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Other_PaymentsList.aspx.vb" Inherits="Other_PaymentsList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Data Table CSS -->
    <link rel="stylesheet" href="../css/jquery.dataTables.min.css">
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <asp:UpdatePanel ID="UP" runat="server" ClientIDMode="Static" RenderMode="Inline">
        <ContentTemplate>
            <div class="page-load">
                <asp:UpdateProgress ID="upLoader" runat="server" ClientIDMode="Static" AssociatedUpdatePanelID="UP">
                    <ProgressTemplate>
                        <div class="loader-container">
                            <div class="lds-ripple">
                                <div></div>
                                <div></div>
                            </div>
                            <h3>Loading</h3>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
            <asp:Label ID="lblRes" runat="server" Visible="false"></asp:Label>
            <!-- Breadcubs Area Start Here -->
            <div class="breadcrumbs-area">
                <h3>All Other Payments</h3>
                <ul>
                    <li>
                        <a href="../Dashboard.aspx">Home</a>
                    </li>
                    <li>All Other Payments</li>
                </ul>
            </div>
            <!-- Breadcubs Area End Here -->
            <!-- Table Area Start Here -->
            <div class="card height-auto">
                <div class="card-body">
                    <div class="heading-layout1">
                        <div class="item-title">
                            <h3>All Other Payments Data</h3>
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
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Code, Description ..." AutoPostBack="true" OnTextChanged="FillGrid"></asp:TextBox>
                            </div>
                            <div class="col-2-xxxl col-xl-2 col-lg-3 col-12 form-group">
                                <asp:LinkButton ID="lbSearch" runat="server" CssClass="fw-btn-fill btn-gradient-yellow text-white text-center" OnClick="FillGrid"><i class="fas fa-search mr-3"></i>SEARCH</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 px-0 text-right">
                        <div class="d-inline-flex mb-3">
                            <%--<a href="Other_Payments.aspx" class="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></a>--%>
                            <asp:LinkButton ID="lbAdd" runat="server" href="Other_Payments.aspx" CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white fw-btn-fill">Add<i class="fa fa-plus ml-3"></i></asp:LinkButton>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:HiddenField ID="SortExpression" runat="server" />
                        <asp:ListView ID="lvMaster" runat="server" ClientIDMode="AutoID">
                            <LayoutTemplate>
                                <table id="DataTables" class="table display data-table text-nowrap">
                                    <thead>
                                        <tr>
                                            <th>Code</th>
                                            <th>Date</th>
                                            <th>Tran. Type</th>
                                            <th>Total Amount</th>
                                            <th>Description</th>
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
                                        <a href='<%# "Other_Payments.aspx?Mode=View&ID=" & Eval("ID")%>'><%# Eval("Code") %></a>
                                        <asp:Label ID="lblID" runat="server" Visible="false" Text='<%# Eval("ID")%>'></asp:Label>
                                    </td>
                                    <td><%# DateTime.Parse(Eval("TranDate")).ToString("yyyy-MM-dd") %> </td>
                                    <td><%# IIf(Eval("TranType").ToString = "P", "Payment", "Receipt") %> </td>
                                    <td><%# PublicFunctions.DecimalFormat(Eval("Amount").ToString) %> </td>
                                    <td><%# Eval("Description").ToString %> </td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                <span class="flaticon-more-button-of-three-dots"></span>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-right">
                                                <asp:Panel ID="pnlView" runat="server">
                                                    <asp:LinkButton ID="lbView" runat="server" CssClass="dropdown-item" href='<%# "Other_Payments.aspx?Mode=View&ID=" & Eval("Id")%>'>
                                              <i class="fas fa-eye text-dodger-blue"></i>View
                                                    </asp:LinkButton>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlEdit" runat="server">
                                                    <asp:LinkButton ID="lbEdit" runat="server" CssClass="dropdown-item" href='<%# "Other_Payments.aspx?Mode=Edit&ID=" & Eval("ID")%>'>
                                              <i class="fas fa-cogs text-dark-pastel-green"></i>Edit
                                                    </asp:LinkButton>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlDelete" runat="server">
                                                    <a class="dropdown-item"
                                                        onclick="ShowConfirmModal('<%# CType(Container, ListViewItem).FindControl("mpConfirmDelete").ClientID.ToString%>','<%# CType(Container, ListViewItem).FindControl("pnlConfirmExtenderDelete").ClientID.ToString%>');return false;">
                                                        <i class="fas fa-times text-orange-red"></i>Delete
                                                    </a>
                                                    <asp:HiddenField ID="hfDelete" runat="server" />
                                                    <asp:ModalPopupExtender ID="mpConfirmDelete" runat="server" PopupControlID="pnlConfirmExtenderDelete" TargetControlID="hfDelete"
                                                        CancelControlID="lbNoDelete" BackgroundCssClass="modal-backdrop fade show">
                                                    </asp:ModalPopupExtender>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                        <asp:Panel ID="pnlConfirmExtenderDelete" runat="server" CssClass="modal fade show" TabIndex="-1" role="dialog" aria-hidden="true" Style="display: none;">
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
                                                            <h3 class="item-title">You want to delete this record ?</h3>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:LinkButton ID="lbYesDelete" runat="server" CssClass="footer-btn btn-success" CommandArgument='<%# Eval("Id") %>' OnClick="Delete">Yes<i class="fa fa-check icon-modal ml-2"></i></asp:LinkButton>
                                                        <asp:LinkButton ID="lbNoDelete" runat="server" CssClass="footer-btn btn-danger" data-dismiss="modal">No<i class="fa fa-times icon-modal ml-2"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
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
            <!-- Table Area End Here -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Data Table Js -->
    <script src="../js/jquery.dataTables.min.js"></script>

    <script>
        $('#DataTables').DataTable({
            bLengthChange: false,
            columnDefs: [
                { orderable: false, targets: -1 }
            ]
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
</asp:Content>
