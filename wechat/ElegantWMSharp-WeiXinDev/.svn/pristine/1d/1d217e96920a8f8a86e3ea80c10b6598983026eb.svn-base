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
using ElegantWM.WeiXin;
using ElegantWM.WeiXin.SimulatorEntity;
using ElegantWM.BLL;
using System.Drawing;
using System.IO;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/20 16:21:43
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
    [Description("微信联系人")]
    public class WXContactsController : BaseController
    {
        [Page]
        [Description("微信联系人")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(int start, int limit, ExtGridSearch condition, Guid accountId)
        {
            int totalCount = 0;
            var list = WMFactory.WXContacts.FindByPage(start, limit, out totalCount,
                                                      o => o.OrderByDescending(x => x.CreateTime),
                                                      f => f.AccountId == accountId, condition);
            return Json(new { data = list, total = totalCount }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(WX_Contacts _t)
        {
            IWXContactsService service = WMFactory.WXContacts;
            WX_Contacts entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<WX_Contacts, WX_Contacts>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("下载微信用户")]
        [HttpPost]
        public JsonResult DownloadContact(Guid sid)
        {
            IWXContactsService srv = new WXContactsService();
            Simulator smr = new Simulator();
            List<Contact> cntList = smr.GetWxContacts(sid);
            foreach (Contact cnt in cntList)
            {
                IEnumerable<WX_Contacts> temp = srv.FindByConditions(null, f => f.AccountId == sid && f.fake_id == cnt.id);
                if (temp != null && temp.Count() > 0)
                {
                    //更新
                    //WX_Contacts tempCnt = temp.FirstOrDefault();
                    //tempCnt.nick_name = cnt.nick_name;
                    //tempCnt.city = cnt.city;
                    //tempCnt.province = cnt.province;
                    //tempCnt.signature = cnt.signature;
                    //tempCnt.country = cnt.country;
                    //tempCnt.remark_name = cnt.remark_name;
                    //srv.Update(tempCnt);
                    continue;
                }
                //新增
                WX_Contacts tempNewCnt = new WX_Contacts();
                tempNewCnt.fake_id = cnt.id;
                tempNewCnt.nick_name = cnt.nick_name;
                tempNewCnt.city = cnt.city;
                tempNewCnt.province = cnt.province;
                tempNewCnt.signature = cnt.signature;
                tempNewCnt.country = cnt.country;
                tempNewCnt.remark_name = cnt.remark_name;
                tempNewCnt.AccountId = sid;
                tempNewCnt.groupName = cnt.group;
                srv.Insert(tempNewCnt);
            }
            return Json(ResultMsg.Success("微信账号同步已完成！共计：" + cntList.Count.ToString() + "条"));
        }

        [Action]
        [Description("获取详细信息")]
        [HttpPost]
        public JsonResult ContactsDetail(Guid sid, long fakeId)
        {
            Simulator smr = new Simulator();
            Contact cnt = smr.GetContactDetail(sid, fakeId);

            IWXContactsService srv = new WXContactsService();
            IEnumerable<WX_Contacts> temp = srv.FindByConditions(null, f => f.AccountId == sid && f.fake_id == fakeId);
            if (temp != null && temp.Count() > 0)
            {
                //更新
                WX_Contacts tempCnt = temp.FirstOrDefault();
                tempCnt.nick_name = cnt.nick_name;
                tempCnt.city = cnt.city;
                tempCnt.province = cnt.province;
                tempCnt.signature = cnt.signature;
                tempCnt.country = cnt.country;
                tempCnt.remark_name = cnt.remark_name;
                srv.Update(tempCnt);
            }
            return Json(cnt);
        }

        [Action]
        [Description("获取头像")]
        [HttpGet]
        public void ContactHeadImg(Guid sid, long fakeId)
        {
            Simulator smr = new Simulator();
            Bitmap myImage = new Bitmap(smr.GetHeadImg(sid, fakeId));
            MemoryStream ms = new MemoryStream();
            myImage.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            Response.ClearContent();
            Response.ContentType = "image/Jpeg";
            Response.BinaryWrite(ms.ToArray());
        }

        [Action]
        [Description("发送消息")]
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SendMsg(Guid sid, long[] fakeIds, string msg)
        {
            Simulator smr = new Simulator();
            int success = 0;
            foreach (long id in fakeIds)
            {
                if (smr.SendMsg(sid, id, Server.UrlEncode(msg)))
                    success++;
            }
            return Json(ResultMsg.Success("消息发送成功！共计："+success.ToString()+"条"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(WX_Contacts _t)
        {
            if (WMFactory.WXContacts.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }
    }
}
