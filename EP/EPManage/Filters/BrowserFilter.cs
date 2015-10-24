using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EPManageWeb.Filters
{
    public class BrowserFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RequestContext.HttpContext.Request.ServerVariables["HTTP_USER_AGENT"].IndexOf("Firefox") == -1)
                filterContext.Result = new ContentResult() { Content = "请使用Firefox浏览器使用本软件" };
        }
    }
}