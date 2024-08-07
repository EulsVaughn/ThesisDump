
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Async="true" Inherits="ThesisDump.Login" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0; /* Light gray background */
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center items horizontally */
        }

        .login-heading {
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
            color: #0056b3; /* Dark blue heading */
        }

        .login-form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-size: 14px;
            margin-bottom: 5px;
            color: #333; /* Dark gray label text */
        }

        .form-input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            width: 100%;
        }

        .btn-login {
            background-color: #0056b3; /* Dark blue button */
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #003366; /* Darker blue on hover */
        }
        .login-logo {
    max-width: 100%;
    height: auto;
    margin-bottom: 20px; /* Adjust as needed */
}

    </style>
</head>
   
<body>
    <form id="form1" runat="server">
        <div class="login-container">
    <div class="login-box">
        <img src="Images/mswdlogo.png" alt="Logo" class="login-logo">

        <h2 class="login-heading">MSWD Agdangan Login</h2>
        <div class="form-group">
            <label for="txtUsername" class="form-label">Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtPassword" class="form-label">Password:</label>
            <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-input"></asp:TextBox>
        </div>
        <div>
            <asp:Button ID="btnLogin" Text="Login" OnClick="btnLogin_Click" runat="server" CssClass="btn-login" />
        </div>
    </div>
</div>
    </form>
</body>
</html>
