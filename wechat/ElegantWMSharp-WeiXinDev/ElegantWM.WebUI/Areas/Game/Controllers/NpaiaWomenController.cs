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
    public class NpaiaWomenController : BaseNPaiaController
    {
        //
        // GET: /Game/NpaiaWomen/
        [Page]
        [Description("首页")]
        public ActionResult NPWomenIndex(Guid sid, string oid)
        {
            return Redirect("~/Game/NpaiaWomen/End?sid=" + sid + "&oid=" + oid);

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == oid);

            if (gr.Count() > 0)
            {
                Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());
                return Redirect("~/Game/NpaiaWomen/GameInfo?level=" + ga.Level + "&lid=" + oid + "&sid=" + sid + "&oid=" + oid);
            }

            return View();
        }

        [Page]
        [Description("款式信息")]
        public ActionResult ClothInfo(int id, Guid sid, string oid)
        {
            //return Redirect("~/Game/NpaiaWomen/End?sid=" + sid + "&oid=" + oid);

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == oid);

            if (gr.Count() > 0)
            {
                Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());
                return Redirect("~/Game/NpaiaWomen/GameInfo?level=" + ga.Level + "&lid=" + oid + "&sid=" + sid + "&oid=" + oid);
            }

            ViewBag.ID = id;
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

        [Action]
        [Description("攒红包")]
        [HttpPost]
        [Open]
        public JsonResult addMoney(string lid, string sid, string oid)
        {
            //已攒过
            if (WMFactory.GameLink.GetCount(f => f.Group == 10 && f.Lid == lid && f.Oid == oid) > 0)
            {
                return Json(ResultMsg.Failure("只能帮忙攒一次红包！")); ;
            }

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == lid);
            if (gr.Count() == 0)
            {
                return Json(ResultMsg.Failure("找不到记录！"));
            }
            else
            {
                Game_Record g = gr.First();
                int total = g.doTimes;
                int recently = g.linkedTimes;
                int count = WMFactory.GameLink.GetCount(f => f.Group == 10 && f.Lid == lid);
                int rest = 0;
                if (total == 3298)
                {
                    rest = 100 - count;
                }
                else if (total == 2398)
                {
                    rest = 80 - count;
                }
                else
                {
                    rest = 50 - count;
                }
                //if (total == 3298)
                //{
                //    rest = 6 - count;
                //}
                //else if (total == 2398)
                //{
                //    rest = 6 - count;
                //}
                //else
                //{
                //    rest = 6 - count;
                //}
                if (rest == 0)
                {
                    return Json(ResultMsg.Success("红包金额已筹满！"));
                }

                //产生随机数
                Random Rdm = new Random();
                int iRdm = Rdm.Next(1, (total - recently) / rest * 2);

                if (rest == 1)
                {
                    iRdm = total - recently;
                }

                Game_Link gl = new Game_Link();
                gl.Group = 10;
                gl.Lid = lid;
                gl.Oid = oid;

                WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                gl.NickName = wf.nickname;
                gl.Avatar = wf.headimgurl;
                gl.Oper = iRdm.ToString();
                gl.CreateUser = "jmj";

                WxFans wx = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), lid);

                if (WMFactory.GameLink.Insert(gl))
                {
                    g.linkedTimes = recently + iRdm;
                    g.ModifyUser = "jmj";

                    if (WMFactory.GameRecord.Update(g))
                    {
                        return Json(ResultMsg.Success("成功帮" + wx.nickname + "筹得" + iRdm + "元红包金额"));
                    }
                    else
                    {
                        return Json(ResultMsg.Failure("操作失败！"));
                    }
                }
                else
                {
                    return Json(ResultMsg.Failure("操作失败！"));
                }
            }
        }

        [Page]
        [Description("活动详情")]
        public ActionResult GameInfo(int level, string lid, string sid, string oid)
        {
            return Redirect("~/Game/NpaiaWomen/End?sid=" + sid + "&oid=" + oid);

            Game_Record record;
            //自己点开
            if (lid.ToUpper() == oid.ToUpper())
            {
                ViewBag.TYPE = 1;
                //表中没有记录，插入新记录
                if (WMFactory.GameRecord.GetCount(f => f.Group == 10 && f.Oid == oid) == 0)
                {
                    record = new Game_Record();
                    record.Oid = oid;

                    WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                    record.Nickname = wf.nickname;
                    record.Group = 10;
                    record.Num = 0;

                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 10 && f.Level == level);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Seq = "";
                    record.Num = 0;
                    record.isAward = 0;
                    if (level == 1)
                    {
                        record.doTimes = 3298;
                    }
                    else if (level == 2)
                    {
                        record.doTimes = 2398;
                    }
                    else if (level == 3)
                    {
                        record.doTimes = 1898;
                    }
                    else
                    {
                        record.doTimes = 1298;
                    }

                    record.linkedTimes = 0;
                    record.CreateUser = "JMJ";

                    WMFactory.GameRecord.Insert(record);
                }
                else
                {
                    IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == oid);
                    record = gr.First();

                    Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());
                    level = ga.Level;

                    if (record.linkedTimes >= record.doTimes)
                    {
                        return Redirect("~/Game/NpaiaWomen/Winning?sid=" + sid + "&oid=" + oid);
                    }
                }
            }
            //好友打开
            else
            {
                ViewBag.TYPE = 2;
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == lid);
                record = gr.First();

                Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());
                level = ga.Level;

                if (WMFactory.GameLink.GetCount(f => f.Group == 10 && f.Lid == lid && f.Oid == oid) > 0)
                {
                    ViewBag.BTN = 2;
                }
                else
                {
                    ViewBag.BTN = 1;
                }
            }

            WxFans wx = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), lid);
            ViewBag.LEVEL = level;
            ViewBag.AVATAR = wx.headimgurl;
            ViewBag.NAME = wx.nickname;
            ViewBag.MONEY = record.linkedTimes;

            IEnumerable<Game_Link> gl = WMFactory.GameLink.FindByConditions(null, f => f.Group == 10 && f.Lid == lid);
            ViewBag.LIST = gl.OrderByDescending(o => o.CreateTime);

            return View();
        }

        [Page]
        [Description("得奖界面")]
        public ActionResult Winning(Guid sid, string oid)
        {
            //return Redirect("~/Game/NpaiaWomen/End?sid=" + sid + "&oid=" + oid);

            //已领奖
            if (WMFactory.GameRecord.GetCount(f => f.Group == 10 && f.Oid == oid && f.isAward == 1) > 0)
            {
                ViewBag.TYPE = 1;
            }
            else
            {
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == oid);
                Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());

                //还有奖品
                if (ga.PNum > 0)
                {
                    if (ga.Level == 5)
                    {
                        return Redirect("~/Game/NpaiaWomen/Info?type=L&sid=" + sid + "&oid=" + oid);
                    }
                    else
                    {
                        return Redirect("~/Game/NpaiaWomen/Info?type=J&sid=" + sid + "&oid=" + oid);
                    }
                }
                else
                {
                    IEnumerable<Game_Award> ga5 = WMFactory.GameAward.FindByConditions(null, f => f.Group == 10 && f.Level == 5);
                    //还有礼品
                    if (ga5.First().PNum > 0)
                    {
                        //替换奖品ID与名称
                        gr.First().AwardId = ga5.First().Id;
                        gr.First().AwardName = ga5.First().Name;
                        gr.First().ModifyUser = "JMJ";
                        if (WMFactory.GameRecord.Update(gr.First()))
                        {

                        }
                        else
                            return Json(ResultMsg.Failure("信息提交失败，请重试！"));
                    }
                    else
                    {
                        ViewBag.TYPE = 2;
                    }
                }
            }

            return View();
        }

        [Page]
        [Description("中奖信息")]
        public ActionResult Info(string type, Guid sid, string oid)
        {
            //return Redirect("~/Game/NpaiaWomen/End?sid=" + sid + "&oid=" + oid);
            if (type == "J")
            {
                ViewBag.TYPE = "J";
            }
            else
            {
                ViewBag.TYPE = "L";
            }
            return View();
        }

        [Action]
        [Description("提交信息")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_UserInfo gu)
        {
            if (WMFactory.GameUserInfo.GetCount(f => f.Group == 10 && f.Oid == gu.Oid) > 0)
            {
                return Json(ResultMsg.Success("信息已提交。"));
            }

            gu.CreateUser = "JMJ";
            gu.Group = 10;

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 10 && f.Oid == gu.Oid);
            gr.First().isAward = 1;
            gr.First().ModifyUser = "JMJ";
            Game_Award ga = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());
            if (ga.PNum > 0)
            {
                ga.PNum = ga.PNum - 1;
            }
            else
            {
                return Json(ResultMsg.Failure("later"));
            }


            if (WMFactory.GameUserInfo.Insert(gu) && WMFactory.GameRecord.Update(gr.First()) && WMFactory.GameAward.Update(ga))
            {
                return Json(ResultMsg.Success("信息提交成功。"));
            }
            else
                return Json(ResultMsg.Failure("信息提交失败，请重试！"));
        }

        [Page]
        [Description("结束信息")]
        public ActionResult End(Guid sid, string oid)
        {
            return View();
        }
    }
}
