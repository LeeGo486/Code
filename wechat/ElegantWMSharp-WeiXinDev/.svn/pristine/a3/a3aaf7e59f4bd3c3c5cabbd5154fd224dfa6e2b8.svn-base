using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.DTO;
using System.Text.RegularExpressions;
using System.Web.Security;
using ElegantWM.WeiXin.MsgEntity;
namespace ElegantWM.WebUI.Areas.DLWXSite.Controllers
{
    public class VIPController : BaseDLWXSiteController //BaseDLWXSite
    {
        //
        // GET: /DL/VIP/

        [Page]
        [Description("VIP主页")]
        public ActionResult Index(Guid sid, string oid)
        {

            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            if (dtpCentum.Rows[0]["phone"].ToString() == "")
            {
                return Redirect("~/DLWXSite/VIP/CreateVIP?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                ViewBag.UserName = dtpCentum.Rows[0]["name"].ToString();
                ViewBag.UserInfo = dtpCentum.Rows[0]["phone"].ToString();
                ViewBag.Centum = dtpCentum.Rows[0]["points"].ToString();
            }


            return View();
        }

        #region 会员中心

        [Page]
        [Description("VIPInformation")]
        public ActionResult VIPInformation(string sid, string oid)
        {

            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            if (dtpCentum.Rows[0]["phone"].ToString() == "")
            {
                return Redirect("~/DLWXSite/VIP/CreateVIP?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                ViewBag.UserName = dtpCentum.Rows[0]["name"].ToString();
                ViewBag.UserInfo = dtpCentum.Rows[0]["phone"].ToString();
                ViewBag.Centum = dtpCentum.Rows[0]["points"].ToString();
            }
            ViewBag.dtpCentumInfo = dtpCentum;
            return View();
        }



        [Page]
        [Description("我的积分")]
        public ActionResult GetMyIntegral(string sid, string oid)
        {
            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            ViewBag.dtpCentumInfo = dtpCentum;

            DataTable dtpVIPPrivilege = WMFactory.Wsrr.DLGetVIPPrivilege();
            ViewBag.dtpVIPPrivilegeInfo = dtpVIPPrivilege;

            DataTable dtpVIPCustomerRetail = WMFactory.Wsrr.GetCustomerRetailInfoCommonInterface("DL", "1", oid);
            ViewBag.dtpVIPCustomerRetail = dtpVIPCustomerRetail;

            int lv = int.Parse(dtpVIPPrivilege.Select("vipstate='" + dtpCentum.Rows[0]["state"] + "'")[0]["lv"].ToString());

            if (lv == 1)
            {
                ViewBag.state = "恭喜！已经是最高级别！";
                ViewBag.Info = 1;

            }
            else
            {
                lv = lv - 1;
                ViewBag.state = dtpVIPPrivilege.Select("lv='" + lv + "'")[0]["vipstate"].ToString();
                ViewBag.Info = 2;
            }
            return View();
        }


        [Action]
        [Description("积分兑换送券")]
        [HttpPost]
        [Open]
        public JsonResult TicketByExchangeIntegral(string sid, string oid, string type)
        {
            DataTable dtTicketByExchangeIntegral = WMFactory.Wsrr.AddTicketByExchangeIntegralCommonInterface("DL", "1", oid, "0", "1", "积分换购", "14", "1", "2", "60", "", "", "");
            if (dtTicketByExchangeIntegral.Rows[0]["Result"].ToString().ToLower() == "true")
            {
                return Json(ResultMsg.Success("兑换成功,请去卡券中心查询！"));
            }
            else
            {
                return Json(ResultMsg.Failure("兑换失败"));
            }
        }

        [Action]
        [Description("获取下一级别会员特权")]
        [HttpPost]
        [Open]
        public JsonResult GetNextVIPState(string state)
        {
            return Json(ResultMsg.Success(WMFactory.Wsrr.DLGetVIPPrivilege().Select("vipstate='" + state + "'")[0]["content"].ToString()));
        }


        [Page]
        [Description("卡券中心")]
        public ActionResult GetMyTicket(string sid, string oid)
        {
            DataTable dtpMyTicketInfo = WMFactory.Wsrr.GetCustomerTicketInfoCommonInterface("DL", "1", oid);
            if (dtpMyTicketInfo.Rows[0]["GetStatus"].ToString() == "")
            {
                ViewBag.flag = "1";
            }
            else
            {
                ViewBag.flag = "0";
                ViewBag.MyTicketInfo = dtpMyTicketInfo.Select("GetStatus ='未使用'");
            }
            return View();
        }


        [Page]
        [Description("个人详细信息")]
        public ActionResult GetPersonInfo(string sid, string oid)
        {
            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            ViewBag.dtpCentumInfo = dtpCentum;
            return View();

        }

        [Page]
        [Description("个人详细信息修改")]
        public ActionResult ChangePersonInfo(string sid, string oid)
        {
            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            ViewBag.dtpCentumInfo = dtpCentum;
            return View();

        }

        [Action]
        [Description("DRP个人详细信息修改")]
        [HttpPost]
        [Open]
        public JsonResult UpdateCustomerInfo(Guid sid, string oid, string VipTel, string VipSex, string VipName, string VipBirthday, string VipOccupation, string province, string city, string county, string VipAdd)
        {
            string issqflag = "修改成功";
            //WxFans wx = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            DataTable dt = WMFactory.Wsrr.UpdateCustomerInfoCommonInterface("1", "DL", VipName, VipTel, oid, "", VipSex, "", VipBirthday, province, city, county, VipOccupation, "", VipAdd);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
            {
                #region C3
                IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.Telphone == VipTel && f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
                if (fans == null || fans.Count() <= 0)
                {
                    //查询如果这个手机号没有在绑定表里面绑定,那就直接绑定.
                    //插入到关联表
                    WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                    fan.IsUsing = 0;
                    fan.AccountId = sid;
                    fan.OpenId = oid;
                    fan.Telphone = VipTel;
                    fan.CreateUser = "DLWXSite";
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                }
                else
                {
                    WX_LK_RegMemberFans fan = fans.First();
                    //查询如果这个手机号在绑定表里面绑定,那就直接按照这个手机号把微信号直接修改
                    //插入到关联表

                    if (fan.ModifyUser == "修改个人信息")
                    {
                        if (fan.Telphone != VipTel)
                        {
                            fan.IsUsing = 0;
                            fan.AccountId = sid;
                            fan.OpenId = oid;
                            fan.Telphone = VipTel;
                            fan.ModifyUser = "修改个人信息";
                            WMFactory.WXLKRegMemberFans.Update(fan);
                        }
                    }
                    else
                    {
                        bool songquan = false;
                        if (fan.Telphone != VipTel)
                        {
                            fan.IsUsing = 0;
                            fan.AccountId = sid;
                            fan.OpenId = oid;
                            fan.Telphone = VipTel;
                            fan.ModifyUser = "修改个人信息";
                            songquan = WMFactory.WXLKRegMemberFans.Update(fan);
                        }
                        else
                        {
                            fan.ModifyUser = "修改个人信息";
                            songquan = WMFactory.WXLKRegMemberFans.Update(fan);
                        }
                        if (songquan.ToString().ToLower() == "true")
                        {
                            DataTable dtjlchange = WMFactory.Wsrr.CustomerJFchangeCommonInterface("DL", "1", oid, "add", "1000", "完善资料送积分");
                            issqflag = "提交成功，可至“我的积分”查询！";
                        }
                    }
                }
                #endregion

                return Json(ResultMsg.Success(issqflag));
            }
            else
            {
                return Json(ResultMsg.Failure("修改失败！"));
            }
        }

        [Page]
        [Description("最新通知")]
        public ActionResult GetNoticeInfo(string sid, string oid)
        {
            DataTable dt = WMFactory.Wsrr.DLGetNotice();
            ViewBag.Notice = dt;
            return View();
        }

        [Page]
        [Description("附近店铺")]
        public ActionResult GetNearbyShopInfo(string sid, string oid)
        {
            return View();
        }


        [Action]
        [Description("获取门店")]
        public PartialViewResult GetNearbyShopInfoPartial(Guid sid, string oid, string latitude, string longitude, string type, string pid, string cid)
        {
            string where = "";
            if (type == "single")
            {
                where = " j_com = '贝爱' and ISNULL(depotselect,'') ='0' ";
            }
            else
            {
                where = "g_sf = '" + pid + "' AND g_cs = '" + cid + "' and j_com = '贝爱' and ISNULL(depotselect,'') ='0' ";
            }
            DataTable dt = WMFactory.Wsrr.GetMDMDepot(where);
            dt.Columns.Add("Distance", typeof(double));
            if (!string.IsNullOrEmpty(latitude))
            {
                double latitude2 = double.Parse(latitude);
                double longitude2 = double.Parse(longitude);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    double strlatitude = double.Parse(dt.Rows[i]["z_char15"].ToString());
                    double strlongitude = double.Parse(dt.Rows[i]["z_char14"].ToString());
                    double jl = double.Parse(GetDistance(strlatitude, strlongitude, latitude2, longitude2).ToString("0.00"));
                    dt.Rows[i]["Distance"] = jl;
                }
            }
            DataView dv = dt.DefaultView;
            dv.Sort = "Distance Asc";

            DataTable dt2 = dv.ToTable(true, "j_name", "g_address", "Distance", "m_shoptel");


            if (dt2.Rows[0]["j_name"].ToString() == "")
            {
                ViewBag.flag = "1";
            }
            else
            {
                ViewBag.flag = "2";
            }

            if (dt2.Rows[0]["j_name"].ToString() != "")
            {
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    dt2.Rows[i]["j_name"] = dt2.Rows[i]["j_name"].ToString().Substring(2, dt2.Rows[i]["j_name"].ToString().Length - 2);
                }
            }

            if (type == "all")
            {
                ViewBag.Shop = dt2;

            }
            else
            {
                DataTable NewTable = dt2.Clone();
                DataRow[] rows = dt2.Select("1=1");
                for (int i = 0; i < 3; i++)
                {
                    NewTable.ImportRow((DataRow)rows[i]);
                }
                ViewBag.Shop = NewTable;
            }

            return PartialView();
        }


