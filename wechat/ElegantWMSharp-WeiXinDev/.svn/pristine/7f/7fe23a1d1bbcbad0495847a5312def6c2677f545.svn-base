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

namespace ElegantWM.WebUI.Areas.Game
{
    public class JLAuthFilter : ActionFilterAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext == null)
            {
                throw new ArgumentNullException("filterContext");
            }

            //如果同时存在sid和oid
            if (!string.IsNullOrEmpty(filterContext.HttpContext.Request["sid"]) && !string.IsNullOrEmpty(filterContext.HttpContext.Request["oid"]))
            {
                string oid = filterContext.HttpContext.Request["oid"].Trim();
                Guid sid = Guid.Parse(filterContext.HttpContext.Request["sid"]);
                //判断当前oid是否和session的一直，防止用户分享出去，别的用户打开
                if (SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]) == null ||
                    SessionHelper.Get("oid_" + filterContext.HttpContext.Request["sid"]).ToString() != oid)
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

                object[] openApi = filterContext.ActionDescriptor.GetCustomAttributes(typeof(Open), true);
                if (openApi.Length == 1)
                {
                    //对外开放的API
                    return;
                }

                //判断是否注册了（绑定）
                if (ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid) == null)
                {
                    filterContext.Result = new RedirectResult("http://mp.weixin.qq.com/s?__biz=MjM5NDI0OTQ2MQ==&mid=206976945&idx=1&sn=9c87eacbf485874f1e032a670842b309#rd");
                    return;
                }
            }//如果sid为空
            else if (string.IsNullOrEmpty(filterContext.HttpContext.Request["sid"]))
            {
                filterContext.Result = new RedirectResult("~/Matrix/AMLogin/WarningMsg/96");
                return;
            }//如果oid为空，并且session里不存在oid
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