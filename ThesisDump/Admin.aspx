<%@ Page Title="Admin" Language="C#" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Async="true" Inherits="ThesisDump.Admin" ValidateRequest="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top-level container -->
    <style>
        /* Government style for hyperlinks */
        .gov-link-button {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            color: #000;
            background-color: #f0f0f0;
            border: 1px solid #000;
            border-radius: 5px;
            font-weight: bold;
        }

        /* Government style for buttons */
        .gov-button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Government style for textboxes */
        .gov-textbox {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        /* Government style for dropdownlists */
        .gov-dropdownlist {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        /* Government style for labels */
        .gov-label {
            font-weight: bold;
        }

        /* Government style for GridView */
        .gov-gridview {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        .gov-gridview th, .gov-gridview td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .gov-gridview th {
            background-color: #f2f2f2;
            color: #000;
        }

        .gov-gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .gov-gridview tr:hover {
            background-color: #ddd;
        }
    </style>
    <div style="display: flex; flex-direction: row; align-items: flex-start;">
        <!-- Container for the side panel -->
        <div style="border: 1px solid #000; padding: 10px; height: 900px; width: 200px; border-width: 2px;">
            <!-- Button to load PHP content -->
            <asp:LinkButton ID="btnLoadPhpContent" runat="server" Text="User Accounts" OnClick="btnLoadPhpContent_Click" CssClass="gov-link-button"></asp:LinkButton>
            <br /><br /><br />
            <asp:LinkButton ID="lnkAuditTrail" runat="server" OnClick="lnkAuditTrail_Click" CssClass="gov-link-button">Audit Trail</asp:LinkButton>
        </div>

        <!-- Container for the iframe and update/add panels -->
        <div style="flex-grow: 1; margin-left: 20px;">
            <!-- Iframe container -->
            <div style="border: 1px solid #ccc; padding: 10px;">
                <div id="iframeContainer" runat="server">
                    <iframe id="iframePhpContent" runat="server" style="width: 100%; height: 447px; border: 1px solid #ccc;"></iframe>
                </div>
                <asp:GridView ID="gvAuditTrail" runat="server" AutoGenerateColumns="true" CssClass="gov-gridview" Visible="false" Height="277px" Width="100%" Style="margin-top: 20px;"></asp:GridView>
            </div>

            <!-- Container for the update and add panels -->
            <div style="border: 1px solid #ccc; padding: 10px; margin-top: 20px;">
                <!-- Update and Add actions container -->
                <div id="userDataContainer" class="auto-style4">
                    <div class="auto-style4">
                        <asp:LinkButton ID="lnkUpdate" runat="server" OnClick="lnkUpdate_Click" CssClass="gov-button">Update</asp:LinkButton>
                        &nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="lnkAdd" runat="server" OnClick="lnkAdd_Click" CssClass="gov-button">Add</asp:LinkButton>
                        <br />
                    </div>
                    <asp:Panel ID="updatePanel" runat="server" Visible="false">
                        <div class="auto-style4">
                            <!-- User interaction elements for update and add -->
                            <br />
                            <asp:Label ID="Label1" runat="server" Text="Username:" Visible="false" CssClass="gov-label"></asp:Label>
                            <br />
                            <asp:DropDownList ID="userupdate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="userupdate_SelectedIndexChanged" Width="200px" CssClass="gov-dropdownlist">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:TextBox ID="adduser" runat="server" style="margin-left: 0px" Width="200px" CssClass="gov-textbox"></asp:TextBox>
                            <br />
                            <asp:Label ID="Label2" runat="server" Text="Password:" Visible="false" CssClass="gov-label"></asp:Label>
                            <br />
                            <asp:TextBox ID="password" runat="server" style="margin-left: 0px" Width="200px" CssClass="gov-textbox"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="Officer ID:" Visible="false" CssClass="gov-label"></asp:Label>
                            <br />
                            <asp:DropDownList ID="officerid" runat="server" style="margin-left: 0px" CssClass="gov-dropdownlist">
                                <asp:ListItem>ADMIN</asp:ListItem>
                                <asp:ListItem>USER</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:Label ID="Label4" runat="server" Text="User Role:" CssClass="gov-label" Visible="false"></asp:Label>
                            <br />
                            <asp:DropDownList ID="role" runat="server" style="margin-left: 0px" Width="200px" CssClass="gov-dropdownlist">
                                <asp:ListItem>USER</asp:ListItem>
                                <asp:ListItem>ADMIN</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <br />
                        </div>
                    </asp:Panel>
                    <asp:TextBox ID="TextBoxStatus" runat="server" ValidateRequest="false" CssClass="gov-textbox" Visible="false"></asp:TextBox>
                    <br />
                    <asp:Button ID="Add" runat="server" Text="Add" Visible="False" OnClick="Add_Click" CssClass="gov-button" />
                    <asp:Button ID="update" runat="server" Text="Update" Visible="False" OnClick="update_Click" CssClass="gov-button" />
                    <br /><br /><br /><br /><br /><br />
                </div>
            </div>
        </div>  
    </div>

    <!-- Gridview for Audit Trail -->

</asp:Content>
