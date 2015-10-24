using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Matrix.Controllers
{
    /// <summary>
    /// 通过小翅膀登录 
    /// </summary>
    public class AMLoginController : Controller
    {
        public ActionResult Index() 
        { 
            if (!string.IsNullOrEmpty(Request["oid"]) && !string.IsNullOrEmpty(Request["sid"]))
            {
                //判断用户是否存在
                string oid=Request["oid"].Trim();
                Guid sid=Guid.Parse(Request["sid"]);
                ViewBag.User = WMFactory.WXLKFansC3AM.GetCurrentAMUser(sid, oid);
            }
            return View();
        }

        #region VexSSO相关
        /// <summary>
        /// 注册手机号
        /// </summary>
        /// <returns></returns>
        public ActionResult VexSSOReg()
        {
            return View();
        }

        [Action]
        [Description("发送短信")]
        [HttpPost]
        public JsonResult SendSms(string tel)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase) && !Regex.IsMatch(tel, @"^6\d{8}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.SendSMS(tel);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("验证码已发送！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("通行证注册+绑定")]
        [HttpPost]
        public JsonResult VexSSOBind(string tel, string pwd, string code ,string amuser,string ampwd,bool reged)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase) && !Regex.IsMatch(tel, @"^6\d{8}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.VexSSORegAndBindAM(tel, pwd, amuser, ampwd, code, reged);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
            {
                //绑定微信号，如果存在的话，绑定微信
                if (!string.IsNullOrEmpty(Request["oid"]) && !string.IsNullOrEmpty(Request["sid"]))
                {
                    //VexSSO绑定微信号
                    WMFactory.Wsrr.VexSSOBind(tel, pwd, "ITDCWeChat", Request["oid"], "");
                    
                    //插入到关联表
                    WX_LK_RegMemberFans fan = new WX_LK_RegMemberFans();
                    fan.IsUsing = 0;
                    fan.AccountId = Guid.Parse(Request["sid"]);
                    fan.OpenId = Request["oid"];
                    fan.Telphone = tel;
                    fan.CreateUser = "Matrix";
                    WMFactory.WXLKRegMemberFans.Insert(fan);
                }
                //更新C3AM的账号
                WMFactory.Wsrr.UpdateC3AMUser(amuser, tel, pwd);
                return Json(ResultMsg.Success("注册成功！"));
            }
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("忘记密码")]
        public ActionResult VexSSOGetPwd()
        {
            return View();
        }

        [Action]
        [Description("发送找回密码验证码")]
        [HttpPost]
        public JsonResult VexSSOGetPwdCode(string tel)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase) && !Regex.IsMatch(tel, @"^6\d{8}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.VexSSOGetPwdCode(tel);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success("验证码已发送！"));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        [Action]
        [Description("密码发送到手机")]
        [HttpPost]
        public JsonResult VexSSOSendPwd2Phone(string tel,string code)
        {
            if (!Regex.IsMatch(tel, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase) && !Regex.IsMatch(tel, @"^6\d{8}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("手机号格式错误！"));
            }
            DataTable dt = WMFactory.Wsrr.VexSSOSendPwd2Phone(tel,code);
            if (dt.Rows[0][0].ToString().ToLower() == "true")
                return Json(ResultMsg.Success(dt.Rows[0][1].ToString()));
            else
                return Json(ResultMsg.Failure(dt.Rows[0][1].ToString()));
        }

        #endregion

        //绑定用户
        public JsonResult Binding()
        {
            if (string.IsNullOrEmpty(Request["name"]) || string.IsNullOrEmpty(Request["pwd"]) || string.IsNullOrEmpty(Request["oid"]) || string.IsNullOrEmpty(Request["sid"]))
            {
                return Json(ResultMsg.Failure("参数非法！"));
            }
            ResultMsg rst = SSOHelper.Login(Request["name"].Trim(), Server.UrlEncode(Request["pwd"].Trim()), "ITDC(" +
                (Request.UserAgent.Contains("(")&&Request.UserAgent.Contains(")")?Request.UserAgent.Substring(Request.UserAgent.IndexOf("(") + 1, Request.UserAgent.IndexOf(")") - Request.UserAgent.IndexOf("(") - 1):Request.Browser.Platform)
                + "_" + Request.Browser.Type+")", Request.UserHostAddress);
            if (rst.result == 0)
            {
                CertificateDto cert = AuthToken.CurrentUserByTid(rst.msg);
                //20141006,验证是否有手机号码
                if (string.IsNullOrEmpty(cert.Phone) || cert.Phone.Trim().Length <= 0)
                {
                    SSOHelper.LogOut(cert.tokenId);//注销
                    return Json(ResultMsg.Failure("NEEDTELPHONE"));
                }
                //插入到用户绑定表，如果存在则更新数据
                WX_LK_FansC3AM fam = new WX_LK_FansC3AM();

                fam.AccountId = Guid.Parse(Request["sid"]);
                fam.OpenId = Request["oid"];
                fam.CreateUser = "ITDC";
                fam.Uid = Guid.Parse(cert.Id);

                //判断同一个人是否在另一个微信号里，提示请先解除绑定
                Guid uid = Guid.Parse(cert.Id);
                if (WMFactory.WXLKFansC3AM.GetCount(f => f.Uid == uid && f.AccountId == fam.AccountId && f.OpenId!=fam.OpenId) > 0)
                {
                    SSOHelper.LogOut(cert.tokenId);//注销
                    return Json(ResultMsg.Failure("该账户已绑定其他微信号，请先解绑！"));
                }
                IEnumerable<WX_LK_FansC3AM> userList = WMFactory.WXLKFansC3AM.FindByConditions(null, f => f.AccountId == fam.AccountId && f.OpenId == fam.OpenId);
                bool flag = false;
                if (userList != null && userList.Count() == 1)
                {
                    fam = userList.FirstOrDefault();
                    fam.ModifyUser = "ITDC";
                    //如果微信账户和当前认证的账户不是同一个人
                    if (fam.Uid != Guid.Parse(cert.Id))
                    {
                        SSOHelper.LogOut(cert.tokenId);//注销
                        return Json(ResultMsg.Failure("该微信已绑定，回复？解绑"), JsonRequestBehavior.AllowGet);
                    }
                    flag = true;
                }

                fam.UserName = cert.UserName;
                fam.TokenId = Guid.Parse(cert.tokenId);

                if (flag)
                    flag = WMFactory.WXLKFansC3AM.Update(fam);
                else
                    flag = WMFactory.WXLKFansC3AM.Insert(fam);

                if (flag)
                {
                    //绑定成功，清空历史缓存，否则会导致最长23分钟内无效登录的情况
                    CacheHelper.CacheInsertFromMinutes("AMU_" + fam.AccountId.ToString() + "_" + fam.OpenId, fam, 23);
                    return Json(ResultMsg.Success("绑定成功！"), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    SSOHelper.LogOut(cert.tokenId);//注销
                    CacheHelper.CacheNull("AMU_" + fam.AccountId.ToString() + "_" + fam.OpenId);
                    return Json(ResultMsg.Success("绑定失败,请重试！"), JsonRequestBehavior.AllowGet);
                }
            }
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        public ActionResult WarningMsg(int id)
        {
            switch (id)
            {
                case 94:
                    ViewBag.Msg = "微信登录授权成功！";
                    break;
                case 95:
                    ViewBag.Msg = "恭喜您，注册成功！";
                    break;
                case 99:
                    ViewBag.Msg="系统禁止在微信外部打开！";
                    break;
                case 98:
                    ViewBag.Msg = "用户绑定成功，您可继续操作！";
                    break;
                case 97:
                    ViewBag.Msg = "微信授权失败！";
                    break;
                case 96:
                    ViewBag.Msg = "非法请求，缺少必要参数！";
                    break;
                default:
                    ViewBag.Msg = "未识别指令！";
                    break;
            }
            return View();
        }
    }
}
