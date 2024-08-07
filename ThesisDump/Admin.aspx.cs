using System;
using System.Net;
using System.Web.UI.WebControls;

namespace ThesisDump
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserDropdown();
                BindOfficerDropdown();
                HideUpdateAddControls();
            }
        }

        protected void btnLoadPhpContent_Click(object sender, EventArgs e)
        {
            LoadPhpContent();
            ShowUpdateAddControls();
            gvAuditTrail.Visible = false;
            iframePhpContent.Visible = true;
            updatePanel.Visible = true;
         //   update.Visible = true;
           // Add.Visible = true;
         //   adduser.Visible = true;
         //   officerid.Visible = true;
        //    role.Visible = true;
        //    password.Visible = true;
        }

        protected void lnkUpdate_Click(object sender, EventArgs e)
        {
            updatePanel.Visible = true;
            password.Visible = true;
            officerid.Visible = true;
            role.Visible = true;
            userupdate.Visible = true;
        //    TextBoxStatus.Visible = true;
            update.Visible = true;
            Add.Visible = false;
            adduser.Visible = false;
            Label1.Visible = true;
            Label2.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            password.Visible = true;
            officerid.Visible = true;
            role.Visible = true;
            adduser.Visible = true;
            userupdate.Visible = false;
            adduser.Text = "";
            password.Text = "";
            update.Visible = false;
            Add.Visible = true;
            Label1.Visible = true;
            Label2.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;
        }

        protected void userupdate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedUsername = userupdate.SelectedValue;
            PopulateUserData(selectedUsername);
        }

        private void BindUserDropdown()
        {
            string url = "http://localhost:8080/getusernames.php";
            try
            {
                WebClient client = new WebClient();
                string phpOutput = client.DownloadString(url);
                string[] usernames = phpOutput.Split(',');

                userupdate.Items.Clear();
                foreach (string username in usernames)
                {
                    userupdate.Items.Add(new ListItem(username));
                }
            }
            catch (Exception ex)
            {
                // Handle any errors
            }
        }

        private void LoadPhpContent()
        {
       //     TextBoxStatus.Text = "Loading PHP content...";
            string url = "http://localhost:8080/displayusers.php";

            try
            {
                iframePhpContent.Attributes["src"] = url;
             //   TextBoxStatus.Text = "";
            }
            catch (Exception ex)
            {
           //     TextBoxStatus.Text = "Error loading PHP content: " + ex.Message;
            }
        }

        private void PopulateUserData(string username)
        {
            string url = "http://localhost:8080/getuserdata.php?username=" + username;
            try
            {
                WebClient client = new WebClient();
                string phpOutput = client.DownloadString(url);
                string[] userData = phpOutput.Split(',');

                adduser.Text = userData[0];
                password.Text = userData[1];
                officerid.SelectedValue = userData[2];
                role.SelectedValue = userData[3];
            }
            catch (Exception ex)
            {
                TextBoxStatus.Text = "Error loading user data: " + ex.Message;
            }
        }

        private void HideUpdateAddControls()
        {
            lnkUpdate.Visible = false;
            lnkAdd.Visible = false;
            adduser.Visible = false;
            password.Visible = false;
            officerid.Visible = false;
            role.Visible = false;
            updatePanel.Visible = false;
            userupdate.Visible = false;
         //   TextBoxStatus.Visible = false;
        }

        private void BindOfficerDropdown()
        {
            string url = "http://localhost:8080/getofficerids.php";
            try
            {
                WebClient client = new WebClient();
                string phpOutput = client.DownloadString(url);
                string[] officerIDs = phpOutput.Split(',');

                officerid.Items.Clear();
                foreach (string id in officerIDs)
                {
                    officerid.Items.Add(new ListItem(id));
                }
            }
            catch (Exception ex)
            {

            }
        }

        private void ShowUpdateAddControls()
        {
            lnkUpdate.Visible = true;
            lnkAdd.Visible = true;
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            try
            {
                string username = adduser.Text;
                string password1 = password.Text;
                string officer_id = officerid.SelectedValue;
                string role1 = role.SelectedValue;

                string url = "http://localhost:8080/adduser.php?";
                url += "username=" + username + "&";
                url += "password=" + password1 + "&";
                url += "officer_id=" + officer_id + "&";
                url += "role=" + role1;

                WebClient client = new WebClient();

                string result = client.DownloadString(url);

               TextBoxStatus.Text = result;

                adduser.Text = "";
                password.Text = "";
                officerid.SelectedIndex = 0;
                role.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                TextBoxStatus.Text = "Error adding user: " + ex.Message;
            }
        }

        protected void update_Click(object sender, EventArgs e)
        {
            try
            {
                string username = adduser.Text;
                string password1 = password.Text;
                string officer_id = officerid.SelectedValue;
                string role1 = role.SelectedValue;

                string url = "http://localhost:8080/update.php?";
                url += "username=" + username + "&";
                url += "password=" + password1 + "&";
                url += "officer_id=" + officer_id + "&";
                url += "role=" + role1;

                WebClient client = new WebClient();

                string result = client.DownloadString(url);

                TextBoxStatus.Text = result;

                adduser.Text = "";
                password.Text = "";
                officerid.SelectedIndex = 0;
                role.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                TextBoxStatus.Text = "Error updating user: " + ex.Message;
            }
        }


        // Event handler for Audit Trail click
        protected void lnkAuditTrail_Click(object sender, EventArgs e)
        {
            // Hide the iframe and update panels
            iframePhpContent.Visible = false;
            updatePanel.Visible = false;
            update.Visible = false;
            Add.Visible = false;

            // Create a sample DataTable
            var dataTable = new System.Data.DataTable();
            dataTable.Columns.Add("Event");
            dataTable.Columns.Add("Date");

            // Add sample data
            dataTable.Rows.Add("Login: user1", DateTime.Now);
            dataTable.Rows.Add("Update Case 3 : user1", DateTime.Now.AddMinutes(10));
            dataTable.Rows.Add("Logout : user1", DateTime.Now.AddMinutes(20));

            // Bind the GridView with the DataTable
            gvAuditTrail.DataSource = dataTable;
            gvAuditTrail.DataBind();
               lnkUpdate.Visible = false;
            lnkAdd.Visible = false;
            // Show the GridView
            gvAuditTrail.Visible = true;
   
        }
    }


}


