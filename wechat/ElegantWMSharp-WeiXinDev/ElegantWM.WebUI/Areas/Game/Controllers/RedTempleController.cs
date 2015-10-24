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
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class RedTempleController : Controller
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        string OID;//定义全局微信号
        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("红庵里抽奖")]
        [Open]
        public string Award(Guid sid, string oid)
        {
            OID = oid;

            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 9 && f.isAward == 1) > 0)
            {
                return repeatAward();
            }
            else if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 9) > 0)
            {
                return repeat();
            }
            Random Rdm = new Random();

            //产生0到4200的随机数
            int iRdm = Rdm.Next(0, 100);
            Game_Record record = new Game_Record();
            record.Oid = oid;
            record.Group = 9;
            record.Num = 1;
            record.isAward = 0;
            record.CreateUser = "gqq";

            // WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            IEnumerable<WX_Fans> fans = WMFactory.WXFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid);
            record.Nickname = fans.First().NickName;
            if (iRdm < 3) //礼盒配套组合(甜瓜玉米小黄瓜小番茄)
            {
                record.AwardId = new Guid("79E82ADD-73C6-456F-86ED-8FE39A08A5B7");
                record.isAward = 1;
                record.AwardName = "礼盒配套组合(甜瓜玉米小黄瓜小番茄)";
                //record.AwardName = "xz.jpg";
            }
            else if (iRdm >= 3 && iRdm < 6) //礼盒配套组合(小黄瓜小番茄)
            {
                record.AwardId = new Guid("5775CBFA-06D2-4DB6-8B51-66E7195A0AEA");
                record.isAward = 1;
                record.AwardName = "礼盒配套组合(小黄瓜小番茄)";
                //record.AwardName = "yrwj.jpg";
            }
            else if (iRdm >= 6 && iRdm < 10) //单品礼盒(小黄瓜或小番茄)
            {
                record.AwardId = new Guid("32C1FCFD-30E6-433B-AE76-B43F69C1CB3C");
                record.isAward = 1;
                record.AwardName = "单品礼盒(小黄瓜或小番茄)";
                // record.AwardName = "hwj.jpg";
            }
            else
            {
                record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");//未中奖
                record.isAward = 0;
            }
            return DoAward(record);
        }

        #region DoAward兑奖

        public string DoAward(Game_Record record)
        {
            try
            {
                if (WMFactory.GameRecord.Insert(record))
                {
                    if (record.AwardId == new Guid("79E82ADD-73C6-456F-86ED-8FE39A08A5B7")) //礼盒配套组合(甜瓜玉米小黄瓜小番茄)
                    {
                        return oneAward();
                    }
                    else if (record.AwardId == new Guid("5775CBFA-06D2-4DB6-8B51-66E7195A0AEA")) //礼盒配套组合(小黄瓜小番茄)
                    {
                        return twoAward();
                    }
                    else if (record.AwardId == new Guid("32C1FCFD-30E6-433B-AE76-B43F69C1CB3C")) //单品礼盒(小黄瓜或小番茄)
                    {
                        return threeAward();
                    }
                    else
                    {
                        return noAward();
                    }
                }
                else
                    return noAward();
            }
            catch (Exception e)
            {
                string s = e.GetBaseException().Message.ToString();
                if (s == "奖品已经发完啦!") //所中奖品数量为0，奖品向下降级
                {
                    if (record.AwardId == new Guid("79E82ADD-73C6-456F-86ED-8FE39A08A5B7")) //礼盒配套组合(甜瓜玉米小黄瓜小番茄)
                    {
                        record.AwardId = new Guid("5775CBFA-06D2-4DB6-8B51-66E7195A0AEA");
                        //record.AwardName = "yrwj.jpg";
                    }
                    else if (record.AwardId == new Guid("5775CBFA-06D2-4DB6-8B51-66E7195A0AEA")) //礼盒配套组合(小黄瓜小番茄)
                    {
                        record.AwardId = new Guid("32C1FCFD-30E6-433B-AE76-B43F69C1CB3C");
                        //record.AwardName = "hwj.jpg";
                    }
                    else if (record.AwardId == new Guid("32C1FCFD-30E6-433B-AE76-B43F69C1CB3C")) //单品礼盒(小黄瓜或小番茄)
                    {
                        record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                        //record.AwardName = "s.jpg";
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

        #region 中奖

        public string oneAward()    //一等奖
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "恭喜您中奖啦！请点击图文了解中奖详情！",
                "请点击图文看一看你中的奖项，并且留下你的联系方式哦！",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211422448.jpg",
                "http://it.hwafashion.com/Game/RedTemple/Info?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&oid=" + OID + "");
        }

        public string twoAward()//二等奖
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "恭喜您中奖啦！请点击图文了解中奖详情！",
                "请点击图文看一看你中的奖项，并且留下你的联系方式哦！",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211422448.jpg",
                "http://it.hwafashion.com/Game/RedTemple/Info?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&oid=" + OID + "");
        }

        public string threeAward()//三等奖
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "恭喜您中奖啦！请点击图文了解中奖详情！",
                "请点击图文看一看你中的奖项，并且留下你的联系方式哦！",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211422448.jpg",
                "http://it.hwafashion.com/Game/RedTemple/Info?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&oid=" + OID + "");
        }

        #endregion

        #region 未中奖

        public string noAward()
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "很遗憾，您未中奖！！",
                "很遗憾，您未中奖！！",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211527142.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/5EA92404-F174-414D-9CAF-B6AB715BFB73?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&kid=412013FC-62F3-4E4B-AE4C-94E3C2C82855");
        }
        #endregion

        #region 参加过提示

        public string repeat()
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "呀~ 你已经参与过了！",
                "一个微信id只可参与一次哦",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211502587.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/5EA92404-F174-414D-9CAF-B6AB715BFB73?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&kid=412013FC-62F3-4E4B-AE4C-94E3C2C82855");

        }

        public string repeatAward()
        {
            string template = @"<Articles>
                                <item>
                                <Title><![CDATA[{0}]]></Title>
                                <Description><![CDATA[{1}]]></Description>
                                <PicUrl><![CDATA[{2}]]></PicUrl>
                                <Url><![CDATA[{3}]]></Url>
                                </item>
                                </Articles>";

            return string.Format(template,
                "呀~ 你已经参与过了！并且中过奖了！",
                "点击查看你获得的奖品",
                "http://it.hwafashion.com/Content/Uploads/07f63c5b-44ae-4ea3-86bc-7e463acebff7/WxRespImg/20150505211502587.jpg",
                 "http://it.hwafashion.com/Game/RedTemple/Info?sid=07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7&oid=" + OID + "");
        }
        #endregion


        [Page]
        [Description("获取获奖信息显示获奖信息")]
        public ActionResult Info(Guid sid, string oid)
        {
            IEnumerable<Game_Record> Info = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 9 && f.isAward == 1);
            ViewBag.Awardimg = Info.First().AwardId + ".jpg";
            return View();
        }

        [Page]
        [Description("填写联系方式")]
        public ActionResult psInfo(Guid sid, string oid)
        {
            return View();
        }


        [Action]
        [Description("填写联系方式提交信息")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_UserInfo gu)
        {
            gu.CreateUser = "gqq";
            gu.Group = 9;

            IEnumerable<Game_UserInfo> gt = WMFactory.GameUserInfo.FindByConditions(null, f => f.Oid == gu.Oid && f.Group == 9);

            if (gt.Count() > 0)
            {
                Game_UserInfo gt2 = gt.First();
                gt2.Oid = gu.Oid;
                gt2.Address = gu.Address;
                gt2.Name = gu.Name;
                gt2.Tel = gu.Tel;
                gt2.ModifyUser = "gqq";
                if (WMFactory.GameUserInfo.Update(gt2))
                    return Json(ResultMsg.Success("信息提交成功。"));
                else
                    return Json(ResultMsg.Failure("信息提交失败，请重试！"));
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
        [Description("送券")]
        [Open]
        public string SendTicket(Guid sid, string oid)
        {
            string strTicket = Guid.NewGuid().ToString();
            IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Oid == oid && f.Group == 9);

            if (gt.Count() > 0)
            {
                return "领取代金券失败，你已经领过代金券，你的代金券为：" + gt.First().Ticketid + " \n\r代金券使用需知：\r凭此券可购买“红庵里”任意农产品 \r每次满30元可使用一张5元代金券 \r每人单次最多可使用10张。";
            }
            else
            {
                Game_Ticket Ticket = new Game_Ticket();
                Ticket.Group = 9;
                Ticket.AwardId = new Guid("07F63C5B-44AE-4EA3-86BC-7E463ACEBFF7");
                Ticket.Ticketid = strTicket;
                Ticket.Oid = oid;
                Ticket.CreateUser = "gqq";
                Ticket.ModifyUser = "gqq";
                Ticket.Oid = oid;
                WMFactory.GameTicket.Insert(Ticket);
                return "恭喜你！成功领取5元代金券 \r代金券号：" + strTicket + " \r代金券使用需知：\n\r凭此券可购买“红庵里”任意农产品 \r每次满30元可使用一张5元代金券 \r每人单次最多可使用10张。";
            }
        }
    }
}
