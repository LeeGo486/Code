using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Talent.Web.TalentInfo
{
    public partial class SocialWelfare : System.Web.UI.Page
    {

        //private static BLL.TB_RC_CompanyBasic cbdb = new BLL.TB_RC_CompanyBasic();

        private static BLL.TB_CG_CityBase cbdb = new BLL.TB_CG_CityBase();

        private static BLL.TB_CG_WelfarePolicyType tcdb = new BLL.TB_CG_WelfarePolicyType();

        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected Model.TB_CG_CityBase model = null;

        protected string selectstr3 = "";
        protected string selectstr4 = "";

        protected Model.TB_RC_Permission per = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            int count = 0;
            if (!IsPostBack)
            {
                var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (tmp == "") per = new Model.TB_RC_Permission();
                else
                    per = pidb.GetModel(tmp);

                string CB_No = Common.Constants.getReqValue(Request, "CB_No");
                if (CB_No == "") model = new Model.TB_CG_CityBase();
                else
                {
                    model = cbdb.GetModel(int.Parse(CB_No));
                    if (model != null)
                    {
                        var list = tcdb.GetModelListByRelate(CB_No);
                        foreach (var tc in list)
                        {

                            if (per.PM_Level >= 1)
                            {
                                if (count < 2)
                                    selectstr3 += GetTalentOption(tc.WT_No);
                                else
                                    selectstr4 += GetTalentOption(tc.WT_No);
                            }
                            else
                            {
                                if (count < 2)
                                    selectstr3 += GetTalentOptionReadonly(tc.WT_No);
                                else
                                    selectstr4 += GetTalentOptionReadonly(tc.WT_No);
                            }
                            count++;
                        }

                        for (int i = count; i < 2; i++)
                        {
                            if (per.PM_Level >= 1)
                            {
                                if (i < 2)
                                    selectstr3 += GetTalentOption(-1);
                                else
                                    selectstr4 += GetTalentOption(-1);
                            }
                            else
                            {
                                if (i < 2)
                                    selectstr3 += GetTalentOptionReadonly(-1);
                                else
                                    selectstr4 += GetTalentOptionReadonly(-1);
                            }
                        }
                    }
                    else model = new Model.TB_CG_CityBase();
                }
            }
        }

        protected string GetTalentOption(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            sb.Append("<select  style=' margin:2px' name='WT_No' >");
            sb.Append("<option></option>");
            foreach (var td in arr)
            {
                if (td.WT_No == no)
                {
                    sb.Append("<option selected=selected value='" + td.WT_No + "'>" + td.WT_WPType + "</option>");
                }
                else
                {
                    sb.Append("<option value='" + td.WT_No + "'>" + td.WT_WPType + "</option>");
                }
            }
            sb.Append("</select>");
            return sb.ToString();
        }

        protected string GetTalentOptionReadonly(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            foreach (var td in arr)
            {
                if (td.WT_No == no)
                {
                    sb.Append("<span style='margin:2px;' >" + td.WT_WPType + "</span>");
                }
            }
            return sb.ToString();
        }
    }
}