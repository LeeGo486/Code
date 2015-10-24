using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;

namespace Talent.Web.TalentInfo
{
    public partial class TalentLlist : System.Web.UI.Page
    {
        private static BLL.TB_CG_SocialPolicyDetail tidb = new BLL.TB_CG_SocialPolicyDetail();

        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();
        private static BLL.TB_RC_UpkeepDate updb = new BLL.TB_RC_UpkeepDate();

        private static BLL.TB_RC_TalentDocument tddb = new BLL.TB_RC_TalentDocument();

        private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();

        protected string talentsper = "";
        protected string queryStr = "";

        protected int index = 0;
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
                tmp = " SP_No='" + CB_No + "' ";
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


        protected void GetListManager(StringBuilder sb, List<Model.TB_CG_SocialPolicyDetail> list, int itemindex)
        {
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr target='sid_talent' rel='" + obj.No + "'><td>");
                sb.Append(itemindex + "<input name='No' type='hidden' value='" + obj.No + "' size='25' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_Area' class='textInput lgray' onblur='switchjs(this)'  value='" + obj.SP_Area + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_Mode' class='textInput lgray' onblur='switchjs(this)'  value='" + obj.SP_Mode + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_AVGBase' class='textInput lgray' onblur='switchjs(this)' value='" + obj.SP_AVGBase + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_MAXBase' class='textInput lgray' onblur='switchjs(this)' value='" + obj.SP_MAXBase + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_MINBase' class='textInput lgray' onblur='switchjs(this)' value='" + obj.SP_MINBase + "' size='15' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_CompanyParRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_CompanyParRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_PersonalParRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_PersonalParRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_CompanyWorkRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_CompanyWorkRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_PersonalWorkRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_PersonalWorkRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_CompanyBirthRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_CompanyBirthRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_PersonalInjuryRatio' class='textInput lgray' onblur='switchjs(this)' size='15' value='" + obj.SP_PersonalInjuryRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_CompanyMedicalRatio' class='textInput lgray' size='15' onblur='switchjs(this)' value='" + obj.SP_CompanyMedicalRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_PersonalMedicalRatio' class='textInput lgray' size='15' onblur='switchjs(this)' value='" + obj.SP_PersonalMedicalRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_CompanySimulateRatio' onblur='switchjs(this)' class='textInput lgray' size='15'  value='" + obj.SP_CompanySimulateRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_PersonalSimulateRatio' onblur='switchjs(this)' class='textInput lgray'  size='15' value='" + obj.SP_PersonalSimulateRatio + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_SocialDate' class='date textInput lgray'  size='15' value='" + obj.SP_SocialDate + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_HealthDate' class='date textInput lgray'  size='15'  value='" + obj.SP_HealthDate + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_SocialAMDate' class='date textInput lgray'  size='15'  value='" + obj.SP_SocialAMDate + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_SocialData' class=' textInput lgray'  size='15'  value='" + obj.SP_SocialData + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_SocialLocalPolicy' class='textInput lgray'  size='15'  value='" + obj.SP_SocialLocalPolicy + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_BusinessTransact' class='textInput lgray'  size='15'  value='" + obj.SP_BusinessTransact + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='SP_Remark1' class='textInput lgray'  size='15'  value='" + obj.SP_Remark1 + "' />");
                sb.Append("</td></tr>");
            }
        }

        protected void GetListReadOnly(StringBuilder sb, List<Model.TB_CG_SocialPolicyDetail> list, int itemindex)
        {
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr target='sid_talent' rel='" + obj.SP_No + "'><td>");
                sb.Append(itemindex);
                sb.Append("</td><td>");
                sb.Append(obj.SP_Area);
                sb.Append("</td><td>");
                sb.Append(obj.SP_Mode);
                sb.Append("</td><td>");
                sb.Append(obj.SP_AVGBase);
                sb.Append("</td><td>");
                sb.Append(obj.SP_MAXBase);
                sb.Append("</td><td>");
                sb.Append(obj.SP_MINBase);
                sb.Append("</td><td>");
                sb.Append(obj.SP_CompanyParRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_PersonalParRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_CompanyWorkRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_PersonalWorkRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_CompanyBirthRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_PersonalInjuryRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_CompanyMedicalRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_PersonalMedicalRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_CompanySimulateRatio);
                sb.Append("</td><td>");
                sb.Append(obj.SP_PersonalSimulateRatio);
                sb.Append("</td><td>");
                //sb.Append((obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")));
                sb.Append(obj.SP_SocialDate  );
                sb.Append("</td><td>"); 
                sb.Append(obj.SP_HealthDate);
                sb.Append("</td><td>");
                sb.Append(obj.SP_SocialAMDate);
                sb.Append("</td><td>");
                sb.Append(obj.SP_SocialData);
                sb.Append("</td><td>");
                sb.Append(obj.SP_SocialLocalPolicy);
                sb.Append("</td><td>");
                sb.Append(obj.SP_BusinessTransact);
                sb.Append("</td><td>");
                sb.Append(obj.SP_Remark1); 
                sb.Append("</td></tr>");
            }
        }

