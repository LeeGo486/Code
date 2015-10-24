using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Talent.Web.Authority
{
    public partial class EditAuthority : System.Web.UI.Page
    {
        private static BLL.TB_CG_Permission permissiondb = new BLL.TB_CG_Permission();


        protected Model.TB_CG_Permission model = null;
        protected string checkboxlist = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            var PM_No = Common.Constants.getReqValue(Request, "PM_No");
            if (PM_No == "")
            {
                model = new Model.TB_CG_Permission();
                checkboxlist = Common.Constants.getCheckbox((model.PM_Province == null ? "" : model.PM_Province));
            }
            else
            {
                model = permissiondb.GetModel(Convert.ToInt32(PM_No));
                if (model == null)
                {
                    model = new Model.TB_CG_Permission();
                    checkboxlist = Common.Constants.getCheckbox((model.PM_Province == null ? "" : model.PM_Province));
                }
                else
                {
                    checkboxlist = Common.Constants.getCheckbox((model.PM_Province == null ? "" : model.PM_Province));
                }
            }
        }
    }
}