using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Web.Security;

using ElegantWM.WeiXin.MsgEntity;
using ElegantWM.Factory;
using ElegantWM.Common;
using ElegantWM.DTO;
using System.Data;
using ElegantWM.Tools;
using ElegantWM.WebUI.Areas.Matrix;
using ElegantWM.EntityModel;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class GLPosterController : Controller
    {
        //
        // GET: /Game/GLPoster/

        public ActionResult Index(Guid sid, string wxid)
        {
            ViewBag.wxid = wxid;
            return View();
        }

        [Action]
        [Description("Appid")]
        [HttpPost]
        [Open]
        public JsonResult GetAppId(string sid)
        {
            WX_Account account = WMFactory.WXAccount.GetById(sid);
            return Json(ResultMsg.Success(account.AppId));
        }

        [Action]
        [Description("ticket")]
        [HttpPost]
        [Open]
        public JsonResult GetTicket(string sid)
        {
            String ticket = ElegantWM.WeiXin.Common.GetTicket(sid);
            return Json(ResultMsg.Success(ticket));
        }

        [Action]
        [Description("signature")]
        [HttpPost]
        [Open]
        public JsonResult GetSignature(string sid, string wxid, string ticket, string nonceStr, string timestamp, string url)
        {
            string[] ArrTmp = { "jsapi_ticket=" + ticket, "noncestr=" + nonceStr, "timestamp=" + timestamp, "url=" + url };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("&", ArrTmp);
            tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();

            return Json(ResultMsg.Success(tmpStr));
        }

    }
}
