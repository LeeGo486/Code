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
    public class PachiraMacrocarpaController : Controller
    {
        string OID;//定义全局微信号
        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("发财树抽奖")]
        [Open]
        public string Award(Guid sid, string oid)
        {
            OID = oid;
            if (WMFactory.GameRecord.GetCount(f => f.Oid == oid && f.Group == 5) > 0)
            {
                return repeat();
            }

            Random Rdm = new Random();

            //产生0到4200的随机数
            int iRdm = Rdm.Next(0, 2500);

            Game_Record record = new Game_Record();
            record.Oid = oid;
            record.Group = 5;
            record.Num = 1;
            record.isAward = 0;
            record.CreateUser = "gqq";


            WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            record.Nickname = wf.nickname;

            if (iRdm < 14) //香皂
            {
                record.AwardId = new Guid("3a4c0d33-7405-4bef-a534-0dbe135e093a");
                record.AwardName = "xz.jpg";
            }
            else if (iRdm >= 14 && iRdm < 28) //羊绒围巾
            {
                record.AwardId = new Guid("3e005e48-7646-4fe4-b103-b0a83a4b0003");
                record.AwardName = "yrwj.jpg";
            }
            else if (iRdm >= 28 && iRdm < 42) //红围巾
            {
                record.AwardId = new Guid("513471b7-dff3-4e91-926c-2d03da3a718c");
                record.AwardName = "hwj.jpg";
            }
            else if (iRdm >= 42 && iRdm < 56) //伞
            {
                record.AwardId = new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d");
                record.AwardName = "s.jpg";
            }
            else if (iRdm >= 56 && iRdm < 70) //杯子组
            {
                record.AwardId = new Guid("23256a32-3028-44b1-a705-e6b24dd4896c");
                record.AwardName = "bzz.jpg";
            }
            else if (iRdm >= 70 && iRdm < 200) //白
            {
                record.AwardId = new Guid("51822c8a-113a-449e-a92e-7a1da18af1cf");
            }
            else if (iRdm >= 200 && iRdm < 400) //橙
            {
                record.AwardId = new Guid("b4f5f06d-0c20-4676-b00e-b7b468332995");
            }
            else if (iRdm >= 400 && iRdm < 700) //粉
            {
                record.AwardId = new Guid("00a24f0a-807b-47d9-a85b-b0f5a60df836");
            }
            else if (iRdm >= 700 && iRdm < 900) //红
            {
                record.AwardId = new Guid("3c5d463d-5f1a-47cf-baca-141325d4e7df");
            }
            else if (iRdm >= 900 && iRdm < 1100) //黄
            {
                record.AwardId = new Guid("9367e840-ed3b-4473-8ea8-8798bb0320d5");
            }
            else if (iRdm >= 1100 && iRdm < 1400) //蓝
            {
                record.AwardId = new Guid("f7f1d78e-d611-409d-86df-f9c88023d386");
            }
            else if (iRdm >= 1400 && iRdm < 1600) //绿
            {
                record.AwardId = new Guid("f4e70a89-51c4-42f3-92b9-a9c5cee0e8f2");
            }
            else if (iRdm >= 1600 && iRdm < 1800) //青
            {
                record.AwardId = new Guid("b6739896-b18e-4ca4-b149-ed5939846c88");
            }
            else if (iRdm >= 1800 && iRdm < 2500) //紫
            {
                record.AwardId = new Guid("ba817dee-d82d-495f-8033-5b20cad95f1c");
            }
            else
            {
                record.AwardId = new Guid("ba817dee-d82d-495f-8033-5b20cad95f1c");
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
                    if (record.AwardId == new Guid("3a4c0d33-7405-4bef-a534-0dbe135e093a")) //香皂
                    {
                        return xzAward();
                    }
                    else if (record.AwardId == new Guid("3e005e48-7646-4fe4-b103-b0a83a4b0003")) //羊绒围巾
                    {
                        return yrwjAward();
                    }
                    else if (record.AwardId == new Guid("513471b7-dff3-4e91-926c-2d03da3a718c")) //红围巾
                    {
                        return hwjAward();
                    }
                    else if (record.AwardId == new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d")) //伞
                    {
                        return sAward();
                    }
                    else if (record.AwardId == new Guid("23256a32-3028-44b1-a705-e6b24dd4896c")) //杯子组
                    {
                        return bzzAward();
                    }
                    else if (record.AwardId == new Guid("51822c8a-113a-449e-a92e-7a1da18af1cf")) //白
                    {
                        return baiAward();
                    }
                    else if (record.AwardId == new Guid("b4f5f06d-0c20-4676-b00e-b7b468332995")) //橙
                    {
                        return cengAward();
                    }
                    else if (record.AwardId == new Guid("00a24f0a-807b-47d9-a85b-b0f5a60df836")) //粉
                    {
                        return fenAward();
                    }
                    else if (record.AwardId == new Guid("3c5d463d-5f1a-47cf-baca-141325d4e7df")) //红
                    {
                        return hongAward();
                    }
                    else if (record.AwardId == new Guid("9367e840-ed3b-4473-8ea8-8798bb0320d5")) //黄
                    {
                        return huangAward();
                    }
                    else if (record.AwardId == new Guid("f7f1d78e-d611-409d-86df-f9c88023d386")) //蓝
                    {
                        return lanAward();
                    }
                    else if (record.AwardId == new Guid("f4e70a89-51c4-42f3-92b9-a9c5cee0e8f2")) //绿
                    {
                        return lvAward();
                    }
                    else if (record.AwardId == new Guid("b6739896-b18e-4ca4-b149-ed5939846c88")) //青
                    {
                        return qingAward();
                    }
                    else if (record.AwardId == new Guid("ba817dee-d82d-495f-8033-5b20cad95f1c")) //紫
                    {
                        return ziAward();
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
                    if (record.AwardId == new Guid("3a4c0d33-7405-4bef-a534-0dbe135e093a")) //香皂
                    {
                        record.AwardId = new Guid("3e005e48-7646-4fe4-b103-b0a83a4b0003");
                        record.AwardName = "yrwj.jpg";
                    }
                    else if (record.AwardId == new Guid("3e005e48-7646-4fe4-b103-b0a83a4b0003")) //羊绒围巾
                    {
                        record.AwardId = new Guid("513471b7-dff3-4e91-926c-2d03da3a718c");
                        record.AwardName = "hwj.jpg";
                    }
                    else if (record.AwardId == new Guid("513471b7-dff3-4e91-926c-2d03da3a718c")) //红围巾
                    {
                        record.AwardId = new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d");
                        record.AwardName = "s.jpg";
                    }
                    else if (record.AwardId == new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d")) //伞
                    {
                        record.AwardId = new Guid("23256a32-3028-44b1-a705-e6b24dd4896c");
                        record.AwardName = "bzz.jpg";
                    }
                    else if (record.AwardId == new Guid("23256a32-3028-44b1-a705-e6b24dd4896c")) //杯子组
                    {
                        record.AwardId = new Guid("51822c8a-113a-449e-a92e-7a1da18af1cf");
                        record.AwardName = "";
                    }
                    else if (record.AwardId == new Guid("51822c8a-113a-449e-a92e-7a1da18af1cf")) //白
                    {
                        record.AwardId = new Guid("b4f5f06d-0c20-4676-b00e-b7b468332995");
                    }
                    else if (record.AwardId == new Guid("b4f5f06d-0c20-4676-b00e-b7b468332995")) //橙
                    {
                        record.AwardId = new Guid("00a24f0a-807b-47d9-a85b-b0f5a60df836");
                    }
                    else if (record.AwardId == new Guid("00a24f0a-807b-47d9-a85b-b0f5a60df836")) //粉
                    {
                        record.AwardId = new Guid("3c5d463d-5f1a-47cf-baca-141325d4e7df");
                    }
                    else if (record.AwardId == new Guid("3c5d463d-5f1a-47cf-baca-141325d4e7df")) //红
                    {
                        record.AwardId = new Guid("9367e840-ed3b-4473-8ea8-8798bb0320d5");
                    }
                    else if (record.AwardId == new Guid("9367e840-ed3b-4473-8ea8-8798bb0320d5")) //黄
                    {
                        record.AwardId = new Guid("f7f1d78e-d611-409d-86df-f9c88023d386");
                    }
                    else if (record.AwardId == new Guid("f7f1d78e-d611-409d-86df-f9c88023d386")) //蓝
                    {
                        record.AwardId = new Guid("f4e70a89-51c4-42f3-92b9-a9c5cee0e8f2");
                    }
                    else if (record.AwardId == new Guid("f4e70a89-51c4-42f3-92b9-a9c5cee0e8f2")) //绿
                    {
                        record.AwardId = new Guid("b6739896-b18e-4ca4-b149-ed5939846c88");
                    }
                    else if (record.AwardId == new Guid("b6739896-b18e-4ca4-b149-ed5939846c88")) //青
                    {
                        record.AwardId = new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d");
                    }
                    else if (record.AwardId == new Guid("ba817dee-d82d-495f-8033-5b20cad95f1c")) //紫
                    {
                        record.AwardId = new Guid("ba817dee-d82d-495f-8033-5b20cad95f1c");
                    }
                    //else if (record.AwardId == new Guid("a33e09a9-09c7-4393-aa1f-ee4b47f7083d")) //
                    //{
                    //    record.AwardId = new Guid("00000000-0000-0000-0000-000000000000");
                    //    record.Num = 0;
                    //}
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

        public string xzAward()
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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130213719997.jpg",
                "http://it.hwafashion.com/Game/PachiraMacrocarpa/Info?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&oid=" + OID + "");
        }

        public string yrwjAward()
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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130213719997.jpg",
                "http://it.hwafashion.com/Game/PachiraMacrocarpa/Info?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&oid=" + OID + "");
        }

        public string hwjAward()
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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130213719997.jpg",
                "http://it.hwafashion.com/Game/PachiraMacrocarpa/Info?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&oid=" + OID + "");
        }

        public string sAward()
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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130213719997.jpg",
                "http://it.hwafashion.com/Game/PachiraMacrocarpa/Info?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&oid=" + OID + "");
        }

        public string bzzAward()
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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130213719997.jpg",
                "http://it.hwafashion.com/Game/PachiraMacrocarpa/Info?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&oid=" + OID + "");
        }

        #endregion

        #region 未中奖
        public string baiAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205159618.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/DA597FBA-E545-4AE6-9FCA-F2D7C1439780?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string cengAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205118933.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/2AE1DDFC-B2D2-4BF3-B937-5994A444D724?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string fenAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205038669.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/03E63303-9CA5-4519-B793-303C5A4069C8?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string hongAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205153955.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/4AD9FE72-AE62-4C43-96C3-CC72C06FD732?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string huangAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
               "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205139306.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/0A57A5A6-695F-43D4-A136-B0D8748EC27A?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string lanAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",

               "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205146732.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/CA56927A-FEAC-4B90-A91A-BC34347DB69F?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string lvAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
               "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205110524.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/36E3FC6D-5F53-4D89-A006-5489AC12B624?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string qingAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205124954.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/6999CC1E-5007-48C6-9CB0-5EC485E58984?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        public string ziAward()
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
               "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205131818.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/BD37B466-E9D4-41CB-94AD-964AF81BD08C?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
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
                "很遗憾，您未中奖！不过，来看一下华之毅为你准备的祝福吧！",
                "请点击图文查看祝福详情！",
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150130205131818.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/BD37B466-E9D4-41CB-94AD-964AF81BD08C?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }
        #endregion

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
                "http://it.hwafashion.com/Content/Uploads/bd20ed8f-0bd5-45b7-9d37-c85552d1701e/WxRespImg/20150131153336108.jpg",
                "http://it.hwafashion.com/WeiXin/Article/Index/353AF387-D3D6-466B-BD86-876F6171E6E1?sid=f6ae42b0-10ff-439f-85ae-14d755bdb9b1&kid=869EB573-027D-4104-A718-D891E7F8C299");
        }

        [Page]
        [Description("抽奖")]
        [Open]
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


        [Page]
        [Description("获取获奖信息显示获奖信息")]
        public ActionResult Info(Guid sid, string oid)
        {
            IEnumerable<Game_Record> Info = WMFactory.GameRecord.FindByConditions(null, f => f.Oid == oid && f.Group == 5 && f.AwardName.IndexOf("jpg") > -1);
            ViewBag.Info = Info;
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
            gu.Group = 5;

            if (WMFactory.GameUserInfo.Insert(gu))
                return Json(ResultMsg.Success("信息提交成功。"));
            else
                return Json(ResultMsg.Failure("信息提交失败，请重试！"));
        }
    }
}
