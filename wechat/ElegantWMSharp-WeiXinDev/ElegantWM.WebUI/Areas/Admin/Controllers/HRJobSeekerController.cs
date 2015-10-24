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
using System.Text.RegularExpressions;

/**
 * 作者：WebMisSharp
 * 时间：2014-03-21 16:10:48
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
    [Description("应聘人员")]
    public class HRJobSeekerController : BaseController
    {
        [Page]
        [Description("应聘人员")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition, Guid jobId)
        {
            int totalCount = 0;
            var list = WMFactory.JobSeeker.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      s => s.JobId == jobId, condition);
            var result = from s in list
                         select new
                         {
                             Id=s.Id,
                             JobId=s.JobId,
                             CreateTime=s.CreateTime,
                             CreateUser=s.CreateUser,
                             EmployeeId=s.EmployeeId,
                             Remark=s.Remark,
                             SkrName=s.SkrName,
                             SkrSex=s.SkrSex,
                             Telphone=s.Telphone
                         };
            return Json(new { data = result, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        //[Action]
        //[Description("更新")]
        //[HttpPut]
        //public JsonResult Put(HR_JobSeeker _t)
        //{
        //    IHRJobSeekerService service = WMFactory.JobSeeker;
        //    HR_JobSeeker entity = service.GetById(_t.Id.ToString());
        //    entity = AutoMapper<HR_JobSeeker, HR_JobSeeker>.Convert(_t, entity);
        //    if (service.Update(entity))
        //        return Json(ResultMsg.Success("更新成功！"));
        //    else
        //        return Json(ResultMsg.Failure("更新失败，请您重试！"));
        //}

        [Open]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(HR_JobSeeker _t)
        {
            if (Session[_t.JobId.ToString()] != null)
            {
                return Json(ResultMsg.Failure("请勿重复提交申请！"));
            }
            if (Guid.Empty == _t.JobId)
                return Json(ResultMsg.Failure("请先选择应聘职位！"));
            if (string.IsNullOrWhiteSpace(_t.SkrName) || string.IsNullOrWhiteSpace(_t.SkrSex)
                || string.IsNullOrWhiteSpace(_t.Telphone))
            {
                return Json(ResultMsg.Failure("信息不全，请补充完整后提交！"));
            }
            if (!Regex.IsMatch(_t.Telphone, @"^1[34578]\d{9}$", RegexOptions.IgnoreCase))
            {
                return Json(ResultMsg.Failure("请提供有效的手机号码！"));
            }
            _t.CreateUser = "WMC";
            if (WMFactory.JobSeeker.Insert(_t))
            {
                Session[_t.JobId.ToString()] = true;
                return Json(ResultMsg.Success("提交成功，我们会尽快联系您！"));
            }
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(HR_JobSeeker _t)
        {
            if (WMFactory.JobSeeker.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
