using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Talent.Web.TalentClass
{
    public partial class EditTalentClass : System.Web.UI.Page
    {
        private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            string tmp = Common.Constants.getReqValue(Request, "TC_No");
            if (tmp != "")
            {
                var model = tcdb.GetModel(Convert.ToInt32(tmp));
                if (model != null)
                {
                    TC_No.Value = model.TC_No.ToString();
                    TC_Class.Value = model.TC_Class;
                    TC_Color.Value = model.TC_Color;
                }
            }
        }
    }
}