<%@ Page Title="Up Skills | Dashboard" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="MessagesList.aspx.vb" Inherits="Dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server"></asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">
        <h3>Messages</h3>
        <ul>
            <li>Messages</li>
        </ul>
    </div>
    <div class="row gutters-20">

        <div class="col-lg-12 col-xl-12 col-12-xxxl">
            <div class="card dashboard-card-six pd-b-20">
                <div class="card-body">
                    <div class="heading-layout1 mg-b-17">
                        <div class="item-title">
                            <h3>Messages</h3>
                        </div>
                        <asp:Label Text="" ID="lblRes" runat="server" />
                    </div>
                    <div class="notice-box-wrap">
                        <asp:TextBox runat="server" ID="txtSearch"  />
                        <asp:ListView runat="server" ID="rbMessages">
                            <ItemTemplate>
                                <div class="notice-list">
                                    <div class="post-date  <%# clsNotifications.SetRandomColor() %>"><%# PublicFunctions.DateFormat(Eval("CreatedDate"), "dd MMM yyyy") %></div>
                                    <h6 class="notice-title">
                                        <a href="#">
                                            <%# Eval("MessageTitle") %>
                                        </a>
                                        <p><%# Eval("MessageBody") %></p>
                                    </h6>
                                    <div class="entry-meta"><%# Eval("CreatedByUserName") %> / <span><%# clsNotifications.SetTimeAgo(Eval("CreatedDate"), Eval("time_ago")) %></span></div>
                                    <div>
                                        <asp:LinkButton Text="Delete" ID="lbDelete" CommandArgument='<%# Eval("MsgNo") %>' OnClientClick="return confirm('Confirm Delete?');" OnClick="Delete" runat="server" />
                                    </div>
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


                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server"></asp:Content>
