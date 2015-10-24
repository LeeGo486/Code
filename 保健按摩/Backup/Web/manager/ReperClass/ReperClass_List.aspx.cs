using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using System.Text;

namespace EPReper.Web.manager.ReperClass
{
    public partial class ReperClass_List : System.Web.UI.Page
    {

        EPReper.BLL.ReperClass RC = new EPReper.BLL.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string userid = "";
        int px = 5;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["delmsg"] != null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "错误消息", "<script>alert('该目录下还存在子目录，请先删除子目录！');</script>");
            }
            //userid = "24";
            
            
            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            }
            else
            {
                Response.Redirect("../../login.aspx");
            }
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "'") == null)
            {
                Response.Redirect("../ReperInfo/ReperInfo.aspx");
            }


            DataTable dt = RC.GetList(" ParentID = 0 and isDel = 0").Tables[0];
            divHtml.InnerHtml = CreateHtmlTask(dt);
            this.PageNavigator1.OnPageChange += new PageChangeHandler(PageNavigator1_PageChange);
            if (!IsPostBack)
            {
                if (Session["pagesize"] == null)
                {
                    Session["pagesize"] = EPReper.Config.UIConfig.PageSize;
                }
                if (Session["pageindex"] == null)
                {
                    Session["pageindex"] = 1;
                }
                DropDownList1.SelectedValue = Tools.CookieHelper.GetCookie("pagesize");

                StartLoad(1, "ParentID =0 and isDel = 0");

            }

        }
        protected void PageNavigator1_PageChange(object sender, int PageIndex)
        {
            Session["pageindex"] = PageIndex;
            StartLoad(PageIndex, "");
        }
        //数据初始化
        protected void StartLoad(int PageIndex, string sqlWhere)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);  //清除缓存。。。
            //获取相关参数信息
            string UserName = "";
            string urole = "";
            int uroleid = 0;
            /*string LoginURL = EPReper.Config.UIConfig.LoginURL;

            if (Tools.CookieHelper.GetCookie("username") != null || Tools.CookieHelper.GetCookie("urole") != null)
            {
                UserName = Tools.CookieHelper.GetCookie("username").ToString();
                urole = Tools.CookieHelper.GetCookie("urole").ToString();
            }
            else
            {
                Response.Redirect(LoginURL);
                return;
            }*/
            int RecordCount = 0, PageCount = 0;
            int PageSize = Convert.ToInt32(Session["pagesize"]);
            DropDownList1.SelectedValue = PageSize.ToString();
            DataTable dt = new DataTable();
            //string sWhere = "ApplicatID='李应斌'";

            if (sqlWhere == string.Empty || sqlWhere == null)
            {
                sqlWhere = "1=1 and isDel=0";
            }

            //分页函数
            dt = RC.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);

            //获取分页信息

            if (RecordCount % PageSize == 0)
            {
                PageCount = RecordCount / PageSize;
            }
            else
            {
                PageCount = RecordCount / PageSize + 1;
            }

            //
            if (dt != null)
            {
                this.PageNavigator1.PageCount = PageCount;//共多少页
                this.PageNavigator1.PageIndex = PageIndex; //当前页数
                this.PageNavigator1.RecordCount = RecordCount;//共多少条记录
            }
            //string tbhead = "任务来源,完成时间,申请人,任务名称,任务描述,任务接受人,任务状态,计划交付时间,更新时间,更新人,链接";
            //string[] TableHead = tbhead.Split(',');


            divHtml.InnerHtml = CreateHtmlTask(dt);
            //divNavigator.InnerHtml = tbhtml.CreateHtmlNavigator();
            dt = null;


        }

        public string CreateHtmlTask(DataTable dt)
        {
            
            StringBuilder sb = new StringBuilder();

            //sb.Append("<table border='0' bgcolor='#ffffff' style='backguound:#e4f3fc' class='table' >");
            sb.Append("<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0' class='table' >");
            sb.Append("<tr class='TR_BG'>");
            //sb.Append("<td align='center' valign='middle' class='sysmain_navi'><input name='Checkboxc' type='checkbox' onclick='javascript:selectAll(this.form,this.checked);' /></td>");
            sb.Append("<td align='center' valign='middle' class='sysmain_navi'></td>");
            sb.Append("<td align='center' valign='middle' class='sysmain_navi'>类名</td>");
            sb.Append("<td align='center' valign='middle' class='sysmain_navi'>操作</td>");
            sb.Append("</tr>");

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {                    
                    sb.Append("<tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>");
                    //sb.Append("<td align='center' valign='middle' class='sysmain_navi' width='5px'><input name='chkSelected' type='checkbox' value='" + dt.Rows[i]["id"].ToString().Trim().ToString() + "'/></td>");
                    sb.Append("<td align='center' valign='middle' class='sysmain_navi' width='5px'></td>");
                    //tempchar = dt.Rows[i].ToString().Trim().ToString().Replace("<p>", "").Replace("</p>", "\n").Replace("<br />", "\n");
                    if (int.Parse(dt.Rows[i]["SubNum"].ToString()) > 0)
                    {                        
                        sb.Append("<td align='left' valign='middle' height='15' >");
                        sb.Append("&nbsp; <img src='../../Images/b.gif' style='cursor:hand' onclick=\"SwitchImg(this,'trid" + dt.Rows[i]["id"].ToString().Trim().ToString() + "');\" border='0'>");       
                        // sb.Append(@" <span id='" + dt.Rows[i]["id"].ToString().Trim().ToString() + "'   title='"
                        //    + Regex.Replace(tempchar, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase) + "'>");
                    }
                    else
                    {
                        sb.Append("<td align='left' valign='middle' height='15' >");
                        sb.Append("&nbsp; <img src='../../Images/s.gif' style='cursor:pointer;' alt='没有子任务' border='0' class='LableItem' />");
                    }                    
                    sb.Append(dt.Rows[i]["classname"].ToString() + "</td>");
                    sb.Append("<td align='right' valign='middle' class='sysmain_navi' width='260px' ><a href='ReperClass_add.aspx?ParentID=" + dt.Rows[i]["id"].ToString().Trim().ToString() + "' class='list_link'>添加子目录</a>&nbsp;&nbsp;<a href='ReperClass_up.aspx?id="+dt.Rows[i]["id"].ToString().Trim().ToString()+"' class='list_link'>修改目录</a>&nbsp;&nbsp;<a href='ReperClass_del.aspx?id=" + dt.Rows[i]["id"].ToString().Trim().ToString() + "' class='list_link' onclick=\"{if(confirm('确定要删除吗？')){return true;}return false;}\">删除目录</a></td>");
                    sb.Append("</tr>");
                    if (Convert.ToInt32(dt.Rows[i]["SubNum"].ToString().Trim().ToString()) > 0)
                    {                        
                        sb.Append("<tr id='trid" + dt.Rows[i]["id"].ToString().Trim().ToString() + "' style='display:none'>");
                        sb.Append("<td colspan='3'>");
                        sb.Append(CreateHtmlSub(dt.Rows[i]["id"].ToString().Trim().ToString()));
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                }
                sb.Append("</table>");
            }
            return sb.ToString();
        }
        public string CreateHtmlSub(string parentid)
        {
            DataTable dtsub = new DataTable();
            string strWhere = "ReperClass.ParentID='" + parentid + "' and isDel=0";
            string filedOrder = "ReperClass.id";
            dtsub = RC.GetTable(100, strWhere, filedOrder);
            //string tempchar = "";
            StringBuilder sb = new StringBuilder();
            
            sb.Append("<table width='98%' border='0' align='right' cellpadding='0' cellspacing='0'   >");
            for (int i = 0; i < dtsub.Rows.Count; i++)
            {
                sb.Append("<tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>");
                //sb.Append("<td align='center' valign='middle' width='15px' class='sysmain_navi'><input name='chkSelected' type='checkbox' value='" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "' /></td>");
                sb.Append("<td align='center' valign='middle' width='15px' class='sysmain_navi'></td>");
                
                
                    //tempchar = dtsub.Rows[i].ToString().Trim().ToString().Replace("<p>", "").Replace("</p>", "\n").Replace("<br />", "\n"); ;
                if (int.Parse(dtsub.Rows[i]["SubNum"].ToString()) > 0)
                {
                    sb.Append("<td align='left' valign='middle' height='15' >");
                    sb.Append("&nbsp; <img src='../../Images/b.gif' style='cursor:hand' onclick=\"SwitchImg(this,'trid" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "');\" border='0'>");
                }
                else
                {
                    sb.Append("<td align='left' valign='middle' height='15' >");
                    sb.Append("&nbsp;<img src=\"../../Images/s.gif\" style=\"cursor:pointer;\" alt='没有子任务' border='0' class='LableItem' />");
                }
                    sb.Append(dtsub.Rows[i]["classname"].ToString()+"</td>");
                    /* HtmlTable += " <span id='" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "' title='" + tempchar + "'>";
                     if (tempchar.Length > 10)
                     {
                         HtmlTable += tempchar.Substring(0, 10);
                     }
                     else
                     {
                         HtmlTable += tempchar;
                     }
                     HtmlTable += "</span>";*/
                    sb.Append("<td align='right' valign='middle' class='sysmain_navi' width='260px' ><a href='ReperClass_add.aspx?ParentID=" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "' class='list_link'>添加子目录</a>&nbsp;&nbsp;<a href='ReperClass_up.aspx?id=" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "' class='list_link'>修改目录</a>&nbsp;&nbsp;<a href='ReperClass_del.aspx?id=" + dtsub.Rows[i]["id"].ToString().Trim().ToString() + "' class='list_link' onclick=\"{if(confirm('确定要删除吗？')){return true;}return false;}\">删除目录</a></td>");
                    sb.Append("</tr>");
                    if (int.Parse(dtsub.Rows[i]["SubNum"].ToString()) > 0)
                    {
                        px = px + 10;
                        sb.Append("<tr id='trid"+dtsub.Rows[i]["id"].ToString().Trim().ToString()+"' style='display:none'>");
                        sb.Append("<td colspan='3'>");
                        sb.Append(CreateHtmlSub(dtsub.Rows[i]["id"].ToString().Trim().ToString()));
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                      
            }
            sb.Append("</table>");
            return sb.ToString();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize"] = DropDownList1.Text.ToString();
            StartLoad(1, "ParentID =0 and isDel = 0");
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

        protected void class_add(object sender, EventArgs e)
        {
            Response.Redirect("ReperClass_add.aspx");
        }
    }
}