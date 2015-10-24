using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System.Configuration;

namespace ElegantWM.WebUI.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index(string token = "")
        {
            Guid ticket;
            if (string.IsNullOrEmpty(token) || !Guid.TryParse(token, out ticket))
            {//去SSO登陆
                ViewBag.SSOUrl = ConfigurationManager.AppSettings["SSO"]
                                + "/Login?gp=" + ConfigurationManager.AppSettings["GroupCode"] + "&sysId=" + ConfigurationManager.AppSettings["SysId"]
                                + "&ReturnUrl=" + Server.HtmlEncode(Request.Url.ToString());

                return View();
            }
            else
            {//去SSO认证
                if (SSOHelper.GetCertificate(ticket.ToString()))
                    return Redirect(string.IsNullOrEmpty(Request["ReturlUrl"]) ? "/Admin/Main" : Request["ReturnUrl"]);
                else
                    return View();
            }
        }

        public ActionResult LogOut()
        {
            AuthToken.ClearAuthToken(AuthToken.CurrentUser.tokenId);
            return Redirect("/Admin/Main");
        }
    }
}
