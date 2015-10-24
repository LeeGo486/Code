using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPReper.Web.View
{
    public partial class Health : System.Web.UI.MasterPage
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        static string userid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();

                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }

            }

        }
    }
}