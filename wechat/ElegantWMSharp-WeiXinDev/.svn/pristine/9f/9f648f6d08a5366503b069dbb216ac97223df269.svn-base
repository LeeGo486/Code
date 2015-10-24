using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

using ElegantWM.WeiXin.MsgEntity;
using ElegantWM.Factory;
using ElegantWM.Common;
using ElegantWM.DTO;
using System.Data;
using ElegantWM.Tools;
using ElegantWM.WebUI.Areas.Matrix;
using ElegantWM.EntityModel;



namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class LittleModelController : BaseGLController
    {
        //
        // GET: /Game/LittleModel/

        public ActionResult Index(Guid sid, string wxid)
        {
            return Redirect("~/Game/Common/ActivityEnd");
            ViewBag.wxid = wxid;
            return View();
        }

        [Action]
        [Description("小模特列表")]
        private DataTable GetLittleModelInfo(string strWhere, int iPage, int iGroup)
        {

            DataTable dt = WMFactory.Game_LittleModel.GetLittleModelInfo(strWhere, iPage, iGroup);

            return dt;
        }

        [Action]
        [Description("获取行数")]
        private int GetCount(int iGroup)
        {
            DataTable dtCount = WMFactory.Game_LittleModel.GetLittleModelCount(iGroup);
            int iCount = Int32.Parse(dtCount.Rows[0][0].ToString());
            return iCount;
        }

        [Action]
        [Description("小模特照片")]
        public PartialViewResult LittleModelPic(string strWhere, int iBeginPage, int iPage, int iGroup, string wxid)
        {
            ViewBag.wxid = wxid;
            if (strWhere == null)
            {
                strWhere = "";
            }
            ViewBag.ModelList = GetLittleModelInfo(strWhere, iPage, iGroup);
            ViewBag.Group = iGroup;
            ViewBag.wxid = wxid;
            PageList(iBeginPage, iGroup, wxid);//页码
            return PartialView();
        }

        [Action]
        [Description("页码")]
        public PartialViewResult PageList(int iBeginPage, int iGroup, string wxid)
        {

            ViewBag.Count = GetCount(iGroup);

            ViewBag.Group = iGroup;

            ViewBag.BeginPage = iBeginPage;

            ViewBag.wxid = wxid;

            return PartialView();
        }

        [Action]
        [Description("小模特个人页面")]
        public ActionResult LittleModelInfo(string LId, int iResult, int iOverplus, string wxid)
        {
            string strWhere = " L_Id = " + LId;

            DataTable dt = GetLittleModelInfo(strWhere, 0, 0);
            ViewBag.Info = dt;
            ViewBag.wxid = wxid;
            ViewBag.resultCode = iResult;
            string strBtn = "";
            string strResult = "";

            if (iResult == 1)
            {
                ViewBag.VoteResult = "已为该小模特投过票，无法重复投票。";
            }
            else if (iResult == 2)
            {
                strResult = "抱歉，您三次投票机会已用完!";
                strBtn = "查看投票结果";
                return Redirect("/Game/LittleModel/resultPage?sid=a2cf00a8-4c8c-4853-b9fd-63fc4b406c38&wxid=" + wxid + "&result=" + strResult + "&strBtn=" + strBtn);
            }
            else if (iResult == 3)
            {
                ViewBag.VoteResult = "";
            };

            return View();
        }

        [Action]
        [Description("验证&投票")]
        public ActionResult Vote(string sid, string wxid, string Lid)
        {
            WxFans wf = ElegantWM.WeiXin.Common.GetFanInfo(sid.ToString(), wxid);
            if (wf == null)
            {
                return Redirect("http://mp.weixin.qq.com/s?__biz=MzA5MTk5ODgzOA==&mid=207299861&idx=1&sn=ae22b7eaef58a729d5ca5d0a9b8b94c1#rd");
            }
            else
            {
                DataTable dtCheck = WMFactory.Game_LittleModel.CheckVote(wxid, Lid);
                int iResult = Int32.Parse(dtCheck.Rows[0][0].ToString());
                int iOverplus = Int32.Parse(dtCheck.Rows[0][1].ToString());
                string strRst = "";
                string strBtn = "";
                if (iResult == 0)
                {
                    ViewBag.sid = "a2cf00a8-4c8c-4853-b9fd-63fc4b406c38";
                    ViewBag.wxid = wxid;
                    if (iOverplus > 0)
                    {
                        strRst = "投票成功,您还有" + iOverplus + "次投票机会";
                        strBtn = "继续投票";
                    }
                    else if (iOverplus == 0)
                    {
                        strRst = "投票成功,您三次投票机会已用完!";
                        strBtn = "查看投票结果";
                    };

                    return Redirect("/Game/LittleModel/resultPage?sid=a2cf00a8-4c8c-4853-b9fd-63fc4b406c38&wxid=" + wxid + "&result=" + strRst + "&strBtn=" + strBtn);
                }
                else
                {
                    return Redirect("/Game/LittleModel/LittleModelInfo?LId=" + Lid + "&iResult=" + iResult + "&iOverplus=" + iOverplus + "&sid=a2cf00a8-4c8c-4853-b9fd-63fc4b406c38&wxid=" + wxid);
                };
            };

        }

        [Action]
        [Description("结果页面")]
        public ActionResult resultPage(string wxid, string result, string strBtn)
        {
            ViewBag.VoteResult = result;
            ViewBag.sid = "a2cf00a8-4c8c-4853-b9fd-63fc4b406c38";
            ViewBag.wxid = wxid;
            ViewBag.index = strBtn;
            return View();
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
        public JsonResult GetSignature(string sid, string wxid, string ticket, string nonceStr, string timestamp, string url)
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
