using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPReper.Web.manager.ReperClass
{
    public partial class ReperManager : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string userid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //userid = "24";
            userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "'") == null)
            {
                Response.Redirect("../ReperInfo/ReperInfo.aspx");
            }
        }
    }
}