using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Tools;
using System.Data;
using ElegantWM.DTO;
using ElegantWM.WebUI.Areas.Matrix;
using ElegantWM.BLL;
using ElegantWM.IBLL;
using ElegantWM.WeiXin.MsgEntity;

/*
 * 2014-09-29
 * 陈杰 修改 当前排队还有x人，根据事发地点计数
 * 
 */
namespace ElegantWM.WebUI.Areas.IT.Controllers
{
    public class SMController : BaseMatrixAMController
    {

        private CertificateDto CurrentUser()
        {
            return AuthToken.CurrentUserByTid(WMFactory.WXLKFansC3AM.GetCurrentAMUser(Guid.Parse(Request["sid"]), Request["oid"]).TokenId.ToString());
        }

        [Action]
        [Description("获取组织架构")]
        public JsonResult CompanyDept()
        {
            CertificateDto cer = CurrentUser();
            return Json(WMFactory.ITDC.GetAMDept(cer.UserName), JsonRequestBehavior.AllowGet);
        }


        [Page]
        [Description("工程师排班")]
        public ViewResult EgrSchedule()
        {
            DataTable dt = WMFactory.ITSMEgrSchedule.ScheduleDetail();
            ViewBag.XQ = dt.DefaultView.ToTable(true, "WD");
            ViewBag.Egr = WMFactory.ITSMEngineer.GetAll();
            return View(dt);
        }



        [Action]
        [Description("员工事件提报")]
        [HttpPost]
        public JsonResult SubmitEvent(ITSM_Event ent)
        {
            if (Session["SEventFlag"] != null && ((DateTime)Session["SEventFlag"]).AddMinutes(5) > DateTime.Now)
            {
                return Json(ResultMsg.Failure("抱歉，您提交的太快，请五分钟后再提交！"));
            }
            CertificateDto cer = CurrentUser();
            ent.ReqMan = cer.UserName;
            ent.CreateUser = "Matrix";
            ent.ProcessStatus = 0;//待派工
            ent.TntId = Guid.Parse(cer.GroupId);
            ent.Code = "";

            int temp = 0;
            DateTime timeNow = DateTime.Now.Date;
            IEnumerable<ITSM_Event> env1 = WMFactory.ITSMEvent.FindByPage(0, 1, out temp, o => o.OrderByDescending(x => x.CreateTime), f => f.CreateTime >= timeNow && f.TntId == ent.TntId);
            if (env1.Count() == 0)
            {
                ent.Code = DateTime.Now.ToString("yyyyMMdd001");
            }
            else
            {
                string strMaxCode = env1.FirstOrDefault().Code;
                ent.Code = DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt64(strMaxCode.Substring(8)) + 1).ToString("000");
            }

            //之前还有多少人排队等待
            int waiters = WMFactory.ITSMEvent.GetCount(f => f.ProcessStatus < 4 && f.TntId == ent.TntId && f.ReqIncident==ent.ReqIncident.Trim());

