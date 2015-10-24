using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using ElegantWM.EntityModel;
using ElegantWM.Tools;

using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Common;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class HRController : BaseMatrix3SController
    {
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("员工能力")]
        public PartialViewResult AbilityList()
        {
            return PartialView();
        }

        [Action]
        [Description("入职年限")]
        public PartialViewResult EntryDate()
        {
            return PartialView();
        }

        [Action]
        [Description("培训次数")]
        public PartialViewResult TrainCount()
        {
            return PartialView();
        }

        [Action]
        [Description("人员基本信息")]
        public PartialViewResult UserInfo()
        {
            return PartialView();
        }

        [Action]
        [Description("能力评价")]
        public PartialViewResult DoAbility()
        {
            return PartialView();
        }

        [Action]
        [Description("培训履历")]
        public PartialViewResult TrainList()
        {
            return PartialView();
        }

        [Action]
        [Description("增加培训")]
        public PartialViewResult AddTrain()
        {
            return PartialView();
        }

        [Action]
        [Description("考勤")]
        public PartialViewResult DoCheck()
        {
            return PartialView();
        }

        [Page]
        [Description("HR工资信息")]
        public ActionResult ShopPayInfo(Guid sid, string oid, string year, string month)
        {
            DataTable dtBindInfo = WMFactory.Wsrr.GetIdentityCardInfo(oid);//通过微信ID获取绑定用户相关数据
            string strIdentityCard = dtBindInfo.Rows[0]["identitycard"].ToString();//获取身份证号

            ViewBag.ShopPayInfo = WMFactory.Wsrr.GetShopPay(strIdentityCard, year, month);//通过年月获取数据,第一次默认空年空月,后台自动获取该身份证号最新的一个月数据
            return View();
        }

        [Action]
        [Description("HR工资信息选择")]
        public PartialViewResult ShopPayInfoSalary(Guid sid, string oid, string year, string month)
        {
            DataTable dtBindInfo = WMFactory.Wsrr.GetIdentityCardInfo(oid);//通过微信ID获取绑定用户相关数据
            string strIdentityCard = dtBindInfo.Rows[0]["identitycard"].ToString();//获取身份证号
            
            ViewBag.ShopPayInfo = WMFactory.Wsrr.GetShopPay(strIdentityCard, year, month);//通过年月获取数据.
            return PartialView();
        }
    }
}
