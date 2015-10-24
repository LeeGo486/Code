using Ext.Net;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GQQ_DevelopHelper;
using System.Configuration;
using System.Data;
using System.Xml;
using System.Xml.Xsl;

public partial class VIPSearch : System.Web.UI.Page
{
    string depotid;//获取传入的店铺名称
    protected void Page_Load(object sender, EventArgs e)
    {
        depotid = Request["depotid"];//获取传入的店铺名称
        depotid = "W1060001";

        DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];

        DevelopHelper.SqlStr = String.Format("SELECT employeeid,names tz_name FROM dbo.j_employee with(nolock) WHERE depotid='{0}' AND valid=0", depotid);
        DataSet ds = DevelopHelper.SQL_ReturnDateSet;
        tz_name_Store.DataSource = ds;
        tz_name_Store.DataBind();

        DevelopHelper.SqlStr = String.Format("select lookname vipoccupation from j18_lookupsub WHERE lookupid='3001'");
        DataSet vipoccupationds = DevelopHelper.SQL_ReturnDateSet;
        vipoccupation_Store.DataSource = vipoccupationds;
        vipoccupation_Store.DataBind();

        DevelopHelper.SqlStr = String.Format("select lookname vipgrab from j18_lookupsub WHERE lookupid='3006'");
        DataSet vipgrabds = DevelopHelper.SQL_ReturnDateSet;
        vipgrab_Store.DataSource = vipgrabds;
        vipgrab_Store.DataBind();

        DevelopHelper.SqlStr = String.Format("select lookname viplove from j18_lookupsub WHERE lookupid='3009'");
        DataSet viploveds = DevelopHelper.SQL_ReturnDateSet;
        viplove_Store.DataSource = viploveds;
        viplove_Store.DataBind();

        DevelopHelper.SqlStr = String.Format(" SELECT Name,provinceId FROM dbo.J_ChinaArea WHERE ParentID =0 ");
        DataSet provinceds = DevelopHelper.SQL_ReturnDateSet;
        province_Store.DataSource = provinceds;
        province_Store.DataBind();

