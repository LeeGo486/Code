﻿using ElegantWM.DTO;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.DLWXSite.Controllers
{
    public class DLGoodsController : BaseDLWXSiteController //BaseDLWXSite
    {
        //
        // GET: /DL/Goods/

        [Page]
        [Description("首页")]
        [Open]
        public ActionResult Index(Guid sid)
        {

            DataTable dtTheme = WMFactory.Wsrr.DLGetTheme();

            DataView dataView = dtTheme.DefaultView;
            dataView.Sort = "ThemeOrder ASC";
            ViewBag.Theme = dtTheme;
            int i = dataView.ToTable(true, "ThemeOrder").Rows.Count;
            ViewBag.ThemeCount = i;
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
            ViewBag.styl_type = styl_type;
            DataTable dt = WMFactory.Wsrr.DLGetStyleInfo(where);
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
            DataTable dt1 = WMFactory.Wsrr.DLGetStyleInfo(where);
            ViewBag.StyleInfo = dt1;
            string id = dt1.Rows[0]["STYL_ID"].ToString();
            ViewBag.Img = dt1.Rows[0]["STYL_PicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);
            ViewBag.BigImg = dt1.Rows[0]["STYL_BigPicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);

            int g = dt1.Rows[0]["STYL_PicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries).Count();
            ViewBag.g = g;
            ViewBag.g1 = g - 1; ViewBag.id = id;


            where = " STL2_STYL_ID = '" + id + "'";
            DataTable dt2 = WMFactory.Wsrr.DLGetStyleSKU(where);

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
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLGetStyleSKU(where)));
        }

        [Action]
        [Description("获取尺码")]
        [HttpPost]
        [Open]
        public JsonResult GetSize(string styleid, string color)
        {
            string where = " STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "'";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLGetStyleSKU(where)));
        }

        #region 购物车

        [Page]
        [Description("购物车")]
        public ActionResult ShoppingCart(string oid)
        {
            string where = "WeiXinID = '" + oid + "'";
            ViewBag.ShoppingCart = WMFactory.Wsrr.DLGetShoppingCart(where);
            return View();
        }


        [Action]
        [Description("添加购物车信息")]
        [HttpPost]
        public JsonResult AddShoppingCart(Guid sid, string oid, string styleid, string color, string size, string number, string price, string sellprice)
        {
            string where = "STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "' AND STL2_Size = '" + size + "'";
            string skuid = WMFactory.Wsrr.DLGetStyleSKU(where).Rows[0]["STL2_ID"].ToString();

            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            string name = dtpCentum.Rows[0]["name"].ToString();
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLAddShoppingCart(oid, skuid, number, price, sellprice, name)));
        }

        [Action]
        [Description("删除购物车信息")]
        [HttpPost]
        public JsonResult DelShoppingCart(string id)
        {
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLDelShoppingCart(id)));
        }
        #endregion




        #region 订单确认

        [Page]
        [Description("订单查询")]
        public ActionResult GetOrder(string sid, string oid)
        {
            string where = "WeiXinID = '" + oid + "'";
            DataTable dt = WMFactory.Wsrr.DLGetOrder(where);

            DataView dv = dt.DefaultView;
            dv.Sort = "Code DESC";
            DataTable dtDistinct = dv.ToTable(true, "ID", "Code", "DEPT_ID", "DeliveryDate", "Amount", "MinState", "Rgdt", "DEPT_Name", "DEPT_Address", "DEPT_Phone");

            ViewBag.NeedTitle = dtDistinct.Select("MinState = '20'", "Code DESC");
            ViewBag.OverTitle = dtDistinct.Select("MinState = '90'", "Code DESC");

            ViewBag.Need = dt.Select("MinState = '20'", "Code DESC");
            ViewBag.Over = dt.Select("MinState = '90'", "Code DESC");
            return View();
        }


        [Page]
        [Description("订单确认")]
        public ActionResult Order(Guid sid, string oid, string id, string styleid, string color, string size, string number)
        {
            DataTable dtpCentum = WMFactory.Wsrr.GetCustomerInfoCommonInterface("1", "DL", oid, "", "", "", "");
            if (dtpCentum.Rows[0]["phone"].ToString() == "")
            {
                return Redirect("~/DLWXSite/VIP/CreateVIP?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                ViewBag.UserName = dtpCentum.Rows[0]["name"].ToString();
                ViewBag.Tel = dtpCentum.Rows[0]["phone"].ToString();
                ViewBag.Centum = dtpCentum.Rows[0]["points"].ToString();
            }
            if (id != null)
            {
                string idStr = "";
                string[] strArr = id.Split('|');
                for (int i = 0; i < strArr.Length; i++)
                {
                    if (i == 0)
                        idStr += "'" + strArr[i] + "'";
                    else
                        idStr += ",'" + strArr[i] + "'";
                }

                string where = "WeiXinID = '" + oid + "' AND ID IN (" + idStr + ")";
                ViewBag.Order = WMFactory.Wsrr.DLGetShoppingCart(where);
            }
            else
            {
                string where = " STYL_ID = '" + styleid + "'";
                DataTable dt1 = WMFactory.Wsrr.DLGetStyleInfo(where);

                where = "STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "' AND STL2_Size = '" + size + "'";
                string skuid = WMFactory.Wsrr.DLGetStyleSKU(where).Rows[0]["STL2_ID"].ToString();

                where = "WeiXinID = '" + oid + "'";
                DataTable dt2 = WMFactory.Wsrr.DLGetShoppingCart(where);

                DataTable dt = dt2.Clone();
                DataRow dr = dt.NewRow();

                dr["ID"] = System.Guid.NewGuid().ToString();
                dr["STL2_ID"] = skuid;
                dr["STYL_Code"] = dt1.Rows[0]["STYL_Code"];
                dr["STYL_Name"] = dt1.Rows[0]["STYL_Name"];
                dr["Number"] = number;
                dr["STL2_Color"] = color;
                dr["STL2_Size"] = size;
                dr["STYL_SellPrice"] = dt1.Rows[0]["STYL_SellPrice"];
                dr["STYL_Price"] = dt1.Rows[0]["STYL_Price"];
                dr["Amount"] = float.Parse(dt1.Rows[0]["STYL_SellPrice"].ToString()) * float.Parse(number);
                dr["STYL_PicturePath"] = dt1.Rows[0]["STYL_PicturePath"];

                dt.Rows.Add(dr);
                ViewBag.Order = dt;
            }

            return View();
        }

        [Action]
        [Description("添加订单信息")]
        [HttpPost]
        public JsonResult AddOrder(string oid, OrderHeadDto head)
        {
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLAddOrder(oid, head)));
        }

        [Action]
        [Description("删除订单信息")]
        [HttpPost]
        public JsonResult DLDelCustomerOrder(string id)
        {
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DLDelCustomerOrder(id)));
        }

        #endregion

        #region 省市区店铺

        [Action]
        [Description("查询省份信息")]
        [HttpPost]
        [Open]
        public JsonResult GetProvince()
        {
            DataTable dt = WMFactory.Wsrr.GetProvinceCommonInterface();
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "Body_ID", "名称")));
        }

        [Action]
        [Description("查询市信息")]
        [HttpPost]
        [Open]
        public JsonResult GetCity(string pid)
        {
            if (pid == "" || pid == "undefined" || pid == null)
            {
                pid = new Guid().ToString();
            }

            string where = "Body_ID_0014 = '" + pid + "'";
            DataTable dt = WMFactory.Wsrr.GetCiteCommonInterface(where);
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "Body_ID_0015", "名称")));
        }


        [Action]
        [Description("查询县区信息")]
        [HttpPost]
        [Open]
        public JsonResult GetCounty(string cid)
        {
            if (cid == "" || cid == "undefined" || cid == null)
            {
                cid = new Guid().ToString();
            }
            string where = "Body_ID_0015 = '" + cid + "'";
            DataTable dt = WMFactory.Wsrr.GetCountyCommonInterface(where);
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "Body_ID", "名称")));
        }

        [Action]
        [Description("查询店铺信息")]
        [HttpPost]
        [Open]
        public JsonResult GetDepot(string pid, string cid)
        {
            if (pid == "" || cid == "")
            {
                cid = new Guid().ToString();
                pid = new Guid().ToString();
            }
            string where = "g_sf = '" + pid + "' AND g_cs = '" + cid + "' and j_com = '贝爱' and ISNULL(depotselect,'') ='0' ";
            DataTable dt = WMFactory.Wsrr.GetMDMDepot(where);

            if (dt.Rows[0]["j_name"].ToString() != "")
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["j_name"] = dt.Rows[i]["j_name"].ToString().Substring(2, dt.Rows[i]["j_name"].ToString().Length - 2);
                }
            }
            DataView dv = dt.DefaultView;


            return Json(JsonHelper.ToJson(dv.ToTable(true, "j_depotid", "j_name")));
        }
        #endregion



    }
}
