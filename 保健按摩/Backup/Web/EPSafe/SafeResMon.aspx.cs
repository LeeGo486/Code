using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using EPReper.Model;
using DAO;

namespace EPReper.Web.EPSafe
{
    public partial class SafeResMon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            string myConnectionString = ConfigurationManager.AppSettings["ConnectionString"];


            string SqlString1 = "SELECT top 1000 Dept,count(*) AS counters FROM [EPHealth].dbo.SafePitFalls where DATEDIFF(Month,Time,GETDATE())=0 "
                              + "group by Dept order by counters desc ";
            SqlConnection myConnection = new SqlConnection(myConnectionString);

            DataSet ds = new DataSet();
            try
            {
                myConnection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SqlString1, myConnection);
                command.Fill(ds, "ds");

                RepeaterResMon.DataSource = ds;
                RepeaterResMon.DataBind();


            }
            catch (System.Data.SqlClient.SqlException ex)
            {

            }

            myConnection.Close();

        }

        // public void ResMon(string dept)


        private void ResMon(object sender, RepeaterCommandEventArgs e)
        {
            //InfoBind();
        }

        private void InfoBind(string dept)
        {

            CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
            string condition = " datediff (month,time,getdate())=0   ";

            if (dept.Length > 0)
            {
                condition = condition + " and  dept like '%" + dept + "%'";
            }


            Pager.RecordCount = int.Parse(newmgr.GetTotalCount(condition));
            Repeateryhxx.DataSource = newmgr.FindAllByPageDesc(((Pager.CurrentPageIndex - 1) * Pager.PageSize).ToString(), Pager.PageSize.ToString(), condition);
            Repeateryhxx.DataBind();
        }


        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
           // InfoBind();
        }



        protected void Res_Click(object sender, CommandEventArgs e)
        {
            string Dept = e.CommandName.Trim();
            InfoBind(Dept);
        }


    }
}