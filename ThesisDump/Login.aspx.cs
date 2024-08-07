using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Web;
using System.Web.UI;

namespace ThesisDump
{
    public partial class Login : Page
    {
        protected async void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            using (HttpClient client = new HttpClient())
            {
                // Set the base address of your PHP server
                client.BaseAddress = new Uri("http://localhost:8080/Login.php");

                // Prepare the form data (username and password)
                var formData = new FormUrlEncodedContent(new[]
                {
            new KeyValuePair<string, string>("uname", username),
            new KeyValuePair<string, string>("pword", password)
        });

                try
                {
                    // Send the POST request to the PHP script
                    HttpResponseMessage response = await client.PostAsync("Login.php", formData);

                    // Check if the request was successful 
                    if (response.IsSuccessStatusCode)
                    {
                        // Read the response content
                        string result = await response.Content.ReadAsStringAsync();

                        // Parse the JSON response
                        dynamic jsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(result);

                        // Check the status in the response
                        string status = jsonResponse["status"];

                        // Check if login was successful
                        if (status == "OK")
                        {
                            string receivedUsername = jsonResponse["username"];
                            string userRole = jsonResponse["role"]; // Extract the user's role

                            // Create a cookie for the username
                            HttpCookie usernameCookie = new HttpCookie("username", receivedUsername);
                            usernameCookie.Expires = DateTime.Now.AddDays(1); // Cookie expiration time
                            Response.Cookies.Add(usernameCookie);

                            // Create a cookie for the role
                            HttpCookie roleCookie = new HttpCookie("role", userRole);
                            roleCookie.Expires = DateTime.Now.AddDays(1); // Set the same expiration time for consistency
                            Response.Cookies.Add(roleCookie);

                            // Redirect to the landing page
                            Response.Redirect("DataVis.aspx");
                        }
                        else
                        {
                            // Handle failed login (code remains the same as your initial implementation)
                        }
                    }
                    else
                    {
                        // Handle HTTP error (code remains the same as your initial implementation)
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions (code remains the same as your initial implementation)
                }
            }
        }


    }



}
