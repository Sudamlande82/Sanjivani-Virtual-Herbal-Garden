using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString["category_id"];
            GetCategoryDetails(id);
        }
    }

    private void GetCategoryDetails(string id)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("SELECT category_name FROM herb_category WHERE id=@id", con);
        cmd.Parameters.AddWithValue("@id", id);

        object result = cmd.ExecuteScalar();

        if (result != null)
        {
            lblCategory.Text = "Category Name: " + result.ToString();
        }

        con.Close();
    }
}