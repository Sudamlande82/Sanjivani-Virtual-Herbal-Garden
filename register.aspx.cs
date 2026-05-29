using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnregister_Click(object sender, EventArgs e)
    {
        InsertData();
    }

    private void InsertData()
    {
        try
        {
            con.Open();
            string query = String.Format("insert into reg (full_name, email, mobile_no, password) values (@full_name, @email, @mobile_no, @password) select scope_identity();");
            SqlCommand cmd = new SqlCommand(query, con);

            //, , , 

            cmd.Parameters.AddWithValue("@full_name", txtfull_name.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@mobile_no", txtmobile.Text);
            cmd.Parameters.AddWithValue("@password", password.Text);

            cmd.ExecuteNonQuery();
        }
        catch (Exception e1)
        {
            string msg = e1.Message;
        }
        finally
        {
            con.Close();
            Response.Write("<script language = 'javascript'>window.alert('You are register..login now');window.location='Default.aspx';</script>");
        }
    }
}