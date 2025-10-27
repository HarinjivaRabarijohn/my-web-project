using System;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedCars();
                LoadDeals();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();

            string query = "SELECT * FROM cars WHERE model LIKE @search OR brand LIKE @search OR CAST(year AS VARCHAR) LIKE @search";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@search", "%" + keyword + "%");
                conn.Open();
                rptCars.DataSource = cmd.ExecuteReader();
                rptCars.DataBind();
            }
        }

        private void LoadFeaturedCars()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString))
            {
                string query = "SELECT TOP 3 * FROM cars";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                rptCars.DataSource = cmd.ExecuteReader();
                rptCars.DataBind();
            }
        }

        private void LoadDeals()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString))
            {
                string query = "SELECT * FROM deals";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                rptDeals.DataSource = cmd.ExecuteReader();
                rptDeals.DataBind();
            }
        }
    }
}

