using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;
using Talent.BLL;
using Talent.Common;

namespace HelpSelf.Web
{
    public partial class login : System.Web.UI.Page
    {
        private static Talent.BLL.TN_SYS_EM_USER userdb = new BLL.TN_SYS_EM_USER();

        protected void Page_Load(object sender, EventArgs e)
        {
            Tools.SessionHelper.Del("userid");

            if (IsPostBack)
            {
                String usernamestr = Talent.Common.Constants.getReqValue(Request, "username");
                String passwordstr = Talent.Common.Constants.getReqValue(Request, "password");
                if (usernamestr.Trim() == "")
                {
                    tooltip.InnerHtml = "请输入用户名";
                    return;
                }

                var user = userdb.getModel(usernamestr);
                if (user == null)
                {
                    tooltip.InnerHtml = "用户不存在";
                    return;
                }

                if (user.CN_PASSWORD == null || user.CN_PASSWORD.Trim() == "")
                {
                    if (passwordstr != "")
                    {
                        tooltip.InnerHtml = "密码错误";
                        return;
                    }
                }
                else if (user.CN_PASSWORD != passwordstr)
                {
                    tooltip.InnerHtml = "密码错误";
                    return;
                }

                Tools.SessionHelper.Add("userid", usernamestr);
                Response.Redirect("userModules.aspx");
            }
            else
            {
                String usernamestr = Common.Constants.getReqValue(Request, "TxtName");
                String passwordstr = Common.Constants.getReqValue(Request, "TxtPassword");
                if (usernamestr.Trim() == "")
                {
                    tooltip.InnerHtml = "请输入用户名";
                    return;
                }

                var user = userdb.getModel(usernamestr);
                if (user == null)
                {
                    tooltip.InnerHtml = "用户不存在";
                    return;
                }

                if (user.CN_PASSWORD == null || user.CN_PASSWORD.Trim() == "")
                {
                    if (passwordstr != "")
                    {
                        tooltip.InnerHtml = "密码错误";
                        return;
                    }
                }
                else if (user.CN_PASSWORD != passwordstr)
                {
                    tooltip.InnerHtml = "密码错误";
                    return;
                }

                Tools.SessionHelper.Add("userid", usernamestr);
                Response.Redirect("userModules.aspx");
            }
        }


        [WebMethod]
        public static string cancell()
        {
            Tools.SessionHelper.Del("userid");
            return "{flag:'true'}";
        }

        [WebMethod]
        public static string clickagain()
        {
            return "";
        }
    }
}