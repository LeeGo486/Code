using ElegantWM.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using ElegantWM.DTO;
using System.Diagnostics;

namespace ElegantWM.WebUI
{
    public class CoreAuthFilter : ActionFilterAttribute
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
            //判定用户是否登录
            if (AuthToken.CurrentUser == null)
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    filterContext.Result = new JsonResult { Data = ResultMsg.Failure("登陆超时，请重新登陆！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
                else
                {
                    filterContext.Result = new HttpUnauthorizedResult();
                }
                return;
            }
            //判断是否是SupperRole,如果是本系统的超级管理员，直接过
            if (AuthToken.CurrentUser.isSupperRole)
                return;
            object[] attrs = filterContext.ActionDescriptor.GetCustomAttributes(typeof(Page), true);
            bool isPage = attrs.Length == 1;
            if (this.AuthorizeCore(filterContext, isPage) == false)
            {
                if (isPage == true)
                {
                    filterContext.Result = new RedirectResult("~/Content/404.html");
                }
                else
                {
                    filterContext.Result = new JsonResult { Data = ResultMsg.Failure("抱歉，您没有当前操作的权限！<br />URL:" + filterContext.HttpContext.Request.Path.ToLower()), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }
        }

        //权限判断业务逻辑
        protected virtual bool AuthorizeCore(ActionExecutingContext filterContext, bool isPage)
        {
            var path = filterContext.HttpContext.Request.Path.ToLower();
            string type = "none";
            if (isPage)
            {
                type = "Page";
            }
            else
            {
                //如果不是模块，判断是否是Action
                object[] attrs = filterContext.ActionDescriptor.GetCustomAttributes(typeof(Action), true);
                type = attrs.Length == 1 ? "Action" : type;
            }
            ResultMsg rst = AuthToken.CheckUrlAccess(path, type);
            if (!rst.success)
            {
                log.Warn("用户：" + AuthToken.CurrentUser.UserName + " 没有访问" + type + "[" + path + "]的权限!");
            }
            return rst.success;
        }
    }
}