using System;

namespace RentalCar2025
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();

            // Optional: remove cookie if you use Forms Authentication, else remove below block
            /*
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var cookie = new System.Web.HttpCookie(".ASPXAUTH")
                {
                    Expires = DateTime.Now.AddDays(-1)
                };
                Response.Cookies.Add(cookie);
            }
            */
        }
    }
}
