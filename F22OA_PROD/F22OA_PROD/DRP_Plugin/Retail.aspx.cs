using CJ;
using Ext.Net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;

public partial class Retail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void RetailSub_DataBind(object sender, StoreRefreshDataEventArgs e)
    {

        try
        {
            string retailId = e.Parameters["rid"].ToString(); if (string.IsNullOrEmpty(retailId))
            {
                X.MessageBox.Alert("异常", "单据参数错误！").Show();
                return;
            }
            string sql = "select retailid,clothingid,s.s_name,c.c_name,j.s_name sizename,d.sizeid,nums,s_price,FSSums,d.x_price,nums*FSSums as xjprice from d_Retailsub d,j_style s,j_color c,j_size j where d.styleid=s.styleid and d.sizeid=j.sizeid and d.colorid=c.colorid and retailid='{0}'";
            //CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["DBRetail"];
            CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];
            CJ_DevelopHelper.SqlStr = string.Format(sql, retailId.ToString().Replace("'", "").Replace("--", ""));
            RetailSubStore.DataSource = CJ_DevelopHelper.SQL_ReturnDateTable;
            RetailSubStore.DataBind();
        }
        catch (Exception error)
        {
            X.MessageBox.Alert("异常", error.Message).Show();
        }
    }

    protected void Report_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        try
        {
            if (Request["shopid"] == null) return;
            //订单销售连接串
            CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];
            //CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["DBRetail"];
            string sql = "select retailid,setdate,znums,zxsums,zssums,FCalcSums,zxsums-zssums as yhsum,s_sums,vipcode,s_name,x_name,crdate,cr_name,comment,sure,chk_sure,depotid from d_Retail ";
            string condition = "where depotid='" + Request["shopid"].ToString().Replace("'", "").Replace("--", "") + "' ";
            //单号
            if (TxtRetailNo.Text.Trim().Length > 0)
            {
                condition += " and retailid='" + TxtRetailNo.Text.Trim().Replace("'", "").Replace("--", "") + "' ";
                X.Js.AddScript("retailno='" + TxtRetailNo.Text.Trim().Replace("'", "").Replace("--", "") + "';#{RetailSubStore}.reload();");
            }
            //开始结束如期
            if (DTStart.SelectedValue != null)
                condition += " and setdate>='" + DTStart.SelectedValue.ToString() + "' ";
            if (DTEnd.SelectedValue != null)
                condition += " and setdate<='" + DTEnd.SelectedValue.ToString() + "' ";
            //状态
            condition += CboState.Value.ToString();
            CJ_DevelopHelper.SqlStr = sql + condition;
            DataTable dt = CJ_DevelopHelper.SQL_ReturnDateTable;
            RetailStore.DataSource = dt;
            RetailStore.DataBind();
        }
        catch (Exception error)
        {
            X.MessageBox.Alert("异常", error.Message).Show();
        }
    }

    protected void BtnSaveToExcel(object sender, EventArgs e)
    {
        string json = ExcelGridData.Value.ToString();
        json = json.Replace("retailid", "单据号");
        json = json.Replace("setdate", "销售日期");
        json = json.Replace("znums", "数量");
        json = json.Replace("zxsums", "现价金额");
        json = json.Replace("zssums", "结算金额");
        json = json.Replace("FCalcSums", "实销金额");
        json = json.Replace("yhsum", "优惠金额");
        json = json.Replace("s_sums", "实收金额");
        json = json.Replace("vipcode", "VIP卡号");
        json = json.Replace("s_name", "营业员");
        json = json.Replace("x_name", "班组");
        json = json.Replace("crdate", "制单日期");
        json = json.Replace("cr_name", "制单人");
        json = json.Replace("comment", "备注");
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;
        this.Response.Clear();
        this.Response.ContentType = "application/vnd.ms-excel";
        this.Response.AddHeader("Content-Disposition", "attachment; filename=Retail" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        XslCompiledTransform xtExcel = new XslCompiledTransform();
        xtExcel.Load(Server.MapPath("ExcelTemp/Excel.xsl"));
        xtExcel.Transform(xml, null, this.Response.OutputStream);
        this.Response.End();
    }
}