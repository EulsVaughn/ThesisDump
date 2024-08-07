using System;
using System.Web.UI.WebControls;
using System.Net;
using Newtonsoft.Json;
using System.Data;
using System.Collections.Generic;
using System.Web.UI;
using System.Text;

namespace ThesisDump
{
    public partial class ViewCase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call the PHP script to fetch JSON data
                string jsonUrl = "http://localhost:8080/viewcase.php";
                string jsonData = new WebClient().DownloadString(jsonUrl);

                // Deserialize JSON data into a list of dictionaries
                List<Dictionary<string, string>> dataList = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(jsonData);

                // Create a DataTable to store the data
                DataTable dataTable = new DataTable();

                // Add columns to the DataTable based on the keys in the JSON data
                foreach (var key in dataList[0].Keys)
                {
                    dataTable.Columns.Add(key);
                }

                // Add rows to the DataTable
                foreach (var item in dataList)
                {
                    DataRow row = dataTable.NewRow();
                    foreach (var key in item.Keys)
                    {
                        row[key] = item[key];
                    }
                    dataTable.Rows.Add(row);
                }

                // Bind the DataTable to the GridView
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }

        protected void DownloadButton_Click(object sender, EventArgs e)
        {
            // Redirect to the export.php file to initiate the download
            Response.Redirect("http://localhost:8080/export.php");
        }
        protected void AddButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCase.aspx");
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            // Perform search based on the text entered in the search box
            string searchText = SearchTextBox.Text.Trim().ToLower();

            // Filter the GridView based on the search text
            foreach (GridViewRow row in GridView1.Rows)
            {
                bool rowVisible = false;
                foreach (TableCell cell in row.Cells)
                {
                    if (cell.Text.ToLower().Contains(searchText))
                    {
                        rowVisible = true;
                        break;
                    }
                }
                row.Visible = rowVisible;
            }
        }
    }
}
