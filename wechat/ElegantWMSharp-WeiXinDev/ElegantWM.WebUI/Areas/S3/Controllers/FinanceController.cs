using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class FinanceController : BaseMatrixS3Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("收入分析")]
        public PartialViewResult Income()
        {
            return PartialView();
        }

        [Action]
        [Description("费用分析")]
        public PartialViewResult Cost()
        {
            return PartialView();
        }

        [Action]
        [Description("利润分析")]
        public PartialViewResult Profit()
        {
            return PartialView();
        }

        [Action]
        [Description("固定资产")]
        public PartialViewResult Asset()
        {
            return PartialView();
        }

        [Action]
        [Description("我的报销单")]
        public PartialViewResult Reimbursement()
        {
            return PartialView();
        }

        [Action]
        [Description("我要申购")]
        public PartialViewResult DoSubscribe()
        {
            return PartialView();
        }

        [Action]
        [Description("我要申购明细")]
        public PartialViewResult DoSubscribesub()
        {
            return PartialView();
        }

        [Action]
        [Description("我要报修")]
        public PartialViewResult DoRepairs()
        {
            return PartialView();
        }

        [Action]
        [Description("我要报销")]
        public PartialViewResult DoReimbursement()
        {
            return PartialView();
        }

        [Action]
        [Description("我要报销明细")]
        public PartialViewResult DoReimbursementsub()
        {
            return PartialView();
        }

        [Action]
        [Description("预算科目")]
        public PartialViewResult DoBudget()
        {
            return PartialView();
        }

        [Action]
        [Description("我的报销单明细")]
        public PartialViewResult ReimbursementDetail()
        {
            return PartialView();
        }
    }
}
