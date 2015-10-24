using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class HZYTourismActivitiesController : BaseHZYController
    {
        //
        // GET: /Game/HZYTourismActivities/

        public ActionResult Index(Guid sid, string oid)
        {
            //log.Debug(oid);
            //log.Debug(sid);
            //WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), oid);
            //if (wf == null)
            //{
            //    return Redirect("http://mp.weixin.qq.com/s?__biz=MzIwODAxNzA1OQ==&mid=209452489&idx=1&sn=d725ac690920900789eb1f5f713290f7#rd");
            //}
            return View();
        }
        /// <summary>
        /// 图片详情
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="oid"></param>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        public ActionResult ImgInfo(string sid, string oid, string SerialNumber)
        {
            int nSerialNumber = int.Parse(SerialNumber);
            Game_Img ImgInfo = WMFactory.Game_Img.FindByConditions(null, f => f.Group == 12 && f.SerialNumber == nSerialNumber).First();
            int nImgRecord = WMFactory.GameRecord.GetCount(f => f.Group == 12 && f.Num == nSerialNumber);

            if (string.IsNullOrEmpty(nImgRecord.ToString()) || nImgRecord == 0)
            {
                ViewBag.ImgRecordCount = 0;//总数
            }
            else
            {
                ViewBag.ImgRecordCount = nImgRecord;//总数
            }
            ViewBag.SerialNumber = ImgInfo.SerialNumber;//总星
            ViewBag.Num = ImgInfo.Num;//总星
            ViewBag.Name = ImgInfo.Name;//姓名
            ViewBag.Address = ImgInfo.Address;//位置
            ViewBag.Introduction = ImgInfo.Introduction;//感想
            ViewBag.Img = ImgInfo.Img;//图片路径else

            return View();
        }

        /// <summary>
        /// 图片上传
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="oid"></param>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        public ActionResult Iwant(string sid, string oid)
        {
            //判断是否注册了（绑定）
            if (ElegantWM.WeiXin.Common.GetFanInfo(sid, oid) == null)
            {
                return Redirect("http://mp.weixin.qq.com/s?__biz=MzIwODAxNzA1OQ==&mid=209452489&idx=1&sn=d725ac690920900789eb1f5f713290f7#rd");
            }
            else
            {
                return View();
            }
        }

        [Action]
        [Description("获取图片")]
        public PartialViewResult GetImgPartial(Guid sid, string oid, string type, int startIndex, int pageSize, int SerialNumber)
        {
            int temp = 0;
            if (type == "1")//1代表精美
            {
                IEnumerable<Game_Img> FineImg = WMFactory.Game_Img.FindByPage(startIndex, pageSize, out temp, o => o.OrderByDescending(c => c.Num), f => f.Group == 12);
                int nCount = 4;
                ViewBag.nCount = nCount;
                ViewBag.FineImg = FineImg;//.Take(4)
                ViewBag.type = "1";
            }
            else if (type == "2")
            {
                IEnumerable<Game_Img> FineImg = WMFactory.Game_Img.FindByPage(startIndex, pageSize, out temp, o => o.OrderByDescending(c => c.CreateTime), f => f.Group == 12);
                int nCount = WMFactory.Game_Img.GetCount(f => f.Group == 12);
                ViewBag.nCount = nCount;
                ViewBag.FineImg = FineImg;//.Take(4)
                ViewBag.type = "2";
            }
            else if (type == "3")
            {
                IEnumerable<Game_Img> FineImg = WMFactory.Game_Img.FindByConditions(null, f => f.Group == 12 && f.SerialNumber == SerialNumber);
                int nCount = FineImg.Count();
                ViewBag.nCount = nCount;
                ViewBag.FineImg = FineImg;
                ViewBag.type = "3";
            }
            return PartialView();
        }

        [Action]
        [Description("上传附件")]
        [HttpPost]
        public JsonResult UploadFile()
        {
            string destFilePath = "";
            destFilePath = "~/Content/Uploads/HZYTourismActivities/";

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

            if (string.IsNullOrEmpty(destFilePath))
            {
                return Json(ResultMsg.Failure("目标文件夹错误"));
            }
            int fileSize = 1024 * 1024 * 4; //4M
            HttpFileCollectionBase postedFile = Request.Files;
            if (postedFile[0].ContentLength > fileSize)
            {
                return Json(ResultMsg.Failure("最大只能上传4M文件！"));
            }
            string destThumbFile = Server.MapPath(destFilePath + "Thumbnail/") + strFileName;
            destFilePath = Server.MapPath(destFilePath) + strFileName;
            Request.Files[0].SaveAs(destFilePath);
            ElegantWM.Tools.ImageHelper.MakeThumbnail(destFilePath, destThumbFile, 800, 800, "W");
            return Json(ResultMsg.Success(strFileName));
        }

        [Action]
        [Description("上传照片")]
        [HttpPost]
        [Open]
        public JsonResult Submit(Game_Img gu)
        {

            IEnumerable<Game_Img> Imgs = WMFactory.Game_Img.FindByConditions(null, f => f.Oid == gu.Oid && f.Group == 12, null);

            if (Imgs != null && Imgs.Count() > 0)
            {
                return Json(ResultMsg.Success("你已经上传过了，一个ID只能上传一次。"));
            }
            else
            {
                Game_Img ImgMax = WMFactory.Game_Img.FindByConditions(o => o.OrderByDescending(x => x.SerialNumber), f => f.Group == 12).First();
                gu.CreateUser = "Cookie";
                gu.ModifyUser = "Cookie";
                gu.Num = 0;
                gu.SerialNumber = ImgMax.SerialNumber + 1;
                gu.Group = 12;

                if (WMFactory.Game_Img.Insert(gu))
                    return Json(ResultMsg.Success("信息提交成功。"));
                else
                    return Json(ResultMsg.Failure("信息提交失败，请重试！"));
            }
        }

        [Action]
        [Description("提交评价")]
        [HttpPost]
        [Open]
        public ActionResult Submittp(string sid, string oid, Game_Record gu)
        {

            if (ElegantWM.WeiXin.Common.GetFanInfo(sid, oid) == null)
            {
                return Json(ResultMsg.Failure("对不起你未关注无法投票"));
            }
            else
            {
                IEnumerable<Game_Record> gr = WMFactory.GameRecord.FindByConditions(null, f => f.Group == 12 && f.Oid == oid && f.Num == gu.Num);

                if (gr.Count() > 0)
                {
                    return Json(ResultMsg.Failure("duang...亲,你已经投过了！"));
                }
                else
                {
                    Guid Sid = Guid.Parse(sid);
                    IEnumerable<WX_Fans> fans = WMFactory.WXFans.FindByConditions(null, f => f.AccountId == Sid && f.OpenId == oid);
                    gu.Nickname = fans.First().NickName;
                    gu.Group = 12;
                    gu.AwardId = System.Guid.NewGuid();
                    gu.AwardName = "";
                    gu.Seq = "";
                    gu.doTimes = 1;
                    gu.CreateUser = "Cookie";
                    if (WMFactory.GameRecord.Insert(gu))
                    {

                        IEnumerable<Game_Img> UpdateImgs = WMFactory.Game_Img.FindByConditions(null, f => f.SerialNumber == gu.Num && f.Group == 12, null);
                        Game_Img UpdateImg = new Game_Img();
                        if (UpdateImgs != null && UpdateImgs.Count() > 0)
                        {
                            UpdateImg = UpdateImgs.FirstOrDefault();
                            UpdateImg.Num = UpdateImgs.FirstOrDefault().Num + gu.linkedTimes;
                            UpdateImg.ModifyUser = "Cookie";
                            WMFactory.Game_Img.Update(UpdateImg);
                        }
                        return Json(ResultMsg.Success("信息提交成功。"));
                    }
                    else
                    {
                        return Json(ResultMsg.Failure("信息提交失败，请重试！"));
                    }
                }
            }
        }

        [Action]
        [Description("Appid")]
        [HttpPost]
        [Open]
        public JsonResult GetAppId(string sid)
        {
            WX_Account account = WMFactory.WXAccount.GetById(sid);
            return Json(ResultMsg.Success(account.AppId));
        }

        [Action]
        [Description("ticket")]
        [HttpPost]
        [Open]
        public JsonResult GetTicket(string sid)
        {
            String ticket = ElegantWM.WeiXin.Common.GetTicket(sid);
            return Json(ResultMsg.Success(ticket));
        }

        [Action]
        [Description("signature")]
        [HttpPost]
        [Open]
        public JsonResult GetSignature(string sid, string oid, string ticket, string nonceStr, string timestamp, string url)
        {
            string[] ArrTmp = { "jsapi_ticket=" + ticket, "noncestr=" + nonceStr, "timestamp=" + timestamp, "url=" + url };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("&", ArrTmp);
            tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();

            return Json(ResultMsg.Success(tmpStr));
        }
    }
}
