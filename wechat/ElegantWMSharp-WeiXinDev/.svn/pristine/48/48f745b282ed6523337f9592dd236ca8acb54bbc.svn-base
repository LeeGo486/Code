using ElegantWM.DTO;
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
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.NPaia.Controllers
{
    public class GoodsController : BaseNPaiaController
    {
        //
        // GET: /NPaia/Goods/

        [Page]
        [Description("首页")]
        [Open]
        public ActionResult Index(Guid sid)
        {
            ViewBag.Sid = sid;
            string mediaJson = "{\"type\":\"news\",\"offset\":0,\"count\":10}";
            WxNews news = ElegantWM.WeiXin.Common.GetMediaList(sid.ToString(), mediaJson);

            int count = 0;
            List<WxItem> rst = new List<WxItem>();
            foreach (WxItem item in news.item)
            {
                if (count >= 3)
                {
                    break;
                }
                else if (item.content.news_item.First().title.Contains("#"))
                {
                    continue;
                }
                else
                {
                    rst.Add(item);
                    count++;
                    string s = item.content.news_item.First().thumb_media_id;
                    mediaJson = "{\"media_id\":\"" + s + "\"}";

                    string destFilePath = "~/Content/MaterialImage/" + sid.ToString() + "/";
                    string mapPath = Server.MapPath(destFilePath);
                    string filePath = mapPath + s + ".jpg";
                    if (!Directory.Exists(mapPath))
                    {
                        Directory.CreateDirectory(mapPath);//不存在就创建目录 
                    }
                    if (System.IO.File.Exists(filePath))
                    {
                        continue;
                    }
                    else
                    {
                        ElegantWM.WeiXin.Common.DownloadImage(sid.ToString(), mediaJson, filePath);
                    }
                }
            }

            ViewBag.ImgList = rst;
            return View();
        }

        [Page]
        [Description("全部商品")]
        [Open]
        public ActionResult Category()
        {
            return View();
        }

        [Page]
        [Description("品类")]
        [Open]
        public ActionResult SKUList(string category, string name, string p, string code)
        {
            ViewBag.Category = name;

            string where = "";
            if (category == "所有")
            {
                where = "(STYL_State = '20' OR STYL_State = '15') AND STYL_Code LIKE '%" + code + "%'";
            }
            else if (category == "新品")
            {
                where = "STYL_State = '20' AND STYL_Property1 = '" + p + "'";
            }
            else
            {
                where = "STYL_State = '20' AND STYL_Class = '" + category + "'";

            }
            DataTable dt = WMFactory.Wsrr.GetStyleInfo(where);
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
            DataTable dt1 = WMFactory.Wsrr.GetStyleInfo(where);
            ViewBag.StyleInfo = dt1;
            string id = dt1.Rows[0]["STYL_ID"].ToString();
            ViewBag.Img = dt1.Rows[0]["STYL_PicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);
            ViewBag.BigImg = dt1.Rows[0]["STYL_BigPicturePath"].ToString().Split(new string[] { @"," }, StringSplitOptions.RemoveEmptyEntries);

            where = " STL2_STYL_ID = '" + id + "'";
            DataTable dt2 = WMFactory.Wsrr.GetStyleSKU(where);

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
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.GetStyleSKU(where)));
        }

        [Action]
        [Description("获取尺码")]
        [HttpPost]
        [Open]
        public JsonResult GetSize(string styleid, string color)
        {
            string where = " STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "'";
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.GetStyleSKU(where)));
        }

        [Page]
        [Description("购物车")]
        public ActionResult ShoppingCart(string oid)
        {
            string where = "WeiXinID = '" + oid + "'";
            ViewBag.ShoppingCart = WMFactory.Wsrr.GetShoppingCart(where);
            return View();
        }

        [Action]
        [Description("添加购物车信息")]
        [HttpPost]
        public JsonResult AddShoppingCart(Guid sid, string oid, string styleid, string color, string size, string number, string price, string sellprice)
        {
            string where = "STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "' AND STL2_Size = '" + size + "'";
            string skuid = WMFactory.Wsrr.GetStyleSKU(where).Rows[0]["STL2_ID"].ToString();

            string tel = "";
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans != null && fans.Count() > 0)
            {
                tel = fans.First().Telphone;
            }

            DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(tel);
            string name = dtpCentum.Rows[0]["vipname"].ToString();

            return Json(JsonHelper.ToJson(WMFactory.Wsrr.AddShoppingCart(oid, skuid, number, price, sellprice, name)));
        }

        [Action]
        [Description("删除购物车信息")]
        [HttpPost]
        public JsonResult DelShoppingCart(string id)
        {
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.DelShoppingCart(id)));
        }

        [Action]
        [Description("查询省份信息")]
        [HttpPost]
        [Open]
        public JsonResult GetProvince()
        {
            DataTable dt = WMFactory.Wsrr.GetProvince();
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "DEPT_DISP_ID_Province")));
        }

        [Action]
        [Description("查询市信息")]
        [HttpPost]
        [Open]
        public JsonResult GetCity(string pid)
        {
            string where = "[DEPT_DISP_ID_Province] = '" + pid + "'";
            DataTable dt = WMFactory.Wsrr.GetCity(where);
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "DEPT_DISP_ID_City")));
        }

        [Action]
        [Description("查询店铺信息")]
        [HttpPost]
        [Open]
        public JsonResult GetDepot(string pid, string cid)
        {
            string where = "[DEPT_DISP_ID_Province] = '" + pid + "' AND [DEPT_DISP_ID_City] = '" + cid + "'";
            DataTable dt = WMFactory.Wsrr.GetDepot(where);
            DataView dv = dt.DefaultView;
            return Json(JsonHelper.ToJson(dv.ToTable(true, "DEPT_ID", "DEPT_Name")));
        }

        [Page]
        [Description("订单确认")]
        public ActionResult Order(Guid sid, string oid, string id, string styleid, string color, string size, string number)
        {
            string tel = "";
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans != null && fans.Count() > 0)
            {
                tel = fans.First().Telphone;
            }

            DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(tel);
            if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
            {
                return Redirect("~/NPaia/VIP/CreateVIP?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                ViewBag.UserName = dtpCentum.Rows[0]["vipname"].ToString();
                ViewBag.Tel = tel;
                ViewBag.Centum = dtpCentum.Rows[0]["centum"].ToString();
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
                ViewBag.Order = WMFactory.Wsrr.GetShoppingCart(where);
            }
            else
            {
                string where = " STYL_ID = '" + styleid + "'";
                DataTable dt1 = WMFactory.Wsrr.GetStyleInfo(where);

                where = "STL2_STYL_ID = '" + styleid + "' AND STL2_Color = '" + color + "' AND STL2_Size = '" + size + "'";
                string skuid = WMFactory.Wsrr.GetStyleSKU(where).Rows[0]["STL2_ID"].ToString();

                where = "WeiXinID = '" + oid + "'";
                DataTable dt2 = WMFactory.Wsrr.GetShoppingCart(where);

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
            return Json(JsonHelper.ToJson(WMFactory.Wsrr.AddOrder(oid, head)));
        }

        [Page]
        [Description("个人中心")]
        public ActionResult Personal(Guid sid, string oid)
        {
            string tel = "";
            IEnumerable<WX_LK_RegMemberFans> fans = WMFactory.WXLKRegMemberFans.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid && f.IsUsing == 0);
            if (fans != null && fans.Count() > 0)
            {
                tel = fans.First().Telphone;
            }

            DataTable dtpCentum = WMFactory.Wsrr.GetUserCentumInfo(tel);
            if (dtpCentum.Rows[0]["mobtel"].ToString() == "")
            {
                return Redirect("~/NPaia/VIP/CreateVIP?sid=" + sid + "&oid=" + oid);
            }
            else
            {
                ViewBag.UserName = dtpCentum.Rows[0]["vipname"].ToString();
                ViewBag.Tel = tel;
                ViewBag.Centum = dtpCentum.Rows[0]["centum"].ToString();
            }

            string where = "WeiXinID = '" + oid + "'";
            DataTable dt = WMFactory.Wsrr.GetOrder(where);

            DataView dv = dt.DefaultView;
            dv.Sort = "Code DESC";
            DataTable dtDistinct = dv.ToTable(true, "ID", "Code", "DEPT_ID", "DeliveryDate", "Amount", "MinState", "Rgdt", "DEPT_Name", "DEPT_Address", "DEPT_Phone");

            ViewBag.NeedTitle = dtDistinct.Select("MinState = '20'", "Code DESC");
            ViewBag.OverTitle = dtDistinct.Select("MinState = '90' OR MinState = '99'", "Code DESC");

            ViewBag.Need = dt.Select("MinState = '20'", "Code DESC");
            ViewBag.Over = dt.Select("MinState = '90' OR MinState = '99'", "Code DESC");

            return View();
        }

        [Page]
        [Description("图文页")]
        public ActionResult News(Guid sid, string media_id)
        {
            string mediaJson = "{\"media_id\":\"" + media_id + "\"}";
            WxItemContent content = ElegantWM.WeiXin.Common.GetMedia(sid.ToString(), mediaJson);
            ViewBag.Title = content.news_item.First().title;
            ViewBag.Content = content.news_item.First().content;
            return View();
        }

        [Page]
        [Description("主题页")]
        [Open]
        public ActionResult Theme(Guid sid, string name)
        {
            ViewBag.Name = name;

            //string where = " ThemeName = '" + name + "' AND B.[Status]='上架' and D.STYL_State='20'";
            string where = " ThemeName = '" + name + "'";
            DataTable dt = WMFactory.Wsrr.GetStyleSKUByTheme(where);
            DataView dv = dt.DefaultView;
            dv.Sort = "VID,StyleID DESC";
            DataTable dtDistinct = dv.ToTable(true, "VID", "Name", "Image", "BigImage");
            ViewBag.Title = dtDistinct.Select("1=1", "Name DESC");
            ViewBag.List = dt.Select("1=1", "Name DESC,CreateTime DESC");
            return View();
        }
    }
}
