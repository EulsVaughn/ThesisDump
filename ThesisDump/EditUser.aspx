<%@ Page Language="C#" AutoEventWireup="true" Async="true" CodeBehind="EditUser.aspx.cs" Inherits="ThesisDump.EditUser" MasterPageFile="~/MasterPage1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="government-container">
        <h1 class="government-heading">Edit User Information</h1>
        <div class="government-form">
            <div class="form-group">
                <label for="currentPassword" class="government-label">Current Password:</label>
                <asp:TextBox ID="currentPassword" runat="server" CssClass="government-input" TextMode="Password"></asp:TextBox>
                <asp:Button ID="checkPasswordBtn" runat="server" CssClass="government-button" Text="Check Password" OnClick="checkPasswordBtn_Click" />
            </div>
            <div id="newPasswordDiv" runat="server" style="display: none;">
                <div class="form-group">
                    <label for="newPassword" class="government-label">New Password:</label>
                    <asp:TextBox ID="newPassword" runat="server" CssClass="government-input" TextMode="Password"></asp:TextBox>
                    <asp:Button ID="updatePasswordBtn" runat="server" CssClass="government-button" Text="Update Password" />
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Government-style container */
        .government-container {
            margin: 50px auto;
            max-width: 600px;
            padding: 20px;
            background-color: #f2f2f2;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Government-style heading */
        .government-heading {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Government-style form */
        .government-form {
            margin-bottom: 20px;
        }

        /* Form group */
        .form-group {
            margin-bottom: 15px;
        }

        /* Government-style label */
        .government-label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* Government-style input */
        .government-input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Government-style button */
        .government-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .government-button:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>
