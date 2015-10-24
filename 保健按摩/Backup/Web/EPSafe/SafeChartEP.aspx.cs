using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using DAO;
using EPReper.Model;
using System.Web.UI.DataVisualization.Charting;

namespace EPReper.Web.EPSafe
{
    public partial class SafeChartEP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
            GetFirstChart();
            InfoBind();
            this.Chart2.Visible = false;

            //  SetDefaultdata();
        }

        private void SetDefaultdata()
        {
            if (Request.QueryString["fid"] != null)
            {
                string fid = Request.QueryString["fid"].ToString();

                if (fid == "1")
                {
                    this.Chart1.Visible = true;
                    this.Chart2.Visible = false;
                }
                else
                {
                    this.Chart1.Visible = false;
                    this.Chart2.Visible = true;
                }
            }
        }

        private void GetFirstChart()
        {

            string myConnectionString = ConfigurationManager.AppSettings["ConnectionString"];
            string mySelectQuery = "SELECT A.Dept,isnull(B.CountAll,0) as countall, isnull(C.CountFinish,0) as countfinish FROM "
                                 + "(SELECT  DISTINCT(Dept)  FROM [EPHealth].[dbo].[SafePitFalls]) as A "
                                 + "left join  "
                                 + "( SELECT Dept,COUNT(Dept)as CountAll FROM [EPHealth].[dbo].[SafePitFalls] group by Dept"
                                 + " ) B on A.Dept=B.Dept "
                                 + "left join "
                                 + " ( SELECT Dept,COUNT(Dept)as CountFinish FROM [EPHealth].[dbo].[SafePitFalls] where ISNULL( PitResult,'')!='' group by Dept"
                                 + " ) C on A.Dept=C.Dept order by B.CountAll desc";


            string mySelectQuery2 = " select A.based,A.counter ,isnull(B.counter,0) as finishcounter from  (select convert(char(7),Time,120) as based "
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

            this.Chart1.Series[0].PostBackValue = "#AXISLABEL";
            this.Chart1.Series[0].ToolTip = "单击查看全部隐患";

            this.Chart1.Series[1].PostBackValue = "999" + "#AXISLABEL";
            this.Chart1.Series[1].ToolTip = "单击查看已处理隐患";


            Chart2.Series["Default1"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "counter");
            Chart2.Series["Default2"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "finishcounter");

            myConnection.Close();

        }

        private void InfoBind()
        {
            CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
            string condition = " ";
            if (ViewState["con"] == null)
            {
                condition = condition = "1!=1";
            }
            else
            {
                string allornot = "";
                if (ViewState["fulldept"].ToString().Substring(0, 3) == "999")
                {
                    allornot = "已处理";
                }
                else
                {
                    allornot = "全部";
                }

                condition = condition + ViewState["con"];
                lbusername.Text = "您正在查看的是   " + ViewState["dept"].ToString() + "  " + allornot + "的安全隐患 ";
            }

            Pager.RecordCount = int.Parse(newmgr.GetTotalCount(condition));
            RepeaterPubGG.DataSource = newmgr.FindAllByPageDesc(((Pager.CurrentPageIndex - 1) * Pager.PageSize).ToString(), Pager.PageSize.ToString(), condition);
            RepeaterPubGG.DataBind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            InfoBind();
        }

        protected void ImgeMap_Click(object sender, ImageMapEventArgs e)
        {
             

            ViewState["fulldept"] = e.PostBackValue.ToString();
            if (e.PostBackValue.Substring(0, 3) == "999")
            {
                ViewState["dept"] = e.PostBackValue.Substring(3, e.PostBackValue.Length - 3);

                ViewState["con"] = " ( Dept='" + e.PostBackValue.Substring(3, e.PostBackValue.Length - 3) + "')  and  ISNULL( PitResult,'')!='' ";
            }
            else
            {

                ViewState["con"] = " ( Dept='" + e.PostBackValue + "') ";
                ViewState["dept"] = e.PostBackValue;
            }
            InfoBind();
        }

    }
}