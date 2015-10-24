using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using Talent.BLL;

namespace Talent.Web.TalentInfo
{
    public partial class TalentLlist : System.Web.UI.Page
    {
        private static BLL.TB_RC_TalentInfor tidb = new BLL.TB_RC_TalentInfor();
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();
        private static BLL.TB_RC_UpkeepDate updb = new BLL.TB_RC_UpkeepDate();
        private static BLL.TB_RC_InterViewer ivdb = new BLL.TB_RC_InterViewer();

        protected string talentsper = "";
        protected string queryStr = "";

        protected int index = 0 ;
        protected int total = 0;

        protected Model.TB_RC_Permission per = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (tmp == "") per = new Model.TB_RC_Permission();
                else
                    per = pidb.GetModel(tmp);
                
                tmp = Common.Constants.getReqValue(Request, "numPerPage");
                int pagesize = Convert.ToInt32(tmp == "" ? "0" : tmp);
                tmp = Common.Constants.getReqValue(Request, "pageNum");
                index = Convert.ToInt32(tmp == "" ? "1" : tmp);

                string CB_No = Common.Constants.getReqValue(Request, "CB_No");
                tmp = " TI_CB_No='" + CB_No + "' ";
                total = tidb.GetTotal(tmp);

                queryStr = tmp;
               
