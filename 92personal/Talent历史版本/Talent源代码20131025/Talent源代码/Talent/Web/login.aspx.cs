using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace Talent.Web
{
    public partial class login : System.Web.UI.Page
    {
        private static BLL.TN_SYS_EM_USER user = new BLL.TN_SYS_EM_USER();
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected void Page_Load(object sender, EventArgs e)
        {
            Tools.SessionHelper.Del("userid");

            
            
             if (IsPostBack)
             {
                 if (username.Value != "")
                 {
                     var model = user.getModel(username.Value);
                     if (model != null)
                     {
                         var pi = pidb.GetModel(model.CN_LOGIN);
                         if (pi != null && (pi.PM_Level != -1))
                         {
                             Tools.SessionHelper.Add("userid", username.Value);
                             Response.Redirect("index.aspx");
                         }
                     }
                 }
             }
        }
    }
}