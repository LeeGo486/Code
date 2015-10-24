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
using System.IO;
using System.Web;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/28 15:38:04
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
    [Description("关键字响应")]
    public class WXRespImgTxtController : BaseController
    {
        [Page]
        [Description("关键字响应")]
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("获取Grid数据")]
        [HttpGet]
        public JsonResult Get(Guid kwId)
        {
            var list = WMFactory.WXRespImgTxt.FindByConditions(o => o.OrderByDescending(y => y.IsMain).ThenBy(x => x.OrderIndex),
                                                      f => f.KwId == kwId);
            return Json(new { data = list }, JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("更新")]
        [HttpPut]
        public JsonResult Put(WX_RespImgTxt _t)
        {
            IWXRespImgTxtService service = WMFactory.WXRespImgTxt;
            WX_RespImgTxt entity = service.GetById(_t.Id.ToString());
            entity = AutoMapper<WX_RespImgTxt, WX_RespImgTxt>.Convert(_t, entity);
            if (service.Update(entity))
                return Json(ResultMsg.Success("更新成功！"));
            else
                return Json(ResultMsg.Failure("更新失败，请您重试！"));
        }

        [Action]
        [Description("新增")]
        [HttpPost]
        public JsonResult Post(WX_RespImgTxt _t)
        {
            if (WMFactory.WXRespImgTxt.Insert(_t))
                return Json(ResultMsg.Success("新增成功！"));
            else
                return Json(ResultMsg.Failure("新增失败，请您重试！"));
        }

        [Action]
        [Description("删除")]
        [HttpDelete]
        public JsonResult Delete(WX_RespImgTxt _t)
        {
            if (WMFactory.WXRespImgTxt.Delete(s => s.Id == _t.Id))
                return Json(ResultMsg.Success("删除成功！"));
            else
                return Json(ResultMsg.Failure("删除失败，请您重试！"));
        }

        [Action]
        [Description("获取响应信息")]
        [HttpGet]
        public JsonResult GetRespList(Guid kwId)
        {
            return Json(WMFactory.WXRespImgTxt.FindByConditions(o => o.OrderBy(e => e.OrderIndex), f => f.KwId == kwId), JsonRequestBehavior.AllowGet);
        }

        [Action]
        [Description("测试响应服务")]
        [HttpPost]
        public JsonResult TestSrv(string url, string prms)
        {
            return Json(Tools.HttpCrossDomain.Post(url, prms));
        }

        [Action]
        [Description("响应服务DEMO")]
        [HttpPost]
        [Open]
        public ContentResult WxSrvRespDemo(string oid, string sid, string mid, string zdy)
        {
            return Content("您传来的sid=" + sid + ",oid=" + oid + ",mid=" + mid + ",自定义=" + zdy);
        }

        [Action]
        [Description("响应服务Demo")]
        [HttpPost]
        [Open]
        public string WxSrvRespDemoNews(string oid, string sid)
        {
            return @"<Articles><item><Title><![CDATA[测试没有图片的情况]]></Title><Description><![CDATA[测试没有图片的情况]]></Description><PicUrl><![CDATA[http://matrix.chinacloudtech.com/Content/Uploads/e7021ec0-c8f4-4c6d-a380-84cbe2903e24/WxRespImg/20140731100805067.jpg]]></PicUrl><Url><![CDATA[http://www.baidu.com?sid=e7021ec0-c8f4-4c6d-a380-84cbe2903e24&oid=o92ebuGPPnDHv4tnKMb-lKiPmWmM]]></Url></item><item><Title><![CDATA[测试一下下喽]]></Title><Description><![CDATA[测试一下下喽]]></Description><PicUrl><![CDATA[http://matrix.chinacloudtech.com/Content/Uploads/e7021ec0-c8f4-4c6d-a380-84cbe2903e24/WxRespImg/20140730231006153.jpg]]></PicUrl><Url><![CDATA[http://matrix.chinacloudtech.com/Common/Article/f91f176f-b5f0-41bc-927c-6bc6ccc96a5f?sid=e7021ec0-c8f4-4c6d-a380-84cbe2903e24&oid=o92ebuGPPnDHv4tnKMb-lKiPmWmM]]></Url></item><item><Title><![CDATA[测试子条目]]></Title><Description><![CDATA[测试子条目]]></Description><PicUrl><![CDATA[http://matrix.chinacloudtech.com/Content/Uploads/e7021ec0-c8f4-4c6d-a380-84cbe2903e24/WxRespImg/20140730231749070.jpg]]></PicUrl><Url><![CDATA[http://matrix.chinacloudtech.com/Common/Article/170ab50e-f514-48ee-9ac5-32bb043f5bfb?sid=e7021ec0-c8f4-4c6d-a380-84cbe2903e24&oid=o92ebuGPPnDHv4tnKMb-lKiPmWmM]]></Url></item></Articles>";
        }

        [Action]
        [Description("保存响应服务")]
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SaveRespSrv(WX_RespImgTxt _t)
        {
            IEnumerable<WX_RespImgTxt> list = WMFactory.WXRespImgTxt.FindByConditions(null, f => f.KwId == _t.KwId);
            bool flag = false;
            if (list != null && list.Count() > 0)
            {
                WX_RespImgTxt txt = list.FirstOrDefault();
                txt.Content = _t.Content;
                txt.AbsUrl = _t.AbsUrl.Trim();
                flag = WMFactory.WXRespImgTxt.Update(txt);
            }
            else
                flag = WMFactory.WXRespImgTxt.Insert(_t);
            if (flag)
                return Json(ResultMsg.Success("保存成功！"));
            else
                return Json(ResultMsg.Failure("保存失败，请您重试！"));
        }

        [Action]
        [Description("保存响应文本")]
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SaveRespTxt(WX_RespImgTxt _t)
        {
            IEnumerable<WX_RespImgTxt> list = WMFactory.WXRespImgTxt.FindByConditions(null, f => f.KwId == _t.KwId);
            bool flag = false;
            if (list != null && list.Count() > 0)
            {
                WX_RespImgTxt txt = list.FirstOrDefault();
                txt.Content = _t.Content;
                flag = WMFactory.WXRespImgTxt.Update(txt);
            }
            else
                flag = WMFactory.WXRespImgTxt.Insert(_t);
            if (flag)
                return Json(ResultMsg.Success("保存成功！"));
            else
                return Json(ResultMsg.Failure("保存失败，请您重试！"));
        }

        [Action]
        [Description("")]
        [HttpPost]
        public JsonResult UploadImg(Guid sid)
        {
            string destFilePath = "~/Content/Uploads/" + sid + "/WxRespImg/";
            if (!Directory.Exists(Server.MapPath(destFilePath)))
            {
                Directory.CreateDirectory(Server.MapPath(destFilePath));
            }
            //判断type类型
            if (Request.Files.Count == 0)
            {
                return Json(ResultMsg.Failure("请选择文件！"));
            }
            string strFileName = Path.GetFileName(Request.Files[0].FileName);
            string strExtension = Path.GetExtension(strFileName).ToLower();
            if (!".jpg|.png".Contains(strExtension))
            {
                return Json(ResultMsg.Failure("仅支持jpg,png格式图片！"));
            }
            strFileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + strExtension;
            int fileSize = 1024 * 1024 * 4; //4M
            HttpFileCollectionBase postedFile = Request.Files;
            if (postedFile[0].ContentLength > fileSize)
            {
                return Json(ResultMsg.Failure("最大只能上传<4M文件！"));
            }
            destFilePath = Server.MapPath(destFilePath) + strFileName;
            Request.Files[0].SaveAs(destFilePath);
            return Json(ResultMsg.Success(sid + "/WxRespImg/" + strFileName));
        }
    }
}
