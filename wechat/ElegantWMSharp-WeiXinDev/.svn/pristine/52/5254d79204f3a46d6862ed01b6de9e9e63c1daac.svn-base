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
 * 时间：2014/6/11 17:25:23
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
    [Description("粉丝管理")]
    public class WXFansController : BaseController
    {
        [Page]
        [Description("粉丝管理")]
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
            var list = WMFactory.WXFans.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.AccountId == accountId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [HttpPost]
        [Open]
        public JsonResult SendServiceNotice(Guid sid, string oid)
        {
            WxServiceNotice notice = new WxServiceNotice();
            notice.touser = oid;
            notice.template_id = "Ikb2gb1JH5p9ZTTycb8i0RghIMlRqiyb48Be7EwZCK0";
            notice.url = "http://www.baidu.com";
            notice.topcolor = "#ff6666";
            notice.data = "{\"first\":{\"value\":\"尊敬的陈杰，您收到一条新的ITSM事件，请及时在ITDC公众账号中处理。\\n\\n\",\"color\":\"#ff6666\"},"
                          + "\"keynote1\":{\"value\":\"201410290099\",\"color\":\"#ff6666\"},"
                          + "\"keynote2\":{\"value\":\"2014-10-29\",\"color\":\"#666666\"},"
                          + "\"remark\":{\"value\":\"事件描述：我的打印机坏掉了，麻烦帮我处理下哦。\\n员工姓名：陈杰\\n所在部门：商品部\\n事发地点：雅莹商业园\",\"color\":\"#333333\"}}";
            if (ElegantWM.WeiXin.Common.SendServiceNotice(sid.ToString(), notice))
                return Json(ResultMsg.Success("服务通知发送成功！"));
            else
                return Json(ResultMsg.Failure("服务通知发送失败！"));
        }

        [Action]
        [Description("同步MP后台关注者")]
        [HttpGet]
        public static string SyncOpenId(Guid sid)
        {
            WxOpenIds openIds = ElegantWM.WeiXin.Common.GetFanList(sid.ToString(), "");
            string fails = "ErrorList：";
            foreach (string oid in openIds.data.openid)
            {
                if (WMFactory.WXFans.GetCount(f => f.AccountId == sid && f.OpenId == oid) <= 0)
                {
                    WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
                    WX_Fans fan = new WX_Fans();
                    fan.OpenId = oid;
                    fan.AccountId = sid;
                    fan.NickName = wf.nickname;
                    fan.Sex = wf.sex;
                    fan.City = wf.city;
                    fan.Province = wf.province;
                    fan.Avatar = wf.headimgurl;
                    fan.CreateUser = "SYNC";
                    if (!WMFactory.WXFans.Insert(fan))
                    {
                        fails += oid + ",";
                    }
                }
            }

            if (openIds.total <= openIds.count)
            {
                //说明没有更多了
            }

            return fails;
        }

        public string Send48Msg(Guid sid, string oid)
        {
            ElegantWM.WeiXin.Common.SendCustomerService(sid.ToString(), oid, "text", "{\"content\":\"测试测试看看看\"}");
            return "OK";
        }

        //[Action]
        //[Description("更新")]
        //[HttpPut]
        //public JsonResult Put(WX_Fans _t)
        //{
        //    IWXFansService service = WMFactory.WXFans;
        //    WX_Fans entity = service.GetById(_t.Id.ToString());
        //    entity = AutoMapper<WX_Fans, WX_Fans>.Convert(_t, entity);
        //    if (service.Update(entity))
        //        return Json(ResultMsg.Success("更新成功！"));
        //    else
        //        return Json(ResultMsg.Failure("更新失败，请您重试！"));
        //}

        //[Action]
        //[Description("新增")]
        //[HttpPost]
        //public JsonResult Post(WX_Fans _t)
        //{
        //    if (WMFactory.WXFans.Insert(_t))
        //        return Json(ResultMsg.Success("新增成功！"));
        //    else
        //        return Json(ResultMsg.Failure("新增失败，请您重试！"));
        //}

        //[Action]
        //[Description("删除")]
        //[HttpDelete]
        //public JsonResult Delete(WX_Fans _t)
        //{
        //    if (WMFactory.WXFans.Delete(s => s.Id == _t.Id ))
        //        return Json(ResultMsg.Success("删除成功！"));
        //    else
        //        return Json(ResultMsg.Failure("删除失败，请您重试！"));
        //}
    }
}
