using ElegantWM.WeiXin;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.WeiXin.Controllers
{
    public class RobotController : BaseController
    {
        /// <summary>
        /// 接收微信请求接口
        /// </summary>
        /// <returns></returns>
        public ContentResult Index()
        {
            StreamReader reader = new StreamReader(Request.InputStream);
            string xml = reader.ReadToEnd();
            string result = MessageRouter.AnalyzeXmlFromWeiXin(Request["sid"],xml);
            return Content(result);
        }
    }
}
