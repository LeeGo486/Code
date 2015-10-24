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
 * 时间：2014/7/26 0:33:03
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
    [Description("行业管理")]
    public class OO_IndustryController : BaseController
    {
        [Page]
        [Description("行业管理")]
        public ActionResult Index()
        {
            return View();
        }

		[Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get()
        {
            var list = WMFactory.OO_Industry.FindByConditions(o => o.OrderBy(x => x.OrderIndex),
                                                      f => f.IsDelete == 0);
            return Json(new { data = list}, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(OO_Industry _t)
        {
            IOO_IndustryService service = WMFactory.OO_Industry;
            OO_Industry entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<OO_Industry, OO_Industry>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(OO_Industry _t)
        {
            if (WMFactory.OO_Industry.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(OO_Industry _t)
        {
            if (WMFactory.OO_Industry.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
