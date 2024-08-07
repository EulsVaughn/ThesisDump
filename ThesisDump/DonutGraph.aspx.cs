using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Threading.Tasks;

namespace ThesisDump
{
    public partial class DonutGraph : System.Web.UI.Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the statusId query parameter is provided
                if (Request.QueryString["Status_ID"] != null)
                {
                    string statusId = Request.QueryString["Status_ID"];
                    await PopulateGridView(statusId);
                }
            }
        }

        private async Task PopulateGridView(string statusId)
        {
            try
            {
                string statusText = "";


                switch (statusId)
                {
                    case "STID_01":
                        statusText = "Resolved Cases";
                        break;
                    case "STID_02":
                        statusText = "Ongoing Cases";
                        break;
                    case "STID_03":
                        statusText = "Open Cases";
                        break;
                    default:
                        break;
                }

                // Set the label text
                Label1.Text = $"Cases with Status: {statusText}";
                // URL of the PHP script
                string phpScriptUrl = "http://localhost:8080/PopulateGridViewDonut.php";

                // Create an HttpClient instance
                using (HttpClient client = new HttpClient())
                {
                    // Prepare the data to be sent to the PHP script
                    var data = new Dictionary<string, string>
                    {
                        { "Status_ID", statusId }
                    };

                    // Encode the data
                    var content = new FormUrlEncodedContent(data);

                    // Send a POST request to the PHP script
                    var response = await client.PostAsync(phpScriptUrl, content);

                    // Check if the response is successful
                    if (response.IsSuccessStatusCode)
                    {
                        // Read the response content as a string
                        string jsonResponse = await response.Content.ReadAsStringAsync();

                        // Deserialize the JSON response to a DataTable
                        DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonResponse);

                        // Bind the DataTable to the GridView
                        GridViewCaseInfo.DataSource = dt;
                        GridViewCaseInfo.DataBind();
                    }
                    else
                    {
                        // Handle unsuccessful response
                        Response.Write("Failed to fetch data from PHP script.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Write($"An error occurred: {ex.Message}");
            }
        }
    }
}

