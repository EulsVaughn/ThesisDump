    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
    using System.Net.Http;
    using System.Threading.Tasks;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    namespace ThesisDump
    {
        public partial class AddCase : System.Web.UI.Page
        {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve username from cookie
                string uname = Request.Cookies["username"]?.Value;
                HandleVisibility();

                // Check if username exists
                if (!string.IsNullOrEmpty(uname))
                {
                    // Call PHP file to retrieve data and pass the username
                    string phpUrl = $"http://localhost:8080/GetData.php?username={HttpUtility.UrlEncode(uname)}";
                    await GetDataFromPHP(phpUrl);
                }
                else
                {
                    // Handle case where username is not found in cookie or is empty
        
                }
            }
        }

            private async Task GetDataFromPHP(string url)
            {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    HttpResponseMessage response = await client.GetAsync(url);
                    if (response.IsSuccessStatusCode)
                    {
                        string data = await response.Content.ReadAsStringAsync();

                        // Deserialize JSON data into a C# object
                        var jsonData = JsonConvert.DeserializeObject<Dictionary<string, List<Dictionary<string, string>>>>(data);
                        if (jsonData.ContainsKey("Officer") && jsonData["Officer"].Count > 0)
                        {
                            var officerData = jsonData["Officer"][0]; // Assuming Officer data is always at index 0
                            if (officerData.ContainsKey("Officer_ID"))
                            {
                                // Retrieve Officer_ID, Officer_FName, and Officer_LName
                                string officerId = officerData["Officer_ID"];
                                string officerFName = officerData["Officer_FName"];
                                string officerLName = officerData["Officer_LName"];
                                string officerFullname = officerFName + " " + officerLName;

                                // Set signed and handled TextBoxes to display Officer_ID
                                signed.Text = officerFullname;
                              
                                handled.Text = officerFullname;
                            
                                // You can use officerFName and officerLName as needed

                                // Bind data to dropdowns
                                //     BindDropDown(ddlCaseDesc, jsonData["CaseDescription"], "CaseDesc_ID", "CaseDesc_ID");
                                //       BindDropDown(ddlChild, jsonData["Child"], "Child_ID", "Child_ID");
                                //      BindDropDown(ddlFamily, jsonData["Family"], "Family_ID", "Family_ID");
                                BindDropDown(ddlAbuseType, jsonData["AbuseType"], "Abuse_ID", "Abuse_Type");


                                BindDropDown(chAddress, jsonData["Address"], "Address_ID", "address");

                                BindDropDown(momAddress, jsonData["Address"], "Address_ID", "address");

                                BindDropDown(dadAddress, jsonData["Address"], "Address_ID", "address");

                                BindDropDown(gaddress, jsonData["Address"], "Address_ID", "address");

                                BindDropDown(DropDownList1, jsonData["Status"], "Status_ID", "Status");
                            }
                 
                            else
                            {
                                // Handle HTTP error
                            }

                            
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
            }

      

        private void BindDropDown(DropDownList ddl, List<Dictionary<string, string>> data, string valueField, string textField)
            {
                ddl.Items.Clear(); // Clear existing items in the dropdown list

                // Iterate through data and add to dropdown list
                foreach (var record in data)
                {
                    // Add item to dropdown list
                    ddl.Items.Add(new ListItem(record[textField], record[valueField]));
                }
            }

        protected async void Button1_Click(object sender, EventArgs e)
        {
            await SendDataToServer();

        }


        private async Task SendDataToServer()
        {
            Debug.WriteLine("Sending data to server...");
            using (var client = new HttpClient())
            {
                var values = new Dictionary<string, string>
        {


            // Child information
            { "chlastname", chlastname.Text },
            { "cfirstname", cfirstname.Text },
            { "chmiddlename", chmiddlename.Text },
            { "chdob", chdob.Text }, // Assuming you have a field for Date of Birth
            { "DropDownListGen", DropDownListGen.SelectedValue },
            { "chindicatives", chindicatives.Text },
       
            { "chAddress", chAddress.Text },
            
            // Mother's information
            { "momfname", momfname.Text },
            { "momnum", momnum.Text },
            { "momemail", momemail.Text },
            { "momOccupation", momOccupation.Text },
            { "momMaritalStatus", momMaritalStatus.SelectedValue },

            // Father's information
            { "dadfname", dadfname.Text },
            { "dadnum", dadnum.Text },
            { "dademail", dademail.Text },
            { "dadoccupation", dadoccupation.Text },
            { "dadMaritalStatus", dadMaritalStatus.SelectedValue },

            // Guardian's information (if any, otherwise you need to adjust)
            { "gName", gName.Text },
            { "gnum", gnum.Text },
            { "gemail", gemail.Text },
            { "goccupation", goccupation.Text },
            { "gMaritalStatus", gMaritalStatus.SelectedValue },
             { "familydesc",familydesc.Text },
            // Additional fields for family description or addresses if you have them
            // {"familyDesc", familyDesc.Text} // Example


             {"DOR", DOR.Text },
            {"Record_Date", DOR.Text },
          //     signed.Text = officerId;
                { "officerId", signed.Text},

             { "ddlAbuseType", ddlAbuseType.SelectedValue},
             { "DropDownList1", DropDownList1.SelectedValue},
             {"casedesc",casedesc.Text },
             {"Resolution_Date", DORESO.Text },
             {"Action_Taken", action.Text },

            {"Services_Received", servicerec.Text},
            { "transactionDateTime", DOR.Text}

        

                // no PARENTS ADDRESS YET MAMAYA NALANG kasi wala rin sa database


            };



                var content = new FormUrlEncodedContent(values);

                var url = "http://localhost:8080/addcase1.php";

                var response = await client.PostAsync(url, content);

                Debug.WriteLine("Response status code: " + response.StatusCode);

                var responseString = await response.Content.ReadAsStringAsync();

                Debug.WriteLine("Response content: " + responseString);
            }
          
        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Call the method to handle visibility whenever the selected index of DropDownList1 changes
            HandleVisibility();
        }

        private void HandleVisibility()
        {
            string selectedValue = DropDownList1.SelectedValue;

            if (selectedValue == "STID_02") // ONGOING OPEN LANG ACTION
            {
                divActionsTaken.Visible = true;
                divActionsTaken1.Visible = true;
                divServicesReceived.Visible = false;
                divServicesReceived1.Visible = false;
          
            }
            else if (selectedValue == "STID_01") // RESOLVED SERVICES RECEIVED VIS
            {
                divActionsTaken.Visible = false;
                divActionsTaken1.Visible = false;
                divServicesReceived.Visible = true;
                divServicesReceived1.Visible = true;
       

            }
            else if (selectedValue == "STID_00" || selectedValue == "STID_03")
            {
                // Handle other cases if necessary
                divActionsTaken.Visible = false;
                divActionsTaken1.Visible = false;
                divServicesReceived.Visible = false;
                divServicesReceived1.Visible = false;
             
            }
     
        }


    }
}
