using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class GLTicketController : Controller
    {
        //public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //
        // GET: /Game/GLTicket/

        public ActionResult Index(Guid sid, string oid)
        {
            //log.Debug(sid);
            //log.Debug(oid);
            WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            string Ticketid = "";
            if (wf == null)
            {
                return Redirect("http://mp.weixin.qq.com/s?__biz=MzA5MTk5ODgzOA==&mid=203506347&idx=1&sn=f7b5f8c4c5ec7443ad8c35f0d646f40a#rd");
            }
            else
            {
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 8);
                if (gr.Count() > 0)
                {
                    IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Oid == oid && f.Group == 8);
                    Game_Ticket gtf = gt.First();
                    Ticketid = gtf.Ticketid;
                    ViewBag.Content1 = "人民币88元立减优惠";
                    ViewBag.Content2 = "[礼品券代码：" + Ticketid + "]";
                    ViewBag.Ticketid = Ticketid;
                }
                else
                {
                    Game_Record record = new Game_Record();
                    record.Oid = oid;
                    record.Group = 8;
                    record.Num = 1;
                    record.isAward = 1;
                    record.CreateUser = "gqq";
                    record.Nickname = wf.nickname;

                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 8 && f.Level == 1);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    Ticketid = DoAward(record);
                    if (Ticketid == "")
                    {
                        ViewBag.Content1 = "抱歉，您晚来一步！";
                        ViewBag.Content2 = "更多活动可至雅斓名店进行咨询！";
                        ViewBag.Ticketid = "";
                    }
                    else
                    {
                        ViewBag.Content1 = "人民币88元立减优惠";
                        ViewBag.Content2 = "[礼品券代码：" + Ticketid + "]";
                        ViewBag.Ticketid = Ticketid;
                    }
                }
            }

            return View();
        }


        public string DoAward(Game_Record record)
        {
            string ticketid = "";
            try
            {
                if (WMFactory.GameRecord.Insert(record))
                {

                    Game_Award ga = WMFactory.GameAward.GetById(record.AwardId.ToString());
                    //搜索中奖券号
                    IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Group == 8 && f.AwardId == ga.Id && string.IsNullOrEmpty(f.Oid));

                    if (gt.Count() > 0)
                    {
                        Game_Ticket gt2 = gt.First();
                        gt2.Oid = record.Oid;
                        gt2.ModifyUser = "gqq";
                        WMFactory.GameTicket.Update(gt2);
                        ticketid = gt2.Ticketid;
                    }
                } return (ticketid);
            }
            catch (Exception e)
            {
                string s = e.GetBaseException().Message.ToString();
                if (s == "奖品已经发完啦!")
                {
                    return (ticketid);
                }
                else
                {
                    return (ticketid);
                }
            }
        }

        public ActionResult Notice(Guid sid, string oid)
        {
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
        public JsonResult GetSignature(string sid, string oid, string ticket, string nonceStr, string timestamp, string url)
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
