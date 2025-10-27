using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

namespace RentalCar2025
{
    public partial class BookingsFeedback : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check admin session or redirect
            if (Session["UserID"] == null || Session["Role"] == null || Convert.ToInt32(Session["Role"]) != 1)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBookings();
                LoadFeedback();
            }
        }

        private void LoadBookings()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        b.booking_id, u.Username, 
                        c.brand + ' ' + c.model AS car, 
                        b.start_date, b.end_date, b.status, 
                        p.amount AS payment_amount, b.email, b.phone
                    FROM bookings b
                    INNER JOIN Users u ON b.UserID = u.UserID
                    INNER JOIN Cars c ON b.car_id = c.car_id
                    LEFT JOIN payments p ON b.booking_id = p.booking_id
                    ORDER BY b.booking_id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBookings.DataSource = dt;
                gvBookings.DataBind();
            }
        }

        private void LoadFeedback()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        f.feedback_id, u.Username, f.rating, f.comment, f.submitted_on
                    FROM feedback f
                    INNER JOIN Users u ON f.UserID = u.UserID
                    ORDER BY f.submitted_on DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvFeedback.DataSource = dt;
                gvFeedback.DataBind();
            }
        }

        protected void gvBookings_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Cancel")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                string newStatus = e.CommandName == "Approve" ? "Approved" : "Cancelled";

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Update booking status
                    string updateQuery = "UPDATE bookings SET status = @status WHERE booking_id = @booking_id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@status", newStatus);
                        cmd.Parameters.AddWithValue("@booking_id", bookingId);
                        cmd.ExecuteNonQuery();
                    }

                    // Get user email for notification
                    string email = null;
                    string username = null;
                    string carName = null;
                    string startDate = null;
                    string endDate = null;

                    string selectQuery = @"
                        SELECT u.email, u.Username, c.brand + ' ' + c.model AS car, 
                               CONVERT(varchar, b.start_date, 23) AS start_date, 
                               CONVERT(varchar, b.end_date, 23) AS end_date
                        FROM bookings b
                        INNER JOIN Users u ON b.UserID = u.UserID
                        INNER JOIN Cars c ON b.car_id = c.car_id
                        WHERE b.booking_id = @booking_id";

                    using (SqlCommand cmd2 = new SqlCommand(selectQuery, conn))
                    {
                        cmd2.Parameters.AddWithValue("@booking_id", bookingId);
                        using (SqlDataReader reader = cmd2.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                email = reader["email"] != DBNull.Value ? reader["email"].ToString() : "";
                                username = reader["Username"].ToString();
                                carName = reader["car"].ToString();
                                startDate = reader["start_date"].ToString();
                                endDate = reader["end_date"].ToString();
                            }
                        }
                    }

                    if (!string.IsNullOrEmpty(email))
                    {
                        SendEmailNotification(email, username, carName, startDate, endDate, newStatus);
                    }
                }

                lblBookingMessage.Text = $"Booking ID {bookingId} has been {newStatus.ToLower()}.";
                LoadBookings();
            }
        }

        private void SendEmailNotification(string toEmail, string username, string car, string startDate, string endDate, string status)
        {
            try
            {
                string subject = $"Your booking has been {status}";
                string body = $@"
                    Dear {username},<br/><br/>
                    Your booking for the car <strong>{car}</strong> from <strong>{startDate}</strong> to <strong>{endDate}</strong> has been <strong>{status}</strong>.<br/><br/>
                    Thank you for using our rental service.<br/><br/>
                    Best regards,<br/>
                    RentalCar Team";

                MailMessage mail = new MailMessage();
                mail.To.Add(toEmail);
                mail.From = new MailAddress("no-reply@rentalcar.com");
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient();
                // Configure your SMTP client here (host, port, credentials)
                smtp.Host = "smtp.your-email-provider.com";
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("your-email@example.com", "your-email-password");
                smtp.EnableSsl = true;

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                // Log error or ignore email sending failure
            }
        }
    }
}
