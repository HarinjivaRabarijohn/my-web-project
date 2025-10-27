using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace RentalCar2025
{
    public partial class AdvancedSearch : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["CarRentalDB1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlSort.SelectedValue = "price_asc"; // default sort
                LoadData();
            }
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadData(txtSearch.Text.Trim());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(txtSearch.Text.Trim());
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadData(txtSearch.Text.Trim());
        }

        private void LoadData(string searchFilter = "")
        {
            string sortOption = ddlSort.SelectedValue;
            string carsOrderBy = "price_per_day ASC"; 
            string dealsOrderBy = "discount_percent ASC"; 

            switch (sortOption)
            {
                case "price_asc":
                    carsOrderBy = "price_per_day ASC";
                    dealsOrderBy = "discount_percent ASC";
                    break;
                case "price_desc":
                    carsOrderBy = "price_per_day DESC";
                    dealsOrderBy = "discount_percent DESC";
                    break;
                case "brand_asc":
                    carsOrderBy = "brand ASC, model ASC";
                    dealsOrderBy = "title ASC";
                    break;
                case "brand_desc":
                    carsOrderBy = "brand DESC, model DESC";
                    dealsOrderBy = "title DESC";
                    break;
                default:
                    carsOrderBy = "price_per_day ASC";
                    dealsOrderBy = "discount_percent ASC";
                    break;
            }

            LoadCars(carsOrderBy, searchFilter);
            LoadDeals(dealsOrderBy, searchFilter);
        }

        private void LoadCars(string orderBy, string filter)
        {
            string sqlCars = @"
                SELECT car_id, brand, model, year, description, price_per_day, image_path
                FROM Cars
                WHERE (@filter = '' OR brand LIKE '%' + @filter + '%' OR model LIKE '%' + @filter + '%')
                ORDER BY " + orderBy;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(sqlCars, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@filter", filter);
                DataTable dtCars = new DataTable();
                da.Fill(dtCars);
                gvCars.DataSource = dtCars;
                gvCars.DataBind();
            }
        }

        private void LoadDeals(string orderBy, string filter)
        {
            string sqlDeals = @"
                SELECT d.deal_id, d.title, d.description, d.discount_percent, d.valid_until, d.image_path,
                       c.brand, c.model
                FROM deals d
                LEFT JOIN Cars c ON d.car_id = c.car_id
                WHERE (@filter = '' OR d.title LIKE '%' + @filter + '%' OR c.brand LIKE '%' + @filter + '%' OR c.model LIKE '%' + @filter + '%')
                ORDER BY " + orderBy;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(sqlDeals, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@filter", filter);
                DataTable dtDeals = new DataTable();
                da.Fill(dtDeals);
                gvDeals.DataSource = dtDeals;
                gvDeals.DataBind();
            }
        }
    }
}