                if (CB_No!="")
                    talentsper = GetTalentsPer(pagesize,index,tmp,total);
            }
        }

        protected string GetTalentsPer(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            var list = tidb.GetModelList(pagesize, index, querystr, itempager);

            if (per.PM_Level >=1 ) GetListManager(sb, list,pagesize*(index-1));
            else GetListReadOnly(sb, list, pagesize * (index - 1));

            return sb.ToString();
        }


        protected void GetListManager(StringBuilder sb, List<Model.TB_RC_TalentInfor> list,int itemindex)
        {
            var dsIV = ivdb.GetList();
            var dtIV = dsIV.Tables[0]; 
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr target='sid_talent' rel='" + obj.TI_No + "'><td>");
                sb.Append(itemindex + "<input name='TI_No' type='hidden' value='" + obj.TI_No + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_OtherCBName' class='textInput lgray'  value='" + obj.TI_OtherCBName + "' size='30' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_BrandName' class='textInput lgray'  value='" + obj.TI_BrandName + "' size='30' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Industry' class='textInput lgray'  value='" + obj.TI_Industry + "' size='30' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_TalentClass' class='textInput lgray' value='" + obj.TI_TalentClass + "' size='25' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Name' class='textInput lgray' value='" + obj.TI_Name + "' size='25' />");
                sb.Append("</td><td>");
                sb.Append("<select name='TI_Sex'  class='textInput'><option></option><option value='男' " + (obj.TI_Sex == "男" ? "selected=selected" : "") + " >男</option><option value='女' " + (obj.TI_Sex == "女" ? "selected=selected" : "") + " >女</option></select>");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Phone' class='textInput lgray' size='15' value='" + obj.TI_Phone + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Email' class='textInput lgray'  value='" + obj.TI_Email + "' size='30' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Reason' class='textInput lgray'  value='" + obj.TI_Reason + "' size='67' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Work' class='textInput lgray' size='67' value='" + obj.TI_Work + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Src' class='textInput lgray' size='15' value='" + obj.TI_Src + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Recommend' class='textInput lgray' size='15' value='" + obj.TI_Recommend + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_RecommendPost' class='textInput lgray' size='15' value='" + obj.TI_RecommendPost + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_OtherRecommendPost' class='textInput lgray' size='15' value='" + obj.TI_OtherRecommendPost + "' />");
                sb.Append("</td><td>");
                sb.Append("<select name='TI_Interviewer'  class='textInput'><option></option>");
                foreach (DataRow ivobj in dtIV.Rows)
                {
                    if (ivobj["IV_Class"].ToString() == obj.TI_Interviewer)
                    {
                        sb.Append("<option selected=\"selected\" value = \"" + obj.TI_Interviewer + "\" >" + obj.TI_Interviewer + "</option>");
                    }else {
                        sb.Append("<option value = \"" + ivobj["IV_Class"].ToString() + "\" >" + ivobj["IV_Class"].ToString() + "</option>");
                    };
                };
                sb.Append("</select></td><td>");
                sb.Append("<input name='TI_Mark' class='textInput lgray' size='15' value='" + obj.TI_Mark + "' />");
                sb.Append("</td><td>");
                sb.Append("<select name='TI_Audition'  class='textInput'><option></option><option value='是' " + (obj.TI_Audition == "是" ? "selected=selected" : "") + ">是</option><option value='否' " + (obj.TI_Audition == "否" ? "selected=selected" : "") + " >否</option></select>");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_AuditionResult' class='textInput lgray' size='67'  value='" + obj.TI_AuditionResult + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_FollowUpPeople' class='textInput lgray'  size='15' value='" + obj.TI_FollowUpPeople + "' />");
                sb.Append("</td><td>");
                sb.Append("<a href='TalentInfo/TalentUpkeep.aspx?CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>维护管理</a>");
                sb.Append("</td><td>");
                sb.Append("<a href='TalentInfo/TalentDocument.aspx?CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>简历管理</a>");
                sb.Append("</td></tr>");
            }
        }

        protected void GetListReadOnly(StringBuilder sb, List<Model.TB_RC_TalentInfor> list,int itemindex)
        {
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr target='sid_talent' rel='" + obj.TI_No + "'><td>");
                sb.Append(itemindex);
                sb.Append("</td><td>");
                sb.Append(obj.TI_BrandName);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Industry);
                sb.Append("</td><td>");
                sb.Append(obj.TI_TalentClass);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Name);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Sex);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Work);
                sb.Append("</td><td>");
           //     sb.Append(obj.TI_Phone);
          //      sb.Append("</td><td>");
                sb.Append(obj.TI_Src);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Recommend);
                sb.Append("</td><td>");
                sb.Append(obj.TI_RecommendPost);
                sb.Append("</td><td>");
                sb.Append(obj.TI_OtherRecommendPost);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Mark);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Audition);
                sb.Append("</td><td>");
                sb.Append(obj.TI_AuditionResult);
                sb.Append("</td><td>");
                sb.Append(obj.TI_FollowUpPeople);
                sb.Append("</td><td>");
                //sb.Append((obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")));
                //sb.Append("</td><td>");
                //sb.Append(obj.TI_MaintainResult);
                //sb.Append("</td><td>");
                sb.Append("<a href='TalentInfo/TalentUpkeep.aspx?status=99&CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>维护管理</a>");
              //  sb.Append("</td><td>");
              //  sb.Append("<a href='TalentInfo/TalentDocument.aspx?status=99&CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>简历管理</a>");
                sb.Append("</td></tr>");
            }
        }

        /**
         * 导出
         */
        public static StringWriter ReportTalent(string queryStr)
        {
            StringWriter sw = new StringWriter();
            sw.WriteLine("序号,品牌或企业,行业,人才类别,姓名,性别,联系方式,工作经历,来源,推荐人,推荐岗位,其它可能适合的岗位,特点,是否面试,面试结果,跟进人,维护时间,维护结果");
            List<Model.TB_RC_TalentInfor> list = tidb.GetModelList(queryStr);
            int itemindex = 0;
            foreach (var obj in list)
            {
                itemindex++;
                sw.Write("=\"" + itemindex + "\"");
                sw.Write(",=\"" + obj.TI_BrandName + "\"");
                sw.Write(",=\"" + obj.TI_Industry + "\"");
                sw.Write(",=\"" + obj.TI_TalentClass + "\"");
                sw.Write(",=\"" + obj.TI_Name + "\"");
                sw.Write(",=\"" + obj.TI_Sex + "\"");
                sw.Write(",=\"" + obj.TI_Phone + "\"");
                sw.Write(",=\"" + obj.TI_Work + "\"");
                sw.Write(",=\"" + obj.TI_Src + "\"");
                sw.Write(",=\"" + obj.TI_Recommend + "\"");
                sw.Write(",=\"" + obj.TI_RecommendPost + "\"");
                sw.Write(",=\"" + obj.TI_OtherRecommendPost + "\"");
                sw.Write(",=\"" + obj.TI_Mark + "\"");
                sw.Write(",=\"" + obj.TI_Audition + "\"");
                sw.Write(",=\"" + obj.TI_AuditionResult + "\"");
                sw.Write(",=\"" + obj.TI_FollowUpPeople + "\"");
              //  sw.Write(",=\"" + (obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")) + "\"");
              //  sw.WriteLine(",=\"" + obj.TI_MaintainResult + "\"");
                var subkeeps = updb.GetModelList(" UD_TI_No='" + obj.TI_No + "' ");
                int i = 0;
                foreach (var keep in subkeeps)
                {
                    if (i == 0)
                    {
                        sw.Write(",=\"" + (keep.UD_Date == null ? "" : keep.UD_Date.Value.ToString("yyyy-MM-dd")) + "\"");
                        sw.WriteLine(",=\"" + Common.Constants.getNullToString(keep.UD_Result).Replace("\r\n", " ") + "\"");
                    }
                    else
                    {
                        sw.Write(",,,,,,,,,,,,,,");
                        sw.Write(",=\"" + (keep.UD_Date == null ? "" : keep.UD_Date.Value.ToString("yyyy-MM-dd")) + "\"");
                        sw.WriteLine(",=\"" + Common.Constants.getNullToString(keep.UD_Result).Replace("\r\n", " ") + "\"");
                    }
                    i++;
                }
                if (i == 0)
                {
                    sw.WriteLine("");
                }
            }
            sw.Close();
            return sw;
        }

    }
}