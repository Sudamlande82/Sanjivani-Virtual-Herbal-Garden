using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class profile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["mobile_no"] != null)
        {
            lblmobile_no.Text = Session["mobile_no"].ToString();

            if (!IsPostBack)
            {
                BindUsername();
            }
        }
    }

    private void BindUsername()
    {
        try
        {
            SqlCommand com;
            string str;

            con.Open();
            str = "select id, full_name, email, mobile_no, password from reg where mobile_no='" + lblmobile_no.Text + "'";
            com = new SqlCommand(str, con);
            SqlDataReader rd = com.ExecuteReader();
            if (rd.Read())
            {
                txtname.Text = rd["full_name"].ToString();
                txtemail.Text = rd["email"].ToString();
                txtmobile.Text = rd["mobile_no"].ToString();
                txtpassword.Text = rd["password"].ToString();
                lblid.Text = rd["id"].ToString();

                lblusername.Text = rd["full_name"].ToString();
                lblemail.Text = rd["email"].ToString();
                lblphone.Text = rd["mobile_no"].ToString();
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

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        UpdateData();
    }

    private void UpdateData()
    {
        try
        {
            con.Open();

            string query = "UPDATE reg SET full_name=@full_name, email=@email, mobile_no=@mobile_no, password=@password WHERE id=@id";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@full_name", txtname.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@mobile_no", txtmobile.Text);
            cmd.Parameters.AddWithValue("@password", txtpassword.Text);
            cmd.Parameters.AddWithValue("@id", lblid.Text);

            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                // Refresh data
                BindUsername();
                Response.Write("<script>alert('Profile Updated Successfully');</script>");
            }
            else
            {
                Response.Write("<script>alert('Update Failed');</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
        }
        finally
        {
            con.Close();
        }
    }
}