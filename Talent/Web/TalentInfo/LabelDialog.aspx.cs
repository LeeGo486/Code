using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Talent.Model;

namespace Talent.Web.TalentInfo
{
    public partial class LabelDialog : System.Web.UI.Page
    {
        private static BLL.TB_RC_Permission pidb = new BLL.TB_RC_Permission();

        protected  Model.TB_RC_Permission  per = new TB_RC_Permission();
        protected void Page_Load(object sender, EventArgs e)
        {
            var tmp = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (tmp == "") per = new Model.TB_RC_Permission();
            else  {  
                per = pidb.GetModel(tmp);
                if(per == null ) per = new Model.TB_RC_Permission();
            }
        }
    }
}