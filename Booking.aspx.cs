using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class Booking : System.Web.UI.Page
    {
        public decimal PricePerDay { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["car_id"] != null)
                {
                    int carId;
                    if (int.TryParse(Request.QueryString["car_id"], out carId))
                    {
                        LoadCarDetails(carId);
                    }
                    else
                    {
                        lblError.Text = "Invalid car selection.";
                        pnlBookingForm.Visible = false;
                    }
                }
                else
                {
                    lblError.Text = "No car selected.";
                    pnlBookingForm.Visible = false;
                }

                LoadDeals();
            }
        }

        private void LoadCarDetails(int carId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT brand, model, price_per_day FROM Cars WHERE car_id = @car_id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@car_id", carId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string brand = reader["brand"].ToString();
                    string model = reader["model"].ToString();
                    PricePerDay = Convert.ToDecimal(reader["price_per_day"]);

                    lblCarName.Text = brand + " " + model;
                    hfCarId.Value = carId.ToString();

                    // Store in hidden field for JavaScript
                    hfPricePerDay.Value = PricePerDay.ToString();
                }
                else
                {
                    lblError.Text = "Car not found.";
                    pnlBookingForm.Visible = false;
                }
            }
        }

        private void LoadDeals()
        {
            string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT deal_id, title, discount_percent, image_path FROM deals WHERE valid_until >= CAST(GETDATE() AS DATE)";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptDeals.DataSource = dt;
                rptDeals.DataBind();
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        string insertQuery = @"
                            INSERT INTO bookings (UserID, car_id, email, phone, start_date, end_date, addressCleint, delivery_time, deal_id, status)
                            VALUES (@UserID, @car_id, @Email, @Phone, @StartDate, @EndDate, @AddressClient, @DeliveryTime, @DealId, 'Pending')";

                        SqlCommand cmd = new SqlCommand(insertQuery, con);

                        if (Session["UserID"] == null)
                        {
                            lblError.Text = "Please log in before booking.";
                            return;
                        }

                        int currentUserId = Convert.ToInt32(Session["UserID"]);

                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        cmd.Parameters.AddWithValue("@car_id", Convert.ToInt32(hfCarId.Value));
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@StartDate", DateTime.Parse(txtStartDate.Text));
                        cmd.Parameters.AddWithValue("@EndDate", DateTime.Parse(txtEndDate.Text));
                        cmd.Parameters.AddWithValue("@AddressClient", txtDropOffLocation.Text.Trim());
                        cmd.Parameters.AddWithValue("@DeliveryTime", ddlDeliveryTime.SelectedValue);

                        int dealId = 0;
                        if (!string.IsNullOrEmpty(Request.Form["rdoDeal"]))
                        {
                            dealId = Convert.ToInt32(Request.Form["rdoDeal"]);
                            cmd.Parameters.AddWithValue("@DealId", dealId);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@DealId", DBNull.Value);
                        }

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    Response.Redirect("Payment.aspx");
                }
                catch (Exception ex)
                {
                    lblError.Text = "Booking failed: " + ex.Message;
                }
            }
        }
    }
}
