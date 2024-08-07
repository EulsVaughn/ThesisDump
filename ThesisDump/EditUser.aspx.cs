using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThesisDump
{
    public partial class EditUser : System.Web.UI.Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the username from the cookie
                string username = Request.Cookies["username"]?.Value;

                if (!string.IsNullOrEmpty(username))
                {
                    // Call a method to fetch user information from the database
               //     await LoadUserInformation(username);

                }
                else
                {
                    // Handle the case where the username is not provided in the cookie
                    // You might want to redirect the user to the login page or display an error message
                }
            }
        }

        protected async void checkPasswordBtn_Click(object sender, EventArgs e)
        {
            // Retrieve the current password from the TextBox control
            TextBox currentPasswordTextBox = (TextBox)FindControl("currentPassword");

            if (currentPasswordTextBox != null)
            {
                string currentPassword = currentPasswordTextBox.Text;

                string username = Request.Cookies["username"]?.Value;
                string phpScriptUrl = "http://localhost:8080/CheckPassword.php";

                using (var client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
            {
                { "username", username },
                { "currentPassword", currentPassword }
            };

                    var content = new FormUrlEncodedContent(values);

                    try
                    {
                        var response = await client.PostAsync(phpScriptUrl, content);

                        if (response.IsSuccessStatusCode)
                        {
                            // Show the new password textbox if the current password is correct
                            newPasswordDiv.Style["display"] = "block";
                        }
                        else
                        {
                            // Display an error message
                            // You can handle different error scenarios here
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incorrect current password.');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exception
                    }
                }
            }
            else
            {
                // Handle the case where the TextBox control is not found
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Current password TextBox not found.');", true);
            }
        }







    }
}
