using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace ThesisDump
{
    public partial class LandingPage : System.Web.UI.Page
    {

        protected async void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack) // Ensure code only runs when the page is first loaded
            {
                if (Request.Cookies["username"] != null && Request.Cookies["role"] != null)
                {
                    // Read the username from the cookie
                    string username = Request.Cookies["username"].Value;
                    string userrole = Request.Cookies["role"].Value;

                    // Display the username
                    TextBox1.Text = username;
                    TextBox2.Text = userrole;

                     await LoadWelcomeMessage();
                }
                else
                {
                    // Redirect the user to the login page if the session is null
                    Response.Redirect("Login.aspx");
                }
            }


        }
        private async Task LoadWelcomeMessage()
        {
            // Check if the username is present in the query string
            if (Request.Cookies["username"] != null )
            {
                string userrole = Request.Cookies["role"].Value;
                string username = Request.Cookies["username"].Value;

                // Call the Welcome.php script and pass the username
                using (HttpClient client = new HttpClient())
                {
                    // Set the base address of your PHP server
                    client.BaseAddress = new Uri("http://localhost:8080/Welcome.php");

                    // Prepare the form data (username)
                    var formData = new FormUrlEncodedContent(new[]
                    {
                    new KeyValuePair<string, string>("username", username),
                        new KeyValuePair<string, string>("role", userrole)
                }); 

                    try
                    {
                        // Send the POST request to the PHP script
                        HttpResponseMessage response = await client.PostAsync("Welcome.php", formData);

                        // Check if the request was successful
                        if (response.IsSuccessStatusCode)
                        {
                            // Read the response content
                            string result = await response.Content.ReadAsStringAsync();

                            // Display the welcome message with the Officer's name
                            lblWelcomeMessage.Text = "Welcome, " + result + "!";
                        }
                        else
                        {
                            // Handle HTTP error
                            lblWelcomeMessage.Text = "Error: Unable to retrieve welcome message.";
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        lblWelcomeMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
            else
            {
                // Handle missing username in the query string
                lblWelcomeMessage.Text = "Error: Username not found in query string.";
            }
        }


        protected void btnDatabaseDisplay_Click(object sender, EventArgs e)
        {
            // Database displays all tables within the DB. To further iterate.
            Response.Redirect("DataB.aspx");
        }

        protected void btnDataStatistics_Click(object sender, EventArgs e)
        {



            if (Request.Cookies["username"] != null)
            {
                string username = Request.Cookies["username"].Value.ToString();

                TextBox1.Text = username;
                Response.Redirect($"DataVis.aspx");
            }
            else
            {
                TextBox1.Text = "Username not found";
            }




        }








        protected void Button1_Click(object sender, EventArgs e)
        {
            LogoutUser();
            Response.Redirect("Login.aspx");
        }

        protected void ClearCookie(string cookieName)
        {
            // Check if the cookie exists
            if (Request.Cookies[cookieName] != null)
            {
                // Clear the cookie by setting its expiration time to a past date
                HttpCookie cookie = new HttpCookie(cookieName);
                cookie.Expires = DateTime.Now.AddDays(-1); // Set expiration to past date
                Response.Cookies.Add(cookie);
            }
        }
        private void LogoutUser()
        {
            // Clear session variables and redirect to login page
            ClearCookie("username");



        }

        protected void btnRiskAssessment_Click(object sender, EventArgs e)
        {
            Response.Redirect("Analytics.aspx");
        }
    }
}




