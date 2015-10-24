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

namespace ElegantWM.WebUI.Areas.HR
{
    public class HRAuthFilter : ActionFilterAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
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
            if (!string.IsNullOrEmpty(CookieHelper.GetCookie("HRWXUid")) && !string.IsNullOrEmpty(CookieHelper.GetCookie("HRWXUName")))
            {
                return;
            }

            //如果没有登录，则跳转到登录页面
            if (filterContext.HttpContext.Request.IsAjaxRequest())
            {
                filterContext.Result = new JsonResult { Data = ResultMsg.Failure("请重新登录！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
            else
            {
                filterContext.Result = new RedirectResult("~/HR/Course/Register?ReturnUrl="+filterContext.RequestContext.HttpContext.Server.HtmlEncode(filterContext.RequestContext.HttpContext.Request.RawUrl.ToString()));
            }

        }

    }
}