using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Drawing;
using System.Web.Services;
using System.ComponentModel;
using System.IO;


namespace Talent.Web.TalentInfo
{
    public partial class TalentInfo : System.Web.UI.Page
    {
        private static BLL.TB_CG_CityBase cbdb = new BLL.TB_CG_CityBase();

        //private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();

        private static BLL.TB_CG_SocialWelfareLink cbcrdb = new BLL.TB_CG_SocialWelfareLink();

        private static BLL.TB_CG_SocialPolicyDetail tidb = new BLL.TB_CG_SocialPolicyDetail();

        //private static BLL.TB_RC_TalentDocument tddb = new BLL.TB_RC_TalentDocument();

        protected Model.TB_CG_CityBase model = null;

        protected string selectstr = "";
        protected string talentsper = "";
        
 
        protected void Page_Load(object sender, EventArgs e)
        {
          /*  int count = 0;
            if (!IsPostBack)
            {
                string CB_No = Common.Constants.getReqValue(Request, "CB_No");
                if (CB_No == "") model = new Model.TB_RC_CompanyBasic();
                else
                {
                    model = cbdb.GetModel(int.Parse(CB_No));
                    if (model != null)
                    {
                        var list = tcdb.GetModelListByRelate(CB_No);
                        foreach (var tc in list)
                        {
                            count++;
                            selectstr += GetTalentOption(tc.TC_No);
                        }
                        for (int i = count; i < 5; i++)
                        {
                            selectstr += GetTalentOption(-1);
                        }
                        talentsper = GetTalentsPer(model.CB_No);
                    }
                }
            } */
        }

        /*增加公司*/
        public static int AddLabelCompanyDialog(HttpRequest req, ref string message,ref int id)
        {
            string tmp = "";
            Model.TB_CG_CityBase model = new Model.TB_CG_CityBase();

            model.CB_X = Common.Constants.getReqValue(req, "CB_X");
            model.CB_Y = Common.Constants.getReqValue(req, "CB_Y");
            model.CB_Name = Common.Constants.getReqValue(req, "CB_Name");
            model.cb_shopnum = Common.Constants.getReqValue(req, "CB_Num");
            //tmp = Common.Constants.getReqValue(req, "CB_Num");
            //if (tmp != "") model.CB_Num = int.Parse(tmp);
            model.CB_Num = Common.Constants.getReqValue(req, "CB_Position");
            model.cb_setup = Common.Constants.getReqValue(req, "CB_SetUp");
            model.CB_Des = Common.Constants.getReqValue(req, "CB_Des");
            model.CB_Je = Common.Constants.getReqValue(req, "CB_Je");

            if (model.CB_X == "" || model.CB_Y == "")
            {
                message = "坐标为空，不能加入";
                return Common.Constants.ERR;
            }

            message = "增加城市成功";
            id = cbdb.Add(model);

            return Common.Constants.OK;
        }

