﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Talent.Web.TalentInfo
{
    public partial class TalentUpkeep : System.Web.UI.Page
    {
        private static BLL.TB_RC_UpkeepDate updb = new BLL.TB_RC_UpkeepDate();

        protected string filelist = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            var CB_No = Common.Constants.getReqValue(Request, "CB_No");
            var TI_No = Common.Constants.getReqValue(Request, "TI_No");
            StringBuilder sb = new StringBuilder();
            var list = updb.GetModelList(" UD_CB_No='" + CB_No + "'  and  UD_TI_No='" + TI_No + "' ");
            foreach (var td in list)
            {
                sb.Append("<div class='unit'><label style='width:270px'>");
                sb.Append((td.UD_Date == null ? "" : td.UD_Date.Value.ToString("yyyy-MM-dd")) + "&nbsp;:&nbsp;" + td.UD_Result);
                sb.Append("</label><a class='ldelete' href='ajaxWebServices.ashx?webmethod=delTalentUpkeep&rel=ducument_dia&UD_No=" + td.UD_No + "' callback='TalentInfo.RefeshDocument' " + (Request["status"] == "99" ? "style='display:none'" : "") + " target='ajaxTodo' title='确定要删除吗?'>删除</a></div>");
            }
            filelist = sb.ToString();
        }

        public static int AddUpkeep(HttpRequest req, ref string message, ref string forwardurl)
        {
            Model.TB_RC_UpkeepDate model = new Model.TB_RC_UpkeepDate();
            model.UD_CB_No = Convert.ToInt32(Common.Constants.getReqValue(req, "CB_No"));
            model.UD_TI_No = Convert.ToInt32(Common.Constants.getReqValue(req, "TI_No"));
            forwardurl = "TalentInfo/TalentUpkeep.aspx?CB_No=" + model.UD_CB_No + "&TI_No=" + model.UD_TI_No;
            var tmp =  Common.Constants.getReqValue(req, "UD_Date");
            if (tmp != "") model.UD_Date = DateTime.Parse(tmp);
            model.UD_Result = Common.Constants.getReqValue(req, "UD_Result");
            model.UD_CreateDate = DateTime.Now;
            model.UD_CreatePer = Tools.SessionHelper.Get("userid") ;
            updb.Add(model);
            message = "添加维护信息成功！";
            return Common.Constants.OK;
        }


        public static int DelTalentUpkeep(HttpRequest req, ref string message, ref string forwardurl)
        {
            var model = updb.GetModel(Convert.ToInt32(Common.Constants.getReqValue(req, "UD_No")));
            forwardurl = "TalentInfo/TalentUpkeep.aspx?CB_No=" + model.UD_CB_No + "&TI_No=" + model.UD_TI_No;
            updb.Delete(model.UD_No);
            message = "文档删除成功"; 
            return Common.Constants.OK;
        }
    }
}