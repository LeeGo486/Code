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
 * 时间：2014/6/4 16:04:13
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
    [Description("课程报名")]
    public class HRLKCourseUserController : BaseController
    {
        [Page]
        [Description("课程报名")]
        public ActionResult Index()
        {
            return View();
        }

		[Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit,Guid courseId, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.HRLKCourseUser.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f=>f.Cid==courseId, condition);
            var result = from s in list
                         select new
                         {
                             Id = s.Id,
                             UserName = s.User.UserName,
                             EmployeeID = s.User.EmployeeID,
                             CreateTime = s.CreateTime
                         };
            return Json(new { data = result, total = totalCount }, JsonRequestBehavior.AllowGet);
        }
    }
}
