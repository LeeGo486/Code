using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using ElegantWM.Common;
using ElegantWM.DTO;
using System.Data;
using ElegantWM.Tools;
using ElegantWM.WebUI.Areas.Matrix;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class CMTFeedBackController : BaseMatrixS3Controller
    {
        //
        // GET: /S3/CMTFeedBack/
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("反馈日历")]
        public PartialViewResult Calender() 
        {
            return PartialView();
        }

        [Action]
        [Description("获取登陆用户信息")]
        private DataTable GetCurUser() {
            DataTable dtUser = WMFactory.Wsrr.CheckS3UserBind(Request["oid"]);
            return dtUser;
        }

        [Action]
        [Description("获取当月信息")]
        public string Get(DateTime start, DateTime end, string strRole) 
        {
            //DataTable dtUser = GetCurUser();
            //string deptoid = dtUser.Rows[0]["depotid"].ToString();

            string strBegin = Convert.ToString(start);
            string strEnd = Convert.ToString(end);
            //string strRole = Request["strRole"];
            string DepotID = "";
            string Role = "";
            string UserID = "";

            strBegin = strBegin.Substring(0, 10);
            //start = "2014-11-01";
            strEnd = strEnd.Substring(0, 10);
            //end = "2014-11-30";
            if (strRole == "店长")
            {
                 DepotID = "H1038003";
                 Role = "店长";
                 UserID = "H00000056";
            }
            else {
                DepotID = "";
                Role = "导购";
                UserID = "H00000666";
            }
            //string strReturn = "{\"Role\":\"导购\",\"DepotID\":\"E0009658\",\"UserID\":\"H00000666\",\"data\":";
            string strReturn = "{\"Role\":\"" + Role + "\",\"DepotID\":\"" + DepotID + "\",\"UserID\":\"" + UserID + "\",\"data\":";
            string strAml = "【操作类型,GET】【CONO,HYFG】【DIVI,EP】【用户角色," + Role + "】【用户ID," + UserID + "】【店铺ID," + DepotID + "】【开始时间," + strBegin + "】【结束时间," + strEnd + "】【实体,TaskSummary】【明细类型,】";
            DataSet ds = WMFactory.CMTTaskDetail.TaskResult("API_REPORT.TaskView", strAml);
            DataTable dt = ds.Tables[0];
            string jsonStr = JsonHelper.ToJson(dt);//"]"
            strReturn += jsonStr + "}";
            return strReturn;

            //return Json(JsonHelper.ToJson(WMFactory.Wsrr.GetTaskView(aml)));
        }

        [Action]
        [Description("预约任务")]
        public ActionResult TaskDeail(string data) {
            return PartialView();
        }

        [Action]
        [Description("获取任务明细")]
        public string GetTaskDetail(CMTTaskDetailDto para)
        {

            if (para.Role == "店长" && para.UserID == "") {
                para.UserID = "H00000659";
            }


            string aml = "【操作类型,GET】【CONO,HYFG】【DIVI,EP】【用户角色," + para.Role + "】【用户ID," + para.UserID + "】【店铺ID," + para.DepotID + "】【开始时间," + para.Date + "】【结束时间,】【实体,TaskDetail】【明细类型," + para.Type + "】";

            DataSet ds = WMFactory.CMTTaskDetail.TaskResult("API_REPORT.TaskView", aml);

            //取后台返回的字符串
            string strRst = ds.Tables[0].Rows[0][0].ToString();

            //转换
            DataSet dsTranslation = XmlHelper.GetDSByExcelXML(strRst, false, false);

            string jsonStr = JsonHelper.ToJson(dsTranslation);//"]"
            
            return jsonStr;
        }

        [Action]
        [Description("个人信息")]
        public PartialViewResult CustomerInfo(string CusID)
        {
            string where = "[Code]='" + CusID + "'";
            DataTable dt = WMFactory.Wsrr.GetCustomerInfo(where);
            ViewBag.CusInfo = dt;
            return PartialView();
        }

        [Action]
        [Description("预约任务反馈")]
        public PartialViewResult TaskFeedBack(string where, string taskID, string CUSID) 
        {
            DataTable dt = WMFactory.Wsrr.GetFruit(where);
            DataTable dt_Refuse = WMFactory.Wsrr.Refuse("拒绝原因");
            ViewBag.Select = dt;
            ViewBag.Reason = dt_Refuse;
            ViewBag.Type = where;
            ViewBag.ID = taskID;
            ViewBag.CUSID = CUSID;
            return PartialView();
        }

        [Action]
        [Description("到店任务反馈")]
        public PartialViewResult TaksFeedArrival(string taskID,string CUSID)
        {
            ViewBag.ID = taskID;
            ViewBag.CUSID = CUSID;
            return PartialView();
        }

        [Action]
        [Description("任务提交")]
        [ValidateInput(false)]
        public JsonResult FeedBackSumbit(string where) 
        {
            where += "<LmUser>赵振</LmUser>";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.FBSumbit(where)));
        }

        [Action]
        [Description("到店提交")]
        [ValidateInput(false)]
        public JsonResult FeedBackSumbitArrival(string where) {
            where += "<LmUser>赵振</LmUser>";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.FeedBackSumbitArrival(where)));
        }

        [Action]
        [Description("客户经理列表")]
        public JsonResult SellerList(CMTTaskDetailDto para)
        {
            DataTable dt = WMFactory.Wsrr.SellerList(para.DepotID);

            return Json(JsonHelper.ToJson(dt));
        }


    }
}
