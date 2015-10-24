using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class ManagerController : Controller
    {
        //
        // GET: /S3/Manager/

        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("店铺目标")]
        public PartialViewResult DepotGoal()
        {
            return PartialView();
        }

        [Action]
        [Description("客户经理目标")]
        public PartialViewResult EmployeeGoal()
        {
            return PartialView();
        }

        [Action]
        [Description("行动计划")]
        public PartialViewResult DepotPlan()
        {
            return PartialView();
        }

        [Action]
        [Description("行动计划详细")]
        public PartialViewResult DepotPlanDetail()
        {
            return PartialView();
        }
    }
}
