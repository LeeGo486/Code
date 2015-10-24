using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;

namespace EPReper.Web.EPSafe
{
    public partial class BookDetails : System.Web.UI.Page
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
            CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();
            SafeBook safebook = newmgr.FindById(Request["fid"].ToString());
            if (safebook == null)
            {
                this.lbtitle.Text = "无法找到该记录，可能已经被删除！";
                return;
            }
            this.lbtitle.Text = safebook.booktitle;
            this.Title = safebook.booktitle + "--安全新闻管理";
            this.lbcontent.Text = safebook.bookcontents;
            this.lbAinfo.Text = " &nbsp;&nbsp;作者：" + safebook.createperson + " &nbsp;&nbsp;最后修改：" + safebook.createtime + "  &nbsp;&nbsp;有效访问量：" + safebook.bookkits.ToString();
        }


        private void PageAccess()
        {
            CommonDao<SafePageAccess> Pagemgr = new CommonDao<SafePageAccess>();
            SafePageAccess pa = new SafePageAccess();
            pa.createtime = DateTime.Now.ToString();

            pa.pagename = Request.RawUrl;
            if (Tools.CookieHelper.GetCookie("username") != null)
                pa.userinfo = Tools.CookieHelper.GetCookie("username").ToString() + " IP:" + Request.UserHostAddress;
            else
                pa.userinfo = "匿名 IP:" + Request.UserHostAddress;

            if (int.Parse(Pagemgr.GetTotalCount(" pagename='" + pa.pagename + "' and userinfo ='" + pa.userinfo + "'")) <= 0)
            {
                Pagemgr.Add(pa);
                CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();
                SafeBook safebook = newmgr.FindById(Request["fid"].ToString());
                safebook.bookkits++;
                newmgr.Update(safebook);

            }

        }
    }
}