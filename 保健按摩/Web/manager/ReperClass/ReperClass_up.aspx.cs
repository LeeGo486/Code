using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

namespace EPReper.Web.manager.ReperClass
{
    public partial class ReperClass_up : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.Model.ReperClass rc = new Model.ReperClass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }
            id = Request.QueryString["id"].ToString();
            if (!IsPostBack)
            {
                DataTable dt = RC.GetList(" id = " + id).Tables[0];
                txtname.Text = dt.Rows[0]["classname"].ToString();
            }
            DirectoryInfo imagesfile = new DirectoryInfo(Server.MapPath("../../Images/ico"));
            DataList1.DataSource = imagesfile.GetFiles("*.png");
            DataList1.DataBind();
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string picname = pic1.Value;
            string classpic = "../../Images/ico/" + picname;
            rc.id = int.Parse(id);
            rc.classname = txtname.Text;
            rc.pic = classpic;
            RC.Update(rc);
            Response.Redirect("ReperClass_List.aspx");
        }
        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("../ReperInfo/ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("../manager/user_list.aspx");
        }
        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }
    }
}