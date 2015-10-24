using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.manager
{
    public partial class usermod : System.Web.UI.Page
    {
        EPReper.BLL.Manager Manager = new BLL.Manager();
        EPReper.Model.Manager manager = new Model.Manager();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"].ToString();
                manager = Manager.GetModel(Convert.ToInt32(id));
                username.Value = manager.UserName;
                phonenum.Value = manager.phonenum;
                //works.Value = manager.works;
                states.Value = manager.states;
                reper.Value = manager.repair;
                selerol();
                if (manager.isAdmin == 1)
                {
                    admin.Checked = true;
                }
                else
                {
                    admin.Checked = false;
                }
                //string[] re = manager.repair.Split(',');
                //for (int i = 0; i < re.Length; i++)
                //{
                //    int j = Convert.ToInt32(re[i]);
                //    URole.Items[1].Selected=true;
                //}

            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            manager.id = Request.QueryString["id"].ToString();
            manager.UserName = username.Value;
            manager.works ="0";
            manager.states = states.Value;
            if (admin.Checked)
            {
                manager.isAdmin = 1;
            }
            else
            {
                manager.isAdmin = 0;
            }
            manager.phonenum = phonenum.Value;
            string chkSelect = "";
            //for (int i = 0; i < URole.Items.Count; i++)
            //{
            //    if (URole.Items[i].Selected == true)
            //        chkSelect += URole.Items[i].Value + ",";
            //}
            chkSelect = reper.Value;
            manager.repair = chkSelect;

            Manager.Update(manager);



            Response.Redirect("user_list.aspx");
        }

        protected void selerol()
        {
            string str = "<table border='0' >";


            DataTable dt = RC.GetList(" parentID = 0 and isDel = 0 ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    str += "<tr><td><input id='URole" + dt.Rows[i]["id"] + "' name='ro' value='" + dt.Rows[i]["id"] + "' type='checkbox' /><label >" + dt.Rows[i]["classname"] + "</label></td></tr>";
                }
            }
            str += "</table>";
            URole.InnerHtml = str;
        }
        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("../ReperInfo/ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("../ReperClass/ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("user_list.aspx");
        }

        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }
    }
}