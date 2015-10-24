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
 * 时间：2015-07-27 16:27:59
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
    [Description("WX_QR_Code")]
    public class WX_QR_CodeController : BaseController
    {
        [Page]
        [Description("WX_QR_Code")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, Guid accountId, ExtGridSearch condition)
        {
            int totalCount = 0;
            var list = WMFactory.WX_QR_Code.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                         f => f.AccountId == accountId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(WX_QR_Code _t)
        {
            IWX_QR_CodeService service = WMFactory.WX_QR_Code;
            WX_QR_Code entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<WX_QR_Code, WX_QR_Code>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(WX_QR_Code _t)
        {
            if (WMFactory.WX_QR_Code.Insert(_t))
            {
                int iScene_id = _t.Scene_ID;
                string action_name = _t.Action_Name;
                string sceneJson = " { \"action_name\": \"" + action_name + "\", \"action_info\": {\"scene\": {\"scene_id\": " + iScene_id + "}}}";
                string sid = _t.AccountId.ToString();
                string url = ElegantWM.WeiXin.Common.Qr_limit_scene(sid, sceneJson, iScene_id);
                if (!string.IsNullOrEmpty(url))
                {
                    return Json(ResultMsg.Success("新增成功！"));
                }
                else
                {
                    return Json(ResultMsg.Failure("新增失败，请您重试！"));
                }
            }
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }
    }
}
