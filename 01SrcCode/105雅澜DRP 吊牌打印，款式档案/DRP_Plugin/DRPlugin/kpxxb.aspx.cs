using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

public partial class kpxxb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["HM"] == null || Request["HM"].Trim().Length <= 0)
        {
            LbInfo.Text = "<font color='red'>参数错误，执行失败！</font>"; return;
        }
        if (!IsPostBack)
        {
            Excute();
        }
    }
    private void Excute()
    {
        CJ.CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey157"].ToString(), "001", "EP_X6", "PROD");
        CJ.CJ_DevelopHelper.SqlStr = "select * from KPXXB where FPHM='" + Server.HtmlEncode(Request["HM"].Replace("'", "")) + "'";
        DataTable dt = CJ.CJ_DevelopHelper.SQL_ReturnDateTable;
        if (dt.Rows.Count <= 0)
        {
            LbInfo.Text = "<font color='red'>参数错误，执行失败！</font>"; return;
        }
        CJ.CJ_DevelopHelper.SqlStr = "update KPXXB set FPSDQR=1 where FPHM='" + Server.HtmlEncode(Request["HM"].Replace("'", "")) + "'";
        if (CJ.CJ_DevelopHelper.SQL_ExecuteNonQuery > 0)
        {
            LbInfo.Text = "<font color='Green'>恭喜您，操作执行成功！</font>";
        }
    }
}