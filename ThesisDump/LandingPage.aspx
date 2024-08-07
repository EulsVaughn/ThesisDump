<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Async="true" Inherits="ThesisDump.LandingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Child Welfare Tracking Program</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 50px;
            text-align: center;
        }

        .button {
            padding: 10px 20px;
            font-size: 18px;
            margin: 10px;
        }
        .auto-style1 {
            margin-bottom: 70px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>

            <asp:Label ID="lblWelcomeMessage" runat="server" Text=""></asp:Label>
            
                Welcome to the Child Welfare Tracking Program&nbsp;&nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                &nbsp;<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnLogout" runat="server" CssClass="auto-style1" Height="42px" OnClick="Button1_Click" Text="Logout" Width="162px" />
            </h1>
            <p>This program tracks child welfare in a specific municipality, utilizing databases, visualizations, analytics, and more.</p>

            <asp:Button ID="btnDatabaseDisplay" runat="server" CssClass="button" Text="Database Display" OnClick="btnDatabaseDisplay_Click" />
            <asp:Button ID="btnDataStatistics" runat="server" CssClass="button" Text="Data Statistics and Visualization Dashboard" OnClick="btnDataStatistics_Click" />
            <asp:Button ID="btnRiskAssessment" runat="server" CssClass="button" Text="Risk Assessment, Benchmarking, and Outcome Tracking" OnClick="btnRiskAssessment_Click" />


        </div>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
