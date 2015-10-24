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

/**
 * 作者：WebMisSharp
 * 时间：2014/7/11 10:06:54
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
    [Description("基础信息")]
    public class ITSMBasicInfoController : BaseController
    {
        [Page]
        [Description("基础信息")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取下拉数据")]
        [HttpGet]
        public JsonResult GetBasicInfo(string type)
        {
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            IEnumerable<ITSM_BasicInfo> list = WMFactory.ITSMBasicInfo.FindByConditions(o => o.OrderBy(x => x.BIndex), f => f.TntId == tntId && f.BIType == type);
            return Json(list,JsonRequestBehavior.AllowGet);
        }

		[Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.ITSMBasicInfo.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      null, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(ITSM_BasicInfo _t)
        {
            IITSMBasicInfoService service = WMFactory.ITSMBasicInfo;
            ITSM_BasicInfo entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<ITSM_BasicInfo, ITSM_BasicInfo>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(ITSM_BasicInfo _t)
        {
            _t.TntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            if (WMFactory.ITSMBasicInfo.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(ITSM_BasicInfo _t)
        {
            if (WMFactory.ITSMBasicInfo.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
