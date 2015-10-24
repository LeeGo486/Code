using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

namespace EPReper.Web
{
    public partial class login : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

               /* string longnamerequer = Request.QueryString["TxtName"];
                //Encoder ed = Encoding.UTF8.GetEncoder();
                string passwordrequer = Request.QueryString["TxtPassword"];
                if (longnamerequer != null)
                {
                    Save(longnamerequer, passwordrequer);
                }*/

                var username = Request.QueryString["username"] == null ? "" : Request.QueryString["username"];
               // username = HttpUtility.UrlEncode(username, Encoding.GetEncoding("gb2312"));
              //  username = HttpUtility.UrlDecode(username, Encoding.UTF8);
                var mode = Request.QueryString["mode"];
                DataTable dt = UI.GetList("CN_LOGIN = '" + username + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    Tools.CookieHelper.SaveCookie("CN_ID", dt.Rows[0]["CN_ID"].ToString(), 1);
                    Tools.CookieHelper.SaveCookie("username", "<font color=\"Red\">" + username + "</font>欢迎您", 1);
                    if (mode == "1") Response.Redirect("index.aspx");
                    if (mode == "2") Response.Redirect("View/Default.aspx");
                    if (mode == "3") Response.Redirect("EPSafe/Default.aspx");
                }
            }
        }

        protected void login_Click(object sender, ImageClickEventArgs e)
        {


            string loginname = TxtName.Text.Trim();
            string password = TxtPassword.Text;
            if (UI.Login(loginname, password))
            {
                DataTable dt = UI.GetList("CN_LOGIN = '" + loginname + "'").Tables[0];
                Tools.CookieHelper.SaveCookie("CN_ID", dt.Rows[0]["CN_ID"].ToString(), 1);
                //Tools.CookieHelper.GetCookie("username") = "欢迎您<<font color=\"Red\">"+loginname+"</font>>";
                Tools.CookieHelper.SaveCookie("username", "<font color=\"Red\">" + loginname + "</font>欢迎您", 1);
                //Response.Redirect("main.aspx");
                Response.Redirect("RepairHealth.aspx");

            }
        }
        protected void Save(string loginname, string password)
        {
            if (UI.Login(loginname, password))
            {
                DataTable dt = UI.GetList("CN_LOGIN = '" + loginname + "'").Tables[0];
                Tools.CookieHelper.SaveCookie("CN_ID", dt.Rows[0]["CN_ID"].ToString(), 1);
                //Tools.CookieHelper.GetCookie("username") = "欢迎您<<font color=\"Red\">"+loginname+"</font>>";
                Tools.CookieHelper.SaveCookie("username", "<font color=\"Red\">" + loginname + "</font>欢迎您", 1);
                //Response.Redirect("main.aspx");
                Response.Redirect("RepairHealth.aspx");

            }
        }
    }
}