        [Page]
        [Description("筛选店铺")]
        public ActionResult GetAllShop(string sid, string oid)
        {
            return View();
        }




        #endregion

        #region VIP注册新增

        [Page]
        [Description("VIP注册")]
        [Open]
        public ActionResult CreateVip(Guid sid, string oid)
        {
            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            if (dtpCentum.Rows[0]["phone"].ToString() != "")
            {
                return Redirect("~/DLWXSite/VIP/VIPInformation?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                return View();
            }
        }

        [Action]
        [Description("DRP验证手机号是否存在会员")]
        [HttpPost]
        [Open]
        public JsonResult DRPCheckPhone(Guid sid, string oid, string VipTel, string VipSex, string VipName, string VipBirthday)
        {

            if (WMFactory.Wsrr.GetCustomerInfoCommonInterface("3", "DL", "", "", VipTel, "", "").Rows[0]["phone"].ToString() == "")
            {
                DataTable dt = WMFactory.Wsrr.AddCustomerInfoCommonInterface("1", "DL", VipName, VipTel, oid, "", VipSex, "", VipBirthday, "", "", "", "", "", "");

                if (dt.Rows[0][0].ToString().ToLower() == "true")
                {
                    //插入到关联表
                    WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                    fan.IsUsing = 0;
                    fan.AccountId = sid;
                    fan.OpenId = oid;
                    fan.Telphone = VipTel;
                    fan.CreateUser = "DLWXSite";
                    bool flag = WMFactory.WXLKRegMemberFans.Insert(fan);
                    if (flag.ToString().ToLower() == "true")
                    {
                        DataTable dtTicketAdd = WMFactory.Wsrr.AddCustomerTicketInfoCommonInterface("DL", "1", oid, "0", "1", "绑定有礼", "26", "1", "30", "", "", "");
                        return Json(ResultMsg.Success("注册成功！"));
                    }
                    else
                    {
                        return Json(ResultMsg.Failure("注册失败请重试！"));
                    }
                }
                else
                {
                    return Json(ResultMsg.Failure(dt.Rows[0][1].ToString().ToLower()));
                }
            }
            else
            {
                //WxFans wx = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                DataTable dt = WMFactory.Wsrr.UpdateCustomerInfoCommonInterface("3", "DL", VipName, VipTel, oid, "", VipSex, "", VipBirthday, "", "", "", "", "", "");
                if (dt.Rows[0][0].ToString().ToLower() == "true")
                {
                    #region C3
                    bool updateflag = false;
                    IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.Telphone == VipTel && f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
                    if (fans == null || fans.Count() <= 0)
                    {
                        //查询如果这个手机号没有在绑定表里面绑定,那就直接绑定.
                        //插入到关联表
                        WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                        fan.IsUsing = 0;
                        fan.AccountId = sid;
                        fan.OpenId = oid;
                        fan.Telphone = VipTel;
                        fan.CreateUser = "DLWXSite";
                        updateflag = WMFactory.WXLKRegMemberFans.Insert(fan);
                    }
                    else
                    {
                        WX_LK_RegMemberFans fan = fans.First();
                        //查询如果这个手机号在绑定表里面绑定,那就直接按照这个手机号把微信号直接修改
                        //插入到关联表
                        if (fan.Telphone != VipTel)
                        {
                            fan.IsUsing = 0;
                            fan.AccountId = sid;
                            fan.OpenId = oid;
                            fan.Telphone = VipTel;
                            fan.ModifyUser = "DLWXSite";
                            updateflag = WMFactory.WXLKRegMemberFans.Update(fan);
                        }
                        else
                        {
                            updateflag = true;
                        }
                    }
                    #endregion
                    if (updateflag.ToString().ToLower() == "true")
                    {
                        DataTable dtTicketAdd = WMFactory.Wsrr.AddCustomerTicketInfoCommonInterface("DL", "1", oid, "0", "1", "绑定有礼", "26", "1", "30", "", "", "");
                        return Json(ResultMsg.Success("绑定成功！"));
                    }
                    else
                    {
                        return Json(ResultMsg.Failure("绑定失败，请重新尝试！"));
                    }


                }
                else
                {
                    return Json(ResultMsg.Failure("绑定失败！这个手机号已经绑定微信号！"));
                }
            }
        }

        #endregion

        #region 获取公众号参数


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

        #region 短信验证码
        [Action]
        [Description("发送短信")]
        [HttpPost]
        [Open]
        public JsonResult SendSms(string tel)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.SendSmsAnyTelCommonInterface(tel, "weixin", "3");
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("短信发送成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("验证手机短信验证")]
        [HttpPost]
        [Open]
        public JsonResult CheckAuthCode(Guid sid, string oid, string VipTel, string AuthCode)
        {
            DataTable dt = WMFactory.Wsrr.CheckAuthCodeCommonInterface(VipTel, AuthCode);

            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("验证成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }
        #endregion

        #region 经度纬度计算


        private const double EARTH_RADIUS = 6378.137;//地球半径
        private static double rad(double d)
        {
            return d * Math.PI / 180.0;
        }

        public static double GetDistance(double lat1, double lng1, double lat2, double lng2)
        {
            double radLat1 = rad(lat1);
            double radLat2 = rad(lat2);
            double a = radLat1 - radLat2;
            double b = rad(lng1) - rad(lng2);

            double s = 2 * Math.Asin(Math.Sqrt(Math.Pow(Math.Sin(a / 2), 2) +
             Math.Cos(radLat1) * Math.Cos(radLat2) * Math.Pow(Math.Sin(b / 2), 2)));
            s = s * EARTH_RADIUS;
            s = Math.Round(s * 10000) / 10000;
            return s;
        }

        #endregion
    }
}
