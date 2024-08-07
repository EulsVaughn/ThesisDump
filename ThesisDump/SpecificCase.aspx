<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" Async="true" CodeBehind="SpecificCase.aspx.cs" Inherits="ThesisDump.SpecificCase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="GridViewContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel1" runat="server">
        <div class="auto-style4">
            <h2><span style="font-size: larger"><strong>Details of Case Number </strong></span><strong>
                <asp:Label ID="caseno" runat="server" style="font-size: larger"></asp:Label>
                </strong><span style="font-size: larger"><strong>: </strong></span><strong>
                <asp:Label ID="cname" runat="server" style="font-size: larger"></asp:Label>
                </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<strong> </strong></h2>
        </div>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server">
        <div class="auto-style4">
            <strong>Case</strong> <strong>Information</strong><asp:Panel ID="Panel3" runat="server" Height="250px">
                <div style="margin-left: 40px; border: 1px solid black; padding: 10px;">

    <div style="display: inline-block; margin-right: 20px; margin-bottom: 10px;">
        <h1 style="font-size: 24px;"><strong>Full Name:</strong></h1>
        <asp:Label ID="child" runat="server"></asp:Label>
    </div>

    <div style="display: inline-block; margin-right: 20px; margin-left: 0px; margin-bottom: 10px;">
        <h2 style="font-size: 22px;"><strong>Status:</strong></h2>
        <asp:Label ID="status" runat="server" Style="font-weight: bold;"></asp:Label>
        <strong id="caseLabel">Case</strong>
    </div>

    <div style="display: inline-block; margin-right: 20px; margin-bottom: 10px;">
        <h3 style="font-size: 20px;"><strong>Date of Record:</strong></h3>
        <asp:Label ID="DOR1" runat="server"></asp:Label>
    </div>

    <div style="display: inline-block; margin-right: 20px; margin-bottom: 10px;">
        <h3 style="font-size: 20px;"><strong>Gender:</strong></h3>
        <asp:Label ID="gen" runat="server"></asp:Label>
    </div>

    <div style="display: inline-block; margin-right: 20px; margin-bottom: 10px;">
        <h3 style="font-size: 20px;"><strong>Type of Abuse:</strong></h3>
        <asp:Label ID="toa" runat="server"></asp:Label>
    </div>

    <div style="display: inline-block; margin-right: 20px; margin-bottom: 10px;">
        <h3 style="font-size: 20px;"><strong>Handled By:</strong></h3>
        <asp:Label ID="handle" runat="server"></asp:Label>
    </div>

<!-- Your HTML content here -->



<!-- Your HTML content continues -->

<script>
    // JavaScript logic to set the color of the status label and Case label
    var statusLabel = document.getElementById('<%= status.ClientID %>');
    var caseLabel = document.getElementById('caseLabel');

    if (statusLabel.innerHTML.trim() === 'Resolved') {
        statusLabel.style.color = 'green';
        caseLabel.style.color = 'green';
    } else if (statusLabel.innerHTML.trim() === 'Ongoing') {
        statusLabel.style.color = 'orange';
        caseLabel.style.color = 'orange';
    } else if (statusLabel.innerHTML.trim() === 'Open') {
        statusLabel.style.color = 'red';
        caseLabel.style.color = 'red';
    }
</script>



</div>





                      <div class="government-style-section">
            <div class="auto-style4">
            <strong class="government-style-subheader">Child Information</strong>
            <br /><br />
            </div>
            <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Last Name:</strong><br />
        <asp:TextBox ID="chlastname" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>First Name:</strong><br />
        <asp:TextBox ID="cfirstname" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Middle Name:</strong><br />
        <asp:TextBox ID="chmiddlename" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Date of Birth:</strong><br />
        <asp:TextBox ID="chdob" runat="server" Width="120px" TextMode="Date" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Gender:</strong><br />
        <asp:DropDownList ID="DropDownListGen" runat="server" Width="120px" CssClass="government-style-dropdown" Enabled="False">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Male</asp:ListItem>
            <asp:ListItem>Female</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Indicatives:</strong><br />
        <asp:TextBox ID="chindicatives" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Educational Level:</strong><br />
        <asp:DropDownList ID="DropDownListEduc" runat="server" Width="120px" CssClass="government-style-dropdown" Enabled="False">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Elementary</asp:ListItem>
            <asp:ListItem>High School</asp:ListItem>
            <asp:ListItem>Pre-School</asp:ListItem>
            <asp:ListItem>Not Studying</asp:ListItem>
        </asp:DropDownList>
    </div>
    <br />
    <strong>Address:</strong><br />
    <asp:DropDownList ID="chAddress" runat="server" CssClass="government-style-dropdown" Enabled="False" EnableViewState="true">
                </asp:DropDownList>
