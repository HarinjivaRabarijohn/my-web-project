using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace RentalCar2025
{
    public partial class EditProfile : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            // Assume UserID stored in Session after login
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = (int)Session["UserID"];

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = "SELECT Username, FullName, email, phone FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtUsername.Text = reader["Username"].ToString();
                        txtFullName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["email"] == DBNull.Value ? "" : reader["email"].ToString();
                        txtPhone.Text = reader["phone"] == DBNull.Value ? "" : reader["phone"].ToString();
                    }
                    else
                    {
                        ShowMessage("User not found.", false);
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = (int)Session["UserID"];

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Basic validation
            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowMessage("Full Name is required.", false);
                return;
            }

            if (!string.IsNullOrEmpty(password) || !string.IsNullOrEmpty(confirmPassword))
            {
                if (password != confirmPassword)
                {
                    ShowMessage("Passwords do not match.", false);
                    return;
                }
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql;
                SqlCommand cmd;

                if (!string.IsNullOrEmpty(password))
                {
                    // Update with password change (hash password before saving!)
                    // Here, example without hash for brevity — replace with proper hashing!
                    sql = @"UPDATE Users SET FullName = @FullName, email = @Email, phone = @Phone, Password = @Password WHERE UserID = @UserID";
                    cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@Password", password);
                }
                else
                {
                    // Update without password
                    sql = @"UPDATE Users SET FullName = @FullName, email = @Email, phone = @Phone WHERE UserID = @UserID";
                    cmd = new SqlCommand(sql, conn);
                }

                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", (object)email ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Phone", (object)phone ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@UserID", userId);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Profile updated successfully.", true);
                        ClearPasswordFields();
                    }
                    else
                    {
                        ShowMessage("Update failed. Please try again.", false);
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("An error occurred: " + ex.Message, false);
                }
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = success ? "message success-message" : "message error-message";
            lblMessage.Visible = true;
        }

        private void ClearPasswordFields()
        {
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
