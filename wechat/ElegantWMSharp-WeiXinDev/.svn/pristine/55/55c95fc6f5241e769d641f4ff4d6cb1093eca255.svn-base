using ElegantWM.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using ElegantWM.DTO;
using System.Diagnostics;
using ElegantWM.Tools;
using ElegantWM.EntityModel;
using System.Data;

namespace ElegantWM.WebUI.Areas.S3
{
    public class Matrix3SAuthFilter : ActionFilterAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //过滤器
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext == null) 
            {
                throw new ArgumentNullException("filterContext");
            }

            object[] openApi = filterContext.ActionDescriptor.GetCustomAttributes(typeof(Open), true);
            if (openApi.Length == 1)
            {
                //对外开放的API
                return;
            }

            //如果同时存在sid和oid
            if (!string.IsNullOrEmpty(filterContext.HttpContext.Request["sid"]) && !string.IsNullOrEmpty(filterContext.HttpContext.Request["oid"]))
            {
                string oid = filterContext.HttpContext.Request["oid"].Trim();
                Guid sid = Guid.Parse(filterContext.HttpContext.Request["sid"]);

                //判断当前oid是否和session的一直，防止用户分享出去，别的用户打开
                //8088端口为测试系统，不需要判断是否相等
                if (filterContext.HttpContext.Request.Url.Port==80 && (SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]) == null 
                    || SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]).ToString() != oid)
                    )
                {
                    if (filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        filterContext.Result = new JsonResult { Data = ResultMsg.Failure("实际操作账号和微信号不符！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                        return;
                    }
                    else
                    {
                        filterContext.Result = new RedirectResult(filterContext.HttpContext.Request.RawUrl.Replace("?oid=" + oid, "").Replace("&oid=" + oid, ""));
                        return;
                    }
                }

                //判断是否注册了（绑定）
                if (WMFactory.WXLKRegMemberFans.GetCount(f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0) <= 0)
                {
                    if (filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        filterContext.Result = new JsonResult { Data = ResultMsg.Failure("请先绑定账号！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                        return;
                    }
                    else
                    {
                        filterContext.Result = new RedirectResult("~/S3/User/Register?sid=" + sid.ToString() + "&oid=" + oid + "&ReturnUrl=" + filterContext.HttpContext.Server.UrlEncode(filterContext.HttpContext.Request.RawUrl));
                        return;
                    }
                }
                //判断是否oid绑定了手机号？如果绑定了，判断是否离职
                DataTable dt = WMFactory.Wsrr.CheckS3UserBind(oid);
                if (dt.Rows[0]["Result"].ToString() == "1")
                {
                    if (filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        filterContext.Result = new JsonResult { Data = ResultMsg.Failure("微信末绑定EHR或者POS！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                        return;
                    }
                    else
                    {
                        filterContext.Result = new RedirectResult("~/S3/User/EhrDrpBinding?sid=" + sid.ToString() + "&oid=" + oid + "&ReturnUrl=" + filterContext.HttpContext.Server.UrlEncode(filterContext.HttpContext.Request.RawUrl));
                        return;
                    }
                }
                else if (dt.Rows[0]["Result"].ToString() == "2")
                {
                    if (filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        filterContext.Result = new JsonResult { Data = ResultMsg.Failure("已离职,请重新绑定导购号！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                        return;
                    }
                    else
                    {
                        filterContext.Result = new RedirectResult("~/S3/User/ReBinding?sid=" + sid.ToString() + "&oid=" + oid + "&ReturnUrl=" + filterContext.HttpContext.Server.UrlEncode(filterContext.HttpContext.Request.RawUrl));
                        return;
                    }
                }

            }//如果sid为空
            else if (string.IsNullOrEmpty(filterContext.HttpContext.Request["sid"]))
            {
                filterContext.Result = new RedirectResult("~/Matrix/AMLogin/WarningMsg/96");
                return;
            }//如果oid为空，并且session里存在oid
            else if (SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]) != null)
            {
                filterContext.Result = new RedirectResult(filterContext.HttpContext.Request.RawUrl + "&oid=" + SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]));
                return;
            }

            if (filterContext.HttpContext.Request["code"] != null && filterContext.HttpContext.Request["state"] != null)
            {
                string openId = ElegantWM.WeiXin.Common.GetFanOpenId(filterContext.HttpContext.Request["sid"], filterContext.HttpContext.Request["code"]);
                if (string.IsNullOrEmpty(openId))
                {
                    filterContext.Result = new RedirectResult("/Matrix/AMLogin/WarningMsg/97");
                    return;
                }
                //openId成功获取到
                string tempUrl = filterContext.HttpContext.Request.RawUrl;
                tempUrl = tempUrl.Substring(0, tempUrl.IndexOf("&code="));
                //添加到当前访客的当前微信的session
                SessionHelper.Add("oid_" + filterContext.HttpContext.Request["sid"], openId);
                filterContext.Result = new RedirectResult(tempUrl + "&oid=" + openId);
                return;
            }
            else if (filterContext.HttpContext.Request["code"] == null && filterContext.HttpContext.Request["state"] != null)
            {
                //禁止授权，则重定向后不会带上code参数，仅会带上state参数redirect_uri?state=STATE
                filterContext.Result = new RedirectResult("/Matrix/AMLogin/WarningMsg/97");
                return;
            }

            //判断oid为空放在最后，不然微信回调回来会造成死循环
            if (string.IsNullOrEmpty(filterContext.HttpContext.Request["oid"]))
            {
                string tempUrl = filterContext.HttpContext.Server.UrlEncode(filterContext.HttpContext.Request.Url.AbsoluteUri);
                tempUrl = ElegantWM.WeiXin.Common.GetOAuthUrl(filterContext.HttpContext.Request["sid"], tempUrl);
                filterContext.Result = new RedirectResult(tempUrl);
                return;
            }
        }
    }
}