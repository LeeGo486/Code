using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Talent.Web.TalentInfo
{
    public partial class TalentStudy : System.Web.UI.Page
    {
        private static BLL.TB_RC_CompanyBasic cbdb = new BLL.TB_RC_CompanyBasic();
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected Model.TB_RC_CompanyBasic model = null;

        protected Model.TB_RC_Permission per = null;

        protected void Page_Load(object sender, EventArgs e)
        {
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
                }
            }
        }
    }
}