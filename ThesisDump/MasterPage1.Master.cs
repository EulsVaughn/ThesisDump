using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Web;

namespace ThesisDump
{
    public partial class MasterPage1 : System.Web.UI.MasterPage
    {
        protected override async void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            if (!IsPostBack)
            {
                // Check if the username and role are present in the cookies
                if (Request.Cookies["username"] != null && Request.Cookies["role"] != null)
                {
                    string uname = Request.Cookies["username"].Value.ToString();
                    string role = Request.Cookies["role"].Value.ToString(); // Fetch the role from the cookie

                    // Set AdminButton visibility based on the role
                    AdminButton.Visible = (role == "ADMIN");

                    using (HttpClient client = new HttpClient())
                    {
                        client.BaseAddress = new Uri("http://localhost:8080/Welcome.php");

                        var formData = new FormUrlEncodedContent(new[]
                        {
                    new KeyValuePair<string, string>("username", uname),
                    // Optionally, you can pass the role to your PHP script if needed
                    // new KeyValuePair<string, string>("role", role)
                });

                        try
                        {
                            HttpResponseMessage response = await client.PostAsync("Welcome.php", formData);

                            if (response.IsSuccessStatusCode)
                            {
                                string result = await response.Content.ReadAsStringAsync();

                                // Here you might also include the role in the welcome message, if appropriate
                                lblWelcomeMessage1.Text = "Welcome, " + result + " (" + role + ")!";
                            }
                            else
                            {
                                lblWelcomeMessage1.Text = "Error: Unable to retrieve welcome message.";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblWelcomeMessage1.Text = "Error: " + ex.Message;
                        }
                    }
                }
                else
                {
                    lblWelcomeMessage1.Text = "Error: Username not found in session.";
                    // If the role or username cookie doesn't exist, hide the AdminButton as a safety measure.
                    AdminButton.Visible = false;
                }
            }
        }




        protected void AccountSettingsLink_Click(object sender, EventArgs e)
        {
            // Redirect to the Account Settings page (EditUser.aspx) with the username query string parameter
            string username = Request.Cookies["username"].Value as string;
            if (!string.IsNullOrEmpty(username))
            {
                Response.Redirect($"EditUser.aspx");
            }
            else
            {
                // Handle the case where the username is not available in the session
                // You may redirect to a login page or display an error message
            }
        }

        protected void AddCase_Click(object sender, EventArgs e)
        {
            // Redirect to the Account Settings page (EditUser.aspx) with the username query string parameter
            string username = Request.Cookies["username"].Value as string;
            if (!string.IsNullOrEmpty(username))
            {
                Response.Redirect($"AddCase.aspx");
            }
            else
            {
                // Handle the case where the username is not available in the session
                // You may redirect to a login page or display an error message
            }
        }
        protected void ViewCase_Click(object sender, EventArgs e)
        {
            // Redirect to the Account Settings page (EditUser.aspx) with the username query string parameter
            string username = Request.Cookies["username"].Value as string;
            if (!string.IsNullOrEmpty(username))
            {
                Response.Redirect($"ViewCase.aspx");
            }
            else
            {
                // Handle the case where the username is not available in the session
                // You may redirect to a login page or display an error message
            }
        }
        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to the login page
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        protected void StatDataButton_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to the login page

            Response.Redirect("StatData.aspx");
        }

        protected void AdminSettingsLink_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to the login page

            Response.Redirect("Admin.aspx");
        }
        protected void HomeButton_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to the login page

            Response.Redirect("DataVis.aspx");
        }
    }
 
  

}


