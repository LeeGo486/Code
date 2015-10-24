using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Common;
using DAO;
using EPReper.Model;
using EPReper.BLL;
using Maticsoft.Common;
using System.Data.OleDb;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace EPReper.Web.EPSafe
{
    public partial class Default : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        static string userid = "";
      //  string username = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect("");
            
            if (!IsPostBack)
            {
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }

                GetNewsInfo();
                GetSafeSug();
                GetFirstChart();
                GetYinHuanPai();
                GetTwoTop();
                GetSafeBook();
                GetAdmin();
                GetSafeZhuan();
            }

            GetInfoImgs();
        }

        private void GetFirstChart()
        {

            string myConnectionString = ConfigurationManager.AppSettings["ConnectionString"];
            string mySelectQuery = "SELECT top 3 A.Dept,isnull(B.CountAll,0) as countall, isnull(C.CountFinish,0) as countfinish FROM "
                                 + "(SELECT  DISTINCT(Dept)  FROM [EPHealth].[dbo].[SafePitFalls]) as A "
                                 + "left join  "
                                 + "( SELECT Dept,COUNT(Dept)as CountAll FROM [EPHealth].[dbo].[SafePitFalls] group by Dept"
                                 + " ) B on A.Dept=B.Dept "
                                 + "left join "
                                 + " ( SELECT Dept,COUNT(Dept)as CountFinish FROM [EPHealth].[dbo].[SafePitFalls] where ISNULL( PitResult,'')!='' group by Dept"
                                 + " ) C on A.Dept=C.Dept order by countall desc ";


            string mySelectQuery2 = " select top 3  A.based,A.counter ,isnull(B.counter,0) as finishcounter from  (select convert(char(7),Time,120) as based "
                                    + ",count(*) as counter from [EPHealth].[dbo].[SafePitFalls]  "
                                     + " where   time>dateadd(month,-12,getdate()) group by convert(char(7),time,120) )A"
                                    + " left join ("
                                    + " select convert(char(7),Time,120) as based "
                                    + " ,count(*) as counter from [EPHealth].[dbo].[SafePitFalls]   "
                                    + " where  ISNULL( PitResult,'')!='' "
                                    + "  and  time>dateadd(month,-12,getdate()) group by convert(char(7),time,120) "
                                    + " )B on A.based=B.based order by based";

            SqlConnection myConnection = new SqlConnection(myConnectionString);


            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            try
            {
                myConnection.Open();
                SqlDataAdapter command = new SqlDataAdapter(mySelectQuery, myConnection);
                SqlDataAdapter command2 = new SqlDataAdapter(mySelectQuery2, myConnection);
                command.Fill(ds, "ds");
                command2.Fill(ds2, "ds");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                // log.Error("Query:" + SQLString + "  error:" + ex.Message);
            }


            Chart1.Series["Series1"].Points.DataBindXY(ds.Tables[0].DefaultView, "Dept", ds.Tables[0].DefaultView, "countall");
            Chart1.Series["Series2"].Points.DataBindXY(ds.Tables[0].DefaultView, "Dept", ds.Tables[0].DefaultView, "countfinish");


            Chart2.Series["Default1"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "counter");
            Chart2.Series["Default2"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "finishcounter");

            myConnection.Close();

        }

        private void GetYinHuanPai() {

            CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
            string condition = " ";

            SafePitFalls s = new SafePitFalls();
            condition = condition + " datediff (D,time,getdate())<2 ";
            RepeaterPubGG.DataSource = newmgr.FindBydesc("10",condition,"time"); 
            RepeaterPubGG.DataBind();
        
        }

        private void GetTwoTop()
        {

            string myConnectionString = ConfigurationManager.AppSettings["ConnectionString"];

            string SqlString1 = "select top 3 * from   ( "
+ " select c.deptname dept,isnull(deptmoney,0)+isnull(a.Rewards,0)-isnull(b.Fine,0) TotalMoney "
+ " ,isnull(a.Rewards,0)-isnull(b.Fine,0) sumreward from  "
+ " [EPHealth].dbo.SafeDeptMoney c  "
+ " left join (SELECT Dept,isnull(SUM(Rewards),0) AS Rewards  FROM [EPHealth].[dbo].[SafeRewards] group by Dept) a  on  c.deptname=a.Dept "
+ " left join (SELECT Dept,isnull(SUM(Fine),0) AS Fine FROM [EPHealth].[dbo].SafePitFalls group by Dept) b  on c.deptname=b.Dept "
+ " ) a  order by  sumreward desc ";
            //"select top 3 A.deptname Dept,A.deptmoney+isnull(B.sumreward,0) TotalMoney,isnull(B.sumreward,0) sumreward  from  (select * from [EPHealth].dbo.SafeDeptMoney) A"
            //                     + " left join (SELECT Dept,isnull(SUM(Rewards),0) AS sumreward FROM [EPHealth].[dbo].[SafeRewards] group by Dept) B on A.deptname=B.Dept  order by B.sumreward desc ";
           

            string SqlString2 = "SELECT top 3 Dept,count(*) AS counters FROM [EPHealth].dbo.SafePitFalls where DATEDIFF(Month,Time,GETDATE())=0 "
                              + "group by Dept order by counters desc ";
            SqlConnection myConnection = new SqlConnection(myConnectionString);

            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            try
            {
                myConnection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SqlString1, myConnection);
                SqlDataAdapter command2 = new SqlDataAdapter(SqlString2, myConnection);
                command.Fill(ds, "ds");
                command2.Fill(ds2, "ds");

                Repeater1.DataSource = ds;
                Repeater1.DataBind();

                Repeater2.DataSource = ds2;
                Repeater2.DataBind();

              
            }
            catch (System.Data.SqlClient.SqlException ex)
            {

            }

            myConnection.Close();

        }
        public void GetAdmin()
        {

            EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
            CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
           
            //healthadmin表 works=9的为安全新闻管理员
            if (int.Parse(healadminmgr.GetTotalCount(" username='" + username + "' and works=9 ")) > 0)
            {
                admins.Visible = true;
            }

        }


        private void GetSafeBook()
        {
            CommonDao<SafeBook> sugmgr = new CommonDao<SafeBook>();
            RepeaterBook.DataSource = sugmgr.FindByIDdesc("5", " ");
            RepeaterBook.DataBind();

        }

        private void GetNewsInfo()
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            RpNewReplay.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全新闻' ");
            RpNewReplay.DataBind();

            RepeaterSafeWork.DataSource = newmgr.FindByIDdesc("9", " NewsInfoType = '安全工作' ");
            RepeaterSafeWork.DataBind();

            RepeaterSafeGG.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全信息' and  newstype in('安全公文','安全公告') ");
            RepeaterSafeGG.DataBind();

            RepeaterSafeZD.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全信息' and  newstype in('规章制度') ");
            RepeaterSafeZD.DataBind();

            RepeaterSafeJY.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全信息' and  newstype in('会议纪要') ");
            RepeaterSafeJY.DataBind();

            RepeaterSafeZS.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全信息' and  newstype in('安全知识') ");
            RepeaterSafeZS.DataBind();


            RepeaterBook.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全书籍' ");
            RepeaterBook.DataBind();



        }

        private void GetSafeSug()
        {

            CommonDao<SafeSuggestion> sugmgr = new CommonDao<SafeSuggestion>();
            RepeaterSafeSug.DataSource = sugmgr.FindByIDdesc("5", " ");
            RepeaterSafeSug.DataBind();
        }

        private void GetSafeZhuan()
        {

            CommonDao<Safezhuan> sugmgr = new CommonDao<Safezhuan>();
            RepeaterSafeZhuanTi.DataSource = sugmgr.FindAll();
            RepeaterSafeZhuanTi.DataBind();

        }

        protected void AddSug(object sender, EventArgs e)
        {
            CommonDao<SafeSuggestion> newmgr = new CommonDao<SafeSuggestion>();
            SafeSuggestion safesug = new SafeSuggestion();
            safesug.sugcontent = this.TextArea1.InnerText.ToString();
            string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            safesug.createperson = username;
            safesug.createtime = DateTime.Now.ToString();
            if (newmgr.Add(safesug))
            {
                ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('安全建议添加成功！')", true);
                this.TextArea1.InnerText = "";
                GetSafeSug();
            }
            else
            {

                ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('安全建议添加失败！')", true);
            }

        }





        //绑定新闻flash图片
        public string pics = "'";
        public string links = "'";
        public string texts = "'";
        private void GetInfoImgs()
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            IList<SafeNews> list = newmgr.FindByIDdesc("5", " NewsInfoType = '安全新闻' and  newstype = '图片新闻'");

            foreach (SafeNews sn in list)
            {
                string img = GetFirstImg(sn.newspics);
                if (img != "")
                {
                    pics += img + "|";
                    links += "Details.aspx?fid=" + sn.fid.ToString() + "|";
                    texts += (sn.newstitle.Length > 15 ? sn.newstitle.Substring(0, 15) + "..." : sn.newstitle) + "|";
                }
            }
            pics = pics.TrimEnd('|') + "'";
            links = links.TrimEnd('|') + "'";
            texts = texts.TrimEnd('|') + "'";
        }
        private string GetFirstImg(string imgsUrl)
        {
            string[] imgs = imgsUrl.Split('|');
            for (int i = 0; i < imgs.Count<string>(); i++)
            {
                if (imgs[i].ToLower().Contains("jpg"))
                    return imgs[i];
            }
            return "";
        }

        protected void Chart1Click(object sender, ImageMapEventArgs e)
        {
            Response.Redirect("SafeChart1.aspx?fid=1");
        }

        protected void Chart2Click(object sender, ImageMapEventArgs e)
        {
            Response.Redirect("SafeChart1.aspx?fid=2");
        }

    }
}