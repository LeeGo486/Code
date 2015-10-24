using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class FeedBackController : BaseMatrix3SController
    {
        //
        // GET: /S3/FeedBack/
        private DataTable GetCurUser(string oid)
        {
            DataTable dtUser = WMFactory.Wsrr.CheckS3UserBind(oid);
            return dtUser;
        }

        [Page]
        [Description("客户反馈")]
        [HttpGet]
        public ActionResult Create()
        {
            //获取字典信息
            IEnumerable<S3_Dictionary> dict = WMFactory.S3Dictionary.FindByConditions(null, f => "反馈类型,反馈小类,身高,体型,职业".Contains(f.Type));
            ViewBag.Category = dict.Where(f => f.Type == "反馈类型").OrderBy(o => o.Seq).ToList();
            ViewBag.SubCategory = dict.Where(f => f.Type == "反馈小类").OrderBy(o => o.Seq).ToList();
            ViewBag.Height = dict.Where(f => f.Type == "身高").OrderBy(o => o.Seq).ToList();
            ViewBag.Profs = dict.Where(f => f.Type == "职业").OrderBy(o => o.Seq).ToList();
            ViewBag.Figure = dict.Where(f => f.Type == "体型").OrderBy(o => o.Seq).ToList();

            return View();
        }

        [Page]
        [Description("我的反馈")]
        public ActionResult Index(Guid sid, string oid)
        {
            DateTime curDay = DateTime.Now.Date;
            //获取用户.A0012002
            string curUser = GetCurUser(oid).Rows[0]["employeeid"].ToString();
            ViewBag.CurTotal = WMFactory.SHOPCustomerFeedback.GetCount(f => f.CreateUser == curUser && f.CreateTime >= curDay);
            return View();
        }

        [Action]
        [Description("我的反馈详细")]
        public PartialViewResult DetailList(Guid sid, string oid, string start, string end)
        {
            DateTime startDate = DateTime.Now.Date;
            DateTime endDate = DateTime.Now.Date;
            IEnumerable<SHOP_CustomerFeedback> list = new List<SHOP_CustomerFeedback>();

            if (!string.IsNullOrEmpty(start) && !DateTime.TryParse(start, out startDate))
            {
                return PartialView(list);
            }

            if (!string.IsNullOrEmpty(end) && !DateTime.TryParse(end, out endDate))
            {
                return PartialView(list);
            }

            endDate = endDate.AddDays(1).Date;
            string curUser = GetCurUser(oid).Rows[0]["employeeid"].ToString();
            return PartialView(WMFactory.SHOPCustomerFeedback.FindByConditions(o => o.OrderByDescending(e => e.CreateTime), f => f.CreateUser == curUser && f.CreateTime >= startDate && f.CreateTime <= endDate));
        }

        [Page]
        [Description("获取客户信息")]
        [HttpPost]
        public JsonResult GetVipInfo(string tel)
        {
            return Json(WMFactory.Wsrr.GetVipInfo(tel));
        }

        [Page]
        [Description("提交反馈")]
        [HttpPost]
        public JsonResult Submit(Guid sid, string oid, SHOP_CustomerFeedback fb)
        {
            if (string.IsNullOrEmpty(fb.CusName) || string.IsNullOrEmpty(fb.Remark))//|| string.IsNullOrEmpty(fb.Mobile)
            {
                return Json(ResultMsg.Failure("请补充完整信息"));
            }
            //验证款号是否存在
            if (!string.IsNullOrEmpty(fb.SKC))
            {
                DataTable dt = WMFactory.Wsrr.CheckSKC(fb.SKC);
                if (dt == null || dt.Rows.Count <= 0 || dt.Rows[0]["STYLEID"].ToString().Length <= 0)
                {
                    return Json(ResultMsg.Failure("该款式不存在！"));
                }
                fb.Series = dt.Rows[0]["NAME5"].ToString();
            }

            //获取用户.A0012002
            DataTable dtUser = WMFactory.Wsrr.CheckS3UserBind(oid);

            fb.Branch = dtUser.Rows[0]["d_dq"].ToString();
            fb.CusManager = dtUser.Rows[0]["names"].ToString();
            fb.DepotName = dtUser.Rows[0]["d_name"].ToString();
            fb.CreateUser = dtUser.Rows[0]["employeeid"].ToString();
            fb.DepotId = dtUser.Rows[0]["depotid"].ToString();

            if (WMFactory.SHOPCustomerFeedback.Insert(fb))
                return Json(ResultMsg.Success("反馈提交成功！"));
            else
                return Json(ResultMsg.Failure("抱歉，提交失败！"));
        }

        #region IPAD报表
        [Action]
        [Description("HightCharts报表")]
        [HttpGet]
        [Open]
        public JsonResult RptData(int type, string param, int date)
        {
            return Json(WMFactory.SHOPCustomerFeedback.Report(type, param, date),JsonRequestBehavior.AllowGet);
        }

        [Description("获取详细反馈")]
        [HttpGet]
        [Action]
        [Open]
        public PartialViewResult FeedBackDetail(int type, string param, int date)
        {
            return PartialView(WMFactory.SHOPCustomerFeedback.ReportDetail(type, param, date));
        }
        #endregion
    }
}
