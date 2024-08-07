using Newtonsoft.Json;
using System;
using System.Data;
using System.Net;
using System.Web.UI.WebControls;

namespace ThesisDump
{
    public partial class DataB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call the PHP script
                string phpScriptUrl = "http://localhost:8080/DBView.php";
                string jsonData = CallPhpScript(phpScriptUrl);

                // Deserialize JSON data
                DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(jsonData);

                // Bind data to GridView
                foreach (DataTable table in dataSet.Tables)
                {
                    GridView gridView = new GridView();
                    gridView.DataSource = table;
                    gridView.DataBind();
                    form1.Controls.Add(gridView);
                }
            }
        }

        // Method to call the PHP script and retrieve JSON data
        private string CallPhpScript(string url)
        {
            string responseData = string.Empty;
            try
            {
                using (WebClient client = new WebClient())
                {
                    responseData = client.DownloadString(url);
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                responseData = ex.Message;
            }
            return responseData;
        }
    }
}

