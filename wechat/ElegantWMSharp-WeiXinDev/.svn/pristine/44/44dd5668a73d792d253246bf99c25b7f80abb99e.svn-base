using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class JOREALMothersDayController : Controller
    {
        //
        // GET: /Game/JLMothersDay/
        [Page]
        [Description("填写联系方式")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("发送短信")]
        [HttpPost]
        [Open]
        public JsonResult SendSms(string tel)
        {

            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.SendSmsAnyTelCommonInterface(tel, "pos", "2");
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("短信发送成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("验证手机短信验证")]
        [HttpPost]
        [Open]
        public JsonResult CheckAuthCode(string Tel, string AuthCode)
        {
            DataTable dt = WMFactory.Wsrr.CheckAuthCodeCommonInterface(Tel, AuthCode);

            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("验证成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("填写联系方式提交信息")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_UserInfo gu)
        {
            string guidoid = "oloPUjkzSLyHPqAM5kW6DRzZzc74";
            gu.Oid = guidoid;
            gu.CreateUser = "gqq";
            gu.Group = 1;

            IEnumerable<Game_UserInfo> gr = WMFactory.GameUserInfo.FindByConditions(null, f => f.Oid == guidoid && f.Group == 1 && f.Tel == gu.Tel);
            if (gr.Count() > 0)
            {
                return Json(ResultMsg.Failure("亲，你的手机已经登记过了，请勿重复登记！谢谢！"));
            }
            else
            {
                if (WMFactory.GameUserInfo.Insert(gu))
                    return Json(ResultMsg.Success("信息提交成功。"));
                else
                    return Json(ResultMsg.Failure("信息提交失败，请重试！"));
            }
        }

    }
}
