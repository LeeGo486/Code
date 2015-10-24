using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class GLChristmasController : BaseGLController
    {
        //
        // GET: /Game/GLChristmas/

        public ActionResult Index(Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 3);

            //未参与
            if (gr.Count() == 0)
            {
                return Redirect("~/Game/GLChristmas/End?sid=" + sid + "&oid=" + oid);
            }
            //未抽奖
            else if (gr.First().isAward == 0)
            {
                return Redirect("~/Game/GLChristmas/End?sid=" + sid + "&oid=" + oid);
            }
            //已中奖
            else if (gr.First().AwardId != new Guid("00000000-0000-0000-0000-000000000000"))
            {
                return Redirect("~/Game/GLChristmas/Info?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                return Redirect("~/Game/GLChristmas/End?sid=" + sid + "&oid=" + oid);
            }
        }

        [Action]
        [Description("抽奖")]
        [HttpPost]
        [Open]
        public JsonResult Award(Guid sid, string oid)
        {
            Game_Record record = null;

            //没有抽奖机会
            if (WMFactory.GLGameRecord.GetCount(f => f.Oid == oid && f.Group == 3 && f.isAward == 1) > 0)
            {
                return Json(ResultMsg.Failure("您已抽过奖"));
            }
            else
            {
                //第一次进入游戏
                if (WMFactory.GLGameRecord.GetCount(f => f.Oid == oid && f.Group == 3) == 0)
                {
                    record = new Game_Record();
                    record.Oid = oid;

                    //WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                    //record.Nickname = wf.nickname;
                    record.Nickname = "";
                    record.Group = 3;
                    record.Num = 0;
                    record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                    record.AwardName = "";
                    record.Seq = "";
                    record.isAward = 0;
                    record.doTimes = 0;
                    record.linkedTimes = 0;
                    record.CreateUser = "JMJ";

                    WMFactory.GLGameRecord.Insert(record);
                }

                record = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 3 && f.isAward == 0).First();

                record.isAward = 1;
                record.doTimes = record.doTimes + 1;
                record.ModifyUser = "JMJ";

                Random Rdm = new Random();

                //产生随机数
                int iRdm = Rdm.Next(0, 1000);

                string seq = "";
                if (iRdm < 10) //一等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 1);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "0" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 2, 2);
                }
                else if (iRdm >= 10 && iRdm < 20) //二等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 2);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "0" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 2, 2);
                }
                else if (iRdm >= 20 && iRdm < 35) //三等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 3);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "0" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 2, 2);
                }
                else if (iRdm >= 35 && iRdm < 85) //四等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 4);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "0" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 2, 2);
                }
                else if (iRdm >= 85 && iRdm < 150) //五等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 5);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "000" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 4, 4);
                }
                else if (record.doTimes == 2) //第二次必中五等奖
                {
                    IEnumerable<Game_Award> ga = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == 5);
                    record.AwardId = ga.First().Id;
                    record.AwardName = ga.First().Name;
                    record.Num = 1;

                    seq = "000" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                    record.Seq = seq.Substring(seq.Length - 4, 4);
                }
                else
                {
                    record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                    record.Num = 0;
                }

                string awardId = DoAward(record).ToString().ToUpper();

                if (awardId == "00000000-0000-0000-0000-000000000000")
                    return Json(ResultMsg.Failure("00000000-0000-0000-0000-000000000000"));
                else
                    return Json(ResultMsg.Success(awardId));
            }
        }

        public Guid DoAward(Game_Record record)
        {
            try
            {
                if (WMFactory.GLGameRecord.Update(record))
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
                    Game_Award ga = WMFactory.GLGameAward.GetById(record.AwardId.ToString());
                    int newLevel = ga.Level + 1;

                    IEnumerable<Game_Award> ga2 = WMFactory.GLGameAward.FindByConditions(null, f => f.Group == 3 && f.Level == newLevel);

                    if (ga2.Count() > 0)
                    {
                        record.AwardId = ga2.First().Id;
                        record.AwardName = ga2.First().Name;

                        string seq = "";
                        if (newLevel == 5)
                        {
                            seq = "000" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                            record.Seq = seq.Substring(seq.Length - 4, 4);
                        }
                        else
                        {
                            seq = "0" + (WMFactory.GLGameRecord.GetCount(f => f.Group == 3 && f.AwardId == record.AwardId) + 1).ToString();
                            record.Seq = seq.Substring(seq.Length - 2, 2);
                        } 
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

        [Page]
        [Description("个人信息页")]
        public ActionResult Info(Guid sid, string oid)
        {
            //信息已填，跳转页
            if (WMFactory.GLGameUserInfo.GetCount(f => f.Oid == oid && f.Group == 3) > 0)
            {
                return Redirect("~/Game/GLChristmas/Winning?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                IEnumerable<Game_Record> gr = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 3);

                if (gr.First().AwardId == Guid.Parse("F32D831B-3A8A-4D71-B652-1766D04B5AD6"))
                {
                    return Redirect("~/Game/GLChristmas/Winning?sid=" + sid + "&oid=" + oid);
                }
                else if (gr.First().AwardId == Guid.Parse("2F9F6C73-7935-4E8C-B68A-341005893C93"))
                {
                    return Redirect("~/Game/GLChristmas/Winning?sid=" + sid + "&oid=" + oid);
                }
                else if (gr.First().AwardId == Guid.Parse("AD334A86-8B90-4E58-A845-3E6F809BA9BA"))
                {
                    return Redirect("~/Game/GLChristmas/Winning?sid=" + sid + "&oid=" + oid);
                }
            }

            //IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            //if (fans == null || fans.Count() <= 0)
            //{
            //    ViewBag.Name = "";
            //    ViewBag.Tel = "";
            //}
            //else
            //{
            //    string viptel = fans.First().Telphone;
            //    DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(viptel);

            //    if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
            //    {
            //        ViewBag.Name = "";
            //        ViewBag.Tel = "";
            //    }
            //    else
            //    {
            //        ViewBag.Name = dtpCentum.Rows[0]["vipname"].ToString();
            //        ViewBag.Tel = dtpCentum.Rows[0]["mobtel"].ToString();
            //    }
            //}

            ViewBag.Name = "";
            ViewBag.Tel = "";

            return View();
        }

        [Page]
        [Description("中奖页")]
        public ActionResult Winning(Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 3);

            //未参与
            if (gr.Count() == 0)
            {
                return Redirect("~/Game/GLChristmas/?sid=" + sid + "&oid=" + oid);
            }
            //未抽奖
            else if(gr.First().isAward == 0)
            {
                return Redirect("~/Game/GLChristmas/?sid=" + sid + "&oid=" + oid);
            }
            //未中奖
            else if (gr.First().AwardId == new Guid("00000000-0000-0000-0000-000000000000"))
            {
                return Redirect("~/Game/GLChristmas/Share?sid=" + sid + "&oid=" + oid + "&lid=" + oid);
            }
            else
            {
                ViewBag.Info = gr.First().AwardId;
                ViewBag.Seq = gr.First().Seq;
            }

            return View();
        }

        [Page]
        [Description("分享")]
        public ActionResult Share(string lid, Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == lid && f.Group == 3);

            //未参与
            if (gr.Count() == 0)
            {
                return Redirect("~/Game/GLChristmas/?sid=" + sid + "&oid=" + oid);
            }
            //未抽奖
            else if (gr.First().isAward == 0)
            {
                return Redirect("~/Game/GLChristmas/?sid=" + sid + "&oid=" + oid);
            }
            //已中奖
            else if (gr.First().AwardId != new Guid("00000000-0000-0000-0000-000000000000"))
            {
                //自己点开
                if (lid.ToUpper() == oid.ToUpper())
                    return Redirect("~/Game/GLChristmas/Winning?sid=" + sid + "&oid=" + oid);
                //别人点开
                else
                    return Redirect("~/Game/GLChristmas/?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                //自己点开
                if (lid.ToUpper() == oid.ToUpper())
                    ViewBag.Type = 0;
                //别人点开
                else
                    ViewBag.Type = 1;
                ViewBag.Num = gr.First().linkedTimes;
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
            gu.Group = 3;

            if (WMFactory.GLGameUserInfo.Insert(gu))
                return Json(ResultMsg.Success("信息提交成功。"));
            else
                return Json(ResultMsg.Failure("信息提交失败，请重试！"));
        }

        [Action]
        [Description("点亮星星")]
        [HttpPost]
        [Open]
        public JsonResult ClickStar(Guid sid, string oid, string lid)
        {
            if (WMFactory.GLGameLink.GetCount(f => f.Lid == lid && f.Oid == oid && f.Group == 3) > 0)
            {
                return Json(ResultMsg.Failure("您已经点亮过了！"));
            }
            else
            {
                Game_Link gl = new Game_Link();
                gl.Group = 3;
                gl.Oid = oid;
                gl.Lid = lid;
                gl.CreateUser = "JMJ";

                if (WMFactory.GLGameLink.Insert(gl))
                    return Json(ResultMsg.Success("信息提交成功。"));
                else
                    return Json(ResultMsg.Failure("信息提交失败，请重试！"));
            }
        }

        [Action]
        [Description("重置信息")]
        [HttpPost]
        [Open]
        public JsonResult Reset(Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GLGameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 3);
            if (gr.Count() > 0)
            {
                if (!WMFactory.GLGameRecord.Delete(gr.First()))
                    return Json(ResultMsg.Success("中奖信息重置失败。"));
            }

            IEnumerable<Game_UserInfo> gu = WMFactory.GLGameUserInfo.FindByConditions(null, f => f.Oid == oid && f.Group == 3);

            if (gu.Count() > 0)
            {
                if (!WMFactory.GLGameUserInfo.Delete(gu.First()))
                    return Json(ResultMsg.Success("个人信息重置失败。"));
            }

            IEnumerable<Game_Link> gl = WMFactory.GLGameLink.FindByConditions(null, f => f.Lid == oid && f.Group == 3);

            if (gl.Count() > 0)
            {
                if (!WMFactory.GLGameLink.Delete(gl.First()))
                    return Json(ResultMsg.Success("分享信息重置失败。"));
                else
                    return Json(ResultMsg.Success("重置成功。"));
            }
            else
            {
                return Json(ResultMsg.Success("重置成功。"));
            }
        }

        [Page]
        [Description("结束页")]
        public ActionResult End()
        {
            return View();
        }
    }
}
