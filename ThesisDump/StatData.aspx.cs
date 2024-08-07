using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI.WebControls;

namespace ThesisDump
{
    public partial class StatData : System.Web.UI.Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string uname = Request.Cookies["username"]?.Value;

                // Call the method to populate the dropdown list
                await PopulateDropDown();

                // Get the selected abuse ID from the dropdown list
                string selectedAbuseID = abuselist1.SelectedValue;

                if (!string.IsNullOrEmpty(selectedAbuseID))
                {
                    // Call the method to execute the PHP query with the selected abuse ID
                    await PopulateGridView(); // Populate GridView after selecting the abuse ID
                    Console.WriteLine($"Selected Abuse ID: {selectedAbuseID}");
                }

                if (!string.IsNullOrEmpty(uname))
                {
                    // Call PHP file to retrieve data and pass the username
                    string phpUrl = $"http://localhost:8080/GetData.php?username={HttpUtility.UrlEncode(uname)}";
                    await GetDataFromPHP(phpUrl);
                }
            }
        }



        private async Task PopulateDropDown()
        {
            try
            {
                string uname = Request.Cookies["username"]?.Value;
                if (!string.IsNullOrEmpty(uname))
                {
                    // Call PHP file to retrieve data and pass the username
                    string phpUrl = $"http://localhost:8080/GetData.php?username={HttpUtility.UrlEncode(uname)}";
                    using (HttpClient client = new HttpClient())
                    {
                        HttpResponseMessage response = await client.GetAsync(phpUrl);
                        if (response.IsSuccessStatusCode)
                        {
                            string data = await response.Content.ReadAsStringAsync();

                            // Deserialize JSON data into a C# object
                            var jsonData = JsonConvert.DeserializeObject<Dictionary<string, List<Dictionary<string, string>>>>(data);

                            // Bind the dropdown list
                            BindDropDown(abuselist1, jsonData["AbuseType"], "Abuse_ID", "Abuse_Type");
                        }
                        else
                        {
                            // Handle HTTP error
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }


        private async Task PopulateGridView()
        {
            string selectedAbuseID = abuselist1.SelectedValue;
            string selectedGender = genderlist.SelectedValue; // Get the selected gender value

            // Construct the URL with selected Abuse ID and Gender
            string phpScriptUrl = $"http://localhost:8080/StatsAbuseData.php?AbuseID={HttpUtility.UrlEncode(selectedAbuseID)}&Gender={HttpUtility.UrlEncode(selectedGender)}";

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    HttpResponseMessage response = await client.GetAsync(phpScriptUrl);
                    response.EnsureSuccessStatusCode();
                    string data = await response.Content.ReadAsStringAsync();

                    // Deserialize JSON data into a C# object
                    var jsonData = JsonConvert.DeserializeObject<dynamic>(data);
                    var dataList = jsonData.data;

                    // Create DataTable to hold the data
                    DataTable dt = new DataTable();

                    // Add columns to DataTable
                    dt.Columns.Add("AgeGroup", typeof(string));
                    dt.Columns.Add("Male", typeof(int));
                    dt.Columns.Add("Female", typeof(int));

                    // Add rows to DataTable
                    foreach (var item in dataList)
                    {
                        DataRow row = dt.NewRow();
                        row["AgeGroup"] = item.AgeGroup;

                        // Check if Male value is null, if null, assign default value (0)
                        row["Male"] = item.Male != null ? item.Male : 0;

                        // Check if Female value is null, if null, assign default value (0)
                        row["Female"] = item.Female != null ? item.Female : 0;

                        dt.Rows.Add(row);
                    }

                    // Bind DataTable to GridView
                    GridView1.DataSource = dt;

                    // Set visibility of columns based on selected gender
                    if (selectedGender == "All" || selectedGender == "")
                    {
                        GridView1.Columns[1].Visible = true; // Show Male column
                        GridView1.Columns[2].Visible = true; // Show Female column
                    }
                    else if (selectedGender == "1") // Male selected
                    {
                        GridView1.Columns[1].Visible = true; // Show Male column
                        GridView1.Columns[2].Visible = false; // Hide Female column
                    }
                    else if (selectedGender == "2") // Female selected
                    {
                        GridView1.Columns[1].Visible = false; // Hide Male column
                        GridView1.Columns[2].Visible = true; // Show Female column
                    }

                    GridView1.DataBind();
                }
                catch (HttpRequestException ex)
                {
                    // Handle HTTP request exception
                }
            }
        }











        public class AgeGroupInfo
        {
            public string AgeGroup { get; set; }
            public int? Male { get; set; }
            public int? Female { get; set; }
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
                        BindDropDown(abuselist1, jsonData["AbuseType"], "Abuse_ID", "Abuse_Type");
                    }
                    else
                    {
                        // Handle HTTP error
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

        protected async void abuselist_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedAbuseID = abuselist1.SelectedValue;

            // Call the method to execute the PHP query with the selected abuse ID

            await PopulateGridView();
            TextBox1.Text = selectedAbuseID;

        }
        protected async void genderlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Call the method to populate the GridView when the gender selection changes
            await PopulateGridView();
        }

    }
}
