﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

namespace Talent.Web.TalentInfo
{
    public partial class ReportTalent : System.Web.UI.Page
    {
        private static BLL.TB_RC_CompanyBasic cbdb = new BLL.TB_RC_CompanyBasic();
        private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();

        protected Model.TB_RC_CompanyBasic model = null;
        protected string selectstr = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            int count = 0;
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
                            selectstr += GetTalentOptionReadonly(tc.TC_No);
                        }
                        /*for (int i = count; i < 10; i++)
                        { 
                            selectstr += GetTalentOptionReadonly(-1);
                        }*/
                    }
                    else model = new Model.TB_RC_CompanyBasic();
                }
            }

        }

        protected string GetTalentOptionReadonly(int no)
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            foreach (var td in arr)
            {
                if (td.TC_No == no)
                {
                    sb.Append("<span style='margin:2px;' >" + td.TC_Class + ",</span>");
                }
            }
            return sb.ToString();
        }

        public static StringWriter ReportTalentWord(string CB_No)
        {
            StringWriter sw = new StringWriter();
            HttpContext.Current.Server.Execute("TalentInfo/ReportTalent.aspx?CB_NO=" + CB_No, sw);
            return sw;
        }
    }
}