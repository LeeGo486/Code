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
 * 时间：2014-03-21 16:10:13
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
    [Description("职位管理")]
    public class HRJobsController : BaseController
    {
        [Page]
        [Description("职位管理")]
        public ActionResult Index()
        {
            return View();
        }

        [Open]
        [Description("微信内嵌页面，职位预览")]
        public ActionResult ViewJobs()
        {
            return View();
        }

        [Open]
        [Description("根据ID获取Job")]
        [HttpGet]
        public JsonResult GetJobById(Guid id)
        {
            HR_Jobs job=WMFactory.Jobs.GetById(id.ToString());
            if(job==null)
                return null;
            return Json(new
            {
                Id = job.Id,
                JobName = job.JobName,
                JobSeekers = job.Seekers.Count(),
                Responsibilities = job.Responsibilities,
                Skills = job.Skills,
                NeedNum = job.NeedNum,
                Email = job.Email,
                IsTop = job.IsTop,
                IsShow = job.IsShow,
                CreateUser = job.CreateUser,
                CreateTime = job.CreateTime,
                ModifyUser = job.ModifyUser,
                ModifyTime = job.ModifyTime
            }, JsonRequestBehavior.AllowGet);
        }

        [Open]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.Jobs.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.IsTop).ThenByDescending(x=>x.CreateTime),
                                                      null, condition);
            //转换
            var result = from j in list
                         select new
                         {
                             Id=j.Id,
                             JobName=j.JobName,
                             JobSeekers=j.Seekers.Count(),
                             Responsibilities=j.Responsibilities,
                             Skills=j.Skills,
                             NeedNum=j.NeedNum,
                             Email=j.Email,
                             IsTop=j.IsTop,
                             IsShow=j.IsShow,
                             CreateUser=j.CreateUser,
                             CreateTime=j.CreateTime,
                             ModifyUser=j.ModifyUser,
                             ModifyTime=j.ModifyTime
                         };
            return Json(new { data = result, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(HR_Jobs _t)
        {
            IHRJobsService service = WMFactory.Jobs;
            HR_Jobs entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<HR_Jobs, HR_Jobs>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(HR_Jobs _t)
        {
            if (WMFactory.Jobs.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(HR_Jobs _t)
        {
            if (WMFactory.Jobs.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
