using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select id, plant_name, category, description, use_of_plant, plant_image from plant", con);
        //SqlCommand cmd = new SqlCommand("SELECT id, fee_amount, date_of_received1, mode_of_payment, stud_name, stud_class_name, username, branch FROM accept_cash where (date_of_received1 between '" + txtfromdate.Text + "' and '" + txttodate.Text + "') and branch like '%" + cmbbranch.Text + "%' order by id desc", con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        list_plant.DataSource = ds;
        list_plant.DataBind();
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    private void BindData()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select id, plant_name, category, description, use_of_plant, plant_image from plant where plant_name like '%" + txtsearch.Text + "%'", con);
        //SqlCommand cmd = new SqlCommand("SELECT id, fee_amount, date_of_received1, mode_of_payment, stud_name, stud_class_name, username, branch FROM accept_cash where (date_of_received1 between '" + txtfromdate.Text + "' and '" + txttodate.Text + "') and branch like '%" + cmbbranch.Text + "%' order by id desc", con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        list_plant.DataSource = ds;
        list_plant.DataBind();
    }

    protected void lnkCategory_Command(object sender, CommandEventArgs e)
    {
        string category = e.CommandArgument.ToString();

        // Option 1: Filter data on same page
        list_plant.DataSourceID = null;

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SELECT * FROM plant WHERE category=@cat", con);
        cmd.Parameters.AddWithValue("@cat", category);

        con.Open();
        list_plant.DataSource = cmd.ExecuteReader();
        list_plant.DataBind();
        con.Close();
    }
}