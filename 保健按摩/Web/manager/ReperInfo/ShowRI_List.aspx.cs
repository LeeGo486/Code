using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class ShowRI_List : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string userid = "";
        string classid = "";
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
            string bigid = Request.QueryString["bigid"].ToString();
            Tools.CookieHelper.SaveCookie("bigid", bigid, 1);
            //userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            //userid = "24";
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                mulu.Visible = true;
                renyuan.Visible = true;

            }
            if (Manager.GetList("username like'" + username + "' and isAdmin = 0").Tables[0].Rows.Count > 0)
            {
                repair.Visible = true;

            }
            classid = Request.QueryString["ClassID"].ToString();
            {
                string parentID = classid; ;

                parentID = "parentID = " + parentID;

                DataTable dtv = RC.GetTable(100, parentID + " and isDel = 0 ", " orderNum ");
                string infoStr = "";
                if (dtv != null)
                {
                    if (dtv.Rows.Count > 0)
                    {
                        infoStr += "<ul>";
                        for (int i = 0; i < dtv.Rows.Count; i++)
                        {
                            int k = 0;
                            if (i == 0)
                            {
                                k = 1;
                            }
                            else
                            {
                                k = i;
                            }
                            if ((i + 1) % 3 != 0)
                            {
                                infoStr += "<li>";
                            }
                            else
                            {
                                infoStr += "<li style=\"margin-right:0;\">";
                            }

                            if (int.Parse(dtv.Rows[i]["SubNum"].ToString()) > 0)
                            {
                                infoStr += "<a href=\"ShowRI_List.aspx?bigid=" + bigid + "&ClassID=" + dtv.Rows[i]["id"] + "\">" + dtv.Rows[i]["classname"] + "</a></li>";
                            }
                            else
                            {
                                infoStr += "<a href=\"Reper_add.aspx?bigid=" + bigid + "&id=" + dtv.Rows[i]["id"] + "\">" + dtv.Rows[i]["classname"] + "</a></li>";
                            }
                        }
                        infoStr += "</ul>";
                    }
                }
                ClassView.InnerHtml = infoStr;
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
            Response.Redirect("ShowRI.aspx");
        }
        protected void rep(object sender, EventArgs e)
        {
            Response.Redirect("Repair.aspx");
        }
    }
}