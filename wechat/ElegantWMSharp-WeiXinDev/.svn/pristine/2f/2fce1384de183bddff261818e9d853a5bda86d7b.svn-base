using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.IT.Controllers
{
    public class DCController : BaseMatrixAMController
    {
        [Action]
        [Description("微信应答服务")]
        [Open]
        [HttpPost]
        public string RespForWeiXin(Guid sid, string oid, string kw)
        {
            IEnumerable<WX_LK_FansC3AM> userList = WMFactory.WXLKFansC3AM.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid);
            if (userList == null || userList.Count() != 1)
            {
                return "需要身份认证，<a href='http://it.hwafashion.com/Matrix/AMLogin?sid=" + sid.ToString() + "&oid=" + oid + "'>点击绑定用户</a>";
            }
            string result = WMFactory.ITDC.GetRptData(kw);
            return result.Replace("?key=", "?sid=" + sid + "&oid=" + oid + "&key=");
        }

        [Page]
        [Description("报表")]
        public ActionResult Report()
        {
            if (string.IsNullOrEmpty(Request["key"]))
                ViewBag.Result = "参数错误！";
            else
                ViewBag.Result = WMFactory.ITDC.GetRptData(Request["key"].Trim());
            return View();
        }

        private CertificateDto CurrentUser()
        {
            return AuthToken.CurrentUserByTid(WMFactory.WXLKFansC3AM.GetCurrentAMUser(Guid.Parse(Request["sid"]), Request["oid"]).TokenId.ToString());
        }

        [Page]
        [Description("我的请求")]
        public ActionResult MyRequest()
        {
            return View();
        }

        [Page]
        [Description("我的评价")]
        public ActionResult MyStaff()
        {
            return View();
        }


        [Action]
        [Description("公司系统")]
        [HttpPost]
        public JsonResult GetWebListCombo()
        {
            return Json(WMFactory.ITDC.GetITDCWebList());
        }

        [Page]
        [Description("系统站点")]
        public ActionResult WebList()
        {
            return View();
        }

        [Page]
        [Description("关于我们")]
        public ActionResult About()
        {
            return View();
        }

        [Page]
        [Description("请求服务")]
        public ActionResult NeedHelp()
        {
            int total = 0;
            //获取当前登录人
            string curUser = CurrentUser().UserName;
            ViewBag.ReqMan = WMFactory.ITSMEvent.FindByPage(0, 1, out total, o => o.OrderByDescending(x => x.CreateTime), f => f.ReqMan == curUser).FirstOrDefault();
            ViewBag.UserName = curUser;
            return View();
        }

        [Action]
        [Description("上传附件")]
        [HttpPost]
        public JsonResult UploadFile(int type)
        {
            string destFilePath = "";
            if (type == 0)
                destFilePath = "~/Content/Uploads/Event/";
            else
                destFilePath = "~/Content/Uploads/Request/";

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
            ElegantWM.Tools.ImageHelper.MakeThumbnail(destFilePath, destThumbFile, 80, 80, "W");
            return Json(ResultMsg.Success(strFileName));
        }
    }
}
