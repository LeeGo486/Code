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
 * 时间：2014/6/15 22:28:59
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
    [Description("菜单管理")]
    public class WXMenuController : BaseController
    {
        [Page]
        [Description("菜单管理")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public string Get(Guid accountId)
        {
            return WMFactory.WXMenu.MenuTree(accountId);
        }

        [Action]
        [Description("更新微信菜单")]
        [HttpPost]
        public JsonResult UpdateWxMenu(Guid accountId)
        {
            string strJson = WMFactory.WXMenu.WxMenuJson(accountId);
            return Json(ElegantWM.WeiXin.Common.SaveMenu(accountId.ToString(), strJson));
        }

        [Action]
        [Description("删除微信菜单")]
        [HttpPost]
        public JsonResult DeleteWxMenu(Guid accountId)
        {
            return Json(ElegantWM.WeiXin.Common.RemoveMenu(accountId.ToString()));
        }


        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(WX_Menu _t)
        {
            IWXMenuService service = WMFactory.WXMenu;
            WX_Menu entity = service.GetById(_t.Id.ToString());
            if (entity == null)
                return Post(_t);

            entity = AutoMapper<WX_Menu, WX_Menu>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(WX_Menu _t)
        {
            if (WMFactory.WXMenu.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(WX_Menu _t)
        {
            if (WMFactory.WXMenu.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }

        [Action]
        [Description("复制行业模板")]
        [HttpPost]
        public JsonResult CopyMenu(Guid idtId, Guid wxId)
        {
            WMFactory.WXMenu.CopyMenu(idtId, wxId);
            return Json(ResultMsg.Success("菜单模板应用成功！"));
        }
    }
}
