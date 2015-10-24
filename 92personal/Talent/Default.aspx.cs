using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Services;

namespace Talent.Web
{
    public partial class Default : System.Web.UI.Page
    {
        private static BLL.TN_SYS_EM_USER userdb = new BLL.TN_SYS_EM_USER();
        protected void Page_Load(object sender, EventArgs e)
        {
            //   Response.Redirect("login.aspx");
            string username = Common.Constants.getReqValue(Request, "username");
            //username = "郭琦琦";
            if (username == "")
                Response.Redirect("login.aspx");
            else
            {
                //  var user =  userdb.GetModelByID(username);
                //var user = userdb.getModel(username);
                //if (user == null) Response.Redirect("login.aspx");
                //else
                //{
                ////Tools.SessionHelper.Add("userid", user.CN_LOGIN);
                Tools.SessionHelper.Add("userid", username);
                Response.Redirect("Index.aspx");
                //}
            }
        }

        [WebMethod]
        public static string clickagain()
        {
            return "";
        }
    }
}
