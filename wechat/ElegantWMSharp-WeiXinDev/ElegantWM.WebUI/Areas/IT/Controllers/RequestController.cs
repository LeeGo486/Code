using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.IT.Controllers
{
    public class RequestController : BaseMatrixAMController
    {

        [Page]
        [Description("需求分析")]
        public ActionResult Query()
        {
            return View();
        }


        [Page]
        [Description("我的请求->需求列表")]
        public PartialViewResult MyReqList()
        {
            ViewBag.UserName = this.GetUserName();

            System.Data.DataTable dt = new System.Data.DataTable();
            if (Request["reqState"] == "ALL")
            {
                dt = WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,900】【显示类型,已完成】【需求提报人," + this.GetUserName() + "】");
            }
            else
            {
                dt = WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,900】【显示类型,未完成】【需求提报人," + this.GetUserName() + "】");
            }

            if (dt != null && dt.Rows.Count > 0)
            {
                ViewBag.Order = dt.Rows[0]["NOTCLOSE"].ToString();
                ViewBag.OrderAll = dt.Rows[0]["CLOSE"].ToString();
            }

            return PartialView(dt);
            //return PartialView(WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,900】【需求提报人,罗洁】"));
        }


        [Page]
        [Description("我的评价->需求列表")]
        public PartialViewResult MyStaffReqList()
        {
            ViewBag.UserName = this.GetUserName();

            System.Data.DataTable dt = new System.Data.DataTable();
            if (Request["reqState"] == "ALL")
            {
                dt = WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,910】【显示类型,已评价】【评价人," + this.GetUserName() + "】");
            }
            else
            {
                dt = WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,910】【显示类型,待评价】【评价人," + this.GetUserName() + "】");
            }


            if (dt != null && dt.Rows.Count > 0)
            {
                ViewBag.Order = dt.Rows[0]["NOTCLOSE"].ToString();
                ViewBag.OrderAll = dt.Rows[0]["CLOSE"].ToString();
            }

            return PartialView(dt);
            //return PartialView(WMFactory.ITDC.GetRptDataTable("【操作类型,微信】【问题,910】【评价人,李应离】"));
        }




        [Page]
        [Description("提交订单评价")]
        public ActionResult SurveySubmit()
        {
            return View();
        }

        [Page]
        [Description("用户交付")]
        public ActionResult AgreeDelivery()
        {
            ViewBag.UserName = this.GetUserName();
            return View();
        }

        [Action]
        [Description("需求分析")]
        [HttpPost]
        public string GetQueryData()
        {
            if (string.IsNullOrEmpty(Request["key"]))
                return "参数错误！";
            else
                return WMFactory.ITDC.GetRptData(Request["key"].Trim()).Replace("\n", "<br />").Replace("?key=", "?sid=" + Request["sid"] + "&oid=" + Request["oid"] + "&key=");
        }

        [Action]
        [Description("获取公司部门")]
        public JsonResult GetDept()
        {
            return Json(WMFactory.ITDC.GetAMDept(GetUserName()), JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("获取ITDC公司部门")]
        public JsonResult GetITDComDept()
        {
            return Json(WMFactory.ITDC.GetITDComDept(), JsonRequestBehavior.AllowGet);
        }


        [Action]
        [Description("获取用户信息")]
        public string GetUserName()
        {
            CertificateDto cer = AuthToken.CurrentUserByTid(WMFactory.WXLKFansC3AM.GetCurrentAMUser(Guid.Parse(Request["sid"]), Request["oid"]).TokenId.ToString());
            return cer.UserName;
            //return "李应离";
        }

    }
}
