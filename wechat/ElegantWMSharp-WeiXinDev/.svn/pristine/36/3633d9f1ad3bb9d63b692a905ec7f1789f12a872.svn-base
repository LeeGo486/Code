using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.WeiXin.Controllers
{
    public class ArticleController : Controller
    {
        //ThreadMethod如下:
        private void ThreadMethod(object obj)
        {
            ArrayList arr = (ArrayList)obj;
            WX_RespImgTxt art = (WX_RespImgTxt)arr[0];
            Guid sid = (Guid)arr[1];
            string oid = arr[2].ToString();
            string ip = arr[3].ToString();
            DateTime dtime = DateTime.Now.AddMinutes(-2);
            int total = WMFactory.WXArticleLog.GetCount(f => f.OptType == 1 && f.AccountId == sid && f.ArticleId == art.Id && f.IPAddress == ip && f.CreateTime >= dtime);
            if (total <= 0)
            {
                //更新访问量
                art.Hits += 1;
                art.ModifyUser = "Matrix";
                WMFactory.WXRespImgTxt.Update(art);
                WX_ArticleLog alog = new WX_ArticleLog();
                alog.AccountId = sid;
                alog.ArticleId = art.Id;
                alog.OpenId = oid;
                alog.OptType = 1;
                alog.IPAddress = ip;
                alog.CreateUser = "Matrix";
                WMFactory.WXArticleLog.Insert(alog);
            }
        }

        public ActionResult Index(Guid id, Guid sid, string oid)
        {
            WX_RespImgTxt art = WMFactory.WXRespImgTxt.GetById(id.ToString());
            if (art == null)
                throw new Exception("你所查看的资源不存在！");
            //启动一个线程
            //ParameterizedThreadStart ParStart = new ParameterizedThreadStart(ThreadMethod);
            //Thread myThread = new Thread(ParStart);
            //ArrayList arr = new ArrayList();
            //arr.Add(art);
            //arr.Add(sid);
            //arr.Add(oid);
            //arr.Add(Request.UserHostAddress);
            //myThread.Start(arr);
            return View(art);
        }

        [HttpPost]
        public JsonResult Praise(Guid id, Guid sid, string oid)
        {
            if (WMFactory.WXArticleLog.GetCount(f => f.IPAddress == Request.UserHostAddress && f.AccountId == sid && f.ArticleId == id && f.OptType == 2) > 0)
            {
                return Json(ResultMsg.Failure("您已经点过赞了！"));
            }
            WX_RespImgTxt art = WMFactory.WXRespImgTxt.GetById(id.ToString());
            art.Praise += 1;
            art.ModifyUser = "Matrix";
            WMFactory.WXRespImgTxt.Update(art);
            WX_ArticleLog alog = new WX_ArticleLog();
            alog.AccountId = sid;
            alog.ArticleId = id;
            alog.OpenId = oid;
            alog.OptType = 2;
            alog.IPAddress = Request.UserHostAddress;
            alog.CreateUser = "Matrix";
            WMFactory.WXArticleLog.Insert(alog);
            return Json(ResultMsg.Success("谢谢支持！"));
        }
    }
}
