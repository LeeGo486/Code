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
 * 时间：2014/6/4 16:00:30
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
    [Description("员工签到")]
    public class HRCourseAttendController : BaseController
    {
        [Page]
        [Description("员工签到")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取签到记录")]
        [HttpGet]
        public JsonResult Get(Guid lid, ExtGridSearch condition)
        {
            var list = WMFactory.HRCourseAttend.CourseSignHistory(o => o.OrderBy(x => x.CreateTime), f => f.Lid == lid);
            return Json(new { data = list }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(V_HR_CourseSignRst _t)
        {
            IHRCourseAttendService service = WMFactory.HRCourseAttend;
            IEnumerable<HR_CourseAttend> attendList = service.FindByConditions(null, f => f.Lid == _t.Lid && f.Uid == _t.Uid);
            //不存在，则添加到考勤，应对“缺勤数据”
            if (attendList == null || attendList.Count() <= 0)
            {
                HR_CourseAttend atd = new HR_CourseAttend();
                atd.CreateUser = _t.SignRst;
                atd.Lid = _t.Lid;
                atd.Uid = _t.Uid;
                atd.ModifyUser = "缺勤";
                if(service.Insert(atd))
                    return Json(ResultMsg.Success("更新成功！"));
                else
                    return Json(ResultMsg.Failure("更新失败，请您重试！"));
            }
            HR_CourseAttend attend = attendList.FirstOrDefault();
            attend.CreateUser = _t.SignRst;
            if (service.Update(attend))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }
    }
}
