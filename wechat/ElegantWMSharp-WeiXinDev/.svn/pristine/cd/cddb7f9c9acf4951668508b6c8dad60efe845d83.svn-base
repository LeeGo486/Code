using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System.ComponentModel;
using System.Collections;
using ElegantWM.IBLL;
using ElegantWM.Common;
using ElegantWM.AutoMapper;

/**
 * 作者：WebMisSharp
 * 时间：2015-07-27 16:31:42
 * 功能：restful服务层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/
 
namespace ElegantWM.WebUI.Areas.Admin.Controllers
{
    [Description("二维码用户")]
    public class WX_QR_CodeScanFansController : BaseController
    {
        [Page]
        [Description("二维码用户")]
        public ActionResult Index()
        {
            return View();
        }

		[Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, Guid accountId, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.WX_QR_CodeScanFans.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                        f => f.AccountId == accountId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }
    }
}