        /*更新公司*/
        public static int UpdateTalentInfo(HttpRequest req, ref string message, ref int id)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "获取id失败，请重新选择更新";
                return Common.Constants.ERR;
            }
            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(tmp));
            if (model == null )
            {
                message = "数据库不存在该记录，请刷新地图";
                return Common.Constants.ERR;
            }
            id = model.CB_No;

            var rel = Common.Constants.getReqValue(req, "rel");
            if (rel == "basicID") /*基本信息更新*/
            {
                model.CB_No = int.Parse(Common.Constants.getReqValue(req, "CB_No"));
                model.SP_Area = Common.Constants.getReqValue(req, "SP_Area");
                model.SP_Mode = Common.Constants.getReqValue(req, "SP_Mode");
                model.SP_AVGBase = Common.Constants.getReqValue(req, "SP_AVGBase");
                model.SP_MAXBase = Common.Constants.getReqValue(req, "SP_MAXBase");
                model.SP_MINBase = Common.Constants.getReqValue(req, "SP_MINBase");
                model.SP_CompanyParRatio = Common.Constants.getReqValue(req, "SP_CompanyParRatio");
                model.SP_PersonalParRatio = Common.Constants.getReqValue(req, "SP_PersonalParRatio");
                model.SP_CompanyWorkRatio = Common.Constants.getReqValue(req, "SP_CompanyWorkRatio");
                model.SP_PersonalWorkRatio = Common.Constants.getReqValue(req, "SP_PersonalWorkRatio");
                model.SP_CompanyBirthRatio = Common.Constants.getReqValue(req, "SP_CompanyBirthRatio");
                model.SP_PersonalInjuryRatio = Common.Constants.getReqValue(req, "SP_PersonalInjuryRatio");
                model.SP_CompanyMedicalRatio = Common.Constants.getReqValue(req, "SP_CompanyMedicalRatio");
                model.SP_PersonalMedicalRatio = Common.Constants.getReqValue(req, "SP_PersonalMedicalRatio");
                model.SP_CompanySimulateRatio = Common.Constants.getReqValue(req, "SP_CompanySimulateRatio");
                model.SP_PersonalSimulateRatio = Common.Constants.getReqValue(req, "SP_PersonalSimulateRatio");
                model.SP_SocialDate = Common.Constants.getReqValue(req, "SP_SocialDate");
                model.SP_HealthDate = Common.Constants.getReqValue(req, "SP_HealthDate");
                model.SP_SocialAMDate = Common.Constants.getReqValue(req, "SP_SocialAMDate");
                model.SP_SocialData = Common.Constants.getReqValue(req, "SP_SocialData");
                model.SP_SocialLocalPolicy = Common.Constants.getReqValue(req, "SP_SocialLocalPolicy");
                model.SP_BusinessTransact = Common.Constants.getReqValue(req, "SP_BusinessTransact");
                model.SP_Remark1 = Common.Constants.getReqValue(req, "SP_Remark1");

                //model.MP_Mode = Common.Constants.getReqValue(req, "MP_Mode");
                //model.MP_MAXBase = Common.Constants.getReqValue(req, "MP_MAXBase");
                //model.MP_MINBase = Common.Constants.getReqValue(req, "MP_MINBase");
                //model.MP_CompanyRatio = Common.Constants.getReqValue(req, "MP_CompanyRatio");
                //model.MP_PersonalRatio = Common.Constants.getReqValue(req, "MP_PersonalRatio");
                //model.MP_MPFAdjustDate = Common.Constants.getReqValue(req, "MP_MPFAdjustDate");
                //model.MP_MPFAMDate = Common.Constants.getReqValue(req, "MP_MPFAMDate");
                //model.MP_MPFLocalPolicy = Common.Constants.getReqValue(req, "MP_MPFLocalPolicy");
                //model.PP_PerPolicyOne = Common.Constants.getReqValue(req, "PP_PerPolicyOne");
                //model.PP_PerPolicyTwo = Common.Constants.getReqValue(req, "PP_PerPolicyTwo");
                ////model.WP_WelfarePolicyOne = Common.Constants.getReqValue(req, "WP_WelfarePolicyOne");
                ////model.WP_WelfarePolicyTwo = Common.Constants.getReqValue(req, "WP_WelfarePolicyTwo");

                message = "更新社保信息";

                //cbcrdb.Delete(model.CB_No);//删除原有的记录
                //var arrstr = Common.Constants.getReqValue(req, "WT_No");
                //string[] arr;
                //if (arrstr != "")
                //{
                //    arr = arrstr.Split(',');
                //    foreach (var cr in arr)
                //    {
                //        if (cr.Trim() != "")
                //        {
                //            var tmpModel = new Model.TB_CG_SocialWelfareLink() { CT_CB_No = model.CB_No, CT_TC_No = Convert.ToInt32(cr) };
                //            if (!cbcrdb.Exists(tmpModel))
                //            {
                //                cbcrdb.Add(tmpModel);
                //            }
                //        }
                //    }
                //}
                cbdb.Update(model);
                cbdb.ADDHistory(model);
                return Common.Constants.OK;
            }

            else
            {
                var TI_Nostr = Common.Constants.getReqValue(req, "No");
                var TI_Noarr = TI_Nostr.Split(',');
                if (TI_Nostr != "" && (TI_Noarr.Length > 0))
                {
                    //var No = Common.Constants.getReqValue(req, "No").Split(',');
                    var SP_Area = Common.Constants.getReqValue(req, "SP_Area").Split(',');
                    var SP_Mode = Common.Constants.getReqValue(req, "SP_Mode").Split(',');
                    var SP_AVGBase = Common.Constants.getReqValue(req, "SP_AVGBase").Split(',');
                    var SP_MAXBase = Common.Constants.getReqValue(req, "SP_MAXBase").Split(',');
                    var SP_MINBase = Common.Constants.getReqValue(req, "SP_MINBase").Split(',');
                    var SP_CompanyParRatio = Common.Constants.getReqValue(req, "SP_CompanyParRatio").Split(',');
                    var SP_PersonalParRatio = Common.Constants.getReqValue(req, "SP_PersonalParRatio").Split(',');
                    var SP_CompanyWorkRatio = Common.Constants.getReqValue(req, "SP_CompanyWorkRatio").Split(',');
                    var SP_PersonalWorkRatio = Common.Constants.getReqValue(req, "SP_PersonalWorkRatio").Split(',');
                    var SP_CompanyBirthRatio = Common.Constants.getReqValue(req, "SP_CompanyBirthRatio").Split(',');
                    var SP_PersonalInjuryRatio = Common.Constants.getReqValue(req, "SP_PersonalInjuryRatio").Split(',');

                    var SP_CompanyMedicalRatio = Common.Constants.getReqValue(req, "SP_CompanyMedicalRatio").Split(',');
                    var SP_PersonalMedicalRatio = Common.Constants.getReqValue(req, "SP_PersonalMedicalRatio").Split(',');
                    var SP_CompanySimulateRatio = Common.Constants.getReqValue(req, "SP_CompanySimulateRatio").Split(',');
                    var SP_PersonalSimulateRatio = Common.Constants.getReqValue(req, "SP_PersonalSimulateRatio").Split(',');
                    var SP_SocialDate = Common.Constants.getReqValue(req, "SP_SocialDate").Split(',');
                    var SP_HealthDate = Common.Constants.getReqValue(req, "SP_HealthDate").Split(',');

                    var SP_SocialAMDate = Common.Constants.getReqValue(req, "SP_SocialAMDate").Split(',');
                    var SP_SocialData = Common.Constants.getReqValue(req, "SP_SocialData").Split(',');
                    var SP_SocialLocalPolicy = Common.Constants.getReqValue(req, "SP_SocialLocalPolicy").Split(',');
                    var SP_BusinessTransact = Common.Constants.getReqValue(req, "SP_BusinessTransact").Split(',');
                    var SP_Remark1 = Common.Constants.getReqValue(req, "SP_Remark1").Split(',');

                    for (int i = 0; i < TI_Noarr.Length; i++)
                    {
                        var ti = tidb.GetModel(Convert.ToInt32(TI_Noarr[i]));
                        if (ti != null)
                        {
                            //ti.No = No[i];
                            ti.SP_Area = SP_Area[i];
                            ti.SP_Mode = SP_Mode[i];
                            ti.SP_AVGBase = SP_AVGBase[i];
                            ti.SP_MAXBase = SP_MAXBase[i];
                            ti.SP_MINBase = SP_MINBase[i];
                            ti.SP_CompanyParRatio = SP_CompanyParRatio[i];
                            ti.SP_PersonalParRatio = SP_PersonalParRatio[i];
                            ti.SP_CompanyWorkRatio = SP_CompanyWorkRatio[i];
                            ti.SP_PersonalWorkRatio = SP_PersonalWorkRatio[i];
                            ti.SP_CompanyBirthRatio = SP_CompanyBirthRatio[i];
                            ti.SP_PersonalInjuryRatio = SP_PersonalInjuryRatio[i];

                            ti.SP_CompanyMedicalRatio = SP_CompanyMedicalRatio[i];
                            ti.SP_PersonalMedicalRatio = SP_PersonalMedicalRatio[i];
                            ti.SP_CompanySimulateRatio = SP_CompanySimulateRatio[i];
                             
                            ti.SP_PersonalSimulateRatio = SP_PersonalSimulateRatio[i];

                            ti.SP_SocialDate = SP_SocialDate[i];
                            ti.SP_HealthDate = SP_HealthDate[i];
                            ti.SP_SocialAMDate = SP_SocialAMDate[i];
                            ti.SP_SocialData = SP_SocialData[i];

                            ti.SP_SocialLocalPolicy = SP_SocialLocalPolicy[i];
                            ti.SP_BusinessTransact = SP_BusinessTransact[i];
                            ti.SP_Remark1 = SP_Remark1[i];
                             
                            tidb.Update(ti);
                        }
                    }
                }
                //message = "人才库更新成功";
                return Common.Constants.OK;
              
            }
              
            

            
     
        }
 
        /*更新公积金*/
        public static int UpdateTalentInfo1(HttpRequest req, ref string message, ref int id)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "获取id失败，请重新选择更新";
                return Common.Constants.ERR;
            }
            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(tmp));
            if (model == null)
            {
                message = "数据库不存在该记录，请刷新地图";
                return Common.Constants.ERR;
            }
            id = model.CB_No;

            model.CB_No = int.Parse(Common.Constants.getReqValue(req, "CB_No"));
             
            model.MP_Mode = Common.Constants.getReqValue(req, "MP_Mode");
            model.MP_MAXBase = Common.Constants.getReqValue(req, "MP_MAXBase");
            model.MP_MINBase = Common.Constants.getReqValue(req, "MP_MINBase");
            model.MP_CompanyRatio = Common.Constants.getReqValue(req, "MP_CompanyRatio");
            model.MP_PersonalRatio = Common.Constants.getReqValue(req, "MP_PersonalRatio");
            model.MP_MPFAdjustDate = Common.Constants.getReqValue(req, "MP_MPFAdjustDate");
            model.MP_MPFAMDate = Common.Constants.getReqValue(req, "MP_MPFAMDate");
            model.MP_MPFLocalPolicy = Common.Constants.getReqValue(req, "MP_MPFLocalPolicy");
             
            message = "更新公积金信息";

             
            cbdb.Update1(model);


            return Common.Constants.OK;


        }

        /*更新人事劳动*/
        public static int UpdateTalentInfo2(HttpRequest req, ref string message, ref int id)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "获取id失败，请重新选择更新";
                return Common.Constants.ERR;
            }
            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(tmp));
            if (model == null)
            {
                message = "数据库不存在该记录，请刷新地图";
                return Common.Constants.ERR;
            }
            id = model.CB_No;

            model.CB_No = int.Parse(Common.Constants.getReqValue(req, "CB_No"));
          
            model.PP_PerPolicyOne = Common.Constants.getReqValue(req, "PP_PerPolicyOne");
            model.PP_PerPolicyTwo = Common.Constants.getReqValue(req, "PP_PerPolicyTwo");

            message = "更新人事劳动信息";
 
            cbdb.Update2(model);
 
            return Common.Constants.OK;
 
        }
 
        /*更新特殊福利*/
        public static int UpdateTalentInfo3(HttpRequest req, ref string message, ref int id)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "获取id失败，请重新选择更新";
                return Common.Constants.ERR;
            }
            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(tmp));
            if (model == null)
            {
                message = "数据库不存在该记录，请刷新地图";
                return Common.Constants.ERR;
            }
            id = model.CB_No;

            model.CB_No = int.Parse(Common.Constants.getReqValue(req, "CB_No"));
             
            message = "更新特殊福利";

            cbcrdb.Delete(model.CB_No);//删除原有的记录
            var arrstr = Common.Constants.getReqValue(req, "WT_No");
            string TSFL = ""; 
            string[] arr;
            if (arrstr != "")
            {
                arr = arrstr.Split(',');
                foreach (var cr in arr)
                {
                    if (cr.Trim() != "")
                    {
                        var tmpModel = new Model.TB_CG_SocialWelfareLink() { CT_CB_No = model.CB_No, CT_TC_No = Convert.ToInt32(cr) };
                        if (!cbcrdb.Exists(tmpModel))
                        {
                            cbcrdb.Add(tmpModel);
                            if (TSFL != "")
                            {
                                cbcrdb.Add2(tmpModel);
                                
                            }
                            else
                            {
                                cbcrdb.Add1(tmpModel);
                                TSFL = "11";
                            }
                            
                        }
                    }
                }
            }
            
            return Common.Constants.OK;

        }
        
        /*显示社保的相关信息*/   
        //public static int GetListMergeSocialPolicyDetail(HttpRequest req, ref string message, ref int id)
        //{
        //   int total = 0;
        //   int index = 0;

        //   string queryStr = "";
        //   string listStr = "";
        //   Model.TB_CG_CityBase queryModel = null;
        //   Model.TB_RC_Permission per = null;
        //   var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));

        //   tmp = Common.Constants.getReqValue(req, "numPerPage");
        //        int pagesize = Convert.ToInt32(tmp == "" ? "0" : tmp);
        //        tmp = Common.Constants.getReqValue(req, "pageNum");
        //        index = Convert.ToInt32(tmp == "" ? "1" : tmp);

        //        queryModel = new Model.TB_CG_CityBase();

        //        queryModel.CB_Name = Common.Constants.getReqValue(req, "CB_Name");

        //        //queryModel.SP_Mode = Common.Constants.getReqValue(Request, "SP_Mode");
        //        //queryModel.TI_Name = Common.Constants.getReqValue(Request, "TI_Name");
        //        //queryModel.TI_TalentClass = Common.Constants.getReqValue(Request, "TI_TalentClass");
        //        //queryModel.TI_Sex = Common.Constants.getReqValue(Request, "TI_Sex");
        //        //queryModel.TI_Src = Common.Constants.getReqValue(Request, "TI_Src");
        //        //queryModel.TI_Audition = Common.Constants.getReqValue(Request, "TI_Audition");
        //        //queryModel.TI_AuditionResult = Common.Constants.getReqValue(Request, "TI_AuditionResult");
        //        //queryModel.TI_FollowUpPeople = Common.Constants.getReqValue(Request, "TI_FollowUpPeople");
        //        //queryModel.TI_RecommendPost = Common.Constants.getReqValue(Request, "TI_RecommendPost");
        //        //queryModel.TI_Work = Common.Constants.getReqValue(Request, "TI_Work");
        //        //queryModel.TI_Recommend = Common.Constants.getReqValue(Request, "TI_Recommend");
        //        //queryModel.TI_Industry = Common.Constants.getReqValue(Request, "TI_Industry");
        //        //queryModel.TI_Mark = Common.Constants.getReqValue(Request, "TI_Mark");

        //        tmp = getQueryStr(queryModel);
        //        tmp += Common.Constants.getQueryStr(per.PM_Province);
        //        queryStr = tmp;
        //        total = cbdb.GetTotalMerge(tmp);
        //        listStr = GetListMergeSocialPolicyDetail1(pagesize, index, tmp, total);
            
        //}

        //protected string getQueryStr(Model.TB_CG_CityBase queryModel)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    var properties = TypeDescriptor.GetProperties(queryModel);
        //    foreach (PropertyDescriptor propertyDescriptror in properties)
        //    {
        //        var tmpValue = propertyDescriptror.GetValue(queryModel);
        //        if (tmpValue != null)
        //        {
        //            if (propertyDescriptror.PropertyType == typeof(string) && (tmpValue.ToString().Trim() != ""))
        //            {
        //                sb.Append(string.Format(" and {0} like '%{1}%' ", propertyDescriptror.Name, tmpValue));
        //            }
        //        }
        //    }
        //    return sb.ToString();
        //}

        //public string GetListMergeSocialPolicyDetail1(int pagesize, int index, string querystr, int total)
        //{
        //    int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
        //    if (itempager <= 0) return "";
        //    StringBuilder sb = new StringBuilder();
        //    List<Model.TB_CG_CityBase> list = cbdb.GetListMergeSocialPolicyDetail(pagesize, index, querystr, itempager);
        //    int itemindex = pagesize * (index - 1);
        //    foreach (var obj in list)
        //    {
        //        itemindex++;
        //        sb.Append("<tr><td>");
        //        sb.Append(itemindex);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_Mode);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_AVGBase);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_MAXBase);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_MINBase);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_CompanyParRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_PersonalParRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_CompanyWorkRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_PersonalWorkRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_CompanyBirthRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_PersonalInjuryRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_CompanyMedicalRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_PersonalMedicalRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_CompanySimulateRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_PersonalSimulateRatio);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_SocialDate);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_HealthDate);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_SocialAMDate);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_SocialData);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_SocialLocalPolicy);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_BusinessTransact);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_Remark1);
        //        sb.Append("</td><td>");
        //        sb.Append(obj.SP_DateTime);
        //        sb.Append("</td></tr>");
        //    }
        //    return sb.ToString();
        //}

        /*历史查询*/
        public static int SearchHistoryInfo(HttpRequest req, ref string message, ref int id)
        {
            string Str = "";
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "获取id失败，请重新选择更新";
                return Common.Constants.ERR;
            }

            string SP_Mode = Common.Constants.getReqValue(req, "SP_Mode");
            if (SP_Mode != "")
            {
                Str = Str + "and SP_Mode='" + SP_Mode +"'";
            }
            string SP_AVGBase = Common.Constants.getReqValue(req, "SP_AVGBase");
            if (SP_AVGBase != "")
            {
                Str = Str + "and SP_AVGBase='" + SP_AVGBase + "'";
            }
            string SP_MAXBase = Common.Constants.getReqValue(req, "SP_MAXBase");
            if (SP_MAXBase != "")
            {
                Str = Str + "and SP_MAXBase='" + SP_MAXBase + "'";
            }
            string SP_MINBase = Common.Constants.getReqValue(req, "SP_MINBase");
            if (SP_MINBase != "")
            {
                Str = Str + "and SP_MINBase='" + SP_MINBase + "'";
            }
            string SP_CompanyParRatio = Common.Constants.getReqValue(req, "SP_CompanyParRatio");
            if (SP_CompanyParRatio != "")
            {
                Str = Str + "and SP_CompanyParRatio='" + SP_CompanyParRatio + "'";
            }
            string SP_PersonalParRatio = Common.Constants.getReqValue(req, "SP_PersonalParRatio");
            if (SP_PersonalParRatio != "")
            {
                Str = Str + "and SP_PersonalParRatio='" + SP_PersonalParRatio + "'";
            }
            string SP_CompanyWorkRatio = Common.Constants.getReqValue(req, "SP_CompanyWorkRatio");
            if (SP_CompanyWorkRatio != "")
            {
                Str = Str + "and SP_CompanyWorkRatio='" + SP_CompanyWorkRatio + "'";
            }
            string SP_PersonalWorkRatio = Common.Constants.getReqValue(req, "SP_PersonalWorkRatio");
            if (SP_PersonalWorkRatio != "")
            {
                Str = Str + "and SP_PersonalWorkRatio='" + SP_PersonalWorkRatio + "'";
            }
            string SP_CompanyBirthRatio = Common.Constants.getReqValue(req, "SP_CompanyBirthRatio");
            if (SP_CompanyBirthRatio != "")
            {
                Str = Str + "and SP_CompanyBirthRatio='" + SP_CompanyBirthRatio + "'";
            }
            string SP_PersonalInjuryRatio = Common.Constants.getReqValue(req, "SP_PersonalInjuryRatio");
            if (SP_PersonalInjuryRatio != "")
            {
                Str = Str + "and SP_PersonalInjuryRatio='" + SP_PersonalInjuryRatio + "'";
            }
            string SP_CompanyMedicalRatio = Common.Constants.getReqValue(req, "SP_CompanyMedicalRatio");
            if (SP_CompanyMedicalRatio != "")
            {
                Str = Str + "and SP_CompanyMedicalRatio='" + SP_CompanyMedicalRatio + "'";
            }
            string SP_PersonalMedicalRatio = Common.Constants.getReqValue(req, "SP_PersonalMedicalRatio");
            if (SP_PersonalMedicalRatio != "")
            {
                Str = Str + "and SP_PersonalMedicalRatio='" + SP_PersonalMedicalRatio + "'";
            }
            string SP_CompanySimulateRatio = Common.Constants.getReqValue(req, "SP_CompanySimulateRatio");
            if (SP_CompanySimulateRatio != "")
            {
                Str = Str + "and SP_CompanySimulateRatio='" + SP_CompanySimulateRatio + "'";
            }
            string SP_PersonalSimulateRatio = Common.Constants.getReqValue(req, "SP_PersonalSimulateRatio");
            if (SP_PersonalSimulateRatio != "")
            {
                Str = Str + "and SP_PersonalSimulateRatio='" + SP_PersonalSimulateRatio + "'";
            }
            string SP_SocialDate = Common.Constants.getReqValue(req, "SP_SocialDate");
            if (SP_SocialDate != "")
            {
                Str = Str + "and SP_SocialDate='" + SP_SocialDate + "'";
            }
            string SP_HealthDate = Common.Constants.getReqValue(req, "SP_HealthDate");
            if (SP_HealthDate != "")
            {
                Str = Str + "and SP_HealthDate='" + SP_HealthDate + "'";
            }
            string SP_SocialAMDate = Common.Constants.getReqValue(req, "SP_SocialAMDate");
            if (SP_HealthDate != "")
            {
                Str = Str + "and SP_HealthDate='" + SP_HealthDate + "'";
            }
            string SP_SocialData = Common.Constants.getReqValue(req, "SP_SocialData");
            if (SP_SocialData != "")
            {
                Str = Str + "and SP_SocialData='" + SP_SocialData + "'";
            }
            string SP_SocialLocalPolicy = Common.Constants.getReqValue(req, "SP_SocialLocalPolicy");
            if (SP_SocialLocalPolicy != "")
            {
                Str = Str + "and SP_SocialLocalPolicy='" + SP_SocialLocalPolicy + "'";
            }
            string SP_BusinessTransact = Common.Constants.getReqValue(req, "SP_BusinessTransact");
            if (SP_BusinessTransact != "")
            {
                Str = Str + "and SP_BusinessTransact='" + SP_BusinessTransact + "'";
            }
            string SP_Remark1 = Common.Constants.getReqValue(req, "SP_Remark1");
            if (SP_Remark1 != "")
            {
                Str = Str + "and SP_Remark1='" + SP_Remark1 + "'";
            }
 
            cbdb.GetListHistory(Str);
            
             
            return Common.Constants.OK;

        }

        /*删除公司*/
        public static int DelTalentInfo(HttpRequest req, ref string message)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            if (tmp == "")
            {
                message = "公司编号未获取到";
                return Common.Constants.ERR;
            }
            var iT = Convert.ToInt32(tmp);
            cbdb.Delete(iT);
            cbcrdb.Delete(iT);
            
            message = "删除公司成功";
            return Common.Constants.OK;
        }

        public static int UpdateTalentInfoBasic(HttpRequest req, ref string message)
        {
            string tmp = Common.Constants.getReqValue(req, "CB_No");
            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(tmp));


            if (req.Files[0].ContentLength != 0)
            {
                System.Drawing.Image image = null;
                System.Drawing.Image hb = null;
                System.Drawing.Graphics g = null;
                try
                {
                    var tmpext = Common.Constants.GetFileExt(req.Files[0].FileName);
                    //req.Files[0].SaveAs(req.MapPath("../newImages") + "\\" + tparfs.TP_TeamImag);
                    string filedir = req.MapPath("newImages") + "\\";
                    string filename = tmp + "." + tmpext;
                    req.Files[0].SaveAs(filedir + filename);
                    image = System.Drawing.Image.FromFile(filedir + filename, false);
                    //System.Drawing.Image newimage = image.GetThumbnailImage(700, 400, null, new IntPtr());
                    double dVal = image.Width / 139.00;
                    hb = new System.Drawing.Bitmap(139, (int)(image.Height / dVal));//创建图片对象
                    g = System.Drawing.Graphics.FromImage(hb);//创建画板并加载空白图像
                    g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;//设置保真模式为高度保真
                    g.DrawImage(image, new Rectangle(0, 0, 139, (int)(image.Height / dVal)), 0, 0, image.Width, image.Height, GraphicsUnit.Pixel);//开始画图
                    //2013-10-15注释
                    //model.CB_Img = "sl." + filename;
                    //hb.Save(filedir + "\\" + model.CB_Img);
                }
                finally
                {
                    image.Dispose();
                    g.Dispose();
                    hb.Dispose();
                }
            }

            model.CB_X = Common.Constants.getReqValue(req, "CB_X");
            model.CB_Y = Common.Constants.getReqValue(req, "CB_Y");
            model.CB_Name = Common.Constants.getReqValue(req, "CB_Name");
            model.cb_shopnum = Common.Constants.getReqValue(req, "CB_Num");
            //tmp = Common.Constants.getReqValue(req, "CB_Num");
            //if (tmp != "") model.CB_Num = int.Parse(tmp);
            model.CB_Num = Common.Constants.getReqValue(req, "CB_Position");
            model.cb_setup = Common.Constants.getReqValue(req, "CB_SetUp");
            model.CB_Des = Common.Constants.getReqValue(req, "CB_Des");
            model.CB_Je = Common.Constants.getReqValue(req, "CB_Je");
 
            cbcrdb.Delete(model.CB_No);//删除原有的记录
            var arrstr = Common.Constants.getReqValue(req, "TC_No");
            string[] arr;
            if (arrstr != "")
            {
                arr = arrstr.Split(',');
                foreach (var cr in arr)
                {
                    if (cr.Trim() != "")
                    {
                        var tmpModel = new Model.TB_CG_SocialWelfareLink() { CT_CB_No = model.CB_No, CT_TC_No = Convert.ToInt32(cr) };
                        if (!cbcrdb.Exists(tmpModel))
                        {
                            cbcrdb.Add(tmpModel);
                        }
                    }
                }
            }

            cbdb.Update(model);

            message = "更新公司成功";
            return Common.Constants.OK;
        }

        public static int UpdateTalentInfoStudy(HttpRequest req, ref string message)
        {

            Model.TB_CG_CityBase model = cbdb.GetModel(Convert.ToInt32(Common.Constants.getReqValue(req, "CB_No")));
            //model.CB_Founder = Common.Constants.getReqValue(req, "CB_Founder");
            //model.CB_Advantage = Common.Constants.getReqValue(req, "CB_Advantage");
            //model.CB_OrgStructure = Common.Constants.getReqValue(req, "CB_OrgStructure");
            //model.CB_HumanSrc = Common.Constants.getReqValue(req, "CB_HumanSrc");
            cbdb.Update(model);
            message = "更新公司成功";
            return Common.Constants.OK;
        }



    /*    protected string GetTalentOption(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            sb.Append("<select  style=' margin:2px' name='TC_No' >");
            sb.Append("<option></option>");
            foreach(var td in arr)
            {
                if (td.TC_No == no)
                {
                    sb.Append("<option selected=selected value='" + td.TC_No + "'>" + td.TC_Class + "</option>");
                }
                else
                {
                    sb.Append("<option value='" + td.TC_No + "'>" + td.TC_Class + "</option>");
                }
            }
            sb.Append("</select>");
            return sb.ToString();
        }

        protected string GetTalentsPer(int CB_NO)
        {
            StringBuilder sb = new StringBuilder();
            var list = tidb.GetModelList(" TI_CB_No='" + CB_NO + "' ");
            foreach( var obj in list )
            {
                sb.Append("<tr target='sid_talent' rel='" + obj.TI_No + "'><td>");
                sb.Append(obj.TI_No + "<input name='TI_No' type='hidden' value='" + obj.TI_No + "' size='15' />");   
                sb.Append("</td><td>");
                sb.Append("<input name='TI_BrandName' class='textInput lgray'  value='" + obj.TI_BrandName + "' size='30' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_TalentClass' class='textInput lgray' value='" + obj.TI_TalentClass + "' size='25' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Name' class='textInput lgray' value='" + obj.TI_Name + "' size='25' />");
                sb.Append("</td><td>");
                sb.Append("<select name='TI_Sex'  class='textInput'><option></option><option value='男' " + (obj.TI_Sex == "男" ? "selected=selected" : "") + " >男</option><option value='女' " + (obj.TI_Sex == "女" ? "selected=selected" : "") + " >女</option></select>");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Phone' class='textInput lgray' size='15' value='" + obj.TI_Phone + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_Src' class='textInput lgray' size='15' value='" + obj.TI_Src + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_RecommendPost' class='textInput lgray' size='15' value='" + obj.TI_RecommendPost + "' />");
                sb.Append("</td><td>");
                sb.Append("<select name='TI_Audition'  class='textInput'><option></option><option value='是' " + (obj.TI_Audition == "是" ? "selected=selected" : "") + ">是</option><option value='否' " + (obj.TI_Audition == "否" ? "selected=selected" : "") + " >否</option></select>");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_AuditionResult' class='textInput lgray' size='15'  value='" + obj.TI_AuditionResult + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_FollowUpPeople' class='textInput lgray'  size='15' value='" + obj.TI_FollowUpPeople + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_MaintainDate' class='date textInput lgray'  size='15' value='" + (obj.TI_MaintainDate == null ? "" : obj.TI_MaintainDate.Value.ToString("yyyy-MM-dd")) + "' />");
                sb.Append("</td><td>");
                sb.Append("<input name='TI_MaintainResult' class='textInput lgray'  size='20'  value='" + obj.TI_MaintainResult + "' />");
                sb.Append("</td><td>");
                sb.Append("<a href='TalentInfo/TalentDocument.aspx?CB_No=" + CB_NO + "&TI_No=" + obj.TI_No + "' target='dialog' mask=true  rel='ducument_dia' title='' width='400' height='500'>简历管理</a>");
                sb.Append("</td></tr>");      
            }
            
            return sb.ToString();
        }

        */

        [WebMethod]
        public static string AddTalent(int CB_NO)
        {
            Model.TB_CG_SocialPolicyDetail talent = new Model.TB_CG_SocialPolicyDetail();
            talent.SP_No = CB_NO;
             
            StringBuilder sb = new StringBuilder();
            int i = tidb.Add(talent);
            sb.Append("<tr target='sid_talent' rel='" + i + "'><td>");
            sb.Append(i + "<input name='No' type='hidden' value='" + i + "' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_Area' class='textInput lgray' size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_Mode' class='textInput lgray' size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_AVGBase' class='textInput lgray' size='25' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_MAXBase'  class='textInput lgray' size='25' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_MINBase' class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_CompanyParRatio' class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_PersonalParRatio' class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_CompanyWorkRatio'  class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_PersonalWorkRatio' class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_CompanyBirthRatio' class='textInput lgray' size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_PersonalInjuryRatio' class='textInput lgray'  size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_CompanyMedicalRatio' class=' textInput lgray'  size='15' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_PersonalMedicalRatio' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_CompanySimulateRatio' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_PersonalSimulateRatio' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_SocialDate' class='date textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_HealthDate' class='date textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_SocialAMDate' class='date textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_SocialData' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_SocialLocalPolicy' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_BusinessTransact' class='textInput lgray'  size='20' />");
            sb.Append("</td><td>");
            sb.Append("<input name='SP_Remark1' class='textInput lgray'  size='20' />"); 
            sb.Append("</td></tr>");
            return "{\"flag\":\"true\",\"html\":\"" + sb.ToString() + "\"}";
        }

        [WebMethod]
        public static string DelTalent(int id)
        {
            tidb.Delete(id);
            return "{\"flag\":\"true\",\"html\":\"删除成功\"}";
        }
    }
}