        //DataSet vipcolorDt = DbHelperSQL.Query("select lookname from j18_lookupsub WHERE lookupid='3007'");
        //vipcolor.DataSource = vipcolorDt;
        //vipcolor.DataBind();
    }

    protected void Report_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        try
        {
            //if (TxtVIPNo.Text.Trim().Length <= 0)
            //{
            //    X.MessageBox.Alert("提醒", "请输入VIP卡号！").Show();
            //    return;
            //}
            string strTempWhere = "";
            string StrVipNo = TxtVIPNo.Text.Trim();//VIP卡号
            string StrVipPhone = TxtVIPPhone.Text.Trim();//手机
            string StrVipName = TxtVIPName.Text.Trim();//姓名
            if (StrVipNo == "" && StrVipPhone == "" && StrVipName == "")
            {
                strTempWhere = "";
            }
            else
            {
                if (StrVipNo != "")
                {
                    strTempWhere += " AND vipcode='" + StrVipNo + "' ";
                }
                if (StrVipPhone != "")
                {
                    strTempWhere += " AND mobtel='" + StrVipPhone + "' ";
                }
                if (StrVipName != "")
                {
                    strTempWhere += " AND vipname='" + StrVipName + "' ";
                }
            }


            string sql = @"SELECT   CONVERT(VARCHAR(10), crdate, 21) crdate,vipsex, vipcode , vipname , vipstate , centum , pcentum , mobtel ,  CONVERT(VARCHAR(10), vipbirth, 21) vipbirth , 
                                  tz_name , vipoccupation , vipid , FBuyID ,  CONVERT(VARCHAR(10), viplastdate, 21) viplastdate , lastSums,vip_photo , add_province 
                                  , vipadd ,  vipname , vipsex , Employeeid , tz_name , mobtel ,  CONVERT(VARCHAR(10), vipbirth, 21) vipbirth , vipoccupation , FBuyID  
                                  , add_city , vipadd , vip_communi , vipgrab , viplove , vipbrand1 , vipbrand2 , vipbrand3 , stature , vip_body , vip_skin , vippaper 
                                  , vip_cosmetic , vip_drink , vipcolor , vip_news , vip_gift
                          FROM    vip_user WITH(NOLOCK) WHERE  ISNULL(vipid,'') != '' and  depotid = '{0}'";
            DevelopHelper.SqlStr = String.Format(sql + strTempWhere, depotid);
            DataTable dt = DevelopHelper.SQL_ReturnDateTable;
            if (dt.Rows.Count < 1)
            {
                X.MessageBox.Alert("提醒", "请检查条件！").Show();
                return;
            }
            VIPStore.DataSource = dt;
            VIPStore.DataBind();
        }
        catch (Exception error)
        {
            X.MessageBox.Alert("异常", error.Message).Show();
        }
    }

    public void SaveUpdate(object sender, DirectEventArgs e)
    {


        if (Textvipname.Text.Contains("姐"))
        {
            X.MessageBox.Alert("异常", "您输入姓名含有姐字样").Show();
            return;
        }
        if (Textvipname.Text.Contains("经理"))
        {
            X.MessageBox.Alert("异常", "您输入姓名含有经理字样").Show();
            return;
        }
        if (Textvipname.Text.Contains("老师"))
        {
            X.MessageBox.Alert("异常", "您输入姓名含有老师字样").Show();
            return;
        }
        if (Textvipname.Text.Contains("总"))
        {
            X.MessageBox.Alert("异常", "您输入姓名含有总字样").Show();
            return;
        }
        if (Textvipname.Text.Contains("经理"))
        {
            X.MessageBox.Alert("异常", "您输入姓名含有姐经理").Show();
            return;
        }
        if (Textmobtel.Text.Length < 11)
        {
            X.MessageBox.Alert("异常", "请正确填写手机号").Show();
            return;
        }

        DevelopHelper.SqlStr = String.Format(" SELECT * FROM vip_user WHERE vipid !='{0}' AND mobtel='{1}'", Hidvipid.Text, Textmobtel.Text);
        //int mobtelRecord = DevelopHelper.SQL_ExecuteNonQuery("vip_user.vipid", "vip_user INNER JOIN vip_cardvip ON dbo.vip_user.vipid = dbo.vip_cardvip.vipid", "vip_cardvip.viptypeid IN ('E1','E2','E3','E4') AND vip_user.mobtel='" + mobtel.Text.Trim() + "'");
        int mobtelRecord = DevelopHelper.SQL_ExecuteNonQuery;
        if (mobtelRecord >= 1)
        {
            X.MessageBox.Alert("异常", "您输入的手机号已经存在").Show();
            return;
        }

        string sql = @" UPDATE vip_user SET  vipsex='{0}',vipname='{1}',mobtel='{2}',vipbirth='{3}',tz_name='{4}',Employeeid='{5}',vipoccupation='{6}',
                        add_province='{7}',add_city='{9}',vipadd='{10}',vip_communi ='{11}', vipgrab='{12}', viplove='{13}' , vipbrand1='{14}' , vipbrand2='{15}',
                        vipbrand3='{16}' ,stature='{17}' , vip_body ='{18}',vip_skin ='{19}', vippaper='{20}'  , vip_cosmetic='{21}' , vip_drink='{22}' , 
                        vipcolor ='{23}', vip_news='{24}' , vip_gift='{25}'  WHERE vipid ='{26}'";
        DevelopHelper.SqlStr = String.Format(sql, Cbovipsex.Text, Textvipname.Text, Textmobtel.Text, Textvipbirth.Text, Cbotz_name.SelectedItem.Text, Cbotz_name.Value, Cbotvipoccupation.Text,
                        Cboadd_province.SelectedItem.Text, "", Cboadd_city.SelectedItem.Text, Textvipadd.Text, Textvip_communi.Text, Cbovipgrab.Text, Cboviplove.Text, Textvipbrand1.Text, Textvipbrand2.Text,
                        Textvipbrand3.Text, Textstature.Text, Textvip_body.Text, Textvip_skin.Text, Textvippaper.Text, Textvip_cosmetic.Text, Textvip_drink.Text
                        , Textvipcolor.Text, Textvip_news.Text, Textvip_gift.Text, Hidvipid.Text);
        if (DevelopHelper.SQL_ExecuteSql > 0)
        {
            MsgBox.MessageShow("操作完成，成功", "OK");
        }
        else
        {
            MsgBox.NotifiShow("失败", "OK");
        }
    }

    protected void CityChange(object sender, StoreRefreshDataEventArgs e)
    {
        string strprovinceId = e.Parameters["city"].ToString();

        DevelopHelper.SqlStr = String.Format(" SELECT name FROM dbo.J_ChinaArea WHERE  Grade='2' AND provinceId='{0}'", strprovinceId);
        DataSet cityds = DevelopHelper.SQL_ReturnDateSet;
        city_Store.DataSource = cityds;
        city_Store.DataBind();
    }
}