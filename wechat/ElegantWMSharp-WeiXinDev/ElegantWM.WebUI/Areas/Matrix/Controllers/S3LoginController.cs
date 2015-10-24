using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Matrix.Controllers
{
    public class S3LoginController : Controller
    {
        //
        // GET: /Matrix/S3Login/

        public ActionResult Index()
        {
            return View();
        }

        //绑定用户
        public JsonResult Binding()
        {
            if (string.IsNullOrEmpty(Request["name"]) || string.IsNullOrEmpty(Request["pwd"]))
            {
                return Json(ResultMsg.Failure("参数非法！"));
            }
            ResultMsg rst = SSOHelper.Login(Request["name"].Trim(), Server.UrlEncode(Request["pwd"].Trim()), "SSS", Request.UserHostAddress);
            if (rst.result == 0)
            {
                CertificateDto cert = AuthToken.CurrentUserByTid(rst.msg);
                string accessMan = System.Configuration.ConfigurationManager.AppSettings["AccessMan"];
                if (accessMan.Contains(cert.UserName + "、"))
                {
                    CookieHelper.SaveCookie("S3AMUserNew", cert.UserName, 60 * 24 * 300);
                    return Json(ResultMsg.Success("绑定成功！"), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(ResultMsg.Failure("您无权访问3S！"), JsonRequestBehavior.AllowGet);
                }
            }
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
    }
}
