using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace EPReper.Web.manager.ReperClass
{
    public partial class ReperClass_add : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.Model.ReperClass rc = new Model.ReperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }
            DirectoryInfo imagesfile = new DirectoryInfo(Server.MapPath("../../Images/ico"));
            DataList1.DataSource = imagesfile.GetFiles("*.png");
            DataList1.DataBind();
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string picname = pic1.Value;
            string classpic = "../../Images/ico/" + picname;
            int parentID = 0;
            string classname = txtname.Text;
            if (Request.QueryString["ParentID"] != null)
            {
                parentID = int.Parse(Request.QueryString["ParentID"].ToString());
                if (RC.GetList("parentID = " + parentID + " and classname like '" + classname + "'").Tables[0].Rows.Count > 0)
                {
                    Session["ClassMsg"] = "该目录已经存在！";
                    Response.Redirect("ReperClass_List.aspx");
                }
                RC.Update(parentID);
            }
            if (RC.GetList("parentID = " + parentID + " and classname like '" + classname + "'").Tables[0].Rows.Count > 0)
            {
                Session["ClassMsg"] = "该目录已经存在！";
                Response.Redirect("ReperClass_List.aspx");
            }

            rc.pic = classpic;
            rc.classname = classname;
            rc.parentID = parentID;
            RC.Add(rc);
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