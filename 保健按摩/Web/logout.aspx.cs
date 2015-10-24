using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPReper.Web
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Tools.CookieHelper.ClearCookie("CN_ID");
            Tools.CookieHelper.ClearCookie("username");
            Session["islogin"] = null;
            EPReper.Model.Reper.isReper = 0;
         //   Response.Redirect("login.aspx");
        }
    }
}