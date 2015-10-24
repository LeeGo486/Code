using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;

namespace Talent.Web.TalentClass
{
    public partial class TalentClassCx : System.Web.UI.Page
    {
        //private static BLL.TB_RC_TalentClass tcClass = new BLL.TB_RC_TalentClass();

        private static BLL.TB_CG_WelfarePolicyType tcClass = new BLL.TB_CG_WelfarePolicyType();

        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected int total = 0;
        protected int index = 0;

        protected Model.TB_RC_Permission per = null;
        protected string queryStr = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "") per = new Model.TB_RC_Permission();
            else
                per = pidb.GetModel(tmp);

            tmp = Common.Constants.getReqValue(Request, "numPerPage");
            int pagesize = Convert.ToInt32(tmp == "" ? "0" : tmp);
            tmp = Common.Constants.getReqValue(Request, "pageNum");
            index = Convert.ToInt32(tmp == "" ? "1" : tmp);

            tmp = "";
            tmp = Common.Constants.getReqValue(Request, "TC_Class");

            tmp = getQueryStr(tmp);
            queryStr = tmp;
            total = tcClass.GetTotal(tmp);
            TalentClassList.InnerHtml = GetTalentClassList(pagesize, index, tmp, total);
        }
        public static string GetTalentClassList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_CG_WelfarePolicyType> list = tcClass.GetModelList(pagesize, index, querystr, itempager);
            foreach (var apply in list)
            {
                sb.Append("<tr target='sid_class' rel='" + apply.WT_No + "'>");
                sb.Append("<td><input name='ids' value='" + apply.WT_No + "' type='checkbox'></td>");
                sb.Append("<td>" + apply.WT_No + "</td>");
                sb.Append("<td>" + apply.WT_WPType + "</td>");
                sb.Append("<td><DIV class='colorPicker_controlset'><DIV style='BACKGROUND-COLOR:" + apply.WT_Color + ";width:16px' class='colorPicker-picker'>&nbsp;</DIV></DIV></td>");
                sb.Append("</tr>");
            }
            return sb.ToString();
        }

        /*
         *组装sql
         */
        private static string getQueryStr(string TC_Class)
        {
            string tmp = "";
            if (TC_Class != "")
            {
                tmp += " TC_Class like '%" + TC_Class + "%' ";
            }
            return tmp;
        }

        public static int AddTalentClass(HttpRequest req, ref string message)
        {
            Model.TB_CG_WelfarePolicyType talent = new Model.TB_CG_WelfarePolicyType();
            talent.WT_WPType = Common.Constants.getReqValue(req, "TC_Class");
            talent.WT_Color = Common.Constants.getReqValue(req, "TC_Color");

            int count = tcClass.GetTotal(" WT_WPType='" + talent.WT_WPType + "' or WT_Color ='" + talent.WT_Color + "' ");
            if (count > 0) {
                message = "人才类别或颜色已存在";
                return Common.Constants.ERR;
            }

            message = "增加人才类别成功";
            tcClass.Add(talent);
            return Common.Constants.OK;
        }

        public static int DelTalentClass(HttpRequest req, ref string message)
        {
            string dellist = Common.Constants.getReqValue(req, "ids");
            if (dellist == "")
            {
                message = "删除条件为空！";
                return Common.Constants.ERR;
            }
            tcClass.DeleteList(dellist);
            message = "删除人才类别成功！"; 
            return Common.Constants.OK;
        }

        public static int UpdateTalentClass(HttpRequest req, ref string message)
        {
            string fno = Common.Constants.getReqValue(req, "TC_No");
            if (fno == "")
            {
                message = "需要更新的人才类别id为空，请重新选择!";
                return Common.Constants.ERR;
            }
            var talent = tcClass.GetModel(Convert.ToInt32(fno));
            if (talent == null)
            {
                message = "需要更新的人才类别不存在，请重新选择!";
                return Common.Constants.ERR;
            }
            message = "更新人才类别成功";
            talent.WT_WPType = Common.Constants.getReqValue(req, "TC_Class");
            talent.WT_Color = Common.Constants.getReqValue(req, "TC_Color");
            tcClass.Update(talent); 
            return Common.Constants.OK;
        }

        /**
         * 导出
         */
        public static StringWriter ReportTalentClass(string queryStr)
        {
            StringWriter sw = new StringWriter();
            sw.WriteLine("序号,人才类别,颜色");
            List<Model.TB_CG_WelfarePolicyType> list = tcClass.GetModelList(queryStr);
            foreach (var apply in list)
            {
                sw.Write("=\"" + apply.WT_No + "\"");
                sw.Write(",=\"" + apply.WT_WPType + "\"");
                sw.WriteLine(",=\"" + apply.WT_Color + "\"");
            }
            sw.Close();
            return sw;
        }
    }
}