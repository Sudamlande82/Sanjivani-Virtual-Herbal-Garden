using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["mobile_no"] != null)
        {
            lblmobile_no.Text = Session["mobile_no"].ToString();

            if (lblusername.Text != null)
            {
                //BindUsername();
            }
            //Session.RemoveAll();
        }
    }
}
