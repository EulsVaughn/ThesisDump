a<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataB.aspx.cs" Inherits="ThesisDump.DataB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Database Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Database Display</h1>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="True" CssClass="table table-bordered table-striped">
            </asp:GridView>
            <div id="divTables" runat="server">
                <!-- Content will be dynamically added here -->
            </div>
        </div>
    </form>
</body>
</html>
