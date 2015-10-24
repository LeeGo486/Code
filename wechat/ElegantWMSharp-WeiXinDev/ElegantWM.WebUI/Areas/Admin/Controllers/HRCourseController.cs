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
 * 时间：2014/6/4 15:59:51
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
    [Description("课程管理")]
    public class HRCourseController : BaseController
    {
        [Page]
        [Description("课程管理")]
        public ActionResult Index()
        {
            return View();
        }


        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.HRCourse.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      null, condition);
            var result = from c in list
                         select new
                         {
                             Id = c.Id,
                             CourseName = c.CourseName,
                             TeacherType = c.TeacherType,
                             SignUpType = c.SignUpType,
                             OrgName = c.OrgName,
                             Fee = c.Fee,
                             TrainingNum = c.TrainingNum,
                             RegisterNum=c.Users.Count(),
                             Venue = c.Venue,
                             StartDate = c.StartDate,
                             EndDate = c.EndDate,
                             CourseDesc = c.CourseDesc,
                             IsShow = c.IsShow,
                             CreateUser = c.CreateUser,
                             CreateTime = c.CreateTime,
                             ModifyUser = c.ModifyUser,
                             ModifyTime = c.ModifyTime
                         };
            return Json(new { data = result, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(HR_Course _t)
        {
            IHRCourseService service = WMFactory.HRCourse;
            HR_Course entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<HR_Course, HR_Course>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(HR_Course _t)
        {
            if (WMFactory.HRCourse.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(HR_Course _t)
        {
            if (WMFactory.HRCourse.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
