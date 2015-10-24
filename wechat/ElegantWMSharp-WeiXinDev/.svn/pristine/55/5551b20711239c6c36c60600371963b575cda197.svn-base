using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
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
    public class JOREALLanternFestivalController : BaseJLController
    {

        [Description("卓莱雅元宵节活动")]
        public ActionResult Index(Guid sid, string oid)
        {
            //Guid id = new Guid("00000000-0000-0000-0000-000000000000");
            ////存在记录，并且中奖
            //if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.AwardId != id) > 0)
            //{
            //    return Redirect("~/Game/JOREALLanternFestival/Winning?sid=" + sid + "&oid=" + oid);
            //}
            ////已参与3次
            //else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.doTimes == 3) > 0)
            //{
            //    return Redirect("~/Game/JOREALLanternFestival/CountDown?sid=" + sid + "&oid=" + oid);
            //}
            return View();
        }

        [Page]
        [Description("猜灯谜开始")]
        public ActionResult BeginGame(Guid sid, string oid)
        {
            Guid id = new Guid("00000000-0000-0000-0000-000000000000");
            //存在记录，并且中奖
            //if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.AwardId != id) > 0)
            //{
            //    return Redirect("~/Game/JOREALLanternFestival/Winning?sid=" + sid + "&oid=" + oid);
            //}
            ////已参与3次
            //else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.doTimes == 3) > 0)
            //{
            //    return Redirect("~/Game/JOREALLanternFestival/CountDown?sid=" + sid + "&oid=" + oid);
            //}
            return View();
        }

        [Description("加载题目")]
        public JsonResult LoadQuestion(Guid TntId)
        {
            string Type = "6";
            IEnumerable<Game_Question> questions = WMFactory.GameQuestion.GetQuestions(TntId, Type);
            var qrst = from q in questions
                       select new
                       {
                           Id = q.Id,
                           Question = q.Question,
                           QImage = q.QImage,
                           QType = q.Type
                       };
            var answers = WMFactory.GameAnswer.GetAll();
            var arst = from a in answers
                       select new
                       {
                           Qid = a.Qid,
                           Answer = a.Answer,
                           IsRight = a.IsRight,
                           AType = a.Type,
                       };
            return Json(new { Q = qrst, A = arst }, JsonRequestBehavior.AllowGet);
        }


        [Action]
        [Description("提交数据")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Guid sid, string oid, string RightOrWrong)
        {
            Game_Record record = null;

            //没有抽奖机会
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.isAward == 1) > 100000000)
            {
                return Json(ResultMsg.Failure("您已抽过奖"));
            }
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6 && f.doTimes == 3) > 10000000)
            {
                return Json(ResultMsg.Failure("您抽奖次数已经没有了"));
            }
            else
            {
                //第一次进入游戏
                if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 6) == 0)
                {
                    record = new Game_Record();
                    record.Oid = oid;

                    //WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                    //record.Nickname = wf.nickname;
                    record.Nickname = "";
                    record.Group = 6;
                    record.Num = 0;
                    record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                    record.AwardName = "";
                    record.Seq = "";
                    record.isAward = 0;
                    record.doTimes = 0;
                    record.linkedTimes = 0;
                    record.CreateUser = "gqq";
                    WMFactory.GameRecord.Insert(record);
                }

                #region 中奖 Right
                if (RightOrWrong == "Right")
                {

                    Random Rdm = new Random();
                    //产生随机数
                    int iRdm = Rdm.Next(0, 1000);

                    IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 6);
                    record = gr.First();
                    record.isAward = 1;
                    record.doTimes = record.doTimes + 1;
                    record.ModifyUser = "gqq";

                    if (iRdm <= 20) //一等奖
                    {
                        IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 6 && f.Level == 1);
                        record.AwardId = ga.First().Id;
                        record.AwardName = ga.First().Name;
                        record.Num = 1;
                    }
                    else if (iRdm > 20 && iRdm <= 100) //二等奖
                    {
                        IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 6 && f.Level == 2);
                        record.AwardId = ga.First().Id;
                        record.AwardName = ga.First().Name;
                        record.Num = 1;
                    }
                    else if (iRdm > 100 && iRdm <= 400) //三等奖
                    {
                        IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 6 && f.Level == 3);
                        record.AwardId = ga.First().Id;
                        record.AwardName = ga.First().Name;
                        record.Num = 1;
                    }
                    else  //四等奖等于未中奖
                    {
                        IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 6 && f.Level == 4);
                        record.AwardId = ga.First().Id;
                        record.AwardName = ga.First().Name;
                        record.Num = 1;
                    }
                    try
                    {
                        //DoAward(record);
                        string awardId = DoAward(record).ToString().ToUpper();
                        Game_Ticket Ticket = new Game_Ticket();
                        Ticket.Group = 6;
                        Ticket.Oid = oid;
                        Ticket.CreateUser = "gqq";
                        Ticket.ModifyUser = "gqq";
                        Ticket.AwardId = Guid.Parse(awardId);
                        DataTable dtpList = new DataTable();
                        dtpList.Columns.Add("ticketid");
                        dtpList.Columns.Add("awardId");
                        DataRow dr = dtpList.NewRow();

                        string Ticketid = "";

                        if (awardId.ToUpper() == "C100B881-9D07-46E1-B3DE-F73B407D7C1E")//58
                        {
                            string sums = "58";
                            DataTable dtpTicket = WMFactory.Wsrr.JLTicketCreate(sums);
                            Ticketid = dtpTicket.Rows[0]["Message"].ToString();
                        }
                        else if (awardId.ToUpper() == "F2C6C399-912E-471D-93CF-A7AB83F6A3E8")//88
                        {
                            string sums = "88";
                            DataTable dtpTicket = WMFactory.Wsrr.JLTicketCreate(sums);
                            Ticketid = dtpTicket.Rows[0]["Message"].ToString();
                        }
                        else if (awardId.ToUpper() == "688A34C8-7D3B-42C1-B737-4B1BBB132EC8")//128
                        {
                            string sums = "128";
                            DataTable dtpTicket = WMFactory.Wsrr.JLTicketCreate(sums);
                            Ticketid = dtpTicket.Rows[0]["Message"].ToString();
                        }
                        else if (awardId.ToUpper() == "0162AF90-60F9-4B41-8281-70F06453A18E")//答对未中奖
                        {
                            Ticketid = "";
                        }
                        // WMFactory.GameTicket.Insert(Ticket);
                        dr["ticketid"] = Ticketid;
                        dr["awardId"] = awardId;
                        dtpList.Rows.Add(dr);
                        string jsonStr = JsonHelper.ToJson(dtpList);
                        return Json(ResultMsg.Success(jsonStr));
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                    //if (WMFactory.GameRecord.Update(record))
                    //{
                    //    string awardId = DoAward(record).ToString().ToUpper();

                    //    if (awardId == "00000000-0000-0000-0000-000000000000")
                    //        return Json(ResultMsg.Failure("00000000-0000-0000-0000-000000000000"));
                    //    else
                    //        ///调取WSRR 插入POS和插入绑定表券号返回券号
                    //        return Json(ResultMsg.Success(awardId));
                    //} 

                }

                #endregion

                #region 未中奖

                else if (RightOrWrong == "Wrong")
                {
                    record = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 6).First();
                    record.isAward = 0;
                    record.doTimes = record.doTimes + 1;
                    record.ModifyUser = "gqq";
                    DoAward(record);
                    //return Json(ResultMsg.Failure("未中奖"));
                    //return Json(ResultMsg.Success("未中奖"));
                }
                return Json(ResultMsg.Success(""));
                #endregion

            }

        }

        #region DoAward

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

                    IEnumerable<Game_Award> ga2 = WMFactory.GameAward.FindByConditions(null, f => f.Group == 6 && f.Level == newLevel);

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

        #endregion

        [Page]
        [Description("答题错误")]
        public ActionResult Wrong(Guid sid, string oid)
        {
            return View();
        }

        [Page]
        [Description("结束抽完3次之后")]
        public ActionResult CountDown(Guid sid, string oid)
        {
            return View();
        }

        [Page]
        [Description("中奖页面")]
        public ActionResult Winning(Guid sid, string oid, string awardId, string ticketid)
        {
            IEnumerable<Game_Ticket> Ticketid = WMFactory.GameTicket.FindByConditions(null, f => f.Oid == oid && f.Group == 6);
            //是否中奖,如果中奖把他的信息放进去
            //if (Ticketid == null || Ticketid.Count() <= 0)
            //{
            //    return Redirect("~/Game/JOREALLanternFestival/index?sid=" + sid + "&oid=" + oid);
            //}
            //else
            //{ awardId.Rows[0]["ticketid"].ToString()

            string strAwardId = awardId;
            string strTicketid = ticketid;
            string quantype = "";
            if (strAwardId == "C100B881-9D07-46E1-B3DE-F73B407D7C1E")
            {
                quantype = "58";
            }
            else if (strAwardId == "F2C6C399-912E-471D-93CF-A7AB83F6A3E8")
            {
                quantype = "88";
            }
            else if (strAwardId == "688A34C8-7D3B-42C1-B737-4B1BBB132EC8")
            {
                quantype = "128";
            }
            else if (strAwardId == "0162AF90-60F9-4B41-8281-70F06453A18E")
            {
                quantype = "000";
            }
            ViewBag.Ticketid = strTicketid;
            ViewBag.quantype = quantype;
            return View();
            //}
        }

        [Page]
        [Description("祝福页面")]
        public ActionResult Wish(Guid sid, string oid)
        {
            return View();
        }

        /// <summary>
        /// 获奖之后，微信通知用户
        /// </summary>
        private void SendWxSvrNotice(string oid, string sum)
        {
            try
            {

                //获取申请人的openId
                Guid sid = Guid.Parse("74111E62-F8D7-4D63-805E-36E14A930F04");
                WxServiceNotice notice = new WxServiceNotice();
                notice.touser = oid;
                notice.template_id = "2j8tjIyRstLSBdZC86rquwsc6HhHrmFd1roz3pI72f4";
                notice.url = "http://it.hwafashion.com/game/JOREALLanternFestival/Index?sid=FEF432AF-D0AE-4876-8200-931F47BEF854";
                notice.topcolor = "#ff6666";
                notice.data = "{\"first\":{\"value\":\"尊敬的" + "用户" + "，恭喜获取卓莱雅礼券。\\n\\n\",\"color\":\"#66cc33\"},"
                              + "\"keyword1\":{\"value\":\"春装代金券" + "\",\"color\":\"#66cc33\"},"
                              + "\"keyword2\":{\"value\":\"" + sum + "\",\"color\":\"#666666\"},"
                              + "\"keyword3\":{\"value\":\"" + DateTime.Now.ToString() + "\",\"color\":\"#666666\"},"
                              + "\"remark\":{\"value\":\"描述：" + "凭此券到雅莹奥莱自营线下门店购买春装即可抵用" + "\",\"color\":\"#333333\"}}";
                ElegantWM.WeiXin.Common.SendServiceNotice("74111E62-F8D7-4D63-805E-36E14A930F04", notice);
            }
            catch (Exception error)
            {
                //log.Error(error.Message);
            }
        }

    }
}