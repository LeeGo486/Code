using ElegantWM.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using System.Data.SqlClient;

namespace ElegantWM.WebUI
{
    public class ExceptionHandler : HandleErrorAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public override void OnException(ExceptionContext filterContext)
        {

           Exception Error = filterContext.Exception.GetBaseException();
            //获取出现异常的controller名和action名，用于记录
            string controllerName = (string)filterContext.RouteData.Values["controller"];
            string actionName = (string)filterContext.RouteData.Values["action"];
            string Message = Error.GetType().Name + ":" + Error.Message;//错误信息 
            string Url = HttpContext.Current.Request.RawUrl;//错误发生地址
            log.Error("URL=" + Url + ";Msg=" + Message, Error);
            filterContext.ExceptionHandled = true;
            if (filterContext.HttpContext.Request.IsAjaxRequest())
            {
                filterContext.Result = new JsonResult
                {
                    Data = ResultMsg.Failure(Message),
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }
            else
            {
                //定义一个HandErrorInfo，用于Error页使用
                HandleErrorInfo model = new HandleErrorInfo(Error, controllerName, actionName);
                //ViewResult是ActionResult，经常出现在controller中action方法return后面，但是出现形式是View()
                ViewResult result = new ViewResult
                {
                    ViewName = this.View,
                    MasterName = this.Master,
                    //定义ViewData，使用的是泛型
                    ViewData = new ViewDataDictionary<HandleErrorInfo>(model),
                    TempData = filterContext.Controller.TempData
                };
                filterContext.Result = result;
                filterContext.HttpContext.Response.Clear();
                filterContext.HttpContext.Response.StatusCode = 500;
                filterContext.HttpContext.Response.TrySkipIisCustomErrors = true;
            }
            base.OnException(filterContext);
        }
    }
}