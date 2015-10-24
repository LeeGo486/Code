using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace EPReper.Web.EPSafe
{
    public partial class SafeRewRes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InfoBind();
            }
        }



        private void InfoBind()
        {
            string myConnectionString = ConfigurationManager.AppSettings["ConnectionString"];

            string SqlString1 = "select * from   ( "
+ " select c.deptname dept,isnull(deptmoney,0)+isnull(a.Rewards,0)-isnull(b.Fine,0) TotalMoney "
+ " ,isnull(a.Rewards,0)-isnull(b.Fine,0) sumreward from  "
+ " [EPHealth].dbo.SafeDeptMoney c  "
+ " left join (SELECT Dept,isnull(SUM(Rewards),0) AS Rewards  FROM [EPHealth].[dbo].[SafeRewards] group by Dept) a  on  c.deptname=a.Dept "
+ " left join (SELECT Dept,isnull(SUM(Fine),0) AS Fine FROM [EPHealth].[dbo].SafePitFalls group by Dept) b  on c.deptname=b.Dept "
+ " ) a  order by  sumreward desc ";
          
            SqlConnection myConnection = new SqlConnection(myConnectionString);

            DataSet ds = new DataSet();
            try
            {
                myConnection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SqlString1, myConnection);
                command.Fill(ds, "ds");

                RepeaterRewRes.DataSource = ds;
                RepeaterRewRes.DataBind();
 

            }
            catch (System.Data.SqlClient.SqlException ex)
            {

            }

            myConnection.Close();
 
            
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            InfoBind();
        }

        protected void ImgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
            InfoBind();
        }

    }
}