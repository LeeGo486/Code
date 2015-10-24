using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Talent.Web.TalentInfo
{
    public partial class TalentDocument : System.Web.UI.Page
    {
        private static BLL.TB_RC_TalentDocument tddb = new BLL.TB_RC_TalentDocument();

        protected string filelist = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            var CB_No = Common.Constants.getReqValue(Request, "CB_No");
            var TI_No = Common.Constants.getReqValue(Request, "TI_No");
            StringBuilder sb = new StringBuilder();
            var list = tddb.GetModelList(" TD_CB_No='" + CB_No + "'  and  TD_TI_No='" + TI_No + "' ");
            foreach(var td in list)
            {
                sb.Append("<div class='unit'><label style='width:200px'>");
                sb.Append(td.TD_DocName);
                sb.Append("</label><a class='ldelete' href='ajaxWebServices.ashx?webmethod=delTalentDocument&rel=ducument_dia&TD_No=" + td.TD_No + "' callback='TalentInfo.RefeshDocument' " + ((Request["status"] == "99")? "style='display:none'" : "") + " target='ajaxTodo' title='确定要删除吗?'>删除</a><a class='ldownload' target='_blank' href='NewImages/" + td.TD_docPath + "' >下载</a></div>");
            }
            filelist = sb.ToString();
        }

        public static int AddTalentDocument(HttpRequest req, ref string message, ref string  forwardurl)
        {
            if (req.Files[0].ContentLength != 0)
            {
                Model.TB_RC_TalentDocument model = new Model.TB_RC_TalentDocument();
                model.TD_CB_No = Convert.ToInt32(Common.Constants.getReqValue(req, "CB_No"));
                model.TD_TI_No = Convert.ToInt32(Common.Constants.getReqValue(req, "TI_No"));
                forwardurl = "TalentInfo/TalentDocument.aspx?CB_No=" + model.TD_CB_No + "&TI_No=" + model.TD_TI_No;
                var tmpext = Common.Constants.GetFileExt(req.Files[0].FileName);
                string filedir = req.MapPath("newImages") + "\\";
                string filename = DateTime.Now.ToString("yyyy-MM-dd_HH_mm_ss") + Common.Constants.getGuid() + "." + tmpext;
                req.Files[0].SaveAs(filedir + filename);
                model.TD_DocName = System.IO.Path.GetFileName(req.Files[0].FileName);
                model.TD_docPath = filename;
                model.TD_CreateDate = DateTime.Now;
                model.TD_CreatePer = "";
                tddb.Add(model); 
                message = "添加文档成功";
               
            }
            else
            { 
                message = "文件内容为空" ;
                return Common.Constants.ERR;
            }
            return Common.Constants.OK;
        }


        public static int DelTalentDocument(HttpRequest req, ref string message  ,ref string  forwardurl)
        {
            var model = tddb.GetModel(Convert.ToInt32(Common.Constants.getReqValue(req, "TD_No")));
            forwardurl = "TalentInfo/TalentDocument.aspx?CB_No=" + model.TD_CB_No + "&TI_No=" + model.TD_TI_No;
            tddb.Delete(Convert.ToInt32(Common.Constants.getReqValue(req, "TD_No")));
            message = "文档删除成功";
            return Common.Constants.OK;
        }
    }
}