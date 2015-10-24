using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class NpaiaChristmasController : BaseNPaiaController
    {
        //
        // GET: /Game/NpaiaChristmas/

        [Page]
        [Description("首页")]
        [Open]
        public ActionResult Index(Guid sid,string oid)
        {
            Guid id = new Guid("00000000-0000-0000-0000-000000000000");
            //存在记录，并且中奖
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2 && f.AwardId != id) > 0)
            {
                return Redirect("~/Game/NpaiaChristmas/Winning?sid=" + sid + "&oid=" + oid);
            }
            //已参与3次
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2 && f.doTimes == 3) > 0)
            {
                return Redirect("~/Game/NpaiaChristmas/CountDown?sid=" + sid + "&oid=" + oid);
            }

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 2 && f.AwardId != id);

            ViewBag.List = gr;
            return View();
        }

        [Action]
        [Description("重置信息")]
        [HttpPost]
        [Open]
        public JsonResult Reset(Guid sid,string oid)
        {
            Boolean flagRecord,flagInfo;

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 2);

            if (gr.Count() > 0)
            {
                if (WMFactory.GameRecord.Delete(gr.First()))
                    flagRecord = true;
                else
                    flagRecord = false;
            }
            else
            {
                flagRecord = true;
            }

            IEnumerable<Game_UserInfo> gu = WMFactory.GameUserInfo.FindByConditions(null, f => f.Oid == oid && f.Group == 2);

            if (gu.Count() > 0)
            {
                if (WMFactory.GameUserInfo.Delete(gu.First()))
                    flagInfo = true;
                else
                    flagInfo = false;
            }
            else
            {
                flagInfo = true;
            }


            if (flagRecord && flagInfo)
            {
                return Json(ResultMsg.Success("信息重置成功。"));
            }
            else if (flagRecord && !flagInfo)
            {
                return Json(ResultMsg.Success("个人信息重置失败。"));
            }
            else if (!flagRecord && flagInfo)
            {
                return Json(ResultMsg.Success("中奖记录重置失败。"));
            }
            else
            {
                return Json(ResultMsg.Success("重置失败。"));
            }
        }

        [Page]
        [Description("圣诞袜")]
        public ActionResult Stocking(Guid sid,string oid)
        {
            return View();
        }

        [Page]
        [Description("倒计时")]
        public ActionResult CountDown(Guid sid, string oid)
        {
            Guid id = new Guid("00000000-0000-0000-0000-000000000000");
            //不存在记录，新建倒计时
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2) == 0)
            {
                Game_Record record = new Game_Record();
                record.Oid = oid;

                WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                record.Nickname = wf.nickname;
                record.Group = 2;
                record.Num = 0;
                record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                record.AwardName = "";
                record.Seq = "";
                record.isAward = 0;
                record.doTimes = 0;
                record.linkedTimes = 0;

                record.CreateUser = "JMJ";

                if (WMFactory.GameRecord.Insert(record))
                {
                    ViewBag.Info = "15";
                }
            }
            //存在记录，并且中奖
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2 && f.AwardId != id) > 0)
            {
                return Redirect("~/Game/NpaiaChristmas/Info?sid=" + sid + "&oid=" + oid);
            }
            //已参与3次
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2 && f.doTimes == 3) > 0)
            {
                ViewBag.Info = "抽奖次数已用完";
            }
            //存在记录，未中奖，倒计时结束，重新计时
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 2 && f.isAward == 0) == 0)
            {
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 2 && f.isAward != 0);

                Game_Record record = gr.First();
                record.isAward = 0;

                record.ModifyUser = "JMJ";

                if (WMFactory.GameRecord.Update(record))
                {
                    ViewBag.Info = "15";
                }
            }
            //存在记录，倒计时进行中
            else
            {
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 2 && f.isAward == 0);
                DateTime date = DateTime.Now;
                int second;
                if (gr.First().ModifyTime != null)
                {
                    second = (int)(date - (DateTime)gr.First().ModifyTime).TotalSeconds;
                }
                else
                {
                    second = (int)(date - gr.First().CreateTime).TotalSeconds;
                }

                if (second > 15)
                    ViewBag.Info = 0;
                else
                    ViewBag.Info = (15 - second);
            }

            return View();
        }

        [Page]
        [Description("中奖页")]
        public ActionResult Winning(Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 2 && f.isAward == 0);

            //已抽过奖
            if (gr.Count() == 0)
            {
                IEnumerable<Game_Record> old = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 2 && f.isAward != 0);

                //尚未倒计时，跳转到倒计时页
                if (old.Count() == 0)
                {
                    return Redirect("~/Game/NpaiaChristmas/CountDown?sid=" + sid + "&oid=" + oid);
                }
                //返回当前中奖信息
                else
                {
                    ViewBag.Info = old.First().AwardId;
                }
            }
            else
            {
                //计算时间差
                DateTime date = DateTime.Now;
                int second;
                if (gr.First().ModifyTime != null)
                {
                    second = (int)(date - (DateTime)gr.First().ModifyTime).TotalSeconds;
                }
                else
                {
                    second = (int)(date - gr.First().CreateTime).TotalSeconds;
                }
                //倒计时未结束，返回计时界面
                if (second < 15)
                {
                    return Redirect("~/Game/NpaiaChristmas/CountDown?sid=" + sid + "&oid=" + oid);
                }
                    
                Random Rdm = new Random();

                //产生随机数
                int iRdm = Rdm.Next(0, 4000);

                Game_Record record = gr.First();
                record.isAward = 1;
                record.doTimes = record.doTimes + 1;
                record.ModifyUser = "JMJ";

                if (iRdm < 10) //一等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 2 && f.Level == 1);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;
                }
                else if (iRdm >= 10 && iRdm < 25) //二等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 2 && f.Level == 2);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;
                }
                else if (iRdm >= 25 && iRdm < 50) //三等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 2 && f.Level == 3);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;
                }
                else if (iRdm >= 50 && iRdm < 200) //四等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 2 && f.Level == 4);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;
                }
                else
                {
                    record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                    record.Num = 0;
                }

                if (WMFactory.GameRecord.Update(record))
                {
                    ViewBag.Info = DoAward(record);
                }
            }
            
            return View();
        }

        [Page]
        [Description("个人信息页")]
        public ActionResult Info(Guid sid,string oid)
        {
            //信息已填，跳转页
            if (WMFactory.GameUserInfo.GetCount(f => f.Oid == oid && f.Group == 2) > 0)
            {
                return Redirect("~/Game/NpaiaChristmas/Share?sid=" + sid + "&oid=" + oid);
            }

            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans == null || fans.Count() <= 0)
            {
                ViewBag.Name = "";
                ViewBag.Tel = "";
            }
            else
            {
                string viptel = fans.First().Telphone;
                DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(viptel);

                if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
                {
                    ViewBag.Name = "";
                    ViewBag.Tel = "";
                }
                else
                {
                    ViewBag.Name = dtpCentum.Rows[0]["vipname"].ToString();
                    ViewBag.Tel = dtpCentum.Rows[0]["mobtel"].ToString();
                }
            }

            return View();
        }

        [Action]
        [Description("提交信息")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_UserInfo gu)
        {
            gu.CreateUser = "JMJ";
            gu.Group = 2;

            if (WMFactory.GameUserInfo.Insert(gu))
                return Json(ResultMsg.Success("信息提交成功。"));
            else
                return Json(ResultMsg.Failure("信息提交失败，请重试！"));
        }

        [Page]
        [Description("分享")]
        public ActionResult Share()
        {
            return View();
        }

        public Guid DoAward(Game_Record record)
        {
            try
            {
                if (WMFactory.GameRecord.Update(record))
                {
                    return record.AwardId;
                }
                else
                    return new Guid("00000000-0000-0000-0000-000000000000");
            }
            catch (Exception e)
            {
                string s = e.GetBaseException().Message.ToString();
                if (s == "奖品已经发完啦!") //所中奖品数量为0，奖品向下降级
                {
                    Game_Award ga = WMFactory.GameAward.GetById(record.AwardId.ToString());
                    int newLevel = ga.Level + 1;

                    IEnumerable<Game_Award> ga2 = WMFactory.GameAward.FindByConditions(null, f => f.Group == 2 && f.Level == newLevel);

                    if (ga2.Count() > 0)
                    {
                        record.AwardId = ga2.First().Id;
                        record.AwardName = ga2.First().Name;
                    }
                    else
                    {
                        record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                        record.AwardName = "";
                        record.Num = 0;
                    }
                    
                    return DoAward(record);
                }
                else
                {
                    throw e;
                }
            }
        }
    }
}