</div>

            <br />
            <div class="auto-style4">
                <br />
                <div>
                    <span class="auto-style9"><strong class="government-style-subheader">Family Background</strong></span>
                </div>
                <br />
                <asp:TextBox ID="familydesc" runat="server" Height="137px" TextMode="MultiLine" Width="559px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
                <br />
                <br /><strong class="government-style-subheader">Mother's Information</strong>
                <br />
            </div>
            <div class="auto-style5">
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Full Name:</strong><br />
        <asp:TextBox ID="momfname" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="momnum" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="momemail" runat="server" Width="200px" TextMode="Email" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="momOccupation" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="momMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown" Enabled="False">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <br />
    <strong>Address:</strong><br />
    <asp:DropDownList ID="momAddress" runat="server" CssClass="government-style-dropdown" Enabled="False">
    </asp:DropDownList>
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
        <asp:TextBox ID="dadfname" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="dadnum" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="dademail" runat="server" Width="200px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="dadoccupation" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="dadMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown" Enabled="False">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <br /><br />
    <strong>Address:</strong><br />
    <asp:DropDownList ID="dadAddress" runat="server" CssClass="government-style-dropdown" Enabled="False"></asp:DropDownList>
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
        <asp:TextBox ID="gName" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Phone Number:</strong><br />
        <asp:TextBox ID="gnum" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Email:</strong><br />
        <asp:TextBox ID="gemail" runat="server" Width="200px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Occupation:</strong><br />
        <asp:TextBox ID="goccupation" runat="server" Width="120px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
    </div>
    <div style="display: inline-block; margin-right: 20px;">
        <strong>Marital Status:</strong><br />
        <asp:DropDownList ID="gMaritalStatus" runat="server" Width="120px" CssClass="government-style-dropdown" Enabled="False">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
        </asp:DropDownList>
    </div>
    <br />
    <strong>Address:</strong><br />
    <asp:DropDownList ID="gaddress" runat="server" CssClass="government-style-dropdown" Enabled="False"></asp:DropDownList>
</div>

        </div>
        <div class="auto-style4">
        <br />
            <strong class="government-style-subheader">Status:</strong> 
       <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="true" Enabled="False">
</asp:DropDownList>

            <br />
            <br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4">
            <br /><br />
            </div>
            <div class="auto-style5">
                <div>
                <strong>Type of Abuse:</strong>
                    <br />
                <asp:DropDownList ID="ddlAbuseType" runat="server" Width="209px" CssClass="auto-style6" Height="86px" Enabled="False">
                </asp:DropDownList>
                </div>
                <br />
            <strong class="government-style-subheader">Case Description:</strong>
                <br />
                <br />
                <asp:TextBox ID="casedesc" runat="server" Height="137px" TextMode="MultiLine" Width="559px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
            </div>
        </div>
        <div class="auto-style4">
        <br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4" id="divActionsTaken" runat="server" visible="true">
            <strong class="government-style-subheader">Actions Taken:</strong>
            <br /><br />
            </div>
            <div class="auto-style12" id="divActionsTaken1" runat="server" visible="true">
                <asp:TextBox ID="action" runat="server" Height="138px" TextMode="MultiLine" Width="557px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
            </div>
        </div>
        <div class="auto-style4">
        <br /><br />
        </div>
        <div class="government-style-section">
            <div class="auto-style4" id="divServicesReceived" runat="server" visible="true">
            <strong class="government-style-subheader">Services Received:</strong>
            <br /><br />
            </div>
            <div class="auto-style5" id="divServicesReceived1" runat="server" visible="true">
                <asp:TextBox ID="servicerec" runat="server" Height="157px" TextMode="MultiLine" Width="550px" CssClass="government-style-textbox" Enabled="False"></asp:TextBox>
            </div>
        </div>
        <br /><br />
        <div class="government-style-section">
        </div>
        <br /><br />
        <div class="government-style-section">
            <strong class="government-style-subheader">Dates:</strong>
            <br /><br />
            <div class="auto-style10">
                <strong>Date of Record:</strong><br />
                <asp:TextBox ID="DOR" runat="server" CssClass="government-style-textbox" TextMode="DateTime" Enabled="False"></asp:TextBox>
                <br /><br />
                <br />
                <div class="auto-style11" id="divDateOfResolution" runat="server" visible="true">
                <strong>Date of Resolution:</strong><asp:TextBox ID="DORESO" runat="server" CssClass="government-style-textbox" TextMode="DateTime" Enabled="False"></asp:TextBox>
                </div>
            </div>
        </div>
        <br /><br />
        <div class="government-style-section">
            <strong class="government-style-subheader">Signatures:</strong>
            <br /><br />
            <div class="government-style-fieldset">
                <strong>Signed By:</strong><br />
                <asp:TextBox ID="signed" runat="server" Enabled="False" CssClass="auto-style8" Height="40px" Width="100px"></asp:TextBox>
                <br /><br />
                <strong>Handled by:</strong><br />
                <asp:TextBox ID="handled" runat="server" Enabled="False" Width="100px" CssClass="auto-style8" Height="40px" Visible="False"></asp:TextBox>
                <br />
            </div>
        </div>
        <br />
                 <asp:HyperLink ID="backLink" runat="server" NavigateUrl="javascript:history.back()">Return</asp:HyperLink>
                <asp:Button ID="DLCase" runat="server" OnClick="DLCase_Click" Text="Download" />
                &nbsp;<strong><asp:LinkButton ID="editcase" runat="server" Text="Edit" OnClick="editcase_Click"></asp:LinkButton>

                <br />

                </strong>
                <br />
        <div>
            <asp:Button ID="update" runat="server" Text="Update" Visible="False" OnClick="updatecase_Click"/>
            </asp:Panel>
        </div>
    </asp:Panel>
    <p>
        <br />
    </p>
    <p>
    </p>
    <p>
    </p>
</asp:Content>
