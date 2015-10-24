using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class ReperInfo : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string userid = "";
        string sec = "";
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
                //mulu.Visible = true;
                //renyuan.Visible = true;
                admins.Visible = true;

            }
            if (Manager.GetList("username like'" + username + "' and isAdmin = 0").Tables[0].Rows.Count > 0)
            {
                //repair.Visible = true;                

            }
            if (Request.QueryString["type"] != null)
            {
                sec = Request.QueryString["type"].ToString();
            }



            string parentID = Request.QueryString["parentID"];
            if (parentID == string.Empty || parentID == null)
            {
                parentID = "parentID = 0";
            }
            else
            {
                parentID = "parentID = " + parentID;
            }

            DataTable dt = RC.GetTable(100, parentID + " and isDel = 0 ", " orderNum ");

            string infoStr = "";

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    //infoStr += "<table width=\"100%\" bgcolor=\"#FFFFFF\" style=\"background: #E4F3FC\" class=\"table\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\">";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        //infoStr += "<tr class=\"TR_BG_list\" width=\"100%\">";
                        //infoStr += "<td width=\"100px\">";
                        infoStr += "<ul>";
                        //infoStr += "<li style=\"background-image: url('" + dt.Rows[i]["pic"].ToString() + "'); background-position: bottom;background-repeat: repeat-x; width: 100px; height: 100px; \">";
                        //infoStr += "<img src=\"" + dt.Rows[i]["pic"].ToString() + "\"/>";

                        if (sec.Equals("select"))
                        {
                            baoxiu.Visible = false;
                            chaxun.Visible = true;
                            da.InnerHtml = "<font style=\"font-size: 20px;font-family:微软雅黑;\">维修任务查询</font>";
                            infoStr += "<li onmouseover=\"this.className='li_mouseover'\" onmouseout=\"this.className='li_mouseout'\" >";
                            infoStr += "<a href=\"ShowRI.aspx?bigid=" + dt.Rows[i]["id"] + "\"><img alt=\"\" src=\"" + dt.Rows[i]["pic"].ToString() + "\"  height=\"40px\" style=\"border:0px\"/></a>";
                            infoStr += "<a href=\"ShowRI.aspx?bigid=" + dt.Rows[i]["id"] + "\"><font style=\"font-size: 13px; font-family: 微软雅黑\">查询" + dt.Rows[i]["classname"] + "</font></a></li>";
                        }
                        else
                        {
                            infoStr += "<li style=\"text-align: left;\">";//onmouseover=\"this.className='li_mouseover'\" onmouseout=\"this.className='li_mouseout'\" >";
                            //infoStr += "<a><img alt=\"\" src=\"" + dt.Rows[i]["pic"].ToString() + "\"  height=\"40px\"/></a>";
                            infoStr += "<a style=\"padding-top: 20px;text-align: left;\"><font style=\"font-size: 16px; font-family: 微软雅黑;\">" + dt.Rows[i]["classname"].ToString() + "类：</font></a></li>";
                        }
                        //infoStr += "</ul>";
                        //infoStr += "</td>";
                        DataTable dts = RC.GetList("parentID = " + dt.Rows[i]["id"].ToString() + " and isDel = 0").Tables[0];
                        if (dts != null)
                        {
                            if (dts.Rows.Count > 0)
                            {
                                for (int j = 0; j < dts.Rows.Count; j++)
                                {
                                    //infoStr += "<td width=\"100px\">";
                                    //infoStr += "<ul>";
                                    infoStr += "<li onmouseover=\"this.className='li_mouseover'\" onmouseout=\"this.className='li_mouseout'\">";// onmousedown=\"this.className='btn3_mousedown'\" onmouseup=\"this.className='btn3_mouseup'\">";
                                    //infoStr += "<li style=\"background-image: url('" + dts.Rows[j]["pic"].ToString() + "'); background-position: bottom;background-repeat: repeat-x; width: 100px; height: 100px; \">";
                                    if (sec.Equals("select"))
                                    {
                                        infoStr += "<a href=\"ShowRI.aspx?classid=" + dts.Rows[j]["id"] + "\"><img alt=\"\" src=\"" + dts.Rows[j]["pic"].ToString() + "\"  height=\"40px\" style=\"border:0px\"/></a>";
                                        infoStr += "<a href=\"ShowRI.aspx?classid=" + dts.Rows[j]["id"] + "\"><font style=\"font-size: 13px; font-family: 微软雅黑\">查询" + dts.Rows[j]["classname"] + "</font></a></li>";
                                    }
                                    else
                                    {
                                        infoStr += "<a href=\"Reper_add.aspx?bigid=" + dt.Rows[i]["id"] + "&id=" + dts.Rows[j]["id"] + "\"><img alt=\"\" src=\"" + dts.Rows[j]["pic"].ToString() + "\"  height=\"40px\" style=\"border:0px\"/></a>";
                                        infoStr += "<a href=\"Reper_add.aspx?bigid=" + dt.Rows[i]["id"] + "&id=" + dts.Rows[j]["id"] + "\"><font style=\"font-size: 13px; font-family: 微软雅黑\">" + dts.Rows[j]["classname"].ToString() + "</font></a></li>";
                                    }
                                    //infoStr += "</ul>";
                                    //infoStr += "</td>";
                                }
                            }
                        }
                        //infoStr += "</tr>";
                        infoStr += "</ul>";
                    }
                    //infoStr += "</table>";
                }
            }
            //if (dt != null)
            //{
            //    if (dt.Rows.Count > 0)
            //    {
            //        infoStr += "<ul>";
            //        for (int i = 0; i < dt.Rows.Count; i++)
            //        {
            //            int k = 0;
            //            if (i == 0)
            //            {
            //                k = 1;
            //            }
            //            else
            //            {
            //                k = i;
            //            }
            //            if ((i + 1) % 3 != 0)
            //            {
            //                infoStr += "<li>";
            //            }
            //            else
            //            {
            //                infoStr += "<li style=\"margin-right:0;\">";
            //            }
            //            if (sec.Equals("select"))
            //            {
            //                infoStr += "<a href=\"ShowRI.aspx?classid=" + dt.Rows[i]["id"] + "\">查询" + dt.Rows[i]["classname"] + "</a></li>";
            //            }
            //            else
            //            {
            //                if (int.Parse(dt.Rows[i]["SubNum"].ToString()) > 0)
            //                {
            //                    infoStr += "<a href=\"ShowRI_List.aspx?bigid=" + dt.Rows[i]["id"] + "&ClassID=" + dt.Rows[i]["id"] + "\">" + dt.Rows[i]["classname"] + "</a></li>";
            //                }
            //                else
            //                {
            //                    infoStr += "<a href=\"Reper_add.aspx?bigid=" + dt.Rows[i]["id"] + "&id=" + dt.Rows[i]["id"] + "\">" + dt.Rows[i]["classname"] + "</a></li>";
            //                }
            //            }
            //        }
            //        infoStr += "</ul>";
            //    }
            //}
            ClassView.InnerHtml = infoStr;
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