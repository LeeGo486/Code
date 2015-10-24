using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.GLWXSite.Controllers
{
    public class GLGoodsController : Controller
    {
        //
        // GET: /GLWXSite/Good/

        public ActionResult Index()
        {
            return View();
        }

        //商品展示页
        [Page]
        [Description("品类")]
        [Open]
        public ActionResult SKUList(string styl_type, string name, string category)
        {
            string where = "";

            if (!string.IsNullOrEmpty(category))
            {
                ViewBag.name = category;
                if (category == "所有")
                {
                    where = " (STYL_State = '20' OR STYL_State = '15') ";
                }
                else
                {
                    where = " STYL_State = '20' AND STYL_Class = '" + category + "' ";
                }
            }
            else
            {
                ViewBag.name = name;
                where = "STYL_State = '20' AND STYL_Type = '" + styl_type + "'";
            }

            DataTable dt = WMFactory.Wsrr.GLGetStyleInfo(where);
            DataView dataView = dt.DefaultView;
            dataView.Sort = "STYL_Rgdt DESC";
            DataTable dt2 = dataView.ToTable();
            ViewBag.StyleInfo = dt2;
            return View();
        }

        [Page]
        [Description("品类")]
        [Open]
        public ActionResult SKUDetail(string sku)
        {
            string where = " STYL_Code = '" + sku + "'";
            DataTable dt1 = WMFactory.Wsrr.GLGetStyleInfo(where);
            ViewBag.StyleInfo = dt1;
            string id = dt1.Rows[0]["STYL_ID"].ToString();
            ViewBag.Img = dt1.Rows[0]["STYL_PicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);
            ViewBag.BigImg = dt1.Rows[0]["STYL_BigPicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);

            where = " STL2_STYL_ID = '" + id + "'";
            DataTable dt2 = WMFactory.Wsrr.GLGetStyleSKU(where);

            DataView dataView = dt2.DefaultView;
            dataView.Sort = "STL2_Color,STL2_Size ASC";
            ViewBag.SKU = dt2;
            int i = dataView.ToTable(true, "STL2_Color").Rows.Count;

            ViewBag.Color = dataView.ToTable(true, "STL2_Color");
            ViewBag.Size = dataView.ToTable(true, "STL2_Size");

            return View();
        }

        [Action]
        [Description("获取颜色")]
        [HttpPost]
        [Open]
        public JsonResult GetColor(string styleid, string size)
        {
            string where = " STL2_STYL_ID = '" + styleid + "' AND STL2_Size = '" + size + "'";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.GLGetStyleSKU(where)));
        }

        [Action]
        [Description("获取尺码")]
        [HttpPost]
        [Open]
        public JsonResult GetSize(string styleid, string color)
        {
            string where = " STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "'";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.GLGetStyleSKU(where)));
        }

    }
}
