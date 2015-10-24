using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using DAO;
using EPReper.Common;
using Maticsoft.Common;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EPReper.Web.EPSafe
{
    public partial class NewsAdd : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDropValueDefault();
                SetDefaultdata();
              
            }

        }
 
        private void SetDropValueDefault()
        {

            string Sql = "SELECT  distinct ZhuanName  FROM [EPHealth].[dbo].[Safezhuan] ";

            DataTable dt = Query(Sql).Tables[0];

            this.DropDownListZhuanTi.Items.Clear();
            DropDownListZhuanTi.DataSource = dt;
            DropDownListZhuanTi.DataTextField = "ZhuanName";
            DropDownListZhuanTi.DataValueField = "ZhuanName";
            DropDownListZhuanTi.DataBind();
            DropDownListZhuanTi.Items.Insert(0, new ListItem("", ""));
        }


        private void SetDefaultdata()
        {
            if (Request.QueryString["fid"] != null)
            {
                CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
                SafeNews safenew = newmgr.FindById(Request.QueryString["fid"]);
                if (safenew != null)
                {
                    SpanType.InnerText = safenew.NewsInfoType.ToString() + "--" + safenew.newstype.ToString();
                    this.Txtctitle.Text = safenew.newstitle.ToString();
                    this.TxtNewsContent.InnerHtml = safenew.newscontents.ToString();
                    CommonDao<Safezhuan> sugmgr = new CommonDao<Safezhuan>();
                    Safezhuan safezhuan = sugmgr.FindByConditions(" fid='" + safenew.NewsZhuan + "' ");

                    if (safezhuan != null)
                    {
                        ListItem itmSelected = this.DropDownListZhuanTi.Items.FindByValue(safezhuan.ZhuanName);
                        if (itmSelected != null) { itmSelected.Selected = true; }
                    }
                }
                else
                {
                    MessageBox.ShowAndRedirect(this, "出错了，文章未找到！", "SafeAdmin.aspx");
                }
            }
            else
            {
                if (Request.QueryString["Infotype"] != null && Request.QueryString["type"] != null)
                {
                    SpanType.InnerText = Request.QueryString["Infotype"] + "---" + Request.QueryString["type"];
                }
                else
                {
                    MessageBox.ShowAndRedirect(this, "页面错误", "SafeAdmin.aspx");
                }
            }
        }


        protected void GetValue(object sender, EventArgs e)
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            SafeNews safenew = new SafeNews();

            if (Request.QueryString["fid"] != null)
            {
                safenew = newmgr.FindById(Request.QueryString["fid"].ToString());
            }
            safenew.newstitle = this.Txtctitle.Text.Trim().ToString();

            CommonDao<Safezhuan> sugmgr = new CommonDao<Safezhuan>();
            Safezhuan safezhuan = sugmgr.FindByConditions(" ZhuanName='" + this.DropDownListZhuanTi.Text.Trim().ToString() + "' ");

            if(safezhuan!=null){
                safenew.NewsZhuan = safezhuan.fid.ToString();
            }
            safenew.newscontents = this.TxtNewsContent.InnerText.ToString();

            if (Request.QueryString["Infotype"] != null && Request.QueryString["type"] != null)
            {
                safenew.NewsInfoType = Request.QueryString["Infotype"].ToString();
                safenew.newstype = Request.QueryString["type"].ToString();
            }

            if (safenew.NewsInfoType == "安全新闻")
            {
                GetImg getimg = new GetImg();
                safenew.newspics = getimg.MyGetImgUrl(safenew.newscontents);
                if (safenew.newspics.Length > 0)
                {
                    safenew.newstype = "图片新闻";
                }
            }
            EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
            string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            safenew.createperson = username;
            safenew.createtime = DateTime.Now.ToString();

            if (Request.QueryString["fid"]!= null)
            {
                if (newmgr.Update(safenew))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，" + safenew.newstype + "修改成功！", "SafeAdmin.aspx?Infotype=" + safenew.NewsInfoType + "&type=" + safenew.newstype + "");
                }
                MessageBox.Show(this, "Sorry," + safenew.newstype + "修改失败！，请您重试！");

            }
            else
            {
                if (newmgr.Add(safenew))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，" + safenew.newstype + "添加成功！", "SafeAdmin.aspx?Infotype=" + safenew.NewsInfoType + "&type=" + safenew.newstype + "");
                }
                MessageBox.Show(this, "Sorry," + safenew.newstype + "添加失败！，请您重试！");
            }
        }

        public static DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {

                }
                return ds;
            }
        }
    }
}