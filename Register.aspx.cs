using System;
using System.Configuration;
using System.Data.SqlClient;

namespace RentalCar2025
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string selectedRole = ddlRole.SelectedValue;

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }
            int Role = 0;
            if (selectedRole == "Admin")
                Role = 1;
            else if (selectedRole == "Client")
                Role = 2;
            else
            {
                lblMessage.Text = "Please select a valid role.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
            string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Users (FullName, Username, Password, Role) VALUES (@FullName, @Username, @Password, @Role)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password); 
                cmd.Parameters.AddWithValue("@Role", Role);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Registration successful!";
                    ClearFields();
                    Response.Redirect("Login.aspx");
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        private void ClearFields()
        {
            txtFullName.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlRole.SelectedIndex = 0;
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
