using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class JOREALGuessThePriceController : BaseJLController
    {
        //
        // GET: /Game/JOREALGuessThePrice/
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public ActionResult Index(Guid sid, string oid)
        {
            if (string.IsNullOrEmpty(oid) || string.IsNullOrEmpty(sid.ToString()))
            {
                return Redirect("~/Game/JOREALGuessThePrice/Wrong?sid=" + sid.ToString() + "&oid=" + oid);//异常
            }
            IEnumerable<Game_UserInfo> gt = WMFactory.GameUserInfo.FindByConditions(null, f => f.Oid == oid && f.Group == 11);
            if (gt.Count() > 0)
            {
                return Redirect("~/Game/JOREALGuessThePrice/Wrong?sid=" + sid.ToString() + "&oid=" + oid);//已经玩过
            }
            return View();
        }

        [Page]
        [Description("提交")]
        public ActionResult Notice(string sid, string oid)
        {
            return View();
        }

        [Action]
        [Description("填写联系方式提交信息")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_UserInfo gu, string sid)
        {
            gu.CreateUser = "gqq";
            gu.Group = 11;

            IEnumerable<Game_UserInfo> gt = WMFactory.GameUserInfo.FindByConditions(null, f => f.Oid == gu.Oid && f.Group == 11);

            if (gt.Count() > 0)
            {
                return Json(ResultMsg.Failure("你已经参与过了！"));
            }
            else
            {
                if (WMFactory.GameUserInfo.Insert(gu))
                    return Json(ResultMsg.Success("信息提交成功。"));
                else
                    return Json(ResultMsg.Failure("信息提交失败，请重试！"));
            }
        }

        [Page]
        [Description("已经提交过了")]
        public ActionResult Wrong(string sid, string oid)
        {
            return View();
        }

        #region 分享

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
        public JsonResult GetSignature(string sid, string oid, string ticket, string nonceStr, string timestamp, string url)
        {
            string[] ArrTmp = { "jsapi_ticket=" + ticket, "noncestr=" + nonceStr, "timestamp=" + timestamp, "url=" + url };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("&", ArrTmp);
            tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();

            return Json(ResultMsg.Success(tmpStr));
        }

        #endregion
    }
}
