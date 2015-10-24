using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class EquipmentController : BaseMatrixS3Controller
    {
        [Page]
        [Description("设施维护")]
        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("我的任务")]
        public ActionResult MyTasks()
        {
            return View();
        }

        [Page]
        [Description("设施维护申报")]
        [HttpPost]
        public PartialViewResult EditFacility()
        {
            return PartialView();
        }

        [Page]
        [Description("形象品申报")]
        [HttpPost]
        public PartialViewResult EditVivid()
        {
            return PartialView();
        }

        [Page]
        [Description("IT设施申报")]
        [HttpPost]
        public PartialViewResult EditIT()
        {
            return PartialView();
        }
    }
}
