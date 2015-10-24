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
    public partial class BookAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDefaultdata();
            }



        }




        private void SetDefaultdata()
        {
            if (Request.QueryString["fid"] != null)
            {

                CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();

                SafeBook safebook = newmgr.FindById(Request.QueryString["fid"]);
                if (safebook != null)
                {
                   
                    this.Txtctitle.Text = safebook.booktitle.ToString();
                    this.TxtNewsContent.InnerHtml = safebook.bookcontents.ToString();
                }
                else
                {

                    MessageBox.ShowAndRedirect(this, "出错了，文章未找到！", "SafeAdmin.aspx");
                }
            }
            
        }


        protected void GetValue(object sender, EventArgs e)
        {
            CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();
            SafeBook safebook = new SafeBook();

            if (Request.QueryString["fid"] != null)
            {
                safebook = newmgr.FindById(Request.QueryString["fid"].ToString());
            }
            safebook.booktitle = this.Txtctitle.Text.Trim().ToString();
            safebook.bookcontents = this.TxtNewsContent.InnerText.ToString();

            EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
            string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();

            safebook.createperson = username;
            safebook.createtime = DateTime.Now.ToString();


            if (Request.QueryString["fid"] != null)
            {
                if (newmgr.Update(safebook))
                {

                    MessageBox.ShowAndRedirect(this, "恭喜您，安全书籍修改成功！", "SafeBookAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全书籍修改失败！，请您重试！");

            }
            else
            {

                if (newmgr.Add(safebook))
                {

                    MessageBox.ShowAndRedirect(this, "恭喜您，安全书籍添加成功！", "SafeBookAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全添加失败！，请您重试！");
            }
        }
    }
}