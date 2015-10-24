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

namespace ElegantWM.WebUI.Areas.NPaia.Controllers
{
    public class VIPController : BaseNPaiaController//BaseNPaia
    {

        [Page]
        [Description("VIP查询积分")]
        [Open]
        public string SearchVipScore(Guid sid, string oid)
        {
            string vipname = "";
            string centum = "";
            string viptel = "";

            //查找这个微信号是否绑定会员
            //var list = WMFactory.WXLKRegMemberFans.FindByConditions(o => o.OrderByDescending(x => x.Id), f => f.AccountId == sid);

            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans == null || fans.Count() <= 0)
            {
                return "请您先绑定，<a href='http://it.hwafashion.com/NPaia/VIP/CreateVip?sid=" + sid.ToString() + "&oid=" + oid + "'>点击绑定</a>";
            }
            else
            {
                viptel = fans.First().Telphone;
                DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(viptel);

                if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
                {
                    return "异常,请重新绑定,<a href='http://it.hwafashion.com/NPaia/VIP/CreateVip?sid=" + sid.ToString() + "&oid=" + oid + "'>点击绑定</a>";
                }
                else
                {
                    vipname = dtpCentum.Rows[0]["vipname"].ToString();
                    viptel = dtpCentum.Rows[0]["mobtel"].ToString();
                    centum = dtpCentum.Rows[0]["centum"].ToString();
                    return "会员姓名：" + vipname + "\r\n" + "注册手机：" + viptel + "\r\n" + "当前积分：" + centum;
                }
            }
        }

        [Page]
        [Description("VIP主页")]
        public ActionResult Index(Guid sid, string oid)
        {
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans != null && fans.Count() > 0)
            {
                ViewBag.UserInfo = fans.First().Telphone;
            }
            return View();
        }

        #region 注册会员

        [Page]
        [Description("VIP注册")]
        [Open]
        public ActionResult CreateVip(Guid sid, string oid)
        {
            return View();
        }

        [Action]
        [Description("DRP验证手机号是否存在会员")]
        [HttpPost]
        [Open]
        public JsonResult DRPCheckPhone(Guid sid, string oid, string VipTel, string VipSex, string VipName)
        {
            //通过手机查询，积分，如果返回的表里面没有数据或者表不存在就直接判断会员号不存在。
            DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(VipTel);

            if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
            {
                //调取WSRR生成会员USER和会员VIP卡
                DataTable dt = WMFactory.Wsrr.VipUserForC3(VipTel, VipSex, VipName);
                if (dt.Rows[0][0].ToString().ToLower() == "true")
                {
                    //插入到关联表
                    WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                    fan.IsUsing = 0;
                    fan.AccountId = sid;
                    fan.OpenId = oid;
                    fan.Telphone = VipTel;
                    fan.CreateUser = "NPaia";
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                    return Json(ResultMsg.Success("注册成功！"));
                }
                else
                {
                    return Json(ResultMsg.Failure("注册失败"));
                }
            }
            else
            {
                IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.Telphone == VipTel && f.OpenId == oid && f.IsUsing == 0);
                if (fans == null || fans.Count() <= 0)
                {
                    //查询如果这个手机号没有在绑定表里面绑定,那就直接绑定.
                    //插入到关联表
                    WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                    fan.IsUsing = 0;
                    fan.AccountId = sid;
                    fan.OpenId = oid;
                    fan.Telphone = VipTel;
                    fan.CreateUser = "NPaia";
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                    return Json(ResultMsg.Success("注册成功！"));
                }
                else
                {
                    WX_LK_RegMemberFans fan = fans.First();
                    //查询如果这个手机号在绑定表里面绑定,那就直接按照这个手机号把微信号直接修改
                    //插入到关联表
                    fan.IsUsing = 0;
                    fan.AccountId = sid;
                    fan.OpenId = oid;
                    fan.Telphone = VipTel;
                    fan.ModifyUser = "NPaia";
                    WMFactory.WXLKRegMemberFans.Update(fan);
                    return Json(ResultMsg.Success("注册成功！"));
                }
            }
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
            DataTable dt = WMFactory.Wsrr.SendSmsAnyTel(tel);
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
            DataTable dt = WMFactory.Wsrr.CheckAuthCode(VipTel, AuthCode);

            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("验证成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }
        #endregion

        [Action]
        [Description("查询店铺信息")]
        [HttpPost]
        [Open]
        public JsonResult GetDepot(Guid sid, string oid)
        {
            DataTable dt = WMFactory.Wsrr.GetDepot(" [DEPT_State] = '20' ");
            if (dt.Rows.Count == 0)
            {
                return Json(ResultMsg.Failure("失败！请检查数据！"));

            }
            else
            {
                return Json(ResultMsg.Success(JsonHelper.ToJson(dt)));
            }
        }


        [Page]
        [Description("VIPInformation")]
        public ActionResult VIPInformation(Guid sid, string oid)
        {
            string viptel = "";
            DataTable dtpCentumInfo;

            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans == null || fans.Count() <= 0)
            {
                return Redirect("~/NPaia/VIP/CreateVip?sid=" + sid.ToString() + "&oid=" + oid);//异常的时候重新绑定
            }
            else
            {
                viptel = fans.First().Telphone;
                dtpCentumInfo = WMFactory.Wsrr.GetUserCentumInfo(viptel);

                if (dtpCentumInfo.Rows[0]["mobtel"].ToString() == "")
                {
                    return Redirect("~/NPaia/VIP/CreateVip?sid=" + sid.ToString() + "&oid=" + oid);//异常的时候重新绑定
                }
            }
            ViewBag.dtpCentumInfo = dtpCentumInfo;
            return View();
        }

    }
}
