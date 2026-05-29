using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class contact : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_Click(object sender, EventArgs e)
    {
        InsertData();
    }

    private void InsertData()
    {
        try
        {
            con.Open();
            string query = String.Format("insert into feedback (name, email, msg) values (@name, @email, @msg) select scope_identity();");
            SqlCommand cmd = new SqlCommand(query, con);

            //, , , 

            cmd.Parameters.AddWithValue("@name", txtname.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@msg", txtmsg.Text);

            cmd.ExecuteNonQuery();
        }
        catch (Exception e1)
        {
            string msg = e1.Message;
        }
        finally
        {
            con.Close();
            Response.Write("<script language = 'javascript'>window.alert('Feedback Added..');window.location='contact.aspx';</script>");
        }
    }

    protected void btnsubmit_suggestion_Click(object sender, EventArgs e)
    {
        try
        {
            con.Open();
            string query = String.Format("insert into suggest (suggest_desc) values (@suggest_desc) select scope_identity();");
            SqlCommand cmd = new SqlCommand(query, con);

            //, , , 

            cmd.Parameters.AddWithValue("@suggest_desc", txtsuggestions.Text);

            cmd.ExecuteNonQuery();
        }
        catch (Exception e1)
        {
            string msg = e1.Message;
        }
        finally
        {
            con.Close();
            Response.Write("<script language = 'javascript'>window.alert('Suggestion Added..');window.location='contact.aspx';</script>");
        }
    }
}