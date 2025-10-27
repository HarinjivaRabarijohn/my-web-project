using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in and is admin
            if (Session["UserID"] == null || Session["Role"] == null || Convert.ToInt32(Session["Role"]) != 1)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserCounts();
                LoadUsers();
            }
        }

        private void LoadUserCounts()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Count clients (role = 2)
                using (SqlCommand cmdClients = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 2", conn))
                {
                    lblClients.Text = cmdClients.ExecuteScalar().ToString();
                }

                // Count admins (role = 1)
                using (SqlCommand cmdAdmins = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 1", conn))
                {
                    lblAdmins.Text = cmdAdmins.ExecuteScalar().ToString();
                }
            }
        }

        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT UserID, Username, FullName, email, Role, status FROM Users ORDER BY UserID", conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int UserID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "UpgradeUser")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("UPDATE Users SET Role = 1 WHERE UserID = @id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", UserID);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadUserCounts();
                LoadUsers();
            }
            else if (e.CommandName == "ToggleStatus")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Get current status
                    string currentStatus = null;
                    using (SqlCommand cmdGet = new SqlCommand("SELECT status FROM Users WHERE UserID = @id", conn))
                    {
                        cmdGet.Parameters.AddWithValue("@id", UserID);
                        object result = cmdGet.ExecuteScalar();
                        currentStatus = result == DBNull.Value ? "Active" : (string)result;
                    }

                    // Toggle status
                    string newStatus = currentStatus == "Active" ? "Blocked" : "Active";

                    using (SqlCommand cmdUpdate = new SqlCommand("UPDATE Users SET status = @status WHERE UserID = @id", conn))
                    {
                        cmdUpdate.Parameters.AddWithValue("@status", newStatus);
                        cmdUpdate.Parameters.AddWithValue("@id", UserID);
                        cmdUpdate.ExecuteNonQuery();
                    }
                }
                LoadUserCounts();
                LoadUsers();
            }
            else if (e.CommandName == "DeleteUser")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmdDeleteFeedback = new SqlCommand("DELETE FROM feedback WHERE UserID = @id", conn))
                    {
                        cmdDeleteFeedback.Parameters.AddWithValue("@id", UserID);
                        cmdDeleteFeedback.ExecuteNonQuery();
                    }

                    // Delete related bookings
                    using (SqlCommand cmdDeleteBookings = new SqlCommand("DELETE FROM bookings WHERE UserID = @id", conn))
                    {
                        cmdDeleteBookings.Parameters.AddWithValue("@id", UserID);
                        cmdDeleteBookings.ExecuteNonQuery();
                    }

                    // Delete related cart items
                    using (SqlCommand cmdDeleteCart = new SqlCommand("DELETE FROM cart WHERE UserID = @id", conn))
                    {
                        cmdDeleteCart.Parameters.AddWithValue("@id", UserID);
                        cmdDeleteCart.ExecuteNonQuery();
                    }

                    // Now delete the user
                    using (SqlCommand cmdDeleteUser = new SqlCommand("DELETE FROM Users WHERE UserID = @id", conn))
                    {
                        cmdDeleteUser.Parameters.AddWithValue("@id", UserID);
                        cmdDeleteUser.ExecuteNonQuery();
                    }
                }
                LoadUserCounts();
                LoadUsers();
            }
        }

        protected void btnSearchUsers_Click(object sender, EventArgs e)
        {
            string searchText = txtSearchUsers.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = @"
                    SELECT UserID, Username, FullName, email, Role, status
                    FROM Users
                    WHERE (Username LIKE @search OR FullName LIKE @search OR email LIKE @search)
                    ORDER BY UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + searchText + "%");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearchUsers.Text = "";
            LoadUsers(); // Rebind full user list
        }
    }
}
