using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class EmployeeController : Controller
    {
        //
        // GET: /S3/Employee/

        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("年度目标")]
        public PartialViewResult EmployeeGoal()
        {
            return PartialView();
        }

        [Action]
        [Description("人脉存折")]
        public PartialViewResult Contacts()
        {
            return PartialView();
        }

        [Action]
        [Description("个人信息")]
        public PartialViewResult CustomerInfo()
        {
            return PartialView();
        }

        [Action]
        [Description("行动计划")]
        public PartialViewResult EmployeePlan()
        {
            return PartialView();
        }

        [Action]
        [Description("行动计划详细")]
        public PartialViewResult EmployeePlanDetail()
        {
            return PartialView();
        }

        [Action]
        [Description("行动计划汇报")]
        public PartialViewResult DoEmployeePlan()
        {
            return PartialView();
        }
    }
}
