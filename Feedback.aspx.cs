using System;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class Feedback : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect if user is not logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.CssClass = "message error";
            lblMessage.Text = "";

            int userId = Convert.ToInt32(Session["UserID"]);

            if (string.IsNullOrEmpty(ddlRating.SelectedValue))
            {
                lblMessage.Text = "Please select a rating between 1 and 5.";
                return;
            }

            if (!int.TryParse(ddlRating.SelectedValue, out int rating) || rating < 1 || rating > 5)
            {
                lblMessage.Text = "Invalid rating selected.";
                return;
            }

            string comment = txtComment.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string sql = @"INSERT INTO feedback (UserID, rating, comment) VALUES (@UserID, @rating, @comment)";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@rating", rating);
                    cmd.Parameters.AddWithValue("@comment", comment);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.CssClass = "message success";
                lblMessage.Text = "Thank you for your feedback!";

                // Clear form
                ddlRating.SelectedIndex = 0;
                txtComment.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "message error";
                lblMessage.Text = "Error submitting feedback: " + ex.Message;
            }
        }
    }
}
