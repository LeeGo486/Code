using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class JuiceBarController : Controller
    {
        //
        // GET: /Game/JuiceBar/
        private DataTable GetCurUser()
        {
            DataTable dtUser = WMFactory.Wsrr.CheckS3UserBind(Request["oid"]);
            return dtUser;
        }

        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("果汁吧抽奖")]
        [Open]
        public string Award(Guid sid,string oid)
        {
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 1) > 0)
            {
                return repeat();
            }

            Random Rdm = new Random();

            //产生0到4200的随机数
            int iRdm = Rdm.Next(0, 2000);

            Game_Record record = new Game_Record();
            record.Oid = oid;
            record.Group = 1;
            record.Num = 1;
            record.isAward = 0;

            DataTable dtUser = GetCurUser();
            record.CreateUser = "jmj";
            //record.CreateUser = dtUser.Rows[0]["names"].ToString();

            if (iRdm < 5) //一等奖
            {
                record.AwardId = new Guid("BABB0AA4-D835-43B9-95F3-579FFF0969C2");
            }
            else if (iRdm >= 5 && iRdm < 13) //二等奖
            {
                record.AwardId = new Guid("D01EB68A-5137-4C99-99E1-B5FBE0829A46");
            }
            else if (iRdm >= 13 && iRdm < 28) //三等奖
            {
                record.AwardId = new Guid("61012CBD-D82A-4A6A-9632-6BDB3D90F41A");
            }
            else if (iRdm >= 28 && iRdm < 128) //四等奖
            {
                record.AwardId = new Guid("A370E0FE-0E55-41B6-8566-666152CF5628");
            }
            else
            {
                record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
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
                    if (record.AwardId == new Guid("BABB0AA4-D835-43B9-95F3-579FFF0969C2")) //一等奖
                    {
                        return firstAward();
                    }
                    else if (record.AwardId == new Guid("D01EB68A-5137-4C99-99E1-B5FBE0829A46")) //二等奖
                    {
                        return secondAward();
                    }
                    else if (record.AwardId == new Guid("61012CBD-D82A-4A6A-9632-6BDB3D90F41A")) //三等奖
                    {
                        return thirdAward();
                    }
                    else if (record.AwardId == new Guid("A370E0FE-0E55-41B6-8566-666152CF5628")) //四等奖
                    {
                        return forthAward();
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
                    if (record.AwardId == new Guid("BABB0AA4-D835-43B9-95F3-579FFF0969C2")) //一等奖变二等奖
                    {
                        record.AwardId = new Guid("D01EB68A-5137-4C99-99E1-B5FBE0829A46");
                    }
                    else if (record.AwardId == new Guid("D01EB68A-5137-4C99-99E1-B5FBE0829A46")) //二等奖变三等奖
                    {
                        record.AwardId = new Guid("61012CBD-D82A-4A6A-9632-6BDB3D90F41A");
                    }
                    else if (record.AwardId == new Guid("61012CBD-D82A-4A6A-9632-6BDB3D90F41A")) //三等奖变四等奖
                    {
                        record.AwardId = new Guid("A370E0FE-0E55-41B6-8566-666152CF5628");
                    }
                    else if (record.AwardId == new Guid("A370E0FE-0E55-41B6-8566-666152CF5628")) //四等奖悲剧
                    {
                        record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
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

        public string firstAward()
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
                "哇，你中奖了哦！",
                "快把这份好运转发给你的小伙伴吧！",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118152553124.jpg", 
                "http://it.hwafashion.com/WeiXin/Article/Index/bc6e5fd6-0207-4057-97e7-6abc8c941025?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

        public string secondAward()
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
                "嘿嘿，你中奖了哦！",
                "快把这份好运转发给你的小伙伴吧！",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118152525590.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/c9efecb7-e429-4dd8-8a1f-3cf7a9cdcb57?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

        public string thirdAward()
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
                "咦，你中奖了呢！",
                "快把这份好运转发给你的小伙伴吧！",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118152613653.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/030a0420-2f78-407c-a346-60b932015e71?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

        public string forthAward()
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
                "恭喜，你中奖了！",
                "快把这份好运转发给你的小伙伴吧！",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118152637225.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/a6744847-21a4-46ee-afd6-af7ec0a49680?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

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
                "呜~ 你没有中奖哦！",
                "不如转发一下，让你的小伙伴请你喝一杯吧~",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118165449113.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/f1c997df-51a5-467b-b802-296d101594f4?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

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
                "一个微信id只可参与一次哦，不如转发，让你的小伙伴也来试试运气吧！",
                "http://it.hwafashion.com/Content/Uploads/f6ae42b0-10ff-439f-85ae-14d755bdb9b1/WxRespImg/20141118152736318.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/7868eb80-c0e7-4922-b07f-600057894dfa?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=b65612f0-53b2-433e-9660-f1696d95c26a");
        }

        [Page]
        [Description("果汁吧领奖")]
        [Open]
        public string Check(Guid sid, string oid)
        {
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 1) == 0)
            {
                return "您尚未抽过奖，快去抽一次吧！";
            }
            else
            {
                List<Game_Record> gr = (List<Game_Record>)WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 1);
                if (gr[0].AwardId == new Guid("00000000-0000-0000-0000-000000000000"))
                {
                    return "很遗憾，您未中奖！";
                }
                else if (gr[0].isAward == 1)
                {
                    return "对不起，您已经领过奖了！";
                }
                else
                {
                    gr[0].isAward = 1;
                    gr[0].ModifyUser = "jmj";

                    DataTable dtUser = GetCurUser();
                    //gr[0].ModifyUser = dtUser.Rows[0]["names"].ToString();
                    if (WMFactory.GameRecord.Update(gr[0]))
                    {
                        Game_Award ga = WMFactory.GameAward.GetById(gr[0].AwardId.ToString());
                        return ga.Name;
                    }
                    else
                    {
                        return "请重试！";
                    }
                    
                }
            }
        }
    }
}
