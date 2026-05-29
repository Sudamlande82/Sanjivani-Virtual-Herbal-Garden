using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_dashboard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["mobile_no"] != null)
        {
            lblmobile_no.Text = Session["mobile_no"].ToString();

            if (lblusername.Text != null)
            {
                BindUsername();
            }
            //Session.RemoveAll();
        }

        if (!IsPostBack)
        {
            BindListView();
        }
    }

    private void BindUsername()
    {
        try
        {
            SqlCommand com;
            string str;

            con.Open();
            str = "select full_name from reg where mobile_no='" + lblmobile_no.Text + "'";
            com = new SqlCommand(str, con);
            SqlDataReader rd = com.ExecuteReader();
            if (rd.Read())
            {
                lblusername.Text = rd["full_name"].ToString();
            }
        }
        catch (Exception e1)
        {
            //string message = e1.Message;
        }
        finally
        {
            con.Close();
        }
    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewCategory")
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("view_category.aspx?category_id=" + id);
        }
    }

    //protected void btnsearch_Click(object sender, EventArgs e)
    //{
    //    BindListView(txtsearch.Text.Trim());
    //}

    private void BindListView(string searchText = "")
    {
        string query = "SELECT id, category_name FROM herb_category";

        if (!string.IsNullOrEmpty(searchText))
        {
            query += " WHERE category_name LIKE @search";
        }

        SqlCommand cmd = new SqlCommand(query, con);
        if (!string.IsNullOrEmpty(searchText))
        {
            cmd.Parameters.AddWithValue("@search", "%" + searchText + "%");
        }

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        //ListView1.DataSource = dt;
        //ListView1.DataBind();
    }
}