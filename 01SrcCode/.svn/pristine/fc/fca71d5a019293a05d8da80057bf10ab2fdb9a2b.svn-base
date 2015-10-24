using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CJ;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class transfer_request : System.Web.UI.Page
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
        using (SqlConnection conn = new SqlConnection(DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey157"], "001", "EP_X6", "PROD")))
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
        CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey157"], "001", "EP_X6", "PROD");
        CJ_DevelopHelper.SqlStr = "select DPMC,XQKH,YS,CM,ZT from DHSQZB where GUID='"
                + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "'";
        DataTable dt = CJ_DevelopHelper.SQL_ReturnDateTable;
        if (dt.Rows.Count <= 0)
        {
            Response.Write("<script>alert('没有调货请求记录！');window.opener=null;window.open('','_self');window.close();</script>");
            return;
        }
        if (dt.Rows[0]["ZT"].ToString().Trim() == "已确认")
        {
            Response.Write("<script>alert('其他店铺已经同意调货，您本次答复无效！');window.opener=null;window.open('','_self');window.close();</script>");
            return;
        }
        if (dt.Rows[0]["ZT"].ToString().Trim() != "待确认")
        {
            Response.Write("<script>alert('您长时间未操作，数据已过期，处理无效！');window.opener=null;window.open('','_self');window.close();</script>");
            return;
        }
        if (Request["yn"].Trim().ToLower() == "y")
        {//如果供货商同意，直接更新表，并关闭其他店铺，更改主表
            List<string> sqlist = new List<string>();
            sqlist.Add("update DHSQMXB set ZT='已关闭' where ZBGUID='"
                + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "';");
            sqlist.Add("update DHSQMXB set ZT='已确认',CNDHSL=1,CNDHRQ=getdate() where ZBGUID='"
                + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "' and GFBH='" + Server.HtmlEncode(Request["shopid"].ToString()) + "' and ZT='已关闭';");
            sqlist.Add("update DHSQZB set ZT='已确认' where GUID='"
                + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "';");
            if (ExecuteSqlTran(sqlist)>0)
            {
                lbresult.Text = "<h2>操作成功</h2><br />您已经<b>同意</b>调出 " + dt.Rows[0]["XQKH"].ToString() + dt.Rows[0]["YS"].ToString() + dt.Rows[0]["CM"].ToString() + "  1件  往" + dt.Rows[0]["DPMC"].ToString() + " <br /> <br /><font color='green'>请等待对方发货通知...</font>";
                return;
            }
            else
            {
                lbresult.Text = "<h1>操作失败！！！</h1>"; return;
            }
        }
        else if (Request["yn"].Trim().ToLower() == "n")
        {
            CJ_DevelopHelper.SqlStr = "select ZT from DHSQMXB where  ZBGUID='" + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "' and GFBH='" + Server.HtmlEncode(Request["shopid"].ToString()) + "'";
            DataTable dtjj = CJ_DevelopHelper.SQL_ReturnDateTable;
            if (dtjj.Rows.Count > 0)
            {
                if (dtjj.Rows[0][0].ToString() != "待确认")
                {
                    lbresult.Text = "<h1>您已经提交过回复或其他店铺已同意发货，本次回复无效！！！</h1>"; return;
                }
            }
            else
            {
                lbresult.Text = "<h1>没有找到记录，操作失败！！！</h1>"; return;
            }
            List<string> sqlist = new List<string>();
            sqlist.Add("if exists (select * from DHSQMXB where ZBGUID='" + Server.HtmlEncode(Request["guid"].ToString())
                + "' and ZT!='已拒绝' and GFBH!='" + Server.HtmlEncode(Request["shopid"].ToString()) + "') "
                + " update DHSQMXB set ZT='已拒绝' where ZBGUID='" + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "' and GFBH='" + Server.HtmlEncode(Request["shopid"].ToString()) + "';"
                + " else begin update DHSQMXB set ZT='已拒绝' where ZBGUID='" + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "' and GFBH='" + Server.HtmlEncode(Request["shopid"].ToString()) + "';"
                + " update DHSQZB set ZT='已拒绝' where GUID='" + Server.HtmlEncode(Request["guid"].ToString().Trim()) + "'; end;");
            if (ExecuteSqlTran(sqlist) > 0)
            {
                lbresult.Text = "<h2>操作成功</h2><br />您已经<b>拒绝</b>调出 " + dt.Rows[0]["XQKH"].ToString() + dt.Rows[0]["YS"].ToString() + dt.Rows[0]["CM"].ToString() + "  1件  往" + dt.Rows[0]["DPMC"].ToString() + " <br /> <br />";
                return;
            }
            else
            {
                lbresult.Text = "<h1>操作失败！！！</h1>"; return;
            }
        }
    }
}