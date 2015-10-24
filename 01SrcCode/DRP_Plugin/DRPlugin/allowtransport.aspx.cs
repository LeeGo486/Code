using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CJ;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class allowtransport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["shopid"] == null
              || Request["shopid"].Trim().Length <= 0
              || Request["guid"] == null
              || Request["guid"].Trim().Length <= 0
              || Request["yn"] == null
              || Request["yn"].Trim().Length <= 0
             )
        {
            Response.Write("<script>alert('参数错误');window.opener=null;window.open('','_self');window.close();</script>");
            return;
        }
        if (!IsPostBack)
        {
            RequestDeal();
        }
    }
    private int ExecuteSqlTran(List<String> SQLStringList)
    {
        //using (SqlConnection conn = new SqlConnection(DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey157"], "001", "EP_X6", "PROD")))
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["X6EPAPP"]))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            SqlTransaction tx = conn.BeginTransaction();
            cmd.Transaction = tx;
            try
            {
                int count = 0;
                for (int n = 0; n < SQLStringList.Count; n++)
                {
                    string strsql = SQLStringList[n];
                    if (strsql.Trim().Length > 1)
                    {
                        cmd.CommandText = strsql;
                        int current = cmd.ExecuteNonQuery();
                        count += current == -1 ? 0 : current;
                    }
                }
                tx.Commit();
                return count;
            }
            catch (Exception)
            {
                tx.Rollback();
                return 0;
            }
        }
    }
    private void RequestDeal()
    {
        //CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey157"], "001", "EP_X6", "PROD");
        CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["X6EPAPP"];
        CJ_DevelopHelper.SqlStr = "select ZT from DHSQZB where GUID='" + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "'";
        DataTable dt = CJ_DevelopHelper.SQL_ReturnDateTable;
        if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString() == "已确认")
        {
            string sql = " update DHSQZB set ZT='待发货' where GUID='{0}' and ZT='已确认';update DHSQMXB set ZT='待发货',xfsjsqsl=1,sjsqrq=getdate() where ZBGUID='{0}' and GFBH='{1}' and ZT='已确认';";
            if (Request["yn"].Trim().ToLower() == "n")
                sql = " update DHSQZB set ZT='已取消' where GUID='{0}' and ZT='已确认';update DHSQMXB set ZT='已取消' where ZBGUID='{0}' and GFBH='{1}' and ZT='已确认';";
            List<string> sqlist = new List<string>();
            sqlist.Add(string.Format(sql, Server.HtmlEncode(Request["guid"].ToString().Trim()), Server.HtmlEncode(Request["shopid"].ToString().Trim())));
            if (ExecuteSqlTran(sqlist) > 0)
            {
                if (Request["yn"].Trim().ToLower() == "y")
                    lbresult.Text = "<h2>操作成功</h2><br />恭喜您，通知发货成功<br />";
                else
                    lbresult.Text = "<h2>操作成功</h2><br />恭喜您，取消发货成功<br />";
            }
            else
            {
                lbresult.Text = "<h2>操作失败，本阶段无此操作！</h2><br />";
            }

        }
        else
        {
            lbresult.Text = "<h2>操作失败</h2><br />系统中不存在该申请记录！或者您已经执行过发货操作！ <br />";
        }
    }
}