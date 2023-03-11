<%@ Page Title="Up Skills | Courses" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Attachment.aspx.vb" Inherits="Course" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHeader" ContentPlaceHolderID="Header" runat="Server">
    <!-- Select 2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">
    <!-- Date Picker CSS -->
    <link rel="stylesheet" href="css/datepicker.min.css">
    <!-- Upload Photo CSS -->
    <link rel="stylesheet" href="css/upload-photo.css" />
</asp:Content>
<asp:Content ID="PageContent" ContentPlaceHolderID="Content" runat="Server">
    <!-- Breadcubs Area Start Here -->
    <div class="breadcrumbs-area">

        <ul>
            <li>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li>Attachments</li>
        </ul>
    </div>
    <!-- Breadcubs Area End Here -->
    <!-- Admit Form Area Start Here -->
    <div class="card height-auto">
        <div class="card-body">
            <div class="heading-layout1">
                <div class="item-title">
                    <h3>
                        <asp:Label Text="" runat="server" ID="lblTitle" /></h3>


                    <asp:Label Text="" ID="lblUserRole" Visible="false" runat="server" />
                    <asp:Label Text="" ID="lblRes" runat="server" />
                </div>
                <asp:Panel CssClass="dropdown" runat="server" ID="divActions">
                    <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                        aria-expanded="false">...</a>

                    <div class="dropdown-menu dropdown-menu-right">

                        <asp:LinkButton ID="lbEdit" CssClass="dropdown-item" runat="server" OnClick="Edit"><i class="fas fa-cogs text-dark-pastel-green"></i>Edit</asp:LinkButton>

                    </div>
                </asp:Panel>
            </div>
            <div class="new-added-form">
                <asp:Panel runat="server" ID="pnlForm">
                    <div class="row">

                        <div class="col-xl-9 col-lg-6">
                            <asp:ValidationSummary ID="ValidationSummary" ClientIDMode="Static" DisplayMode="BulletList" ValidationGroup="vUsers" EnableClientScript="true" runat="server" CssClass="ValidationSummary" Visible="false" />

                            <div class="row">
                                <!-- Course -->
                                <div id="divCourseID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblCourseID" runat="server" for="ddlCourseID">Course</label>
                                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectCourse">
                                        <asp:ListItem Value="">Please Select Course</asp:ListItem>
                                    </asp:DropDownList>
                                    <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqCourseID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlCourseID" InitialValue="" Display="Dynamic" Text="Required Course"></asp:RequiredFieldValidator>--%>
                                </div>
                                <!-- Group -->
                                <div id="divGroupID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblGroupID" runat="server" for="ddlGroupID">Group</label>
                                    <asp:DropDownList ID="ddlGroup" runat="server" CssClass="select2" AutoPostBack="true" OnSelectedIndexChanged="SelectGroup">
                                        <asp:ListItem Value="">Please Select Group</asp:ListItem>
                                    </asp:DropDownList>
                                    <%--<asp:RequiredFieldValidator CssClass="valid-inp" ID="reqGroupID" runat="server" ValidationGroup="vsMaster"
                                    ControlToValidate="ddlGroupID" InitialValue="" Display="Dynamic" Text="Required Group"></asp:RequiredFieldValidator>--%>
                                </div>
                                <!-- Session -->
                                <div id="divSessionID" runat="server" class="col-xl-3 col-lg-6 col-12 form-group">
                                    <label id="lblSessionID" runat="server" for="ddlSessionID">Session *</label>
                                    <asp:DropDownList ID="ddlSession" runat="server" CssClass="select2"
                                        AutoPostBack="true" OnSelectedIndexChanged="SelectSession">
                                        <asp:ListItem Value="">Please Select Session *</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="col-xl-12 col-lg-6 col-12 form-group">
                                    <asp:FileUpload runat="server" ID="fuAttachments" AllowMultiple="true" />
                                    <asp:Button runat="server" ID="uploadedFile" Text="Upload" OnClick="UploadFile" />
                                    <asp:Label ID="listofuploadedfiles" runat="server" />
                                </div>
                                <div class="col-xl-12 col-lg-6 col-12 form-group">
                                    <label>Teacher Files</label>
                                    <asp:GridView ID="gvTeacherFiles" runat="server" CssClass="table table-bordered table-hover table-striped w-100 dataTable dtr-inline collapsed mt-2"
                                        AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="srialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File ">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID").ToString %>' Visible="false"></asp:Label>
                                                    <asp:Panel ID="pnlImage" runat="server">
                                                        <asp:Image CssClass="displayNone" ID="file" runat="server" ImageUrl='<%# Eval("URL")%>' Height="70px" Width="70px" Visible="false" />
                                                        <asp:Label ID="lblURL" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblFileType" runat="server" Text='<%# Eval("FileType").ToString %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblDocumentCopy" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                        <%--<img src='<%# Eval("DocumentCopy").ToString %>' runat="server" />--%>
                                                        <asp:HyperLink ID="linkView" runat="server" NavigateUrl='<%# Eval("URL").ToString %>' onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                                            <asp:Image ID="fileIcon" runat="server" ImageUrl='<%# Eval("URL").ToString %>' CssClass="img-thumbnail" Height="45px" />
                                                        </asp:HyperLink>
                                                    </asp:Panel>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="File Name">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("FileName").ToString %>' ToolTip="Attachment Name" placeholder="Attachment Name"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Description">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Text='<%# Eval("Description").ToString %>' ToolTip="Attachment Description" placeholder="Attachment Description"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Download" Visible="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lbDownload" runat="server" CssClass="icons file-download" Visible="false" NavigateUrl='<%# Eval("URL").ToString  %>' title="Download" download='<%# System.DateTime.Now.ToShortDateString() + " - " + Eval("URL").ToString.Split("/").Last%>'><span onclick="ForceDownload"></span></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton Text="Delete" OnClientClick="return confirm('Are you sure!');" OnClick="DeleteMultiFiles" runat="server" />

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <table style="width: 100%;">
                                                <tr class="EmptyRowStyle">
                                                    <td class="p-0">
                                                        <div>No Attachments Found.</div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                                <div class="col-lg-12 col-12 form-group">
                                    <label>Student Files</label>
                                    <asp:GridView ID="gvStudentFiles" runat="server" CssClass="table table-bordered table-hover table-striped w-100 dataTable dtr-inline collapsed mt-2"
                                        AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="srialNo" runat="server" Text='<%# Val(Container.DataItemIndex.ToString) + 1 %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File ">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID").ToString %>' Visible="false"></asp:Label>
                                                    <asp:Panel ID="pnlImage" runat="server">
                                                        <asp:Image CssClass="displayNone" ID="file" runat="server" ImageUrl='<%# Eval("URL")%>' Height="70px" Width="70px" Visible="false" />
                                                        <asp:Label ID="lblURL" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblFileType" runat="server" Text='<%# Eval("FileType").ToString %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblDocumentCopy" runat="server" Text='<%# Eval("URL").ToString %>' Visible="false"></asp:Label>
                                                        <%--<img src='<%# Eval("DocumentCopy").ToString %>' runat="server" />--%>
                                                        <asp:HyperLink ID="linkView" runat="server" NavigateUrl='<%# Eval("URL").ToString %>' onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                                            <asp:Image ID="fileIcon" runat="server" ImageUrl='<%# Eval("URL").ToString %>' CssClass="img-thumbnail" Height="45px" />
                                                        </asp:HyperLink>
                                                    </asp:Panel>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="File Name">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("FileName").ToString %>' ToolTip="Attachment Name" placeholder="Attachment Name"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Description">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Text='<%# Eval("Description").ToString %>' ToolTip="Attachment Description" placeholder="Attachment Description"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type">
                                                <ItemTemplate>
                                                    <%--                                                    <asp:Label ID="lblFileCategory" runat="server" Text='<%# Eval("FileCat").ToString %>' Visible="false"></asp:Label>--%>
                                                    <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Download" Visible="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lbDownload" runat="server" CssClass="icons file-download" Visible="false" NavigateUrl='<%# Eval("URL").ToString  %>' title="Download" download='<%# System.DateTime.Now.ToShortDateString() + " - " + Eval("URL").ToString.Split("/").Last%>'><span onclick="ForceDownload"></span></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton Text="Delete" OnClientClick="return confirm('Are you sure!');" OnClick="DeleteMultiFiles" runat="server" />

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <table style="width: 100%;">
                                                <tr class="EmptyRowStyle">
                                                    <td class="p-0">
                                                        <div>No Attachments Found.</div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                                <div class="col-12 form-group mg-t-8">
                                    <asp:LinkButton ID="lbSave" runat="server" ValidationGroup="vUsers"
                                        CssClass="btn-fill-lg btn-gradient-yellow btn-hover-bluedark text-white"
                                        CommandArgument="Add" OnClick="Save">Save</asp:LinkButton>
                                    <asp:LinkButton ID="lbCancel" runat="server" CssClass="btn-fill-lg bg-blue-dark btn-hover-yellow text-white" OnClick="Cancel">Cancel</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
    <!-- Admit Form Area End Here -->
</asp:Content>
<asp:Content ID="PageFooter" ContentPlaceHolderID="Footer" runat="Server">
    <!-- Select 2 Js -->
    <script src="js/select2.min.js"></script>
    <!-- Date Picker Js -->
    <script src="js/datepicker.min.js"></script>
    <!-- Upload Photo Js -->
    <script src="js/UploadPhoto.js"></script>
</asp:Content>
