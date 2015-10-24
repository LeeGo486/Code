using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class IPTel : System.Web.UI.Page
{
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Databinding();
        }
    }
    private void Databinding()
    {
        //CJ.CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey102"], "004", "EP_DRP_ZH", "PROD");// "server=192.168.0.102;uid=ERPuser;Pwd=ERPuser2010;database=F22;";
        CJ.CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];
        
        CJ.CJ_DevelopHelper.SqlStr = "select * from CJ_ConnectList where partcom!='总部'";
        RPData.DataSource = CJ.CJ_DevelopHelper.SQL_ReturnDateTable;
        RPData.DataBind();
        CJ.CJ_DevelopHelper.SqlStr = "select * from CJ_ConnectList where partcom='总部'";
        RPZBData.DataSource = CJ.CJ_DevelopHelper.SQL_ReturnDateTable;
        RPZBData.DataBind();
    }
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        if (TxtKeys.Text.Trim().Length > 0)
        {
            string where = "Partcom like '%{0}%' or PartLeader like '%{0}%' or PType  like '%{0}%' or City  like '%{0}%' or ShopNo like '%{0}%' or ShopName  like '%{0}%' or TelCode  like '%{0}%' or Remark   like '%{0}%'";
            CJ.CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL("GFMR0LRA", "004", "EP_DRP_ZH", "PROD"); ;
            CJ.CJ_DevelopHelper.SqlStr = "select * from CJ_ConnectList where partcom!='总部' and (" + string.Format(where, Server.HtmlEncode(TxtKeys.Text.Trim().Replace("'", ""))) + ")";
            RPData.DataSource = CJ.CJ_DevelopHelper.SQL_ReturnDateTable;
            RPData.DataBind();
            CJ.CJ_DevelopHelper.SqlStr = "select * from CJ_ConnectList where partcom='总部' and (" + string.Format(where, Server.HtmlEncode(TxtKeys.Text.Trim().Replace("'", ""))) + ")";
            RPZBData.DataSource = CJ.CJ_DevelopHelper.SQL_ReturnDateTable;
            RPZBData.DataBind();
        }
        else
            Databinding();
    }
}