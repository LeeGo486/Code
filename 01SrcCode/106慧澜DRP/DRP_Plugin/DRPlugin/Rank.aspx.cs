using System;
using CJ;
using System.Data;
using Ext.Net;
using System.Xml;
using System.Xml.Xsl;
using System.Configuration;

public partial class Rank : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Report_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        if (Request["shopid"] == null) return;
        CJ_DevelopHelper.SqlConn_Str = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey102"], "004", "EP_DRP_ZH", "PROD"); //ConfigurationManager.AppSettings["ConnectionString"];
        CJ_DevelopHelper.SqlStr = "select depotid from j_user where userid='" + Request["shopid"].ToString() + "'";
        DataTable dt = CJ_DevelopHelper.SQL_ReturnDateTable;
        if (dt.Rows.Count <= 0) return;
        CJ_DevelopHelper.SqlStr = "select xl 系列,stycolorid 款式,get_date 上货日期,nums 销售,k_num 库存 from T_skctopsale_message where depotid1='" + dt.Rows[0][0].ToString() + "' and nums=0 order by xl desc";
        Report_MainStore.DataSource = CJ_DevelopHelper.SQL_ReturnDateTable;
        Report_MainStore.DataBind();
    }
    protected void ToExcel_Click(object sender, EventArgs e)
    {
        string json = ExcelGridData.Value.ToString();
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;
        this.Response.Clear();
        this.Response.ContentType = "application/vnd.ms-excel";
        this.Response.AddHeader("Content-Disposition", "attachment; filename=SaleRank.xls");
        XslCompiledTransform xtExcel = new XslCompiledTransform();
        xtExcel.Load(Server.MapPath("./Styles/Excel.xsl"));
        xtExcel.Transform(xml, null, this.Response.OutputStream);
        this.Response.End();
    }
}