using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class SelectShow : System.Web.UI.Page
    {
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
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


            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                admins.Visible = true;
            }
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
            string id = Request.QueryString["id"].ToString();
            DataTable dt = RI.GetList("id =" + id).Tables[0];
            //if (Request.QueryString["isrepair"] != null)
            //{
            //    if (EPReper.Model.Reper.isReper == 1)
            //    {
            //        if (!dt.Rows[0]["Finish"].ToString().Equals("2"))
            //        {
            //            Save.Visible = true;
            //        }
            //    }
            //}
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    DataTable dtuser = new DataTable();
                    dtuser = UI.GetInfo("CN_ID = " + dt.Rows[0]["Userid"].ToString());
                    userName.Text = dtuser.Rows[0]["CN_LOGIN"].ToString();
                    dep.Text = dtuser.Rows[0]["CN_DEPTINFO"].ToString();
                    phone.Text = dt.Rows[0]["applyphone"].ToString();

                    string reperid = dt.Rows[0]["ReperID"].ToString();
                    if (reperid != "" && reperid != null)
                    {
                        dtuser = UI.GetInfo("CN_ID = " + reperid);
                        repername.Text = dtuser.Rows[0]["CN_LOGIN"].ToString();
                        reperphone.Text = dt.Rows[0]["repairphone"].ToString();
                    }
                    else
                    {
                        repername.Text = "";
                        reperphone.Text = "";
                    }

                    startComment.Text = dt.Rows[0]["StartComment"].ToString();
                    if (!IsPostBack)
                    {
                        overComment.Text = dt.Rows[0]["OverComment"].ToString();
                    }
                    uptime.Text = Convert.ToDateTime(dt.Rows[0]["uptime"].ToString()).ToString("yyyy/MM/dd hh:mm:ss");
                    string otime = dt.Rows[0]["overtime"].ToString();
                    if (otime != "" && otime != null)
                    {
                        overtime.Text = Convert.ToDateTime(otime).ToString("yyyy/MM/dd hh:mm:ss");
                    }
                    string ttime = dt.Rows[0]["Times"].ToString();
                    if (ttime != null && ttime != "")
                    {
                        times.Text = Convert.ToDateTime(ttime).ToString("yyyy/MM/dd hh:mm:ss");
                    }
                    string isdel = dt.Rows[0]["isdel"].ToString();
                    if (isdel == "1")
                    {
                        state.Text = "已取消";
                    }
                    else
                    {
                        string finish = dt.Rows[0]["finish"].ToString();
                        if (finish == "0")
                        {
                            state.Text = "未接受";
                        }
                        else if (finish == "1")
                        {
                            state.Text = "已接受";
                        }
                        else
                        {
                            state.Text = "已完成";
                        }
                    }
                }
            }
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