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
    public class NpaiaTicketController : Controller
    {
        //
        // GET: /Game/NpaiaTicket/
        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("抽奖")]
        public string Award(Guid sid, string oid)
        {
            string viptel = "";
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans == null || fans.Count() <= 0)
            {
                return register(sid, oid);
            }
            else
            {
                viptel = fans.First().Telphone;
                DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(viptel);

                if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
                {
                    return register(sid, oid);
                }
            }

            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 4);

            //重复抽奖
            if (gr.Count() > 0)
            {
                //未中奖
                if (gr.First().AwardId == new Guid("00000000-0000-0000-0000-000000000000"))
                {
                    return noAward(false);
                }

                Game_Award gaf = WMFactory.GameAward.GetById(gr.First().AwardId.ToString());

                //中奖，查看是否有中券号
                IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Oid == oid && f.Group == 4);
                //中券号
                if (gt.Count() > 0)
                {
                    if (gaf.Level == 1) //一等奖
                    {
                        return firstAward(false, gt.First().Ticketid);
                    }
                    else if (gaf.Level == 2) //二等奖
                    {
                        return secondAward(false, gt.First().Ticketid);
                    }
                    else if (gaf.Level == 3) //三等奖
                    {
                        return thirdAward(false, gt.First().Ticketid);
                    }
                    else
                    {
                        return noAward(false);
                    }
                }
                //未中券号，重新赋券号
                else
                {
                    //搜索中奖券号
                    IEnumerable<Game_Ticket> gt2 = WMFactory.GameTicket.FindByConditions(null, f => f.Group == 4 && f.AwardId == gaf.Id && string.IsNullOrEmpty(f.Oid));

                    if (gt2.Count() > 0)
                    {
                        Game_Ticket gtf = gt2.First();
                        gtf.Oid = gr.First().Oid;

                        gtf.ModifyUser = "JMJ";

                        if (WMFactory.GameTicket.Update(gtf))
                        {
                            if (gaf.Level == 1) //一等奖
                            {
                                return firstAward(false, gtf.Ticketid);
                            }
                            else if (gaf.Level == 2) //二等奖
                            {
                                return secondAward(false, gtf.Ticketid);
                            }
                            else if (gaf.Level == 3) //三等奖
                            {
                                return thirdAward(false, gtf.Ticketid);
                            }
                            else
                            {
                                return noAward(false);
                            }
                        }
                        else
                        {
                            return noAward(false);
                        }
                    }
                    //券号已用完
                    else
                    {
                        return noAward(false);
                    }
                }
            }

            Random Rdm = new Random();

            //产生0到4200的随机数
            int iRdm = Rdm.Next(0, 841);

            Game_Record record = new Game_Record();
            record.Oid = oid;
            record.Group = 4;
            record.Num = 1;
            record.isAward = 0;
            record.CreateUser = "jmj";

            WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            record.Nickname = wf.nickname;

            if (iRdm < 2) //一等奖
            {
                IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 4 && f.Level == 1);
                record.AwardId = ga.First().Id;
                record.AwardName = ga.First().Name;
            }
            else if (iRdm >= 2 && iRdm < 5) //二等奖
            {
                IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 4 && f.Level == 2);
                record.AwardId = ga.First().Id;
                record.AwardName = ga.First().Name;
            }
            else if (iRdm >= 5 && iRdm < 505) //三等奖
            {
                IEnumerable<Game_Award> ga = WMFactory.GameAward.FindByConditions(null, f => f.Group == 4 && f.Level == 3);
                record.AwardId = ga.First().Id;
                record.AwardName = ga.First().Name;
            }
            else
            {
                record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                record.AwardName = "";
                record.Num = 0;
            }
            return DoAward(record);
        }

        public string DoAward(Game_Record record)
        {
            try
            {
                if (WMFactory.GameRecord.Insert(record))
                {
                    Game_Award ga = WMFactory.GameAward.GetById(record.AwardId.ToString());
                    //未中奖
                    if (ga == null)
                    {
                        return noAward(true);
                    }

                    //搜索中奖券号
                    IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Group == 4 && f.AwardId == ga.Id && string.IsNullOrEmpty(f.Oid));

                    if (gt.Count() > 0)
                    {
                        Game_Ticket gt2 = gt.First();
                        gt2.Oid = record.Oid;

                        gt2.ModifyUser = "JMJ";

                        if (WMFactory.GameTicket.Update(gt2))
                        {
                            if (ga.Level == 1) //一等奖
                            {
                                return firstAward(true, gt2.Ticketid);
                            }
                            else if (ga.Level == 2) //二等奖
                            {
                                return secondAward(true, gt2.Ticketid);
                            }
                            else if (ga.Level == 3) //三等奖
                            {
                                return thirdAward(true, gt2.Ticketid);
                            }
                            else
                            {
                                return noAward(true);
                            }
                        }
                        else
                        {
                            return noAward(true);
                        }
                    }
                    //券号已用完
                    else
                    {
                        return noAward(true);
                    }
                }
                else
                    return noAward(true);
            }
            catch (Exception e)
            {
                string s = e.GetBaseException().Message.ToString();
                if (s == "奖品已经发完啦!") //所中奖品数量为0，奖品向下降级
                {
                    Game_Award ga = WMFactory.GameAward.GetById(record.AwardId.ToString());
                    int newLevel = ga.Level + 1;

                    IEnumerable<Game_Award> ga2 = WMFactory.GameAward.FindByConditions(null, f => f.Group == 4 && f.Level == newLevel);

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

        public string firstAward(bool first, string ticketid)
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
                first ? "恭喜您中奖了！请点击图文了解奖券使用规则！" : "您抽过了哦！",
                "请点击图文了解奖券使用规则！中奖券号" + ticketid + ",您可前往恩派雅全国自营门店使用！",
                "http://it.hwafashion.com/Content/Uploads/ff25138f-08f0-49c8-8768-83efaddb2618/WxRespImg/20150123155745406.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/dba041c2-e31f-49b3-8048-0cfc2b8b6afb?sid=ff25138f-08f0-49c8-8768-83efaddb2618&kid=61f55214-37a1-41db-9e49-2e27486005d4");
        }

        public string secondAward(bool first, string ticketid)
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
                first ? "恭喜您中奖了！请点击图文了解奖券使用规则！" : "您抽过了哦！",
                "请点击图文了解奖券使用规则！中奖券号" + ticketid + ",您可前往恩派雅全国自营门店使用！",
                "http://it.hwafashion.com/Content/Uploads/ff25138f-08f0-49c8-8768-83efaddb2618/WxRespImg/20150123155649168.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/dba041c2-e31f-49b3-8048-0cfc2b8b6afb?sid=ff25138f-08f0-49c8-8768-83efaddb2618&kid=61f55214-37a1-41db-9e49-2e27486005d4");
        }

        public string thirdAward(bool first, string ticketid)
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
                first ? "恭喜您中奖了！请点击图文了解奖券使用规则！" : "您抽过了哦！",
                "请点击图文了解奖券使用规则！中奖券号" + ticketid + ",您可前往恩派雅全国自营门店使用！",
                "http://it.hwafashion.com/Content/Uploads/ff25138f-08f0-49c8-8768-83efaddb2618/WxRespImg/20150123155528453.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/dba041c2-e31f-49b3-8048-0cfc2b8b6afb?sid=ff25138f-08f0-49c8-8768-83efaddb2618&kid=61f55214-37a1-41db-9e49-2e27486005d4");
        }

        public string noAward(bool first)
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
                first ? "很遗憾，您没有中奖。" : "您抽过了哦！",
                "感谢您对恩派雅的支持。",
                "http://it.hwafashion.com/Content/Uploads/ff25138f-08f0-49c8-8768-83efaddb2618/WxRespImg/20150126102752972.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/91072100-deab-4e59-94c4-03744f2be54a?sid=ff25138f-08f0-49c8-8768-83efaddb2618&kid=61f55214-37a1-41db-9e49-2e27486005d4");
        }

        public string register(Guid sid, string oid)
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
                "请您先绑定！",
                "点击注册成为恩派雅会员，抽取iPhone 6等礼品。",
                "http://it.hwafashion.com/Content/Uploads/ff25138f-08f0-49c8-8768-83efaddb2618/WxRespImg/20150131235727713.jpg",
                "http://it.hwafashion.com/NPaia/VIP/CreateVip?sid=" + sid.ToString() + "&oid=" + oid);
        }

        [Page]
        [Description("抽奖")]
        public string Clear(Guid sid, string oid)
        {
            IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 4 && f.Oid == oid);

            if (gr.Count() > 0)
            {
                WMFactory.GameRecord.Delete(gr.First());
            }


            IEnumerable<Game_Ticket> gt = WMFactory.GameTicket.FindByConditions(null, f => f.Group == 4 && f.Oid == oid);

            if (gt.Count() > 0)
            {
                Game_Ticket gt2 = gt.First();
                gt2.Oid = "";
                gt2.ModifyUser = "JMJ";

                WMFactory.GameTicket.Update(gt2);
            }

            return "重置成功";
        }
    }
}
