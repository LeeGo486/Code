using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using ElegantWM.EntityModel;
using ElegantWM.Tools;

/*
 * Matrix微信孵化平台对外接口
 * 2014-09-12
 * 陈杰
 */

namespace ElegantWM.WebUI.Areas.WeiXin.Controllers
{
    public class ApiController : Controller
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// 显示微信登录二维码信息
        /// </summary>
        /// <param name="sid">微信账号ID</param>
        /// <param name="ipnUrl">通知url</param>
        /// <param name="showPage">是否弹出用户授权界面</param>
        /// <returns></returns>
        public void ShowQRCode(Guid sid, string ipnUrl,string uniqueCode, bool showPage = true)
        {
            if (ipnUrl.Trim().Length <= 0 || !ipnUrl.ToLower().StartsWith("http") || uniqueCode.Trim().Length<=0)
                throw new Exception("ipnUrl非法！");
            CacheHelper.CacheInsertAddMinutes(sid + "_" + uniqueCode, ipnUrl, 2);
            string wholeUrl = "http://" + Request.Url.Authority + "/WeiXin/Api/GetWxUser?sid=" + sid.ToString() + "&uniqueCode=" + uniqueCode + "&showPage=" + showPage.ToString();
            BarCodeHelper.CreateQRCode(wholeUrl);
        }
        /// <summary>
        /// 根据SID获取当前微信账号信息
        /// </summary>
        /// <param name="sid">微信账号ID</param>
        /// <param name="ipnUrl">通知url</param>
        /// <param name="showPage">是否弹出用户授权界面</param>
        /// <returns></returns>
        public ActionResult GetWxUser(Guid sid, string uniqueCode, bool showPage = true)
        {
            if (CacheHelper.CacheValue(sid + "_" + uniqueCode) == null)
            {
                throw new Exception("该二维码已过时，请刷新二维码后重新扫描！");
            }
            if (Request["code"] != null && Request["state"] != null)
            {
                string ipnUrl = CacheHelper.CacheValue(sid + "_" + uniqueCode).ToString();
                ipnUrl = ipnUrl + (ipnUrl.Contains("?") ? "&" : "?") + "uniqueCode=" + uniqueCode;
                CacheHelper.CacheNull(sid + "_" + uniqueCode);
                
                string data = "";
                if (showPage)
                {
                    //如果是获取打开用户授权页面的方式
                    data = ElegantWM.WeiXin.Common.GetFanUserInfo(Request["sid"], Request["code"]);
                }
                else
                {
                    //不需要打开用户授权页面的方式
                    data = ElegantWM.WeiXin.Common.GetFanOpenId(Request["sid"], Request["code"]);
                }
                try
                {//回调原始的url
                    Tools.HttpCrossDomain.Post(ipnUrl, data);
                }
                catch
                {
                    throw;
                }
                return Redirect("~/Matrix/AMLogin/WarningMsg/94");
            }
            else if (Request["code"] == null && Request["state"] != null)
            {
                //禁止授权，则重定向后不会带上code参数，仅会带上state参数redirect_uri?state=STATE
                throw new Exception("您拒绝了授权，Matrix无法获取到您的微信用户信息！");
            }

            string tempUrl = Server.UrlEncode(Request.Url.AbsoluteUri);
            //需要弹出授权界面
            tempUrl = ElegantWM.WeiXin.Common.GetOAuthUrl(Request["sid"], tempUrl, showPage);
            return Redirect(tempUrl);
            
        }
    }
}
