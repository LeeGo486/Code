using CJ;
using Ext.Net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VipRetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Report_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        try
        {
            if (TxtVIPNo.Text.Trim().Length <= 0)
            {
                X.MessageBox.Alert("提醒", "请输入VIP卡号！").Show();
                return;
            }
            //CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["DBRetail"];
            CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];
            string sql = "select vipid,vipname,centum,pcentum from vip_user where vipcode='{0}'";
            CJ_DevelopHelper.SqlStr = String.Format(sql, TxtVIPNo.Text.Trim().Replace("'", "").Replace("--", ""));
            DataTable dt = CJ_DevelopHelper.SQL_ReturnDateTable;
            string cardno = "";
            if (dt.Rows.Count == 1)
            {
                lbInfo.Html = " &nbsp;&nbsp;&nbsp;&nbsp;姓名:<font color=red>" + dt.Rows[0]["vipname"].ToString()
                           + "</font>  &nbsp;&nbsp;&nbsp;&nbsp;总积分:<font color=red>" + dt.Rows[0]["centum"].ToString()
                           + "</font>  &nbsp;&nbsp;&nbsp;&nbsp;上季积分:<font color=red>" + dt.Rows[0]["pcentum"].ToString() + "</font>";
                cardno = dt.Rows[0]["vipid"].ToString();
            }
            else
            {
                X.MessageBox.Alert("提醒", "VIP卡号不正确，请检查，找到"+dt.Rows.Count.ToString()+"条记录！").Show();
                return;
            }
            RetailStore.DataSource = GetRecordByProc(cardno);
            RetailStore.DataBind();
        }
        catch (Exception error)
        {
            X.MessageBox.Alert("异常", error.Message).Show();
        }
    }

    //返回DataTable
    private DataTable GetRecordByProc(string vipid)
    {
        //using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["DBRetail"]))
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["F22"]))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "P_GetVipSaleRecords";
            cmd.CommandType = CommandType.StoredProcedure;//存储过程
            cmd.Connection = connection;//数据库连接
            cmd.Parameters.Add("@vipid", SqlDbType.VarChar, 40);
            cmd.Parameters["@vipid"].Value = vipid.Replace("'", "");
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            connection.Open();
            adapter.Fill(ds);
            connection.Close();
            return ds.Tables[0];
        }
    }

}