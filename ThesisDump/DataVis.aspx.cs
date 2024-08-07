using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace ThesisDump
{
    public partial class DataVis : System.Web.UI.Page
    {
        // ViewState keys for storing status counts
        private const string ResolvedCountKey = "ResolvedCount";
        private const string OngoingCountKey = "OngoingCount";
        private const string OpenCountKey = "OpenCount";
        private const string MapCoordinatesKey = "MapCoordinates";

        protected int ResolvedCount
        {
            get { return ViewState[ResolvedCountKey] != null ? (int)ViewState[ResolvedCountKey] : 0; }
            set { ViewState[ResolvedCountKey] = value; }
        }

        protected int OngoingCount
        {
            get { return ViewState[OngoingCountKey] != null ? (int)ViewState[OngoingCountKey] : 0; }
            set { ViewState[OngoingCountKey] = value; }
        }

        protected int OpenCount
        {
            get { return ViewState[OpenCountKey] != null ? (int)ViewState[OpenCountKey] : 0; }
            set { ViewState[OpenCountKey] = value; }
        }
        protected List<Coordinate> MapCoordinates
        {
            get { return ViewState[MapCoordinatesKey] as List<Coordinate>; }
            set { ViewState[MapCoordinatesKey] = value; }
        }


        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                await RetrieveStatusCountsAsync();
                await FetchDataFromPHPAsync();
                await FetchDataFromPHPAsync();
                await FetchGenderData();
                await FetchAgeGroupDataAndDrawChart();
                //  await FetchWelfareRateData();


                //   await FetchWelfareRateData();
                //  await FetchMapDataFromPHPAsync();
            }
        }
        private async Task FetchAgeGroupDataAndDrawChart()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    string apiUrl = "http://localhost:8080/GenderAbuseData.php";

                    // Fetch data from the PHP API
                    HttpResponseMessage response = await client.GetAsync(apiUrl);

                    // Check if the response is successful
                    if (response.IsSuccessStatusCode)
                    {
                        // Read the response content as a string
                        string jsonResponse = await response.Content.ReadAsStringAsync();

                        // Deserialize JSON response to dynamic object
                        dynamic data = JsonConvert.DeserializeObject(jsonResponse);

                        // Check if the API call was successful
                        if (data.success == true)
                        {
                            // Get the age group data from the response
                            dynamic ageGroupData = data.data;

                            // Initialize a string to hold the JavaScript code
                            string script = "<script type='text/javascript'>" +
                                            "google.charts.load('current', { 'packages': ['corechart'] });" +
                                            "google.charts.setOnLoadCallback(drawAgeGroupChart);" +
                                            "function drawAgeGroupChart() {" +
                                            "var data = new google.visualization.DataTable();" +
                                            "data.addColumn('string', 'AgeGroup');" +
                                            "data.addColumn('number', 'Total');" +
                                            "data.addRows([";

                            // Iterate through the age group data and add rows to the chart data
                            foreach (var ageGroup in ageGroupData)
                            {
                                script += "['" + ageGroup.AgeGroup + "', " + ageGroup.Total + "],";
                            }

                            // Remove the trailing comma
                            script = script.TrimEnd(',') + "]);";

                            // Add chart drawing code with legend option
                            script += "var options = {" +
                                      "title: 'Age Group Totals'," +
                                      "width: '100%'," +
                                      "height: 400," +
                                      "legend: { position: 'none' }" + // This line removes the legend
                                      "};" +
                                      "var chart = new google.visualization.BarChart(document.getElementById('ageGroupChart'));" +
                                      "chart.draw(data, options);" +
                                      "}" +
                                      "</script>";

                            // Register the script block to the page
                            ClientScript.RegisterStartupScript(GetType(), "AgeGroupChartScript", script, false);
                        }
                        else
                        {
                            // Log an error if the API call was not successful
                            Console.WriteLine("Error: " + data.message);
                        }
                    }
                    else
                    {
                        // Log an error if the API call failed
                        Console.WriteLine("Error: " + response.StatusCode);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        private async Task RetrieveStatusCountsAsync()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    string phpScriptUrl = "http://localhost:8080/StatusCount.php";
                    HttpResponseMessage response = await client.GetAsync(phpScriptUrl);

                    if (response.IsSuccessStatusCode)
                    {
                        string jsonResponse = await response.Content.ReadAsStringAsync();
                        var counts = JsonConvert.DeserializeObject<dynamic>(jsonResponse);

                        // Assuming counts.ResolvedCount, counts.OngoingCount, and counts.OpenCount are retrieved from the database
                        ResolvedCount = counts.ResolvedCount;
                        OngoingCount = counts.OngoingCount;
                        OpenCount = counts.OpenCount;
                    }
                    else
                    {
                        Response.Write($"Failed to retrieve status counts. Status Code: {response.StatusCode}");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"An error occurred while retrieving status counts: {ex.Message}");
            }
        }

        private async Task FetchDataFromPHPAsync()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    string url = "http://localhost:8080/LocationCasesDisp.php";
                    HttpResponseMessage response = await client.GetAsync(url);

                    if (response.IsSuccessStatusCode)
                    {
                        string jsonResponse = await response.Content.ReadAsStringAsync();
                        List<DataItem> data = JsonConvert.DeserializeObject<List<DataItem>>(jsonResponse);

                        GridView1.DataSource = data;
                        GridView1.DataBind();
                    }
                    else
                    {
                        Response.Write("Failed to fetch data from PHP script.");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"An error occurred while fetching data: {ex.Message}");
            }
        }

        public class DataItem
        {
            public string Address { get; set; }
            public int Count { get; set; }
        }
        public class Coordinate
        {
            public string Name { get; set; }
            public double Latitude { get; set; }
            public double Longitude { get; set; }
        }

        // Method to fetch gender data from PHP script
        // Method to fetch gender data from PHP script
        protected async Task FetchGenderData()
        {
            try
            {
                // Call the PHP script to fetch gender counts asynchronously
                int maleCount = await GetGenderCountAsync("Male");
                int femaleCount = await GetGenderCountAsync("Female");

                // Set the values of hidden fields
                MaleCountHiddenField.Value = maleCount.ToString();
                FemaleCountHiddenField.Value = femaleCount.ToString();
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write($"An error occurred while fetching gender data: {ex.Message}");
            }
        }
        protected async Task<int> GetGenderCountAsync(string gender)
        {
            int count = 0;

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    string url = "http://localhost:8080/FetchGenderData.php"; // Replace with your actual PHP script URL
                    HttpResponseMessage response = await client.GetAsync(url);

                    if (response.IsSuccessStatusCode)
                    {
                        string jsonResponse = await response.Content.ReadAsStringAsync();



                        dynamic responseData = JsonConvert.DeserializeObject<dynamic>(jsonResponse);

                        // Check if the response contains the gender count
                        if (responseData != null && responseData[gender + "Count"] != null)
                        {
                            // Extract the count for the specified gender
                            count = responseData[gender + "Count"];

                            // Update the value of the corresponding hidden field
                            if (gender == "Male")
                            {
                                MaleCountHiddenField.Value = count.ToString();
                            }
                            else if (gender == "Female")
                            {
                                FemaleCountHiddenField.Value = count.ToString();
                            }
                        }
                        else
                        {
                            // Handle missing or invalid data in the response
                            throw new Exception($"Failed to retrieve {gender} count from PHP script.");
                        }
                    }
                    else
                    {
                        // Handle error response
                        throw new Exception($"Failed to fetch gender data from PHP script. Status Code: {response.StatusCode}");
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write($"An error occurred while fetching gender data: {ex.Message}");
                // You might want to throw the exception here to propagate it to the caller
                // throw;
            }

            return count;
        }



        protected async void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridView1.PageIndex = e.NewPageIndex;
                await FetchDataFromPHPAsync();
            }
            catch (Exception ex)
            {
                Response.Write($"An error occurred: {ex.Message}");
            }
        }



    }
}













