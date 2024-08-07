<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DonutGraph.aspx.cs" Async="true" Inherits="ThesisDump.DonutGraph" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Page</title>
    <style>
        /* Apply styling to the GridView */
        #GridViewCaseInfo {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid #ddd;
        }

        #GridViewCaseInfo th, #GridViewCaseInfo td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        #GridViewCaseInfo th {
            background-color: #f2f2f2;
        }

        #GridViewCaseInfo tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </h1>
            <asp:GridView ID="GridViewCaseInfo" runat="server" AutoGenerateColumns="false" ShowHeader="true">
                <Columns>
                    <asp:BoundField DataField="Case_ID" HeaderText="Case ID" />
                    <asp:BoundField DataField="CaseDesc_ID" HeaderText="Case Description ID" />
                    <asp:BoundField DataField="Child_ID" HeaderText="Child ID" />
                    <asp:BoundField DataField="Family_ID" HeaderText="Family ID" />
                    <asp:BoundField DataField="Abuse_ID" HeaderText="Abuse ID" />
                    <asp:BoundField DataField="Officer_ID" HeaderText="Officer ID" />
                    <asp:BoundField DataField="Status_ID" HeaderText="Status ID" />
                    <asp:BoundField DataField="Date_Time" HeaderText="Date and Time" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
