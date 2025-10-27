using System;
using System.Configuration;
using System.Data.SqlClient;

namespace RentalCar2025
{
    public partial class EditProfileAdmin : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdminDetails();
            }
        }

        private void LoadAdminDetails()
        {
            string username = Session["username"]?.ToString();

            if (string.IsNullOrEmpty(username))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT email, password, status FROM users WHERE username = @username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtUsername.Text = username;
                    txtEmail.Text = reader["email"].ToString();
                    txtPassword.Attributes["value"] = reader["password"].ToString();
                    ddlStatus.SelectedValue = reader["status"].ToString();
                }

                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string status = ddlStatus.SelectedValue;  // <-- Use string here

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE users SET email = @Email, password = @Password, status = @Status WHERE username = @Username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Profile updated successfully.";
                    lblMessage.Visible = true;
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error updating profile.";
                    lblMessage.Visible = true;
                }
            }
        }
    }
}
