    <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage1.Master" Async="true" AutoEventWireup="true" CodeBehind="AddCase.aspx.cs" Inherits="ThesisDump.AddCase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="GridViewContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auto-style7">
        <style>
        /* Government Style CSS */
        .government-style-container {
            background-color: #f0f0f0;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .government-style-header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .government-style-subheader {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .government-style-section {
            margin-bottom: 20px;
        }

        .government-style-fieldset {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
        }

        .government-style-textbox {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .government-style-dropdown {
            width: calc(100% - 22px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .government-style-button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .government-style-button:hover {
            background-color: #0056b3;
        }
            .auto-style5 {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                text-align: center;
            }
            .auto-style6 {
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                margin-left: 11px;
                margin-right: 0px;
                margin-top: 0px;
            }
            .auto-style7 {
                background-color: #f0f0f0;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                text-align: center;
            }
            .auto-style8 {
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            .auto-style9 {
                text-decoration: underline;
            }
            .auto-style10 {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                margin-left: 40px;
            }
            .auto-style12 {
                text-align: center;
                margin-left: 40px;
            }
            .auto-style13 {
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                margin-left: 35px;
            }
            .auto-style14 {
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                margin-left: 81px;
            }
            .auto-style15 {
                margin-left: 40px;
            }
            .auto-style16 {
                margin-top: 0px;
            }
    </style>
        <span class="auto-style9">
        <strong class="government-style-header">New Case</strong></span>
        <hr />
        <div class="auto-style4">
        <asp:TextBox ID="TextBox2" runat="server" Enabled="False" Visible="False" CssClass="government-style-textbox"></asp:TextBox>
        
        </div>
        
        <div class="government-style-section">
            <div class="auto-style4">
            <strong class="government-style-subheader">Child Information</strong>
            <br /><br />
            </div>
            <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Last Name:</strong><br />
        <asp:TextBox ID="chlastname" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>First Name:</strong><br />
        <asp:TextBox ID="cfirstname" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Middle Name:</strong><br />
        <asp:TextBox ID="chmiddlename" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Date of Birth:</strong><br />
        <asp:TextBox ID="chdob" runat="server" Width="120px" TextMode="Date" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Gender:</strong><br />
        <asp:DropDownList ID="DropDownListGen" runat="server" Width="120px" CssClass="government-style-dropdown">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Male</asp:ListItem>
            <asp:ListItem>Female</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Indicatives:</strong><br />
        <asp:TextBox ID="chindicatives" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Educational Level:</strong><br />
        <asp:TextBox ID="DropDownListEduc" runat="server" Width="120px" CssClass="government-style-dropdown">
        </asp:TextBox>
    </div>
                <div style="display: inline-block; margin-right: 20px;" class="auto-style4">
        <strong>Barangay:</strong><br />
    <asp:DropDownList ID="chAddress" runat="server" CssClass="auto-style8" Width="178px"></asp:DropDownList>
    </div>
    <br />
</div>

            <br />
            <div class="auto-style4">
                <br />
                <div>
                    <strong class="government-style-subheader">Family Background:</strong></div>
                <br />
                <asp:TextBox ID="familydesc" runat="server" Height="137px" TextMode="MultiLine" Width="559px" CssClass="government-style-textbox"></asp:TextBox>
                <br />
                <br /><strong class="government-style-subheader">Mother's Information</strong>
                <br />
            </div>
            <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Full Name:</strong><br />
        <asp:TextBox ID="momfname" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="momnum" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="momemail" runat="server" Width="200px" TextMode="Email" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="momOccupation" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="momMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Barangay:</strong><br />
    <asp:DropDownList ID="momAddress" runat="server" CssClass="auto-style8" Width="115px">
    </asp:DropDownList>
    </div>
                <br />
</div>

        </div>
        <div class="auto-style4">
        <br /><br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4">
            <strong class="government-style-subheader">Father's Information</strong>
            <br /><br />
            </div>
           <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Full Name:</strong><br />
        <asp:TextBox ID="dadfname" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="dadnum" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="dademail" runat="server" Width="200px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="dadoccupation" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="dadMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Barangay:</strong><br />
    <asp:DropDownList ID="dadAddress" runat="server" CssClass="auto-style8" Width="130px"></asp:DropDownList>
    </div>
    <br />
</div>

        </div>
        <div class="auto-style4">
        <br /><br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4">
            <strong class="government-style-subheader">Guardian's Information</strong>
            <br /><br />
            </div>
           <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Full Name:</strong><br />
        <asp:TextBox ID="gName" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="gnum" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="gemail" runat="server" Width="200px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="goccupation" runat="server" Width="120px" CssClass="government-style-textbox"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="gMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Barangay:</strong><br />
    <asp:DropDownList ID="gaddress" runat="server" CssClass="auto-style8" Width="113px"></asp:DropDownList>
    </div>
    <br />
               <br />
</div>

        </div>
        <div class="auto-style4">
            <p class="auto-style15">
                <strong><strong class="government-style-subheader">Status:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type of Abuse:</strong>
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" CssClass="auto-style16" Height="37px" Width="150px">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>Open</asp:ListItem>
                    <asp:ListItem>Ongoing</asp:ListItem>
                    <asp:ListItem>Resolved</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlAbuseType" runat="server" Width="150px" CssClass="auto-style6" Height="37px">
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
            </p>
        </div>
        <div class="government-style-section">
            <div class="auto-style4">
            <br /><br />
            </div>
            <div class="auto-style5">
                <div>
                    <br />
                </div>
                <br /><strong class="government-style-subheader">Case Description:<asp:TextBox ID="casedesc" runat="server" Height="137px" TextMode="MultiLine" Width="559px" CssClass="government-style-textbox"></asp:TextBox>
            </div>
        </div>
        <div class="auto-style4">
        <br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4" id="divActionsTaken" runat="server" visible="false">
            <strong class="government-style-subheader">Actions Taken:</strong>
            <br /><br />
            </div>
            <div class="auto-style12" id="divActionsTaken1" runat="server" visible="false">
                <asp:TextBox ID="action" runat="server" Height="138px" TextMode="MultiLine" Width="557px" CssClass="government-style-textbox"></asp:TextBox>
            </div>
        </div>
        <div class="auto-style4">
        <br /><br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4" id="divServicesReceived" runat="server" visible="false">
            <strong class="government-style-subheader">Services Received:</strong>
            <br /><br />
            </div>
            <div class="auto-style5" id="divServicesReceived1" runat="server" visible="false">
                <asp:TextBox ID="servicerec" runat="server" Height="157px" TextMode="MultiLine" Width="550px" CssClass="government-style-textbox"></asp:TextBox>
            </div>
        </div>
        <br /><br />
        <div class="government-style-section">
        </div>
        <br /><br />
        <div class="government-style-section">
            <br /><br />
            <div class="auto-style10">
                <strong>Date of Record:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date of Resolution:</strong><br />
                <asp:TextBox ID="DOR" runat="server" CssClass="auto-style8" TextMode="DateTimeLocal" Width="180px"></asp:TextBox>
                <asp:TextBox ID="DORESO" runat="server" CssClass="auto-style14" TextMode="DateTimeLocal" Width="221px"></asp:TextBox>
                <br /><br />
                <br />
            </div>
        </div>
        <br /><br />
        <div class="government-style-section">
            <br />
            <div class="auto-style10">
                <strong>Signed by :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Handled By:</strong><br />
                <asp:TextBox ID="signed" runat="server" Enabled="False" CssClass="auto-style8" Height="40px" Width="99px"></asp:TextBox>
                <asp:TextBox ID="handled" runat="server" Enabled="False" Width="100px" CssClass="auto-style13" Height="40px"></asp:TextBox>
                <br />
                <br />
                <br />
            </div>
        </div>
        <br /><br />
        <div>
            <asp:Button ID="Button1" runat="server" Text="Add Case" OnClick="Button1_Click" CssClass="government-style-button" />
        </div>
    </div>
</asp:Content>
