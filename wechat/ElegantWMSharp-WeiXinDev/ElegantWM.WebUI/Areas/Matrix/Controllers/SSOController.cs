using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Matrix.Controllers
{
    public class SSOController : Controller
    {

        [Page]
        [Description("首页")]
        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("登录")]
        public ActionResult Login()
        {
            return View();
        }

        [Page]
        [Description("注册")]
        public ActionResult Register()
        {
            return View();
        }

        [Page]
        [Description("取回密码")]
        public ActionResult RetakePassword()
        {
            return View();
        }

        [Page]
        [Description("系统绑定")]
        public ActionResult Bind()
        {
            return View();
        }


        [Action]
        [Description("执行WSRR")]
        [HttpPost]
        [ValidateInput(false)]
        public string ExecuteWSRR(string key)
        {
            if (string.IsNullOrEmpty(key))
                return "参数错误";
            else
            {
                return WMFactory.ITDC.ExecuteWSRR(key.Trim());
            }
        }
    }
}
