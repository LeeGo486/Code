using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace EPReper.Web.EPSafe
{
    public partial class SafeChart1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
            
                GetFirstChart();
            
                SetDefaultdata();

            }
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
                                 + " ) C on A.Dept=C.Dept";


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


            Chart2.Series["Default1"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "counter");

            Chart2.Series["Default2"].Points.DataBindXY(ds2.Tables[0].DefaultView, "based", ds2.Tables[0].DefaultView, "finishcounter");

            myConnection.Close();

        }


    }
}