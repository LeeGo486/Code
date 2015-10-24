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
using ElegantWM.Tools;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:01:35
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
    [Description("课时设置")]
    public class HRCourseLessonController : BaseController
    {
        [Page]
        [Description("课时设置")]
        public ActionResult Index()
        {
            return View();
        }

        //[Action]
        //[Description("获取Grid数据")]
        //[HttpGet]
        //public JsonResult Get(int start, int limit, ExtGridSearch condition)
        //{
        //    int totalCount = 0;
        //    var list = WMFactory.HRCourseLesson.FindByPage(start, limit, out totalCount,
        //                                              o => o.OrderByDescending(x => x.CreateTime),
        //                                              null, condition);
        //    return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        //}

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(Guid cid)
        {
            int totalCount = 0;
            var list = WMFactory.HRCourseLesson.FindByConditions(o => o.OrderBy(x => x.CreateTime),
                                                      f=>f.Cid==cid, null);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(HR_CourseLesson _t)
        {
            IHRCourseLessonService service = WMFactory.HRCourseLesson;
            HR_CourseLesson entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<HR_CourseLesson, HR_CourseLesson>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(HR_CourseLesson _t)
        {
            if (WMFactory.HRCourseLesson.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(HR_CourseLesson _t)
        {
            if (WMFactory.HRCourseLesson.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }

        [Action]
        [Description("生成二维码")]
        [HttpGet]
        public void ShowQRCode(Guid id)
        {
            string wholeUrl=Request.Url.ToString().Replace("http://","");
            string url = "http://" + wholeUrl.Substring(0, wholeUrl.IndexOf("/")) + "/HR/Course/SignIn/" + id.ToString();
            BarCodeHelper.CreateQRCode(url);
        }
    }
}
