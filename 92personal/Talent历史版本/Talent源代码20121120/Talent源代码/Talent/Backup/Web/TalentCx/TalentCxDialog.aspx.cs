using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Talent.Web.TalentCx
{
    public partial class TalentCxDialog : System.Web.UI.Page
    {
        private static BLL.TB_RC_TalentClass tcdb = new BLL.TB_RC_TalentClass();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static string GetTalentOption()
        {
            var arr = tcdb.GetModelList("");
            StringBuilder sb = new StringBuilder();
            sb.Append("<select  name='TI_TalentClass' >");
            sb.Append("<option></option>");
            foreach (var td in arr)
            {
                sb.Append("<option value='" + td.TC_Class + "'>" + td.TC_Class + "</option>");
            }
            sb.Append("</select>");
            return sb.ToString();
        }
    }
}