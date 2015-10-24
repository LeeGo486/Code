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
using ElegantWM.Tools;

/**
 * 作者：WebMisSharp
 * 时间：2014/5/28 14:07:02
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
    [Description("微信账号")]
    public class WXAccountController : BaseController
    {
        [Page]
        [Description("微信账号")]
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
            Guid TntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            var list = WMFactory.WXAccount.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.TntId == TntId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("获取用户的所有微信号")]
        [HttpGet]
        public JsonResult GetTntAccount()
        {
            Guid TntId = Guid.Parse(AuthToken.CurrentUser.GroupId);

            return Json(WMFactory.WX_Account_USER_AUZ.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.AUZUser == AuthToken.CurrentUser.UserName, null),
                JsonRequestBehavior.AllowGet);

            //if (AuthToken.CurrentUser.UserName == "")
            //{
            //    Guid OpenId = Guid.Parse("BD20ED8F-0BD5-45B7-9D37-C85552D1701E"); //定义查询到的微信号
            //    return Json(WMFactory.WXAccount.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.TntId == TntId && f.Id == OpenId, null), JsonRequestBehavior.AllowGet);
            //}
            //else
            //{
            //    return Json(WMFactory.WXAccount.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.TntId == TntId, null), JsonRequestBehavior.AllowGet);
            //}


        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(WX_Account _t)
        {
            IWXAccountService service = WMFactory.WXAccount;
            WX_Account entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<WX_Account, WX_Account>.Convert(_t, entity);
            if (service.Update(entity))
            {
                //更新缓存，移除即可
                CacheHelper.CacheNull(entity.Id.ToString());
                return Json(ResultMsg.Success("更新成功！"));
            }
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(WX_Account _t)
        {
            if (WMFactory.WXAccount.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(WX_Account _t)
        {
            if (WMFactory.WXAccount.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }

        [Action]
        [Description("获取微信Menu")]
        [HttpGet]
        public JsonResult GetMenu(Guid sid)
        {
            return Json(ElegantWM.WeiXin.Common.GetMenu(sid.ToString()), JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新微信Menu")]
        [HttpPost]
        public JsonResult SaveMenu(Guid sid, string menuJson)
        {
            return Json(ElegantWM.WeiXin.Common.SaveMenu(sid.ToString(), menuJson));
        }
    }
}
