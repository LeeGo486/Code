using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class AssistantController : BaseMatrixS3Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("滞销款提醒")]
        public PartialViewResult SkcChats()
        {
            return PartialView();
        }

        [Action]
        [Description("新品上市")]
        public PartialViewResult NewProduct()
        {
            return PartialView();
        }

        [Action]
        [Description("待办任务")]
        public PartialViewResult Task()
        {
            return PartialView();
        }

        [Action]
        [Description("商品列表")]
        public PartialViewResult SkcList()
        {
            return PartialView();
        }

        [Action]
        [Description("商品信息")]
        public PartialViewResult SkcInfo()
        {
            return PartialView();
        }

        [Action]
        [Description("库存分布")]
        public PartialViewResult Stock()
        {
            return PartialView();
        }

        [Action]
        [Description("系列故事建议")]
        public PartialViewResult AddStory()
        {
            return PartialView();
        }

        [Action]
        [Description("卖点补充")]
        public PartialViewResult AddDesign()
        {
            return PartialView();
        }

        [Action]
        [Description("洗涤保养建议")]
        public PartialViewResult AddWashing()
        {
            return PartialView();
        }

        [Action]
        [Description("销售技巧建议")]
        public PartialViewResult AddSkill()
        {
            return PartialView();
        }

        [Action]
        [Description("搭配建议")]
        public PartialViewResult AddMatch()
        {
            return PartialView();
        }

        [Action]
        [Description("客户效果")]
        public PartialViewResult AddCustomerMatch()
        {
            return PartialView();
        }

        [Action]
        [Description("客户评价列表")]
        public PartialViewResult CustomerEvaluate()
        {
            return PartialView();
        }

        [Action]
        [Description("增加客户评价")]
        public PartialViewResult AddCustomerEvaluate()
        {
            return PartialView();
        }

        [Action]
        [Description("对客户评价")]
        public PartialViewResult DoCustomerEvaluate()
        {
            return PartialView();
        }

        [Action]
        [Description("问题反馈")]
        public PartialViewResult Feedback()
        {
            return PartialView();
        }

        [Action]
        [Description("申请调入")]
        public PartialViewResult DoTurnin()
        {
            return PartialView();
        }

        [Action]
        [Description("申请调出")]
        public PartialViewResult DoTurnout()
        {
            return PartialView();
        }

        [Action]
        [Description("申请召回")]
        public PartialViewResult DoRecall()
        {
            return PartialView();
        }

        [Action]
        [Description("申请促销")]
        public PartialViewResult DoPromotion()
        {
            return PartialView();
        }
    }
}
