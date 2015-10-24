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
        //private static BLL.TB_RC_TalentInfor tidb = new BLL.TB_RC_TalentInfor();

        private static BLL.TB_CG_CityBase tidb = new BLL.TB_CG_CityBase();
        //TB_CG_SocialPolicy
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();
        private static BLL.TB_RC_UpkeepDate updb = new BLL.TB_RC_UpkeepDate();
        //private static BLL.TB_RC_TalentDocument tddb = new BLL.TB_RC_TalentDocument();

        protected int total = 0;
        protected int index = 0;

        protected string queryStr = "";
        protected string listStr = "";
        protected Model.TB_CG_CityBase queryModel = null;
        protected Model.TB_RC_Permission per = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "")
            {
                per = new Model.TB_RC_Permission();
                queryModel = new Model.TB_CG_CityBase();
            }
            else
            {
                per = pidb.GetModel(tmp);

                tmp = Common.Constants.getReqValue(Request, "numPerPage");
                int pagesize = Convert.ToInt32(tmp == "" ? "0" : tmp);
                tmp = Common.Constants.getReqValue(Request, "pageNum");
                index = Convert.ToInt32(tmp == "" ? "1" : tmp);

                queryModel = new Model.TB_CG_CityBase();

                queryModel.CB_Name = Common.Constants.getReqValue(Request, "CB_Name");

                //queryModel.SP_Mode = Common.Constants.getReqValue(Request, "SP_Mode");
                //queryModel.TI_Name = Common.Constants.getReqValue(Request, "TI_Name");
                //queryModel.TI_TalentClass = Common.Constants.getReqValue(Request, "TI_TalentClass");
                //queryModel.TI_Sex = Common.Constants.getReqValue(Request, "TI_Sex");
                //queryModel.TI_Src = Common.Constants.getReqValue(Request, "TI_Src");
                //queryModel.TI_Audition = Common.Constants.getReqValue(Request, "TI_Audition");
                //queryModel.TI_AuditionResult = Common.Constants.getReqValue(Request, "TI_AuditionResult");
                //queryModel.TI_FollowUpPeople = Common.Constants.getReqValue(Request, "TI_FollowUpPeople");
                //queryModel.TI_RecommendPost = Common.Constants.getReqValue(Request, "TI_RecommendPost");
                //queryModel.TI_Work = Common.Constants.getReqValue(Request, "TI_Work");
                //queryModel.TI_Recommend = Common.Constants.getReqValue(Request, "TI_Recommend");
                //queryModel.TI_Industry = Common.Constants.getReqValue(Request, "TI_Industry");
                //queryModel.TI_Mark = Common.Constants.getReqValue(Request, "TI_Mark");

                tmp = getQueryStr(queryModel);
                tmp += Common.Constants.getQueryStr(per.PM_Province);
                queryStr = tmp;
                total = tidb.GetTotalMerge(tmp);
                listStr = GetTalentList(pagesize, index, tmp, total);
            }
        }

        protected string getQueryStr(Model.TB_CG_CityBase queryModel)
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

        public string GetTalentList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_CG_CityBase> list = tidb.GetListMergeSocialPolicyDetail(pagesize, index, querystr, itempager);
            int itemindex = pagesize * (index - 1);
            foreach (var obj in list)
            {
                itemindex++;
                sb.Append("<tr><td>");
                sb.Append(itemindex);
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
                sb.Append(obj.SP_SocialDate);
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
                sb.Append("</td><td>");
                sb.Append(obj.SP_DateTime);
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
            List<Model.TB_CG_CityBase> list = tidb.GetModelListMerge(queryStr);
            int itemindex = 0;
            sw.WriteLine("序号,城市名称,社保缴纳形式,平均基数,社保基数上限,社保基数下限,养老公司承担比例,养老个人承担比例,失业公司承担比例,失业个人承担比例,生育公司承担比例,工伤公司承担比例,医疗公司承担比例,医疗个人承担比例,大病互助充医疗公司承担比例,大病互助充医疗个人承担比例,社保基数调整时间,医保基数调整时间,社保增减社保时间,缴纳社保所需资料,社保当地政策,业务办理,公积金缴纳形式,基数上限,基数下限,公司承担比例,个人承担比例,公积金基数调整时间,公积金增减时间,公积金贷款政策,人事劳动政策一,人事劳动政策二,特殊福利政策一,特殊福利政策二,备注");
            foreach (var obj in list)
            {
                itemindex++;
                sw.Write("=\"" + itemindex + "\"");
                sw.Write(",=\"" + obj.CB_Name + "\"");
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
                sw.Write(",=\"" + obj.MP_Mode + "\"");
                sw.Write(",=\"" + obj.MP_MAXBase + "\"");
                sw.Write(",=\"" + obj.MP_MINBase + "\"");
                sw.Write(",=\"" + obj.MP_CompanyRatio + "\"");
                sw.Write(",=\"" + obj.MP_PersonalRatio + "\"");
                sw.Write(",=\"" + obj.MP_MPFAdjustDate + "\"");
                sw.Write(",=\"" + obj.MP_MPFAMDate + "\"");
                sw.Write(",=\"" + obj.MP_MPFLocalPolicy + "\"");
                sw.Write(",=\"" + obj.PP_PerPolicyOne + "\"");
                sw.Write(",=\"" + obj.PP_PerPolicyTwo + "\"");

                sw.Write(",=\"" + obj.WP_WelfarePolicyOne + "\"");

                sw.Write(",=\"" + obj.WP_WelfarePolicyTwo + "\"");
                sw.Write(",=\"" + obj.SP_Remark1 + "\"");

                var subkeeps = updb.GetModelList(" UD_TI_No='" + obj.CB_No + "' ");
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
                        sw.Write(",,,,,,,,,,,,,,,,,");
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
    }
}