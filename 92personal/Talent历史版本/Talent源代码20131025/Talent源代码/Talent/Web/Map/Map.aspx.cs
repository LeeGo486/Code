using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Text;

namespace Talent.Web.Map
{
    public partial class Map : System.Web.UI.Page
    {
        //private static BLL.TB_RC_CompanyBasic cbdb = new BLL.TB_RC_CompanyBasic();

        private static BLL.TB_CG_CityBase cbdb = new BLL.TB_CG_CityBase();

        //private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();

        private static BLL.TB_CG_WelfarePolicyType tcdb = new BLL.TB_CG_WelfarePolicyType();

        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        private static JavaScriptSerializer jss = new JavaScriptSerializer();

        protected string optionstr = "";

        protected Model.TB_RC_Permission per = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (tmp == "") per = new Model.TB_RC_Permission();
                else
                    per = pidb.GetModel(tmp);

                var list = tcdb.GetModelList("");
                StringBuilder sb = new StringBuilder();
                foreach(var tc in list )
                {
                    sb.Append("<option value='" + tc.WT_Color + "'>" + tc.WT_WPType + "</option>");
                }
                optionstr = sb.ToString();
            }
        }

        [WebMethod]
        public static string GetModelListAndClass(string querystr)
        {
            Model.TB_RC_Permission per = null;
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "") per = new Model.TB_RC_Permission();
            else
            {
                per = pidb.GetModel(tmp);

                var cbarr = cbdb.GetModelListAndClass(querystr + Common.Constants.getQueryStr(per.PM_Province));
                List<LabelPoint> labelList = new List<LabelPoint>();

                Model.TB_CG_CityBase cur = null;
                LabelPoint lab = null;
                int i = 0;
                foreach (var cb in cbarr)
                {

                    if (cur == null || cur.CB_No != cb.CB_No)
                    {

                        if (cur == null)
                        {
                            lab = new LabelPoint();
                            lab.ID = cb.CB_No;
                            lab.ColorInfo = "<DIV style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";

                        }
                        else
                        {
                            lab.ColorInfo = "<div id='m_" + lab.ID + "' class='marker_2'><div class='colorPicker_controlset' style='width:16px'>" + lab.ColorInfo + "</div></div>";
                            lab.ColorInfo = lab.ColorInfo.Replace("#width", (int)(100 / i) + "%");
                            labelList.Add(lab);
                            lab = new LabelPoint();
                            lab.ID = cb.CB_No;
                            lab.ColorInfo = "<DIV style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";
                        }
                        i = 0;
                        /*共同性的*/
                        lab.X = cb.CB_X;
                        lab.Y = cb.CB_Y;
                        lab.InfoWindow = "<div style='width:400px;height:104px'><h4 style='margin:0 0 5px 0;padding:0.2em 0'>" + cb.CB_Name + "</h4>";
                        //if (cb.CB_Img != null)
                        //{
                        //    lab.InfoWindow += "<img style='float:right;margin:4px' id='imgDemo' src='NewImages/" + cb.CB_Img + "' width='139' height='104' title='" + cb.CB_Name + "'/>";
                        //}
                        var tmpdes = (cb.CB_Des == null ? "" : cb.CB_Des);
                        tmpdes = (tmpdes.Length > 88 ? tmpdes.Substring(0, 88)+"..." : tmpdes);
                        lab.InfoWindow += "<div style='float:left;height:104px'><p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em;width:auto'>" + tmpdes + "</p></div><div style='clear:both;padding-left:230px'><a href='javascript:void(0);' target='navTab' style='color:blue'  onclick='map.openNavTab(" + cb.CB_No + ");return false ;'>详情</a></div></div>";
                    }
                    else
                    {
                        lab.ColorInfo += "<div style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";
                    }
                    cur = cb;
                    i++;
                }

                if (cbarr.Count > 0)
                {
                    lab.ColorInfo = "<div id='m_" + lab.ID + "' class='marker_2'><div class='colorPicker_controlset'  style='width:16px'>" + lab.ColorInfo + "</div></div>";
                    lab.ColorInfo = lab.ColorInfo.Replace("#width", (int)(100 / i) + "%");
                    labelList.Add(lab);
                }
                
                return jss.Serialize(labelList);

            }

            return jss.Serialize(new List<LabelPoint>());
        }

        public static string GetModelListAndClass1(string querystr)
        {
            Model.TB_RC_Permission per = null;
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "") per = new Model.TB_RC_Permission();
            else
            {
                per = pidb.GetModel(tmp);

                var cbarr = cbdb.GetModelListAndClass(querystr + Common.Constants.getQueryStr(per.PM_Province));
                List<LabelPoint> labelList = new List<LabelPoint>();

                Model.TB_CG_CityBase cur = null;
                LabelPoint lab = null;
                int i = 0;
                foreach (var cb in cbarr)
                {

                    if (cur == null || cur.CB_No != cb.CB_No)
                    {

                        if (cur == null)
                        {
                            lab = new LabelPoint();
                            lab.ID = cb.CB_No;
                            lab.ColorInfo = "<DIV style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";

                        }
                        else
                        {
                            lab.ColorInfo = "<div id='m_" + lab.ID + "' class='marker_2'><div class='colorPicker_controlset' style='width:16px'>" + lab.ColorInfo + "</div></div>";
                            lab.ColorInfo = lab.ColorInfo.Replace("#width", (int)(100 / i) + "%");
                            labelList.Add(lab);
                            lab = new LabelPoint();
                            lab.ID = cb.CB_No;
                            lab.ColorInfo = "<DIV style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";
                        }
                        i = 0;
                        /*共同性的*/
                        lab.X = cb.CB_X;
                        lab.Y = cb.CB_Y;
                        lab.InfoWindow = "<div style='width:400px;height:104px'><h4 style='margin:0 0 5px 0;padding:0.2em 0'>" + cb.CB_Name + "</h4>";
                        //if (cb.CB_Img != null)
                        //{
                        //    lab.InfoWindow += "<img style='float:right;margin:4px' id='imgDemo' src='NewImages/" + cb.CB_Img + "' width='139' height='104' title='" + cb.CB_Name + "'/>";
                        //}
                        var tmpdes = (cb.CB_Des == null ? "" : cb.CB_Des);
                        tmpdes = (tmpdes.Length > 88 ? tmpdes.Substring(0, 88) + "..." : tmpdes);
                        lab.InfoWindow += "<div style='float:left;height:104px'><p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em;width:auto'>" + tmpdes + "</p></div><div style='clear:both;padding-left:230px'><a href='javascript:void(0);' target='navTab' style='color:blue'  onclick='map.openNavTab(" + cb.CB_No + ");return false ;'>详情</a></div></div>";
                    }
                    else
                    {
                        lab.ColorInfo += "<div style='BACKGROUND-COLOR: " + (cb.WT_Color == null ? "#000" : cb.WT_Color) + ";width:#width' class='colorPicker-picker-self'></div>";
                    }
                    cur = cb;
                    i++;
                }

                if (cbarr.Count > 0)
                {
                    lab.ColorInfo = "<div id='m_" + lab.ID + "' class='marker_2'><div class='colorPicker_controlset'  style='width:16px'>" + lab.ColorInfo + "</div></div>";
                    lab.ColorInfo = lab.ColorInfo.Replace("#width", (int)(100 / i) + "%");
                    labelList.Add(lab);
                }

                return jss.Serialize(labelList);

            }

            return jss.Serialize(new List<LabelPoint>());
        }

    }

    public class LabelPoint
    {
        public int ID { set; get; }
        public string ColorInfo { set; get; }
        public string InfoWindow { set; get; }
        public string X { set; get; }
        public string Y { set; get; }
    }
}