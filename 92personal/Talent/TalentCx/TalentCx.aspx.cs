using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Text;
using System.IO;

namespace Talent.Web.TalentCx
{
    public partial class TalentCx : System.Web.UI.Page
    {
        private static BLL.TB_RC_TalentInfor tidb = new BLL.TB_RC_TalentInfor();
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();
        private static BLL.TB_RC_UpkeepDate updb = new BLL.TB_RC_UpkeepDate();

        protected int total = 0;
        protected int index = 0;

        protected string queryStr = "";
        protected string listStr = "";
        protected Model.TB_RC_TalentInfor queryModel = null;
        protected Model.TB_RC_Permission per = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "")
            {
                per = new Model.TB_RC_Permission();
                queryModel = new Model.TB_RC_TalentInfor();
            }
            else
            {
                per = pidb.GetModel(tmp);

                tmp = Common.Constants.getReqValue(Request, "numPerPage");
                int pagesize = Convert.ToInt32(tmp == "" ? "0" : tmp);
                tmp = Common.Constants.getReqValue(Request, "pageNum");
                index = Convert.ToInt32(tmp == "" ? "1" : tmp);

                queryModel = new Model.TB_RC_TalentInfor();

                queryModel.CB_Name = Common.Constants.getReqValue(Request, "CB_Name");
                queryModel.TI_OtherCBName = Common.Constants.getReqValue(Request, "TI_OtherCBName");
                queryModel.CB_Position = Common.Constants.getReqValue(Request, "CB_Position");
                queryModel.TI_Name = Common.Constants.getReqValue(Request, "TI_Name");
                queryModel.TI_TalentClass = Common.Constants.getReqValue(Request, "TI_TalentClass");
                queryModel.TI_Sex = Common.Constants.getReqValue(Request, "TI_Sex");
                queryModel.TI_Src = Common.Constants.getReqValue(Request, "TI_Src");
                queryModel.TI_Audition = Common.Constants.getReqValue(Request, "TI_Audition");
                queryModel.TI_AuditionResult = Common.Constants.getReqValue(Request, "TI_AuditionResult");
                queryModel.TI_FollowUpPeople = Common.Constants.getReqValue(Request, "TI_FollowUpPeople");
                queryModel.TI_RecommendPost = Common.Constants.getReqValue(Request, "TI_RecommendPost");
                queryModel.TI_OtherRecommendPost = Common.Constants.getReqValue(Request, "TI_OtherRecommendPost");
                queryModel.TI_Work = Common.Constants.getReqValue(Request, "TI_Work");
                queryModel.TI_Recommend = Common.Constants.getReqValue(Request, "TI_Recommend");
                queryModel.TI_Industry = Common.Constants.getReqValue(Request, "TI_Industry");
                queryModel.TI_Mark = Common.Constants.getReqValue(Request, "TI_Mark");

                tmp = getQueryStr(queryModel);
                tmp += Common.Constants.getQueryStr(per.PM_Province);
                queryStr = tmp;
                total = tidb.GetTotalMerge(tmp);
                listStr = GetTalentList(pagesize, index, tmp, total);
            }
        }

        protected string getQueryStr(Model.TB_RC_TalentInfor queryModel)
        {
            StringBuilder sb = new StringBuilder();
            var properties = TypeDescriptor.GetProperties(queryModel);
            foreach (PropertyDescriptor propertyDescriptror in properties)
            {
                var tmpValue = propertyDescriptror.GetValue(queryModel);
                if (tmpValue != null)
                {
                    if (propertyDescriptror.PropertyType == typeof(string) && (tmpValue.ToString().Trim() != ""))
                    {
                        sb.Append(string.Format(" and {0} like '%{1}%' ", propertyDescriptror.Name, tmpValue));
                    }
                    
                }
            } 
            return sb.ToString();
        }

        public  string GetTalentList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_RC_TalentInfor> list = tidb.GetModelListMerge(pagesize, index, querystr, itempager);
            int itemindex = pagesize * (index -1 );
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr><td>");
                sb.Append(itemindex);
                sb.Append("</td><td>");
                sb.Append(obj.CB_Name);
                sb.Append("</td><td>");
                sb.Append(obj.TI_OtherCBName);
                sb.Append("</td><td>");
                sb.Append(obj.CB_Position);
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
                if (per.PM_Level >= 1)
                {
                    sb.Append(obj.TI_Phone);
                    sb.Append("</td><td>");
                }
                sb.Append(obj.TI_Email);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Reason);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Work);
                sb.Append("</td><td>");
                sb.Append( obj.TI_Src);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Recommend);
                sb.Append("</td><td>");
                sb.Append(obj.TI_RecommendPost);
                sb.Append("</td><td>");
                sb.Append(obj.TI_OtherRecommendPost);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Mark);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Interviewer);
                sb.Append("</td><td>");
                sb.Append(obj.TI_Audition);
                sb.Append("</td><td>");
                sb.Append(obj.TI_AuditionResult);
                sb.Append("</td><td>");
                sb.Append(obj.TI_FollowUpPeople);
                sb.Append("</td><td>");
               // sb.Append((obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")));
               // sb.Append("</td><td>");
               // sb.Append(obj.TI_MaintainResult);
              //  sb.Append("</td><td>");
                sb.Append("<a href='TalentInfo/TalentUpkeep.aspx?status=99&CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>维护管理</a>");
                if (per.PM_Level >= 1)
                {
                    sb.Append("</td><td>");
                    sb.Append("<a href='TalentInfo/TalentDocument.aspx?CB_No=" + obj.TI_CB_No + "&TI_No=" + obj.TI_No + "&status=99' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>简历管理</a>");
                }
                sb.Append("</td></tr>");  
            }
            return sb.ToString();
        }

        /**
         * 导出
         */
        public static StringWriter ReportTalent(string queryStr)
        {
            StringWriter sw = new StringWriter();
            List<Model.TB_RC_TalentInfor> list = tidb.GetModelListMerge(queryStr);
            int itemindex = 0;
            sw.WriteLine("序号,目前雇主,其他重要雇主,公司所在地,品牌或企业,行业,人才类别,姓名,性别,联系方式,工作经历,来源,推荐人,推荐岗位,其它可能适合的岗位,特点,是否面试,面试结果,跟进人,维护时间,维护结果");
            foreach (var obj in list)
            {
                itemindex++;
                sw.Write("=\"" + itemindex + "\"");
                sw.Write(",=\"" + obj.CB_Name + "\"");
                sw.Write(",=\"" + obj.CB_Position + "\"");
                sw.Write(",=\"" + obj.TI_OtherCBName + "\"");
                sw.Write(",=\"" + obj.TI_BrandName + "\"");
                sw.Write(",=\"" + obj.TI_Industry + "\"");
                sw.Write(",=\"" + obj.TI_TalentClass + "\"");
                sw.Write(",=\"" + obj.TI_Name + "\"");
                sw.Write(",=\"" + obj.TI_Sex + "\"");
                sw.Write(",=\"" + obj.TI_Phone + "\"");
                sw.Write(",=\"" + obj.TI_Email + "\"");
                sw.Write(",=\"" + obj.TI_Reason + "\"");
                sw.Write(",=\"" + obj.TI_Work + "\"");
                sw.Write(",=\"" + obj.TI_Src + "\"");
                sw.Write(",=\"" + obj.TI_Recommend + "\"");
                sw.Write(",=\"" + obj.TI_RecommendPost + "\"");
                sw.Write(",=\"" + obj.TI_OtherRecommendPost + "\"");
                sw.Write(",=\"" + obj.TI_Interviewer + "\"");
                sw.Write(",=\"" + obj.TI_Mark + "\"");
                sw.Write(",=\"" + obj.TI_Audition + "\"");
                sw.Write(",=\"" + obj.TI_AuditionResult + "\"");
                sw.Write(",=\"" + obj.TI_FollowUpPeople + "\"");
                //sw.WriteLine(",=\"" + obj.TI_FollowUpPeople + "\"");
                //sw.Write(",=\"" + (obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")) + "\"");
                //sw.WriteLine(",=\"" + obj.TI_MaintainResult + "\"");
                var subkeeps = updb.GetModelList(" UD_TI_No='" + obj.TI_No + "' ");
                int i = 0; 
                foreach( var keep in subkeeps)
                {
                    if (i == 0)
                    {
                        sw.Write(",=\"" + (keep.UD_Date == null ? "" : keep.UD_Date.Value.ToString("yyyy-MM-dd")) + "\"");
                        sw.WriteLine(",=\"" + Common.Constants.getNullToString(keep.UD_Result).Replace("\r\n", " ") + "\"");
                    } else {
                        sw.Write(",,,,,,,,,,,,,,,,");
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