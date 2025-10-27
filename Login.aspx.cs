using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace RentalCar2025
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnGoToRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connectionString = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, Role FROM [Users] WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int userId = reader.GetInt32(0);
                        int role = reader.GetInt32(1);

                        Session["UserID"] = userId;
                        Session["Username"] = username;
                        Session["Role"] = role;

                        if (role == 1)
                            Response.Redirect("AdminDashboard.aspx");
                        else if (role == 2)
                            Response.Redirect("ClientDashboard.aspx");
                        else
                            lblMessage.Text = "Unknown role.";
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password.";
                    }
                }
            }
        }
    }
}
