    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net.Http;
    using System.Threading.Tasks;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    namespace ThesisDump
    {
        public partial class SpecificCase : System.Web.UI.Page
        {
        protected void Page_Load(object sender, EventArgs e)
        {
            string uname = Request.Cookies["username"]?.Value;
            if (!IsPostBack)
            {
                string caseID = Request.QueryString["Case_ID"];

                // Call SpecificCase.php
                string getDataUrl = $"http://localhost:8080/GetData.php?username={HttpUtility.UrlEncode(uname)}";
                Task.Run(() => GetDataFromPHP(getDataUrl)).Wait();

                // Call SpecificCase.php after populating additional data
                string specificCaseUrl = $"http://localhost:8080/SpecificCase.php?username={HttpUtility.UrlEncode(uname)}&Case_ID={HttpUtility.UrlEncode(caseID)}";
                Task.Run(() => GetSpecificCaseData(specificCaseUrl)).Wait();
                caseno.Text = caseID;

                // Check if the session variable for case update success is true and show the alert if needed
                if (Session["CaseUpdateSuccess"] != null && (bool)Session["CaseUpdateSuccess"])
                {
                    string script = "alert('Case updated successfully.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

                    // Reset the session variable
                    Session["CaseUpdateSuccess"] = false;
                }
            }
        }



        // Get data from php will populate only the labels and some textbox along with selecting the values on the textbox. 
        // the bind dropdown should populate only the dropdowns
        // start again in this module maybe start by going to populate the dropdowns first.


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
                        var jsonData = JsonConvert.DeserializeObject<Dictionary<string, object>>(data);



                    
                            // Here, you convert the object to the expected List<Dictionary<string, string>> using JsonConvert on each specific item.
                            // You need to ensure the JSON structure matches what you're deserializing into.

                            if (jsonData.ContainsKey("AbuseType"))
                            {
                                var abuseTypeData = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(jsonData["AbuseType"].ToString());
                                BindDropDown1(ddlAbuseType, abuseTypeData, "Abuse_ID", "Abuse_Type");
                            }

                            // Repeat this pattern for each dropdown that needs populating.
                            if (jsonData.ContainsKey("Address"))
                            {
                                var addressData = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(jsonData["Address"].ToString());
                                BindDropDown1(chAddress, addressData, "Address_ID", "address");
                                BindDropDown1(momAddress, addressData, "Address_ID", "address");
                                BindDropDown1(dadAddress, addressData, "Address_ID", "address");
                                BindDropDown1(gaddress, addressData, "Address_ID", "address");
                            }

                            if (jsonData.ContainsKey("Status"))
                            {
                                var statusData = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(jsonData["Status"].ToString());
                                BindDropDown1(DropDownList3, statusData, "Status_ID", "Status");
                            }

                        }
                    }
                
            }
            catch (Exception ex)
            {
                // Ideally, log the exception or handle it as necessary.
            }
        }

        // Function to fetch data from a specific case
        private async Task GetSpecificCaseData(string url)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    HttpResponseMessage response = await client.GetAsync(url);
                    if (response.IsSuccessStatusCode)
                    {
                        string data = await response.Content.ReadAsStringAsync();
                        var jsonData = JsonConvert.DeserializeObject<Dictionary<string, object>>(data);

                        // Check if the data contains the specific case information
                        if (jsonData.ContainsKey("Data"))
                        {
                            var dataSection = JsonConvert.DeserializeObject<Dictionary<string, object>>(jsonData["Data"].ToString());

                            // Now proceed with your previous logic, checking inside "dataSection" for "SpecificCase"
                            if (dataSection.ContainsKey("SpecificCase"))
                            {
                                var specificCaseData = JsonConvert.DeserializeObject<Dictionary<string, string>>(dataSection["SpecificCase"].ToString());

                                // Example: Update a textbox with the child's last name
                                chlastname.Text = specificCaseData["Child_LName"];
                                cfirstname.Text = specificCaseData["Child_FName"];

                                string childname = specificCaseData["Child_FName"] + " " + specificCaseData["Child_LName"];
                                chmiddlename.Text = specificCaseData["Child_MName"];

                                chdob.Text = specificCaseData["Birthdate"];

                                chindicatives.Text = specificCaseData["Indicatives"];

                                momfname.Text = specificCaseData["Mother_Name"];
                                momnum.Text = specificCaseData["Mother_CNum"];
                                momemail.Text = specificCaseData["Mother_Email"];
                                momOccupation.Text = specificCaseData["Mother_Occupation"];
                                dadfname.Text = specificCaseData["Father_Name"];
                                dadnum.Text = specificCaseData["Father_CNum"];
                                dademail.Text = specificCaseData["Father_Email"];
                                dadoccupation.Text = specificCaseData["Father_Occupation"];
                                gName.Text = specificCaseData["Guardian_Name"];
                                gnum.Text = specificCaseData["Guardian_CNum"];

                                gemail.Text = specificCaseData["Guardian_Email"];
                                goccupation.Text = specificCaseData["Guardian_Occupation"];
                                servicerec.Text = specificCaseData["Services_Received"];
                                action.Text = specificCaseData["Action_Taken"];
                                familydesc.Text = specificCaseData["Family_Desc"];
                                string officername = specificCaseData["Officer_FName"] + " " + specificCaseData["Officer_LName"];
                                signed.Text = officername;
                                handled.Text = specificCaseData["Officer_ID"]; 
                             //   handled.Text = officername;
                                casedesc.Text = specificCaseData["Case_Desc"];
                                DOR.Text = specificCaseData["Record_Date"];
                                DORESO.Text = specificCaseData["Resolution_Date"];
                                DropDownListGen.SelectedValue = specificCaseData["Gender"];
                                DropDownListEduc.SelectedValue = specificCaseData["Education_bg"];
                                momMaritalStatus.SelectedValue = specificCaseData["Mother_MariStat"];
                                dadMaritalStatus.SelectedValue = specificCaseData["Father_MariStat"];
                                gMaritalStatus.SelectedValue = specificCaseData["Guardian_MariStat"];

                             toa.Text = specificCaseData["Abuse_Type"];
                                cname.Text = childname;
                                child.Text = childname;
                                status.Text = specificCaseData["Status"];
                                DOR1.Text = specificCaseData["Record_Date"];
                                gen.Text = specificCaseData["Gender"];
                                handle.Text = officername;


                                // Find the status item in DropDownList3
                                ListItem statusItem = DropDownList3.Items.FindByValue(specificCaseData["Status_ID"]);
                                if (statusItem != null)
                                {
                                    // Set the status item as selected
                                    statusItem.Selected = true;
                                }
                                ListItem chaddressitem =  chAddress.Items.FindByValue(specificCaseData["Address_ID"]);
                                if (chaddressitem != null)
                                {
                                    // Set the status item as selected
                                    chaddressitem.Selected = true;
                                }

                                ListItem abuseitem = ddlAbuseType.Items.FindByValue(specificCaseData["Abuse_ID"]);
                                if (abuseitem != null)
                                {
                                    // Set the status item as selected
                                    abuseitem.Selected = true;
                                }


                                // Continue populating other fields as needed
                                // Make sure to check for null or handle exceptions as necessary
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions, possibly log them
            }
        }
        private void DisableTextboxes()
        {
            chlastname.Enabled = false;
            cfirstname.Enabled = false;
            chmiddlename.Enabled = false;
            chdob.Enabled = false;
            DropDownListGen.Enabled = false;
            chindicatives.Enabled = false;
            DropDownListEduc.Enabled = false;
            chAddress.Enabled = false;
            familydesc.Enabled = false;
            momfname.Enabled = false;
            momnum.Enabled = false;
            momemail.Enabled = false;
            momOccupation.Enabled = false;
            momMaritalStatus.Enabled = false;
            momAddress.Enabled = false;
            dadfname.Enabled = false;
            dadnum.Enabled = false;
            dademail.Enabled = false;
            dadoccupation.Enabled = false;
            dadMaritalStatus.Enabled = false;
            dadAddress.Enabled = false;
            gName.Enabled = false;
            gnum.Enabled = false;
            gemail.Enabled = false;
            goccupation.Enabled = false;
            gMaritalStatus.Enabled = false;
            gaddress.Enabled = false;
            DropDownList3.Enabled = false;
            ddlAbuseType.Enabled = false;
            casedesc.Enabled = false;
            action.Enabled = false;
            servicerec.Enabled = false;
            DOR.Enabled = false;
            DORESO.Enabled = false;

            // Toggle the text of the button
            editcase.Text = "Edit";

            // Optionally, toggle the visibility of the Update button
            // Assuming you have an Update button with ID="updateButton"
            update.Visible = false;

        }

        protected async void updatecase_Click(object sender, EventArgs e)
        {


            // Since caseID needs to be a string in the URL, convert the integer back to a string



            string caseID = caseno.Text;
            string childLName = chlastname.Text;
            string childFName = cfirstname.Text;
            string childMName = chmiddlename.Text;
            string birthdate = chdob.Text;
            string gender = DropDownListGen.SelectedValue;
            string indicatives = chindicatives.Text;
            string educationBg = DropDownListEduc.SelectedValue;
            string addressID = chAddress.SelectedValue;

            string momFName = momfname.Text;
            string momNum = momnum.Text;
            string momEmail = momemail.Text;
            string momOccupation1 = momOccupation.Text;
            string momMaritalStatus1 = momMaritalStatus.SelectedValue;

            string dadFName = dadfname.Text;
            string dadNum = dadnum.Text;
            string dadEmail = dademail.Text;
            string dadOccupation = dadoccupation.Text;
            string dadMaritalStatus1 = dadMaritalStatus.SelectedValue;

            string guardianName = gName.Text;
            string guardianNum = gnum.Text;
            string guardianEmail = gemail.Text;
            string guardianOccupation = goccupation.Text;
            string guardianMaritalStatus = gMaritalStatus.SelectedValue;
            string familydesc1 = familydesc.Text;

            string abuseType = ddlAbuseType.SelectedValue;
            string officerId = handled.Text; // You need to get the Officer ID from somewhere in your application
            string caseStatus = DropDownList3.SelectedValue;
            string dateOfReport = DOR.Text;
            string caseDesc = casedesc.Text;
            string resolutionDate = DORESO.Text; // Update this line
            string actionTaken = action.Text; // Update this line
            string servicesReceived = servicerec.Text; // Update this line
            string transactionDateTime = DOR.Text;

            // Prepare the URL with query parameters
            string baseUrl = "http://localhost:8080/UpdateCase.php";
            string urlParams = $"?Case_ID={caseID}&Child_LName={childLName}&Child_FName={childFName}&Child_MName={childMName}&Birthdate={birthdate}&DropDownListGen={gender}&Indicatives={indicatives}&DropDownListEduc={educationBg}&Address_ID={addressID}&momfname={momFName}&momnum={momNum}&momemail={momEmail}&momOccupation={momOccupation1}&momMaritalStatus={momMaritalStatus1}&dadfname={dadFName}&dadnum={dadNum}&dademail={dadEmail}&dadoccupation={dadOccupation}&dadMaritalStatus={dadMaritalStatus1}&gName={guardianName}&gnum={guardianNum}&gemail={guardianEmail}&goccupation={guardianOccupation}&gMaritalStatus={guardianMaritalStatus}&familydesc={familydesc1}&ddlAbuseType={abuseType}&officerId={officerId}&DropDownList1={caseStatus}&DOR={dateOfReport}&casedesc={caseDesc}&Resolution_Date={resolutionDate}&Action_Taken={actionTaken}&Services_Received={servicesReceived}&transactionDateTime={transactionDateTime}&Record_Date={dateOfReport}";



            // Send the request to the PHP endpoint using HttpClient
            using (var client = new HttpClient())
            {
                var response = await client.GetAsync(baseUrl + urlParams);
                var responseString = await response.Content.ReadAsStringAsync();


                string script = "";

                // Display the response message in an alert
                string message = "";
                if (response.IsSuccessStatusCode)
                {
                    message = "Case updated successfully.";
                    Session["CaseUpdateSuccess"] = true; // Set session variable to indicate success
                }
                else
                {
                    message = "Failed to update case. Please try again later.";
                }

                // Construct the JavaScript alert
                string script1 = $"alert('{message}');";

                // Register the script for execution
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script1, true);

                // Disable textboxes if case is updated successfully
                if (response.IsSuccessStatusCode)
                {
                    DisableTextboxes();
                }
            }
        }




        protected void editcase_Click(object sender, EventArgs e)
        {
            // Toggle between enabling and disabling the controls
            bool enableEditing = editcase.Text == "Edit";
            chlastname.Enabled = enableEditing;
            cfirstname.Enabled = enableEditing;
            chmiddlename.Enabled = enableEditing;
            chdob.Enabled = enableEditing;
            DropDownListGen.Enabled = enableEditing;
            chindicatives.Enabled = enableEditing;
            DropDownListEduc.Enabled = enableEditing;
            chAddress.Enabled = enableEditing;
            familydesc.Enabled = enableEditing;
            momfname.Enabled = enableEditing;
            momnum.Enabled = enableEditing;
            momemail.Enabled = enableEditing;
            momOccupation.Enabled = enableEditing;
            momMaritalStatus.Enabled = enableEditing;
            momAddress.Enabled = enableEditing;
            dadfname.Enabled = enableEditing;
            dadnum.Enabled = enableEditing;
            dademail.Enabled = enableEditing;
            dadoccupation.Enabled = enableEditing;
            dadMaritalStatus.Enabled = enableEditing;
            dadAddress.Enabled = enableEditing;
            gName.Enabled = enableEditing;
            gnum.Enabled = enableEditing;
            gemail.Enabled = enableEditing;
            goccupation.Enabled = enableEditing;
            gMaritalStatus.Enabled = enableEditing;
            gaddress.Enabled = enableEditing;
            DropDownList3.Enabled = enableEditing;
            ddlAbuseType.Enabled = enableEditing;
            casedesc.Enabled = enableEditing;
            action.Enabled = enableEditing;
            servicerec.Enabled = enableEditing;
            DOR.Enabled = enableEditing;
            DORESO.Enabled = enableEditing;
            // Toggle the text of the button
            editcase.Text = enableEditing ? "Cancel editing" : "Edit";

            // Optionally, toggle the visibility of the Update button
            // Assuming you have an Update button with ID="updateButton"
            update.Visible = enableEditing;
        }

        protected void DLCase_Click(object sender, EventArgs e)
            {
                string caseID1 = Request.QueryString["Case_ID"];
                // Get the Case_ID from the existing case data
           

                // Redirect to DownloadCase.php with the Case_ID parameter
                Response.Redirect($"http://localhost:8080/SpecificCaseDL.php?Case_ID={HttpUtility.UrlEncode(caseID1)}");
            }
        private void BindDropDown1(DropDownList ddl, List<Dictionary<string, string>> data, string valueField, string textField)
        {
            ddl.Items.Clear(); // Clear existing items in the dropdown list

            // Iterate through data and add to dropdown list
            foreach (var record in data)
            {
                // Add item to dropdown list
                ddl.Items.Add(new ListItem(record[textField], record[valueField]));
            }
        }



    }
}