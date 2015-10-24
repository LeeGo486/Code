using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Talent.Web
{
    public partial class index : System.Web.UI.Page
    {
        private static BLL.TB_RC_Permission permissiondb = new BLL.TB_RC_Permission();

        protected Model.TB_RC_Permission per = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            var userid = Tools.SessionHelper.Get("userid");
            if (userid == null || userid.Trim() == "")
            {
                Response.Redirect("login.aspx");
            }
            per = permissiondb.GetModel(userid);
            if (per == null || per.PM_Level == -1) Response.Redirect("login.aspx");

        }
    }
}