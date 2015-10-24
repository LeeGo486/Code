using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    /// <summary>
    /// 用户信息
    /// </summary>
    public class UserController : BaseMatrix3SController
    {
        [Page]
        [Description("用户信息")]
        public ActionResult Index(Guid sid,string oid)
        {
            //获取店铺名称
            DataTable dt = WMFactory.Wsrr.CheckS3UserBind(oid);
            return View(dt);
        }

        [Page]
        [Description("用户注册")]
        [Open]
        public ActionResult Register()
        {
            if (string.IsNullOrEmpty(Request["sid"]) || string.IsNullOrEmpty(Request["oid"]))
            {
                return Redirect("~/Matrix/AMLogin/WarningMsg/96");
            }
            return View();
        }

        [Page]
        [Description("已离职重新绑定")]
        [Open]
        public ActionResult ReBinding()
        {
            if (string.IsNullOrEmpty(Request["sid"]) || string.IsNullOrEmpty(Request["oid"]))
            {
                return Redirect("~/Matrix/AMLogin/WarningMsg/96");
            }
            return View();
        }

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
            DataTable dt = WMFactory.Wsrr.SendSMS(tel);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("短信发送成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("会员注册")]
        [HttpPost]
        [Open]
        public JsonResult RegistMember(Guid sid,string oid, string tel, string pwd, string code)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase) && !Regex.IsMatch(tel, @"^6\d{8}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }

            //插入到关联表
            WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
            fan.IsUsing = 0;
            fan.AccountId = sid;
            fan.OpenId = oid;
            fan.Telphone = tel;
            fan.CreateUser = "3S";

            try
            {
                DataTable dt = WMFactory.Wsrr.Register3S(tel, oid, pwd, code);
                if (dt.Rows[0][0].ToString().ToLower() == "true")
                {
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                    return Json(ResultMsg.Success("注册成功！"));
                }
                else
                    return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
            }
            catch (Exception error) {
                if (error.Message.Contains("该手机号码已被注册！"))
                {
                    //插入到关联表,已被注册的还是要插入到该表中
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                    //单独绑定一次VEXSSO 微信号
                    WMFactory.Wsrr.VexSSOBind(tel, "", "3SWeChat", oid, "");
                    return Json(ResultMsg.Success("YZC"));
                }
                else
                    return Json(ResultMsg.Failure(error.Message));
            }
        }

        [Page]
        [Description("会员绑定")]
        [Open]
        public ActionResult EhrDrpBinding()
        {
            if (string.IsNullOrEmpty(Request["sid"]) || string.IsNullOrEmpty(Request["oid"]))
            {
                return Redirect("~/Matrix/AMLogin/WarningMsg/96");
            }
            return View();
        }



        [Page]
        [Description("会员绑定")]
        [HttpPost]
        [Open]
        public JsonResult BindEhrDrp(Guid sid,string oid,string ehrName,string idCode,string posCode,bool IsRePos=false)
        {
            //找到手机号
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans == null || fans.Count() <= 0)
                return Json(ResultMsg.Failure("用户未注册"));
            DataTable dt = WMFactory.Wsrr.BindEhrDrp(fans.First().Telphone, ehrName, idCode, posCode, IsRePos);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("绑定成功！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }
    }
}
