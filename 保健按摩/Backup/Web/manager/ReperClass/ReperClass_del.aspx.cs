using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperClass
{
    public partial class ReperClass_del : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }
            string id = Request.QueryString["id"].ToString();
            DataTable dt = RC.GetList("id = " + id).Tables[0];
            if (int.Parse(dt.Rows[0]["SubNum"].ToString()) > 0)
            {
                
                Response.Redirect("ReperClass_List.aspx?delmsg=1");
            }
            else
            {
                RC.UpdateDel(int.Parse(dt.Rows[0]["parentID"].ToString()));
                RC.Delete(int.Parse(id));
                Response.Redirect("ReperClass_List.aspx");
            }
        }
    }
}