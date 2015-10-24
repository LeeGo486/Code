using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.HR.Controllers
{
    public class HRJobController : Controller
    {
        //
        // GET: /HR/HRJob/

        public ActionResult Index()
        {

            ViewBag.Job = WMFactory.Jobs.FindByConditions(o => o.OrderByDescending(c => c.CreateTime), f => f.IsShow == 0, null);
            return View();
        }


        [Page]
        [Description("岗位明细")]
        //[ValidateInput(false)]
        public ActionResult Detail(string id)
        {
            HR_Jobs JobDetail = WMFactory.Jobs.GetById(id.ToString());
            ViewBag.jobid = JobDetail.Id.ToString();
            ViewBag.JobName = JobDetail.JobName.ToString();
            ViewBag.NeedNum = JobDetail.NeedNum.ToString();
            //ViewBag.Responsibilities =JobDetail.Responsibilities.ToString().Replace("&", "&amp;").Replace("'", "''").Replace("\"", "&quot;").Replace(" ", "&nbsp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("\n", "<br>");

            ViewBag.Responsibilities = new HtmlString(JobDetail.Responsibilities.ToString());
            ViewBag.Skills = new HtmlString(JobDetail.Skills.ToString());
            ViewBag.Email = JobDetail.Email.ToString();
            ViewBag.CreateTime = JobDetail.CreateTime.ToString();
            return View();
        }

        [Page]
        [Description("岗位明细")]
        //[ValidateInput(false)]
        public ActionResult JobApply(string id, string jobname)
        {

            ViewBag.id = id;
            ViewBag.jobname = jobname;
            return View();
        }



        [Action]
        [Description("保存申请信息")]
        [HttpPost]
        [Open]
        public JsonResult SaveJob(HR_JobSeeker job)
        {
            job.CreateUser = "gqq";
            job.ModifyUser = "gqq";

            if (WMFactory.JobSeeker.Insert(job))
                return Json(ResultMsg.Success("信息提交成功。"));
            else
                return Json(ResultMsg.Failure("信息提交失败，请重试！"));
        }

    }
}
