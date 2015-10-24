using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;
using Maticsoft.Common;

namespace EPReper.Web.EPSafe
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    GetInfo(); PageAccess();
                }
                catch { this.lbtitle.Text = "错误的请求！！！"; }
            }
        }

        private void GetInfo()
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            CommonDao<SafePinJia> Pinjiamgr = new CommonDao<SafePinJia>();
            SafeNews safenew = newmgr.FindById(Request["fid"].ToString());
            if (safenew == null)
            {
                this.lbtitle.Text = "无法找到该记录，可能已经被删除！";
                return;
            }
            this.lbtitle.Text = safenew.newstitle;
            this.Title = safenew.newstitle + "--安全新闻管理";
            this.lbcontent.Text = safenew.newscontents;
            this.lbAinfo.Text = " &nbsp;&nbsp;作者：" + safenew.createperson + " &nbsp;&nbsp;最后修改：" + safenew.createtime + "  &nbsp;&nbsp;有效访问量：" + safenew.newskits.ToString();

            this.RPMsgs.DataSource = Pinjiamgr.FindByCondition(" masterfid='" + safenew.fid + "'");
            this.RPMsgs.DataBind();

        }





        private void PageAccess()
        {
            CommonDao<SafePageAccess> Pagemgr = new CommonDao<SafePageAccess>();
            SafePageAccess pa = new SafePageAccess();
            pa.createtime = DateTime.Now.ToString();

            pa.pagename = Request.RawUrl;
            if (Tools.CookieHelper.GetCookie("CN_ID") != null)
            {

                EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
                string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                pa.userinfo = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();


            }

            else
            {
                pa.userinfo = "匿名 IP:" + Request.UserHostAddress;
            }

            if (int.Parse(Pagemgr.GetTotalCount(" pagename='" + pa.pagename + "' and userinfo ='" + pa.userinfo + "'")) <= 0)
            {
                Pagemgr.Add(pa);
                CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
                SafeNews safenew = newmgr.FindById(Request["fid"].ToString());
                safenew.newskits++;
                newmgr.Update(safenew);

            }

        }

        protected void ImgBtnMsg_Click(object sender, ImageClickEventArgs e)
        {
            if (this.TxtUserMsgs.Text.Trim().Length > 0)
            {

                string masterfid = Request["fid"].ToString();
                CommonDao<SafePinJia> Pinjiamgr = new CommonDao<SafePinJia>();
                SafePinJia safepinjia = new SafePinJia();
                safepinjia.masterfid = masterfid;
                safepinjia.createtime = DateTime.Now.ToString();
                safepinjia.msgs = this.TxtUserMsgs.Text.Trim().ToString();
                if (Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
                    string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                    safepinjia.createperson = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                }
                else
                {
                    safepinjia.createperson = "匿名 IP:" + Request.UserHostAddress;
                }

                if (Pinjiamgr.Add(safepinjia))
                {
                    Alert("恭喜您，评论成功！");
                    this.RPMsgs.DataSource = Pinjiamgr.FindByCondition(" masterfid='" + masterfid + "'");
                    this.RPMsgs.DataBind();
                }
                else
                {
                    Alert("评论失败！");
                }
            }
            else
                Alert("评论内容不能为空！");
            TxtUserMsgs.Text = "";

        }

        private void Alert(string msg)
        {
            string strJS = "alert('" + msg + "');";
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(ImgBtnMsg, ImgBtnMsg.GetType(), "ajs", strJS, true);
        }

    }
}