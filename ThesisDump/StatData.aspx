<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" Async="true" CodeBehind="StatData.aspx.cs" Inherits="ThesisDump.StatData" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Modal dialog HTML -->
    <div id="myModal" class="modal">
        <div class="modal-content government-style">
            <span class="close" onclick="closeModal()">&times;</span>
            <h4>Select Type of Abuse</h4>
            <asp:DropDownList ID="abuselist1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="abuselist_SelectedIndexChanged" CssClass="government-dropdown">
            
            </asp:DropDownList>
            <h4>Gender</h4>
            <asp:DropDownList ID="genderlist" runat="server" AutoPostBack="true" OnSelectedIndexChanged="genderlist_SelectedIndexChanged" CssClass="government-dropdown">
                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                <asp:ListItem Text="Female" Value="2"></asp:ListItem>
            </asp:DropDownList>
            <!-- Date Selection Group -->
            <div class="date-selection-group">
                <div>
                    <h4>Select Date from</h4>
                    <asp:TextBox ID="date1" runat="server" TextMode="Date" CssClass="government-textbox"></asp:TextBox>
                </div>
                <div>
                    <h4>Select Date To</h4>
                    <asp:TextBox ID="date2" runat="server" TextMode="Date" CssClass="government-textbox"></asp:TextBox>
                </div>
            </div>
            <asp:Label ID="lblSelection" runat="server" Text="" CssClass="government-label"></asp:Label>
        </div>
    </div>


    <!-- Button to open modal -->
    <button id="btnOpenModal" type="button" onclick="openModal()" class="button5">Filter</button>
    <asp:HiddenField ID="hfModalState" runat="server" Value="0" />
    <asp:HiddenField ID="hfModalPosX" runat="server" />
    <asp:HiddenField ID="hfModalPosY" runat="server" />

    <!-- GridView -->
    <div class="government-gridview-container">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview government-gridview" EmptyDataText="No data available" Height="345px" Width="1635px">
            <Columns>
                <asp:BoundField DataField="AgeGroup" HeaderText="Age Group" />
                <asp:BoundField DataField="Male" HeaderText="Male" />
                <asp:BoundField DataField="Female" HeaderText="Female" />
            </Columns>
        </asp:GridView>
    </div>


    <asp:Label ID="Error" runat="server" Text="Label" CssClass="government-label" Visible="False"></asp:Label>


    <RowStyle BorderStyle="Solid" />

    <!-- Styles -->
    <style>
  
        .button5 {
            border-radius: 50%;
  background-color: #f4511e;
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  font-size: 16px;
  margin: 4px 2px;
  opacity: 0.6;
  transition: 0.3s;
  display: inline-block;
  text-decoration: none;
  cursor: pointer;
}

.button5:hover {opacity: 1}
        /* Style for modal dialog without the black shadow */
        .modal {
            display: none;
            position: fixed; /* Or 'absolute' if you prefer */
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%; /* Adjust or remove to prevent covering the whole screen */
            height: 100%; /* Adjust or remove to prevent covering the whole screen */
            background-color: transparent;
        }

        /* Updated Style for modal content */
        .modal-content {
            background-color: #f5f5f5; /* Adjusted background color */
            padding: 20px;
            border: 1px solid #ccc; /* Adjusted border color */
            width: 300px; /* Smaller width */
            position: absolute; /* Changed to absolute for positioning near the button */
            z-index: 10; /* Ensure it's above other content */
            display: flex;
            flex-direction: column; /* Stack elements vertically */
        }

        /* New style for the date selection group */
        .date-selection-group {
            display: flex;
            justify-content: space-between; /* Distribute space between the children */
        }

        .date-selection-group > div {
            flex: 1; /* Make each child take up equal space */
        }

        /* Style for close button */
        .close {
            color: #555;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        /* Government style for textboxes */
        .government-textbox {
            border: 1px solid #ccc;
            padding: 5px;
            font-size: 14px;
        }

        /* Government style for dropdowns */
        .government-dropdown {
            border: 1px solid #ccc;
            padding: 5px;
            font-size: 14px;
        }

        /* Government style for labels */
        .government-label {
            font-size: 14px;
            color: #555;
        }

        /* Government style for buttons */
        .government-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
        }

        .government-button:hover {
            background-color: #0056b3;
        }

        /* Government style for GridView */
        .government-gridview-container {
            width: 100%;
            overflow-x: auto;
        }

        .government-gridview {
            border-collapse: collapse;
            width: max-content; /* Adjust to your preference */
        }

        .government-gridview th,
        .government-gridview td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        .government-gridview th {
            background-color: #f2f2f2;
        }

        .government-gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .government-gridview tr:hover {
            background-color: #ddd;
        }
    </style>

    <!-- Scripts -->
    <script>
        var modal = document.getElementById('myModal');
        var btn = document.getElementById("btnOpenModal");
        var hfModalState = document.getElementById('<%= hfModalState.ClientID %>');

        // When the user clicks on the button, open the modal
        function openModal() {
            // Display the modal
            modal.style.display = "block";
            hfModalState.value = 1; // Indicate that the modal is open

            // Calculate and set the position only if the modal is not already positioned
            // This check is useful for postback scenarios
            var modalContent = document.querySelector('.modal-content');
            if (!modalContent.style.left || !modalContent.style.top) {
                // Get the button position
                var rect = btn.getBoundingClientRect();

                // Set modal position near the button, adjusting as necessary
                modalContent.style.top = (window.scrollY + rect.top) + "px"; // Adjust based on scroll and button position
                modalContent.style.left = (rect.right + 10) + "px"; // A little space from the button

                // Optionally, store these positions if you need to reapply them after postback
                document.getElementById('<%= hfModalPosX.ClientID %>').value = modalContent.style.left;
                document.getElementById('<%= hfModalPosY.ClientID %>').value = modalContent.style.top;
            } else {
                // Reapply positions after postback
                modalContent.style.left = document.getElementById('<%= hfModalPosX.ClientID %>').value;
                modalContent.style.top = document.getElementById('<%= hfModalPosY.ClientID %>').value;
            }
        }


        // When the user clicks on <span> (x), close the modal
        function closeModal() {
            modal.style.display = "none";
            hfModalState.value = 0; // Modal is closed
        }

        // Check the modal state on page load/refresh and show if needed
        // Check if the modal was open before and reopen it at the same position
        function adjustDateInputs() {
            var date1 = document.getElementById('<%= date1.ClientID %>');
            var date2 = document.getElementById('<%= date2.ClientID %>');

            // When date1 changes, update the min attribute of date2
            date1.onchange = function () {
                date2.setAttribute('min', date1.value);
            };

            // When date2 changes, update the max attribute of date1
            date2.onchange = function () {
                date1.setAttribute('max', date2.value);
            };
        }

        // Call adjustDateInputs on page load to ensure the functionality is set up
        window.onload = function () {
            adjustDateInputs();
            if (hfModalState.value == "1") {
                openModal(); // This will now reposition the modal correctly
            }
        };

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
    <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
</asp:Content>