            if (WMFactory.ITSMEvent.Insert(ent))
            {
                Session["SEventFlag"] = DateTime.Now;
                WMFactory.ITSMEvent.Notice(0, ent);
                return Json(ResultMsg.Success("事件提交成功，您之前还有 “" + waiters.ToString() + "人” 在排队。"));
            }
            else
                return Json(ResultMsg.Failure("事件提交失败，请重试！"));
        }

         
        [Page]
        [Description("我的事件列表")]
        public PartialViewResult MyEventList(string state)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);

            //统计当前用户未完成和所有事件数量
            ViewBag.EventCount = WMFactory.ITSMEvent.GetCount(f => f.ReqMan == curUser && f.ProcessStatus != 9 && f.ProcessStatus != 5 && f.TntId == tntId);
            ViewBag.AllEventCount = WMFactory.ITSMEvent.GetCount(f => f.ReqMan == curUser && f.TntId == tntId);

            //返回明细
            if (state == null || state.ToUpper() != "ALL")
            {
                IEnumerable<ITSM_Event> list = WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.ReqMan == curUser && f.ProcessStatus != 9 && f.ProcessStatus != 5 && f.TntId == tntId);
                if(list.Count()!=0)
                    return PartialView(list);
                else
                    return PartialView(WMFactory.ITSMEvent.FindByConditions(null,f=>f.Code=="20140713999"));
            }
            else
            {
                return PartialView(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.ReqMan == curUser && f.TntId == tntId));
            }
        }

        [Page]
        [Description("我的事件评价列表")]
        public PartialViewResult MyStaffEventList(string state)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);

            //统计当前用户待评价和已评价事件数量
            ViewBag.EventCount = WMFactory.ITSMEvent.GetCount(f => f.ReqMan == curUser && f.ProcessStatus == 4 && f.TntId == tntId);
            ViewBag.AllEventCount = WMFactory.ITSMEvent.GetCount(f => f.ReqMan == curUser && f.ProcessStatus == 5 && f.TntId == tntId);

            //返回明细
            if (state == null || state.ToUpper() != "ALL")
            {
                return PartialView(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.ReqMan == curUser && f.ProcessStatus == 4 && f.TntId == tntId));
            }
            else
            {
                return PartialView(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.ReqMan == curUser && f.ProcessStatus == 5 && f.TntId == tntId));
            }
        }

        [Page]
        [Description("ITSM事件报表")]
        public ViewResult Report()
        {
            ViewBag.OverView = WMFactory.ITSMEvent.GetProcData(101);
            return View();
        }

        [Action]
        [Description("ITSM事件报表数据")]
        [HttpPost]
        public JsonResult RptData(int type)
        {
            return Json(WMFactory.ITSMEvent.Report(type));
        }

        [Page]
        [Description("ITSM事件汇报")]
        public ViewResult EventReport(string state)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            //统计当前用户待完成和已完成事件数量
            ViewBag.EventCount = WMFactory.ITSMEvent.GetCount(f => f.Engineer == curUser && f.ProcessStatus < 4 && f.TntId == tntId);
            ViewBag.AllEventCount = WMFactory.ITSMEvent.GetCount(f => f.Engineer == curUser && f.TntId == tntId);
            ViewBag.Engineer = WMFactory.ITSMEngineer.FindByConditions(o => o.OrderBy(x => x.EgrName), f => f.TntId == tntId && f.EgrName != curUser);
            //获取设备和应用
            ViewBag.BasicInfo = WMFactory.ITSMBasicInfo.FindByConditions(o => o.OrderBy(x => x.BIndex), f => f.TntId == tntId && "设备,应用".Contains(f.BIType));
            //返回明细
            if (state == null || state.ToUpper() != "ALL")
            {
                return View(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.Engineer == curUser && f.ProcessStatus < 4 && f.TntId == tntId));
            }
            else
            {
                return View(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.Engineer == curUser && f.TntId == tntId));
            }
        }

        [Page]
        [Description("所有ITSM事件列表")]
        public ViewResult AllEventList(string state)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            //统计当前所有未完成和所有事件数量
            ViewBag.EventCount = WMFactory.ITSMEvent.GetCount(f => f.ProcessStatus < 4 && f.TntId == tntId);
            ViewBag.AllEventCount = WMFactory.ITSMEvent.GetCount(f => f.TntId == tntId);
            //返回明细
            if (state == null || state.ToUpper() != "ALL")
            {
                return View(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.ProcessStatus < 4 && f.TntId == tntId));
            }
            else
            {
                return View(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.TntId == tntId));
            }
        }

        [Page]
        [Description("事件详细")]
        public ActionResult Detail(Guid id)
        {
            ViewBag.EventLog = WMFactory.ITSMEventLog.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.Eid == id);
            return View(WMFactory.ITSMEvent.GetById(id.ToString()));
        }

        [Page]
        [Description("事件历史")]
        public ActionResult DetailHisList(Guid id)
        {
            ViewBag.EventLog = WMFactory.ITSMEventLog.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.Eid == id);
            return View(WMFactory.ITSMEvent.GetById(id.ToString()));
        }

        [Action]
        [Description("是否能撤销")]
        [HttpPost]
        public JsonResult CheckIsCancel(Guid id)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(id.ToString());
            if (ent.ReqMan != curUser)
            {
                return Json(ResultMsg.Failure("只能取消自己的事件"));
            }
            if (ent.ProcessStatus != 0)
            {
                return Json(ResultMsg.Failure("只能取消提报中的事件"));
            }

            return Json(ResultMsg.Success("可以取消"));
        }

        [Action]
        [Description("取消事件")]
        [HttpPost]
        public JsonResult CancelEvent(Guid id)
        {
            //取消自己的事件
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(id.ToString());
            if (ent.ReqMan != curUser)
            {
                return Json(ResultMsg.Failure("只能取消自己的事件"));
            }
            if (ent.ProcessStatus != 0)
            {
                return Json(ResultMsg.Failure("只能取消提报中的事件"));
            }
            ent.ModifyUser = curUser;
            ent.ProcessStatus = 9;
            if (WMFactory.ITSMEvent.Update(ent))
            {
                //插入日志
                ITSM_EventLog entlog = new ITSM_EventLog();
                entlog.Reason = "取消事件";
                entlog.CreateUser = curUser;
                entlog.Eid = ent.Id;
                WMFactory.ITSMEventLog.Insert(entlog);
                return Json(ResultMsg.Success("事件取消成功"));
            }
            else
                return Json(ResultMsg.Failure("操作失败"));
        }

        [Action]
        [Description("是否能评价")]
        [HttpPost]
        public JsonResult CheckIsEvl(Guid id)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(id.ToString());
            if (ent.ReqMan != curUser)
            {
                return Json(ResultMsg.Failure("只能评价自己的事件"));
            }
            if (ent.ProcessStatus != 4 && ent.ProcessStatus != 5)
            {
                return Json(ResultMsg.Failure("无法评价未完成事件"));
            }

            if (ent.ProcessStatus == 5)
            {
                return Json(ResultMsg.Failure("事件已评价,无需再评"));
            }
            return Json(ResultMsg.Success("可以评价"));
        }

        [Action]
        [Description("用户评价")]
        [HttpPost]
        public JsonResult SubmitEval(ITSM_Event ent)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            IITSMEventService srv = WMFactory.ITSMEvent;
            ITSM_Event orgEvent = srv.GetById(ent.Id.ToString());
            if (orgEvent.ReqMan != curUser)
            {
                return Json(ResultMsg.Failure("只能评价自己的事件"));
            }
            if (orgEvent.ProcessStatus != 4)
            {
                return Json(ResultMsg.Failure("失败，事件非待评价状态！"));
            }
            orgEvent.ElvTime = ent.ElvTime;
            orgEvent.ElvAtude = ent.ElvAtude;
            orgEvent.ElvRst = ent.ElvRst;
            orgEvent.ElvDesc = ent.ElvDesc;
            orgEvent.ProcessStatus = 5;
            orgEvent.ModifyUser = curUser;
            //插入日志
            ITSM_EventLog entlog = new ITSM_EventLog();
            entlog.Reason = "完成评价";
            entlog.CreateUser = curUser;
            entlog.Eid = ent.Id;
            WMFactory.ITSMEventLog.Insert(entlog);
            if (srv.Update(orgEvent))
            {
                WMFactory.ITSMEvent.Notice(5, orgEvent);
                return Json(ResultMsg.Success("评价成功，感谢支持"));
            }
            else
                return Json(ResultMsg.Failure("评价失败，请重试"));
        }

        [Page]
        [Description("事件评价")]
        public ActionResult Survey(Guid id)
        {
            return View();
        }

        [Page]
        [Description("工程师事件")]
        public ActionResult EngineerEvent()
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            ViewBag.Engineer = WMFactory.ITSMEngineer.FindByConditions(o => o.OrderBy(x => x.EgrName), f => f.TntId == tntId && f.EgrName != curUser);
            return View(WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime), f => f.Engineer == curUser && f.ProcessStatus != 9 && f.TntId == tntId));
        }

        [Action]
        [Description("转派事件")]
        [HttpPost]
        public JsonResult ShiftEvent(Guid id, string egr, string remark)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(id.ToString());
            if (ent.Engineer != curUser)
            {
                return Json(ResultMsg.Failure("无法处理非己事件"));
            }
            if (ent.ProcessStatus != 2 && ent.ProcessStatus != 3)
            {
                return Json(ResultMsg.Failure("非接收和处理状态，不能转派！"));
            }
            ITSM_EventLog entlog = new ITSM_EventLog();
            entlog.Eid = ent.Id;
            entlog.CreateUser = curUser;
            entlog.Reason = "转派给" + egr;
            entlog.TntId = tntId;
            entlog.Remark = remark;
            WMFactory.ITSMEventLog.Insert(entlog);
            ent.ProcessStatus = 1;
            ent.Engineer = egr;
            if (WMFactory.ITSMEvent.Update(ent))
            {
                WMFactory.ITSMEvent.Notice(6, ent);
                SendWxSvrNotice(ent);
                return Json(ResultMsg.Success("操作成功！"));
            }
            else
                return Json(ResultMsg.Failure("操作失败！"));
        }

        /// <summary>
        /// 转派事件，微信通知用户
        /// </summary>
        private void SendWxSvrNotice(ITSM_Event evt)
        {
            try
            {
                //获取申请人的openId
                Guid sid = Guid.Parse("5E43EF3D-451F-49FC-86DA-8EDC32D08398");
                string egr = evt.Engineer;
                IEnumerable<WX_LK_FansC3AM> fans = WMFactory.WXLKFansC3AM.FindByConditions(null, f => f.AccountId == sid && f.UserName == egr);
                if (fans.Count() != 1)
                {
                    log.Error("找不到转派工程师的OPENID：" + egr);
                    return;
                }
                WxServiceNotice notice = new WxServiceNotice();
                notice.touser = fans.First().OpenId;
                notice.template_id = "Ikb2gb1JH5p9ZTTycb8i0RghIMlRqiyb48Be7EwZCK0";
                notice.url = "http://it.hwafashion.com/IT/SM/EventReport?sid=5E43EF3D-451F-49FC-86DA-8EDC32D08398";
                notice.topcolor = "#ff6666";
                notice.data = "{\"first\":{\"value\":\"尊敬的" + egr + "，您收到一条ITSM转派事件，请及时在ITDC公众账号中处理。\\n\\n\",\"color\":\"#66cc33\"},"
                              + "\"keynote1\":{\"value\":\"" + evt.Code + "\",\"color\":\"#66cc33\"},"
                              + "\"keynote2\":{\"value\":\"" + evt.CreateTime.ToString("yyyy-MM-dd HH:mm:ss") + "\",\"color\":\"#666666\"},"
                              + "\"remark\":{\"value\":\"事件描述：" + evt.EventDesc.Replace("'", "").Replace("\"", "").Replace("\r", "").Replace("\n", "")
                                                    + "\\n员工姓名：" + evt.ReqMan
                                                    + "\\n所在部门：" + evt.ReqCom + "," + evt.ReqDept
                                                    + "\\n办公地点：" + evt.ReqIncident + "\",\"color\":\"#333333\"}}";
                ElegantWM.WeiXin.Common.SendServiceNotice("5E43EF3D-451F-49FC-86DA-8EDC32D08398", notice);
            }
            catch (Exception error)
            {
                log.Error(error.Message);
            }

        }
        private bool SendWxSvrNoticeWhenOver(ITSM_Event evt)
        {
            try
            {
                //获取申请人的openId
                Guid sid = Guid.Parse("5E43EF3D-451F-49FC-86DA-8EDC32D08398");
                string reqMan = evt.ReqMan;
                IEnumerable<WX_LK_FansC3AM> fans = WMFactory.WXLKFansC3AM.FindByConditions(null, f => f.AccountId == sid && f.UserName == reqMan);
                if (fans.Count() != 1)
                {
                    log.Error("找不到事件提出人的OPENID：" + evt.ReqMan);
                    return false;
                }
                WxServiceNotice notice = new WxServiceNotice();
                notice.touser = fans.First().OpenId;
                notice.template_id = "Ikb2gb1JH5p9ZTTycb8i0RghIMlRqiyb48Be7EwZCK0";
                notice.url = "http://it.hwafashion.com/IT/SM/Survey/" + evt.Id.ToString() + "?sid=5E43EF3D-451F-49FC-86DA-8EDC32D08398&oid=" + notice.touser;
                notice.topcolor = "#ff6666";
                notice.data = "{\"first\":{\"value\":\"尊敬的" + reqMan + "，您提交的事件申请，工程师“" + evt.Engineer + "”已经为您处理完成，请对我们的服务进行评价，谢谢您的支持！\\n\\n\",\"color\":\"#ff6666\"},"
                              + "\"keynote1\":{\"value\":\"" + evt.Code + "\",\"color\":\"#ff6666\"},"
                              + "\"keynote2\":{\"value\":\"" + evt.CreateTime.ToString("yyyy-MM-dd HH:mm:ss") + "\",\"color\":\"#666666\"},"
                              + "\"remark\":{\"value\":\"事件描述：" + evt.EventDesc.Replace("'", "").Replace("\"", "").Replace("\r", "").Replace("\n", "")
                                                    + "\\n所在部门：" + evt.ReqCom + "," + evt.ReqDept
                                                    + "\\n办公地点：" + evt.ReqIncident
                                                    + "\\n\\n解决方案：" + evt.EventSolution.Replace("'", "").Replace("\"", "").Replace("\r", "").Replace("\n", "")
                                                    + "\",\"color\":\"#333333\"}}";
                return ElegantWM.WeiXin.Common.SendServiceNotice("5E43EF3D-451F-49FC-86DA-8EDC32D08398", notice);
            }
            catch (Exception error)
            {
                log.Error(error.Message);
                return false;
            }
        }

        [Action]
        [Description("完成事件")]
        [HttpPost]
        public JsonResult CompleteEvent(ITSM_Event evt)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(evt.Id.ToString());

            if (ent.Engineer != curUser)
            {
                return Json(ResultMsg.Failure("无法处理非己事件"));
            }
            if (ent.ProcessStatus != 3)
            {
                return Json(ResultMsg.Failure("非处理状态，不能完成！"));
            }
            ent.EventApp = evt.EventApp;
            ent.EventEquipment = evt.EventEquipment;
            ent.EventSolution = evt.EventSolution;

            ITSM_EventLog entlog = new ITSM_EventLog();
            entlog.Eid = ent.Id;
            entlog.CreateUser = curUser;
            entlog.Reason = "处理完成";
            entlog.TntId = tntId;
            WMFactory.ITSMEventLog.Insert(entlog);
            ent.ProcessStatus = 4;

            if (WMFactory.ITSMEvent.Update(ent))
            {
                if(!SendWxSvrNoticeWhenOver(ent))//如果执行失败了还是要发送小翅膀
                    WMFactory.ITSMEvent.Notice(4, ent);
                return Json(ResultMsg.Success("操作成功！"));
            }
            else
                return Json(ResultMsg.Failure("操作失败！"));
        }

        [Action]
        [Description("变更事件")]
        [HttpPost]
        public JsonResult HandleEvent(Guid id, int type)
        {
            CertificateDto cer = CurrentUser();
            string curUser = cer.UserName;
            Guid tntId = Guid.Parse(cer.GroupId);
            ITSM_Event ent = WMFactory.ITSMEvent.GetById(id.ToString());
            if (ent.Engineer != curUser)
            {
                return Json(ResultMsg.Failure("无法处理非己事件"));
            }
            ITSM_EventLog entlog = new ITSM_EventLog();
            entlog.Eid = ent.Id;
            entlog.CreateUser = curUser;
            if (type == 2 && ent.ProcessStatus != 1)
            {
                return Json(ResultMsg.Failure("非派工状态，操作无效"));
            }
            if (type == 3 && ent.ProcessStatus != 2)
            {
                return Json(ResultMsg.Failure("非接收状态，操作无效"));
            }
            if (type == 4 && ent.ProcessStatus != 3)
            {
                return Json(ResultMsg.Failure("非处理状态，操作无效"));
            }
            else if (type != 2 && type != 3 && type != 4)
            {
                return Json(ResultMsg.Failure("非法操作！"));
            }

            if (type == 2)
            {
                entlog.Reason = "接收事件";
            }
            else if (type == 3)
            {
                entlog.Reason = "处理中";
            }
            else if (type == 4)
            {
                entlog.Reason = "处理完成";
            }

            entlog.TntId = tntId;
            WMFactory.ITSMEventLog.Insert(entlog);
            ent.ProcessStatus = type;
            if (WMFactory.ITSMEvent.Update(ent))
            {
                return Json(ResultMsg.Success("操作成功！"));
            }
            else
                return Json(ResultMsg.Failure("操作失败！"));
        }


        [Page]
        [Description("工程师排班")]
        public ActionResult EngineerScheduling()
        {
            return View();
        }
    }
}