        /**
         * 导出
         */
        public static StringWriter ReportTalent(string queryStr)
        {
            StringWriter sw = new StringWriter();
            sw.WriteLine("序号,区域,社保缴纳形式,平均基数,社保基数上限,社保基数下限,养老公司承担比例,养老个人承担比例,失业公司承担比例,失业个人承担比例,生育公司承担比例,工伤公司承担比例,医疗公司承担比例,医疗个人承担比例,大病互助充医疗公司承担比例,大病互助充医疗个人承担比例,社保基数调整时间,医保基数调整时间,社保增减社保时间,缴纳社保所需资料,社保当地政策,业务办理,备注");
            List<Model.TB_CG_SocialPolicyDetail> list = tidb.GetModelList(queryStr);
            int itemindex = 0;
            foreach (var obj in list)
            {
                itemindex++;
                sw.Write("=\"" + itemindex + "\"");
                sw.Write(",=\"" + obj.SP_Area + "\"");
                sw.Write(",=\"" + obj.SP_Mode + "\"");
                sw.Write(",=\"" + obj.SP_AVGBase + "\"");
                sw.Write(",=\"" + obj.SP_MAXBase + "\"");
                sw.Write(",=\"" + obj.SP_MINBase + "\"");
                sw.Write(",=\"" + obj.SP_CompanyParRatio + "\"");
                sw.Write(",=\"" + obj.SP_PersonalParRatio + "\"");
                sw.Write(",=\"" + obj.SP_CompanyWorkRatio + "\"");
                sw.Write(",=\"" + obj.SP_PersonalWorkRatio + "\"");
                sw.Write(",=\"" + obj.SP_CompanyBirthRatio + "\"");
                sw.Write(",=\"" + obj.SP_PersonalInjuryRatio + "\"");
                sw.Write(",=\"" + obj.SP_CompanyMedicalRatio + "\"");
                sw.Write(",=\"" + obj.SP_PersonalMedicalRatio + "\"");
                sw.Write(",=\"" + obj.SP_CompanySimulateRatio + "\"");
                sw.Write(",=\"" + obj.SP_PersonalSimulateRatio + "\"");
                sw.Write(",=\"" + obj.SP_SocialDate + "\"");
                sw.Write(",=\"" + obj.SP_HealthDate + "\"");
                sw.Write(",=\"" + obj.SP_SocialAMDate + "\"");
                sw.Write(",=\"" + obj.SP_SocialData + "\"");
                sw.Write(",=\"" + obj.SP_SocialLocalPolicy + "\"");
                sw.Write(",=\"" + obj.SP_BusinessTransact + "\"");
                sw.Write(",=\"" + obj.SP_Remark1 + "\""); 
                var subkeeps = updb.GetModelList(" UD_TI_No='" + obj.SP_No + "' ");
                int i = 0;
                foreach (var keep in subkeeps)
                {
                    if (i == 0)
                    {
                        //sw.Write(",=\"" + (keep.UD_Date == null ? "" : keep.UD_Date.Value.ToString("yyyy-MM-dd")) + "\"");
                        sw.WriteLine(",=\"" + Common.Constants.getNullToString(keep.UD_Result).Replace("\r\n", " ") + "\"");
                    }
                    else
                    {
                        sw.Write(",,,,,,,,,,,,,,");
                        //sw.Write(",=\"" + (keep.UD_Date == null ? "" : keep.UD_Date.Value.ToString("yyyy-MM-dd")) + "\"");
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

        protected string GetTalentOption(string talentName)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            sb.Append("<select  style=' margin:2px' name='TI_TalentClass' >");
            sb.Append("<option></option>");
            foreach (var td in arr)
            {
                if (td.TC_Class == talentName)
                {
                    sb.Append("<option selected=selected value='" + td.TC_Class + "'>" + td.TC_Class + "</option>");
                }
                else
                {
                    sb.Append("<option value='" + td.TC_Class + "'>" + td.TC_Class + "</option>");
                }
            }
            sb.Append("</select>");
            return sb.ToString();
        }

    }
}