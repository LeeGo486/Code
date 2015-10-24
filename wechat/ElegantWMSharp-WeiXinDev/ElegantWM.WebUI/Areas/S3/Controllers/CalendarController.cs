using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class CalendarController : BaseMatrix3SController
    {
        //
        // GET: /S3/Calendar/
        private DataTable GetCurUser()
        {
            DataTable dtUser = WMFactory.Wsrr.CheckS3UserBind(Request["oid"]);
            return dtUser;
        }

        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("反馈日历")]
        public PartialViewResult Calendar()
        {
            //WMFactory.SHOPEvent.
            return PartialView();
        }

        [Action]
        [Description("反馈明细")]
        public PartialViewResult Detail(DateTime eventday)
        {
            DataTable dtUser = GetCurUser();
            string deptoid = dtUser.Rows[0]["depotid"].ToString();

            ViewBag.Count = WMFactory.SHOPEventFeedback.GetCount(f => f.DepotId == deptoid && f.EventDay == eventday);
            if (ViewBag.Count == 0)
            {
                ViewBag.Theme = WMFactory.SHOPEvent.FindByConditions(null, f => f.isOver == 0);
            }
            else
            {
                ViewBag.Detail = WMFactory.SHOPEventFeedback.FindByConditions(null, f => f.DepotId == deptoid && f.EventDay == eventday);
            }

            DateTime date = DateTime.Now.Date;
            if (eventday == date) 
            {
                ViewBag.Date = "Current";
            }
            else if (eventday < date)
            {
                ViewBag.Date = "Before";
            }
            else
            {
                ViewBag.Date = "After";
            }
            return PartialView();
        }

        [Action]
        [Description("获取当月反馈")]
        [HttpPost]
        public JsonResult Get(DateTime start, DateTime end)
        {
            DataTable dtUser = GetCurUser();
            string deptoid = dtUser.Rows[0]["depotid"].ToString();
            return Json(WMFactory.SHOPEventFeedback.FindByConditions(null, f => f.DepotId == deptoid && f.EventDay >= start && f.EventDay <= end));
        }

        [Action]
        [Description("活动反馈提交")]
        [HttpPost]
        public JsonResult SubmitEvent(Shop_EventFeedback ent)
        {
            DataTable dtUser = GetCurUser();
            ent.CreateUser = dtUser.Rows[0]["names"].ToString();
            ent.DepotId=dtUser.Rows[0]["depotid"].ToString();
            ent.DepotName=dtUser.Rows[0]["d_name"].ToString();
            ent.CreateUserId=dtUser.Rows[0]["employeeid"].ToString();
            ent.Branch = dtUser.Rows[0]["d_dq"].ToString();


            if (WMFactory.SHOPEventFeedback.Insert(ent))
                return Json(ResultMsg.Success("反馈提交成功。"));
            else
                return Json(ResultMsg.Failure("反馈提交失败，请重试！"));
        }

        [Action]
        [Description("活动反馈修改")]
        [HttpPost]
        public JsonResult UpdateEvent(Shop_EventFeedback ent)
        {
            Shop_EventFeedback se = WMFactory.SHOPEventFeedback.GetById(ent.Id.ToString());

            se.Theme = ent.Theme;
            se.Name = ent.Name;
            se.Global = ent.Global;
            se.PlanNum = ent.PlanNum;
            se.RespondNum = ent.RespondNum;
            se.FactNum = ent.FactNum;
            se.BuyNum = ent.BuyNum;
            se.Price = ent.Price;

            DataTable dtUser = GetCurUser();
            string curUser = dtUser.Rows[0]["names"].ToString();
            se.ModifyUser = curUser;

            if (WMFactory.SHOPEventFeedback.Update(se))
                return Json(ResultMsg.Success("反馈修改成功。"));
            else
                return Json(ResultMsg.Failure("反馈修改失败，请重试！"));
        }

        [Action]
        [Description("获取活动目标")]
        [HttpPost]
        public JsonResult GetGlobal(Guid id)
        {
            DataTable dtUser = GetCurUser();
            string deptoid = dtUser.Rows[0]["depotid"].ToString();
            return Json(WMFactory.SHOPEventFeedback.FindByConditions(null, f => f.Theme == id && f.DepotId == deptoid));
        }
    }
}
