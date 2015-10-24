using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Talent.Web.TalentInfo
{
    public partial class TalentBasic : System.Web.UI.Page
    {

        private static BLL.TB_RC_CompanyBasic cbdb = new BLL.TB_RC_CompanyBasic();
        private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected Model.TB_RC_CompanyBasic model = null;
        protected string selectstr = "";
        protected string selectstr2 = "";

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
                if (CB_No == "") model = new Model.TB_RC_CompanyBasic();
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
                                if (count<5)
                                    selectstr += GetTalentOption(tc.TC_No);
                                else
                                    selectstr2 += GetTalentOption(tc.TC_No);
                            }
                            else
                            {
                                if (count <5)
                                    selectstr += GetTalentOptionReadonly(tc.TC_No);
                                else
                                    selectstr2 += GetTalentOptionReadonly(tc.TC_No);
                            }
                            count++;
                        }
                        for (int i = count; i < 10; i++)
                        {
                            if (per.PM_Level >= 1)
                            {
                                if(i<5)
                                    selectstr += GetTalentOption(-1);
                                else
                                    selectstr2 += GetTalentOption(-1);  
                            }
                            else
                            {
                                if(i<5)
                                    selectstr += GetTalentOptionReadonly(-1);
                                else
                                    selectstr2 += GetTalentOptionReadonly(-1);
                            }
                        }
                    }
                    else model = new Model.TB_RC_CompanyBasic();
                }
            }
        }

        protected string GetTalentOption(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            sb.Append("<select  style=' margin:2px' name='TC_No' >");
            sb.Append("<option></option>");
            foreach (var td in arr)
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

        protected string GetTalentOptionReadonly(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            foreach (var td in arr)
            {
                if (td.TC_No == no)
                {
                    sb.Append("<span style='margin:2px;' >" + td.TC_Class + "</span>");
                }
            }
            return sb.ToString();
        }
    }
}