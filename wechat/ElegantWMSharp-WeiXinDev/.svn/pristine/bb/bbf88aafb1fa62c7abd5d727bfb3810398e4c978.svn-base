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
 * 时间：2014/7/26 0:33:42
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
    [Description("行业模板")]
    public class OO_MenuTemplateController : BaseController
    {
        [Page]
        [Description("行业模板")]
        public ActionResult Index()
        {
            return View();
        }

		[Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public string Get(Guid IdtId)
        {
            return WMFactory.OO_MenuTemplate.MenuTree(IdtId);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(OO_MenuTemplate _t)
        {
            IOO_MenuTemplateService service = WMFactory.OO_MenuTemplate;
            OO_MenuTemplate entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<OO_MenuTemplate, OO_MenuTemplate>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(OO_MenuTemplate _t)
        {
            if (WMFactory.OO_MenuTemplate.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(OO_MenuTemplate _t)
        {
            if (WMFactory.OO_MenuTemplate.Delete(s => s.Id == _t.Id ))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
