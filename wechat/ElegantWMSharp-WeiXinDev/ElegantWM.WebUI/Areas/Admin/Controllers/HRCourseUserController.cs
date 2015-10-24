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
 * 时间：2014/6/4 16:02:43
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
    [Description("员工列表")]
    public class HRCourseUserController : BaseController
    {
        [Page]
        [Description("员工列表")]
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
            var list = WMFactory.HRCourseUser.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      null, condition);
            var result = from s in list
                         select new
                         {
                             Id=s.Id,
                             OpenId=s.OpenId,
                             UserName=s.UserName,
                             EmployeeID=s.EmployeeID,
                             CreateUser=s.CreateUser,
                             CreateTime=s.CreateTime,
                             ModifyUser=s.ModifyUser,
                             ModifyTime=s.ModifyTime
                         };
            return Json(new { data = result, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(HR_CourseUser _t)
        {
            IHRCourseUserService service = WMFactory.HRCourseUser;
            HR_CourseUser entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<HR_CourseUser, HR_CourseUser>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(HR_CourseUser _t)
        {
            if (WMFactory.HRCourseUser.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(HR_CourseUser _t)
        {
            if (WMFactory.HRCourseUser.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
