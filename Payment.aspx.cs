using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class Payment : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        private int BookingId
        {
            get
            {
                if (ViewState["BookingId"] != null)
                    return (int)ViewState["BookingId"];
                return 0;
            }
            set { ViewState["BookingId"] = value; }
        }

        private int UserID
        {
            get
            {
                if (Session["UserID"] != null)
                    return Convert.ToInt32(Session["UserID"]);
                return 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserID == 0)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserBookings();

                if (int.TryParse(Request.QueryString["booking_id"], out int bookingId))
                {
                    BookingId = bookingId;
                    ShowBookingDetails(bookingId);
                }
                else
                {
                    pnlBookingDetails.Visible = false;
                }
            }
        }

        private void LoadUserBookings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT b.booking_id, c.brand + ' ' + c.model AS car_name,
                           b.start_date, b.end_date, b.status
                    FROM bookings b
                    INNER JOIN cars c ON b.car_id = c.car_id
                    WHERE b.UserID = @UserID
                    ORDER BY b.start_date DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error loading bookings: " + ex.Message;
                }
            }
        }

        protected void gvBookings_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteBooking")
            {
                int bookingToDelete = Convert.ToInt32(e.CommandArgument);
                DeleteBooking(bookingToDelete);
                LoadUserBookings();
                pnlBookingDetails.Visible = false;
                lblError.Text = "Booking deleted successfully.";
            }
        }

        private void DeleteBooking(int bookingToDelete)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlDeletePayments = "DELETE FROM payments WHERE booking_id = @booking_id";
                string sqlDeleteBooking = "DELETE FROM bookings WHERE booking_id = @booking_id";

                SqlCommand cmdPayments = new SqlCommand(sqlDeletePayments, conn);
                SqlCommand cmdBooking = new SqlCommand(sqlDeleteBooking, conn);

                cmdPayments.Parameters.AddWithValue("@booking_id", bookingToDelete);
                cmdBooking.Parameters.AddWithValue("@booking_id", bookingToDelete);

                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    cmdPayments.Transaction = transaction;
                    cmdBooking.Transaction = transaction;

                    cmdPayments.ExecuteNonQuery();
                    cmdBooking.ExecuteNonQuery();

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblError.Text = "Error deleting booking: " + ex.Message;
                }
            }
        }

        private void ShowBookingDetails(int bookingIdToShow)
        {
            lblError.Text = "";
            pnlBookingDetails.Visible = true;
            pnlSuccess.Visible = false;
            pnlPaymentForm.Visible = false;
            pnlEditBooking.Visible = false;
            btnEditToggle.Text = "Edit Booking";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT b.booking_id, b.start_date, b.end_date, b.status, b.UserID, b.car_id,
                           c.brand, c.model, c.price_per_day
                    FROM bookings b
                    INNER JOIN cars c ON b.car_id = c.car_id
                    WHERE b.booking_id = @booking_id AND b.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@booking_id", bookingIdToShow);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string status = reader["status"].ToString();

                    lblCarInfo.Text = $"Car: {reader["brand"]} {reader["model"]}";
                    DateTime startDate = Convert.ToDateTime(reader["start_date"]);
                    DateTime endDate = Convert.ToDateTime(reader["end_date"]);
                    lblBookingDates.Text = $"Booking Dates: {startDate:dd MMM yyyy} - {endDate:dd MMM yyyy}";

                    txtStartDateEdit.Text = startDate.ToString("yyyy-MM-dd");
                    txtEndDateEdit.Text = endDate.ToString("yyyy-MM-dd");

                    decimal pricePerDay = Convert.ToDecimal(reader["price_per_day"]);
                    int totalDays = (endDate - startDate).Days + 1;
                    decimal totalAmount = totalDays * pricePerDay;
                    txtAmount.Text = totalAmount.ToString("0.00");

                    if (status == "Paid")
                    {
                        pnlPaymentForm.Visible = false;
                        pnlSuccess.Visible = true;
                        btnEditToggle.Enabled = false;
                    }
                    else
                    {
                        pnlPaymentForm.Visible = true;
                        pnlSuccess.Visible = false;
                        btnEditToggle.Enabled = true;
                    }
                }
                else
                {
                    lblError.Text = "Booking not found or does not belong to you.";
                    pnlBookingDetails.Visible = false;
                }
                reader.Close();
            }
        }

        protected void btnEditToggle_Click(object sender, EventArgs e)
        {
            pnlEditBooking.Visible = !pnlEditBooking.Visible;

            btnEditToggle.Text = pnlEditBooking.Visible ? "Hide Edit Booking" : "Edit Booking";
            pnlPaymentForm.Visible = !pnlEditBooking.Visible;
            pnlSuccess.Visible = false;
        }

        protected void btnSaveBookingChanges_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (BookingId == 0)
            {
                lblError.Text = "No booking selected to update.";
                return;
            }

            if (!DateTime.TryParse(txtStartDateEdit.Text, out DateTime newStartDate))
            {
                lblError.Text = "Invalid Start Date.";
                return;
            }

            if (!DateTime.TryParse(txtEndDateEdit.Text, out DateTime newEndDate))
            {
                lblError.Text = "Invalid End Date.";
                return;
            }

            if (newEndDate < newStartDate)
            {
                lblError.Text = "End Date cannot be before Start Date.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlUpdateBooking = @"
                    UPDATE bookings 
                    SET start_date = @start_date, end_date = @end_date
                    WHERE booking_id = @booking_id AND UserID = @UserID AND status != 'Paid'";

                SqlCommand cmd = new SqlCommand(sqlUpdateBooking, conn);
                cmd.Parameters.AddWithValue("@start_date", newStartDate);
                cmd.Parameters.AddWithValue("@end_date", newEndDate);
                cmd.Parameters.AddWithValue("@booking_id", BookingId);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblError.Text = "Booking updated successfully.";
                        pnlEditBooking.Visible = false;
                        btnEditToggle.Text = "Edit Booking";
                        ShowBookingDetails(BookingId); // Reload details with updated info
                        LoadUserBookings(); // Refresh grid to show updated dates
                    }
                    else
                    {
                        lblError.Text = "Unable to update booking. It may be already paid or not found.";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error updating booking: " + ex.Message;
                }
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEditBooking.Visible = false;
            btnEditToggle.Text = "Edit Booking";
            pnlPaymentForm.Visible = true;
            lblError.Text = "";
            ShowBookingDetails(BookingId);
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (BookingId == 0)
            {
                lblError.Text = "No booking selected for payment.";
                return;
            }

            string paymentMethod = ddlPaymentMethod.SelectedValue;
            decimal amount;
            if (!decimal.TryParse(txtAmount.Text, out amount))
            {
                lblError.Text = "Invalid payment amount.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlInsertPayment = @"
                    INSERT INTO payments (booking_id, payment_method, amount, date_paid)
                    VALUES (@booking_id, @payment_method, @amount, GETDATE())";

                string sqlUpdateBooking = "UPDATE bookings SET status = 'Paid' WHERE booking_id = @booking_id";

                SqlCommand cmdInsert = new SqlCommand(sqlInsertPayment, conn);
                SqlCommand cmdUpdate = new SqlCommand(sqlUpdateBooking, conn);

                cmdInsert.Parameters.AddWithValue("@booking_id", BookingId);
                cmdInsert.Parameters.AddWithValue("@payment_method", paymentMethod);
                cmdInsert.Parameters.AddWithValue("@amount", amount);

                cmdUpdate.Parameters.AddWithValue("@booking_id", BookingId);

                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    cmdInsert.Transaction = transaction;
                    cmdUpdate.Transaction = transaction;

                    cmdInsert.ExecuteNonQuery();
                    cmdUpdate.ExecuteNonQuery();

                    transaction.Commit();

                    pnlPaymentForm.Visible = false;
                    pnlSuccess.Visible = true;
                    lblError.Text = "";

                    LoadUserBookings();  // Refresh grid
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblError.Text = "Payment failed: " + ex.Message;
                }
            }
        }
    }
}
