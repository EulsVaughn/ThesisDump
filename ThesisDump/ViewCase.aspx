<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" Async="true" CodeBehind="ViewCase.aspx.cs" Inherits="ThesisDump.ViewCase" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="government-form">
        <h2>View Case</h2>
        <div class="search-section">
            <asp:TextBox ID="SearchTextBox" runat="server" placeholder="Search..." CssClass="form-control" AutoPostBack="True" OnTextChanged="SearchTextBox_TextChanged" Width="881px"></asp:TextBox>
            <asp:Button ID="dlbutton" runat="server" Text="Download" OnClick="DownloadButton_Click" CssClass="btn btn-success" Height="36px" Width="110px" />
            <asp:Button ID="addbutton" runat="server" Text="Add New Case" OnClick="AddButton_Click" CssClass="btn btn-success" Height="36px" style="margin-left: 9px" Width="150px" />
        </div>
        <div class="case-list">
            <asp:GridView ID="GridView1" runat="server" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <a href='<%# "SpecificCase.aspx?Case_ID=" + Eval("Case ID") %>'>View Details</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <style>
    /* Government style CSS */
   /* Government style CSS */
.government-form {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.government-form h2 {
    font-size: 24px;
    margin-bottom: 20px;
    color: #333;
}

.search-section {
    margin-bottom: 20px;
}

/* Government style for search textbox */
.search-section .form-control {
    width: calc(100% - 120px);
    margin-right: 10px;
    border: 1px solid #ccc;
    padding: 8px;
    font-size: 14px;
}

/* Government style for download button */
.search-section .btn-success {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    text-align: center;
    font-size: 16px;
    cursor: pointer;
}

.search-section .btn-success:hover {
    background-color: #0056b3;
}

.case-list {
    overflow-x: auto;
}

.case-list table {
    width: 100%;
    border-collapse: collapse;
}

.case-list th, .case-list td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: left;
}

.case-list th {
    background-color: #f2f2f2;
    font-weight: bold;
}

.case-list a {
    text-decoration: none;
    color: #007bff;
}

.case-list a:hover {
    text-decoration: underline;
}

    </style>
</asp:Content>
