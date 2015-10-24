using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class QuestionnaireController : Controller
    {
        //调查问卷
        // GET: /Game/Questionnaire/

        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("分数")]
        public ActionResult Results()
        {
            ViewBag.Game_Qrst = WMFactory.Game_Qrst.GetAll().OrderByDescending(f =>f.total);
            return View();
        }

        public ActionResult Start()
        {
            string AM_login = CookieHelper.GetCookie("AM_login");
            if (AM_login == "" || AM_login == null)
            {
                return Redirect("~/Game/Questionnaire/Index");
            }
            if (WMFactory.Game_Qrst.GetCount(f => f.UseName == AM_login) > 0)
            {
                return Redirect("~/Game/Questionnaire/Index");
            }
            return View();
        }

        [Page]
        [Description("登入验证")]
        [HttpPost]
        public JsonResult Login(string password, string name)
        {
            DataTable dt = WMFactory.Wsrr.CheackAMUser(password, name);

            if (dt == null || dt.Rows.Count <= 0 || dt.Rows[0]["AM_login"].ToString() == "")
            {
                return Json(ResultMsg.Failure("登入失败！"));
            }
            else
            {
                if (WMFactory.Game_Qrst.GetCount(f => f.UseName == name) > 0)
                {
                    return Json(ResultMsg.Failure("已经做过一次 不能再做！"));
                }
                else
                {
                    string strAM_login = dt.Rows[0]["AM_login"].ToString();
                    CookieHelper.SaveCookie("AM_login", strAM_login, 60 * 24 * 30 * 1000);//小翅膀登入名
                    return Json(ResultMsg.Success("登入成功！"));
                }
            }
        }

        [Page]
        [Description("提交数据")]
        [HttpPost]
        public JsonResult SumitQA(Game_Qrst qr)
        {
            qr.UseName = CookieHelper.GetCookie("AM_login");
            qr.CreateUser = "gqq";
            qr.ModifyUser = "gqq";
            qr.ModifyTime = DateTime.Now;
            WMFactory.Game_Qrst.Insert(qr);
            return Json(ResultMsg.Success(qr.total));
        }

        

    }
}
