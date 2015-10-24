using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class RI_Show_Dal : System.Web.UI.Page
    {
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        string userid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            }
            else
            {
                Response.Redirect("../../login.aspx");
            }
            //userid = "24"; 
            string id = Request.QueryString["id"].ToString();
            string classid = Request.QueryString["ClassID"].ToString();

            string classname = "";
            string parentid = "";


            do
            {
                DataTable dtc = RC.GetList("id = " + classid).Tables[0];
                classname = dtc.Rows[0]["classname"].ToString() + "->" + classname;
                parentid = dtc.Rows[0]["ParentID"].ToString();
                classid = parentid;
            }
            while (!parentid.Equals("0"));
            cn.InnerHtml = classname.Substring(0, classname.Length - 2);


            DataTable dt = RI.GetList("id =" + id).Tables[0];
            if (Request.QueryString["isrepair"] != null)
            {
                if (EPReper.Model.Reper.isReper == 1)
                {
                    if (!dt.Rows[0]["Finish"].ToString().Equals("2"))
                    {
                        Save.Visible = true;
                    }
                }
            }
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                //mulu.Visible = true;
                //renyuan.Visible = true;

            }
            if (Manager.GetList("username like'" + username + "' and isAdmin = 0").Tables[0].Rows.Count > 0)
            {
                //repair.Visible = true;

            }
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    DataTable dtuser = UI.GetInfo("CN_ID = " + dt.Rows[0]["Userid"].ToString());
                    userName.Text = dtuser.Rows[0]["CN_LOGIN"].ToString();
                    dep.Text = dtuser.Rows[0]["CN_DEPTINFO"].ToString();
                    phone.Text = dtuser.Rows[0]["CN_O_PHONE"].ToString();
                    startComment.Text = dt.Rows[0]["StartComment"].ToString();
                    times.Text = dt.Rows[0]["Times"].ToString();
                }
            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"].ToString();
            //string reperid = "";
            //得到维修人员ID
            string reperid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            string classid = Request.QueryString["ClassID"].ToString();
            string repername = UI.GetInfo("CN_ID = " + reperid).Rows[0]["CN_LOGIN"].ToString();
            string repairphone = Manager.GetList("username = '" + repername + "'").Tables[0].Rows[0]["phonenum"].ToString();

            RI.UpdateDal(id, reperid, repairphone);
            Response.Redirect("../../index.aspx?Finish="+Request.QueryString["Finish"]+"&FinishRepair="+Request.QueryString["FinishRepair"]+"");
            //Response.Redirect("Repair.aspx?ClassID="+classid);
        }

        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("../ReperClass/ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("../manager/user_list.aspx");
        }
        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }
        protected void rep(object sender, EventArgs e)
        {
            Response.Redirect("Repair.aspx");
        }
    }
}