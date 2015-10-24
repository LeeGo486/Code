using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System.ComponentModel;
using System.Collections;
using ElegantWM.IBLL;
using ElegantWM.Common;
using ElegantWM.AutoMapper;
using ElegantWM.WeiXin.MsgEntity;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/30 22:37:06
 * 功能：restful服务层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.WebUI.Areas.Admin.Controllers
{
    [Description("事件管理")]
    public class ITSMEventController : BaseController
    {
        [Page]
        [Description("事件管理")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition)
        {
            int totalCount = 0;
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            var list = WMFactory.ITSMEvent.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.TntId == tntId, condition);
            //只在第一页并且不查询的时候起作用
            if (list.Count() > 0 && start == 0 && condition.fields == null && condition.query == null)
            {
                Session["lastGetTime"] = list.Max(f => f.CreateTime);
            }
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("获取提报人信息")]
        [HttpGet]
        public JsonResult GetReqManInfo(string reqMan)
        {
            int totalCount = 0;
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            var list = WMFactory.ITSMEvent.FindByPage(0, 1, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.TntId == tntId && f.ReqMan == reqMan.Trim());
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("每隔5s获取一次数据")]
        [HttpGet]
        public JsonResult GetPer5Second()
        {
            if (Session["lastGetTime"] == null)
            {
                return Json(new { total = 0 }, JsonRequestBehavior.AllowGet);
            }
            DateTime dtime = (DateTime)Session["lastGetTime"];
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            var list = WMFactory.ITSMEvent.FindByConditions(o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.TntId == tntId && f.CreateTime > dtime);
            if (list.Count() > 0)
                Session["lastGetTime"] = list.Max(f => f.CreateTime);
            return Json(new { data = list, total = list.Count() }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("派工")]
        [HttpPost]
        public JsonResult Assignment(Guid[] ids, string egrName)
        {
            int success = 0;
            foreach (Guid _t in ids)
            {
                IITSMEventService service = WMFactory.ITSMEvent;
                ITSM_Event entity = service.GetById(_t.ToString());
                if (entity.ProcessStatus == 9 || entity.ProcessStatus == 5)
                {
                    return Json(ResultMsg.Failure("“" + entity.Code + "”已取消或已完结的不可再派工！"));
                }
                //校验工程师,20140922修改，f.EgrName换成EgrAmName
                IEnumerable<ITSM_Engineer> egrList = WMFactory.ITSMEngineer.FindByConditions(null, f => f.EgrAmName == egrName);
                if (egrList == null || egrList.Count() <= 0)
                    return Json(ResultMsg.Failure("工程师错误，不存在！"));
                //电话号码
                entity.EngineerPhone = egrList.FirstOrDefault().Phone;
                //20141007,修改为工程师的小翅膀账号名称，否则itdc微信端gang不显示
                entity.Engineer = egrList.First().EgrAmName;
                ITSM_EventLog entLog = new ITSM_EventLog();
                entLog.Reason = "派工给" + egrName;
                entLog.Eid = _t;
                entLog.TntId = Guid.Parse(AuthToken.CurrentUser.GroupId);

                WMFactory.ITSMEventLog.Insert(entLog);

                //派工状态
                entity.ProcessStatus = 1;
                if (service.Update(entity))
                {
                    WMFactory.ITSMEvent.Notice(1, entity);
                    SendWxSvrNotice(entity);//发送微信服务通知
                    success++;
                }
            }
            return Json(ResultMsg.Success("派工成功！共计：" + success.ToString() + "条"));
        }
        /// <summary>
        /// 派工完成，微信通知用户
        /// </summary>
        private void SendWxSvrNotice(ITSM_Event evt)
        {
            //获取工程师的openId
            Guid sid = Guid.Parse("5E43EF3D-451F-49FC-86DA-8EDC32D08398");
            string egr = evt.Engineer;
            IEnumerable<WX_LK_FansC3AM> fans = WMFactory.WXLKFansC3AM.FindByConditions(null, f => f.AccountId == sid && f.UserName == egr);
            if (fans.Count() != 1)
            {
                log.Error("找不到工程师的OPENID：" + egr);
                return;
            }
            WxServiceNotice notice = new WxServiceNotice();
            notice.touser = fans.First().OpenId;
            notice.template_id = "Ikb2gb1JH5p9ZTTycb8i0RghIMlRqiyb48Be7EwZCK0";
            notice.url = "http://it.hwafashion.com/IT/SM/EventReport?sid=5E43EF3D-451F-49FC-86DA-8EDC32D08398";
            notice.topcolor = "#ff6666";
            notice.data = "{\"first\":{\"value\":\"尊敬的" + egr + "，事件经理分配了新的ITSM事件，请及时在ITDC公众账号中处理。\\n\\n\",\"color\":\"#ff6666\"},"
                          + "\"keynote1\":{\"value\":\"" + evt.Code + "\",\"color\":\"#ff6666\"},"
                          + "\"keynote2\":{\"value\":\"" + evt.CreateTime.ToString("yyyy-MM-dd HH:mm:ss") + "\",\"color\":\"#ff6666\"},"
                          + "\"remark\":{\"value\":\"事件描述：" + evt.EventDesc.Replace("'", "").Replace("\"", "").Replace("\r", "").Replace("\n", "")
                                                + "\\n员工姓名：" + evt.ReqMan
                                                + "\\n所在部门：" + evt.ReqCom + "," + evt.ReqDept
                                                + "\\n办公地点：" + evt.ReqIncident + "\",\"color\":\"#333333\"}}";
            ElegantWM.WeiXin.Common.SendServiceNotice("5E43EF3D-451F-49FC-86DA-8EDC32D08398", notice);

        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(ITSM_Event _t)
        {
            IITSMEventService service = WMFactory.ITSMEvent;
            ITSM_Event entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<ITSM_Event, ITSM_Event>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(ITSM_Event _t)
        {
            int temp = 0;
            DateTime timeNow = DateTime.Now.Date;
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            IEnumerable<ITSM_Event> env1 = WMFactory.ITSMEvent.FindByPage(0, 1, out temp, o => o.OrderByDescending(x => x.CreateTime), f => f.CreateTime >= timeNow && f.TntId == tntId);
            if (env1.Count() == 0)
            {
                _t.Code = DateTime.Now.ToString("yyyyMMdd001");
            }
            else
            {
                string strMaxCode = env1.FirstOrDefault().Code;
                _t.Code = DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt64(strMaxCode.Substring(8)) + 1).ToString("000");
            }
            //新增的时候，需要重置时间，否则导致加载两条
            Session["lastGetTime"] = DateTime.Now.AddMilliseconds(200);
            if (WMFactory.ITSMEvent.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(ITSM_Event _t)
        {
            if (WMFactory.ITSMEvent.Delete(s => s.Id == _t.Id))
            {
                //删除事件日志
                WMFactory.ITSMEventLog.Delete(s => s.Eid == _t.Id);
                return Json(ResultMsg.Success("删除成功！"));
            }
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
