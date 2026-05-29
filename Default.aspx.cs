using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnlogin_Click(object sender, EventArgs e)
    {

        try
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString))
            {
                con.Open();

                string query = "SELECT COUNT(*) FROM reg WHERE mobile_no=@mobile AND password=@password";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@mobile", mobile_no.Text);
                cmd.Parameters.AddWithValue("@password", password.Text);

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count > 0)
                {
                    Session["mobile_no"] = mobile_no.Text;

                    // Safe redirect (no thread abort)
                    Response.Redirect("user-dashboard.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    // Safe alert
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Invalid Username And Password Or Contact To Administrator');",
                        true
                    );
                }
            }
        }
        catch (Exception ex)
        {
            // Optional: log the exception
            string msg = ex.Message;
        }

        //try
        //{
        //    if (Regex.IsMatch(mobile_no.Text, @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}", RegexOptions.IgnoreCase))
        //    {
        //        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand("select * FROM reg WHERE mobile_no='" + mobile_no.Text + "' and password='" + password.Text + "'");
        //        cmd.Connection = con;
        //        int OBJ = Convert.ToInt32(cmd.ExecuteScalar());
        //        if (OBJ > 0)
        //        {
        //            Session["mobile_no"] = mobile_no.Text;
        //            Response.Redirect("user-dashboard.aspx");
        //        }
        //        else
        //        {
        //            Response.Write("<script> alert('Invalid Username And Password or Contact To Adminitrator'); </script>");

        //        }
        //    }
        //    else
        //    {
        //        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand("select * FROM reg WHERE mobile_no='" + mobile_no.Text + "' and password='" + password.Text + "'");
        //        cmd.Connection = con;
        //        int OBJ = Convert.ToInt32(cmd.ExecuteScalar());

        //        if (OBJ > 0)
        //        {
        //            Session["mobile_no"] = mobile_no.Text;
        //            Response.Redirect("user-dashboard.aspx");
        //        }
        //        else
        //        {
        //            Response.Write("<script> alert('Invalid Username And Password Or Contact To Administrator'); </script>");
        //        }
        //    }
        //}
        //catch (Exception e1)
        //{
        //    string msg = e1.Message;
        //}
        //finally
        //{
        //    con.Close();
        //}
    }
}