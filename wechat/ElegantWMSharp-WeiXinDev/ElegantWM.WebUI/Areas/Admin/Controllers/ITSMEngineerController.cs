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
 * 时间：2014/6/30 22:30:17
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
    [Description("运维工程师")]
    public class ITSMEngineerController : BaseController
    {
        [Page]
        [Description("运维工程师")]
        public ActionResult Index()
        {
            return View();
        }


        [Action]
        [Description("获取所有")]
        [HttpGet]
        public JsonResult GetAll()
        {
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            return Json(WMFactory.ITSMEngineer.FindByConditions(o => o.OrderBy(c => c.EgrName), f => f.TntId == tntId).ToList(), JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition)
        {
            int totalCount = 0;
            Guid tntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            var list = WMFactory.ITSMEngineer.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderBy(x => x.EgrName),
                                                      f => f.TntId == tntId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(ITSM_Engineer _t)
        {
            IITSMEngineerService service = WMFactory.ITSMEngineer;
            ITSM_Engineer entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<ITSM_Engineer, ITSM_Engineer>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(ITSM_Engineer _t)
        {
            if (WMFactory.ITSMEngineer.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(ITSM_Engineer _t)
        {
            if (WMFactory.ITSMEngineer.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }


    }
}
