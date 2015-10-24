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

namespace ElegantWM.WebUI.Areas.Matrix
{
    public class MatrixS3AuthFilter : ActionFilterAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext == null) 
            {
                throw new ArgumentNullException("filterContext");
            }
            if (CookieHelper.GetCookie("S3AMUserNew") == null)
            {
                //如果没有登录，则跳转到登录页面
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    filterContext.Result = new JsonResult { Data = ResultMsg.Failure("请重新登录！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                    return;
                }
                else
                {
                    filterContext.Result = new RedirectResult("~/Matrix/S3Login?ReturnUrl=" + filterContext.HttpContext.Request.RawUrl);
                    return;
                }
            }
        }
    }
}