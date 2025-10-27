using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace RentalCar2025
{
    public partial class Cart : System.Web.UI.Page
    {
        private readonly string _connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode("Cart.aspx"));
                    return;
                }
                LoadCart();
            }
        }

        private void LoadCart()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = @"
                SELECT c.car_id, c.brand, c.model, c.year, c.description, c.price_per_day, c.image_path
                FROM cart cart
                INNER JOIN cars c ON cart.car_id = c.car_id
                WHERE cart.UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                conn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    rptCart.DataSource = dr;
                    rptCart.DataBind();
                }
            }

            lblEmptyCart.Visible = (rptCart.Items.Count == 0);
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int car_id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Remove")
            {
                int UserID = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection conn = new SqlConnection(_connStr))
                using (SqlCommand cmd = new SqlCommand("DELETE FROM cart WHERE UserID = @UserID AND car_id = @CarID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", UserID);
                    cmd.Parameters.AddWithValue("@CarID", car_id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadCart(); // refresh list after removal
            }
            else if (e.CommandName == "BookNow")
            {
                // Direct to booking page with the selected car_id
                Response.Redirect("Booking.aspx?car_id=" + car_id);
            }
        }
    }
}

