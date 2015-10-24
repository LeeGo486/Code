using ElegantWM.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using ElegantWM.DTO;
using System.Diagnostics;
using System.Web.Security;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.Tools;

namespace ElegantWM.WebUI.Areas.WeiXin
{
    public class WXAuthFilter : ActionFilterAttribute
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// 验证微信推送来的消息的合法性
        /// </summary>
        /// <param name="filterContext"></param>
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext == null)
            {
                throw new ArgumentNullException("filterContext");
            }
            //首先获取接入的url参数
            string sid = filterContext.HttpContext.Request["sid"];
            if (string.IsNullOrEmpty(sid))
            {
                throw new Exception("缺少SID参数，请先在HZY微信平台中申请！");
            }
            WX_Account account = null;
            if (CacheHelper.CacheValue(sid) == null)
            {
                //根据SID获取当前的微信帐号信息
                account = WMFactory.WXAccount.GetById(sid);
                if (account == null)
                {
                    throw new Exception("接入错误！微信账号ID不存在！");
                }
                CacheHelper.CacheInsertFromMinutes(sid, account, 120);
            }
            account = (WX_Account)CacheHelper.CacheValue(sid);
            string[] ArrTmp = { account.Token, filterContext.HttpContext.Request["timestamp"], filterContext.HttpContext.Request["nonce"] };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("", ArrTmp);
            tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();
            //log.Debug("111");
            //log.Debug("tmpStr" + tmpStr);
           // log.Debug("signature" + filterContext.HttpContext.Request["signature"].ToLower());
            if (tmpStr != filterContext.HttpContext.Request["signature"].ToLower())
            {
                filterContext.Result = new JsonResult { Data = ResultMsg.Failure("请求来源错误！"), JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                log.Debug(filterContext.Result);

            }
            else if (account.IsAccessed == 0)
            {
                //log.Debug("2222");
                //如果是首次接入，那么接入成功，更新接入状态
                WMFactory.WXAccount.Update("IsAccessed=1 where Id='" + account.Id.ToString() + "'");
                account.IsAccessed = 1;
                CacheHelper.CacheInsertFromMinutes(sid, account, 120);
                ContentResult rst = new ContentResult();
                rst.Content = filterContext.HttpContext.Request["echostr"];
                filterContext.Result = rst;
            }
        }
    }
}