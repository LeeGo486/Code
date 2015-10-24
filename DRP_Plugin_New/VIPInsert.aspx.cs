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

public partial class VIPInsert : System.Web.UI.Page
{
    string depotid;//获取传入的店铺编号
    string userid;//获取传入的操作员编号
    string zt;//获取传入帐套
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!X.IsAjaxRequest)
        //{
        depotid = Request["depotid"];//获取传入的店铺编号
        userid = Request["userid"];//获取传入的操作员编号
        zt = Request["zt"];//获取传入帐套

        //X.MessageBox.Alert("传入参数提示", "店铺编号：" + depotid + "操作员编号：" + userid + "帐套：" + zt).Show();

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

        //沟通方式
        DevelopHelper.SqlStr = String.Format("select lookname liketalktype from j18_lookupsub WHERE lookupid='3012'");
        DataSet vipliketalktype = DevelopHelper.SQL_ReturnDateSet;
        vipliketalktype_Store.DataSource = vipliketalktype;
        vipliketalktype_Store.DataBind();

        //体形
        DevelopHelper.SqlStr = String.Format("select lookname body from j18_lookupsub WHERE lookupid='3026'");
        DataSet body = DevelopHelper.SQL_ReturnDateSet;
        body_Store.DataSource = body;
        body_Store.DataBind();

        DevelopHelper.SqlStr = String.Format(" SELECT Name,provinceId FROM dbo.J_ChinaArea WHERE ParentID =0 ");
        DataSet provinceds = DevelopHelper.SQL_ReturnDateSet;
        province_Store.DataSource = provinceds;
        province_Store.DataBind();
        //}
    }

    public void SaveInsert(object sender, DirectEventArgs e)
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


        DateTime dtNow = DateTime.Now;
        DevelopHelper.SqlStr = String.Format(@" SELECT A.* FROM dbo.vip_user a WITH(NOLOCK)  INNER JOIN dbo.j_depot b WITH(NOLOCK)  ON a.depotid = b.depotid AND 
                               b.unitid IN (SELECT  unitid FROM dbo.j_depot  WITH(NOLOCK) WHERE depotid='{0}') WHERE A.mobtel = '{1}' ", depotid, Textmobtel.Text);
        //int mobtelRecord = DevelopHelper.SQL_ExecuteNonQuery;

        DataTable mobtelRecord = DevelopHelper.SQL_ReturnDateTable;

        if (mobtelRecord.Rows.Count > 0)
        {
            X.MessageBox.Alert("异常", "您输入的手机号已经存在").Show();
            return;
        }

        //验证首单
        //
        string FCalcSums = DBNull.Value.ToString();//实收金额
        string discount = DBNull.Value.ToString();//折扣
        string sure_date = DBNull.Value.ToString();//首单购买日期

        if (TextFBuyID.Text != "")
        {
            DevelopHelper.SqlStr = String.Format(@"SELECT  sure_date,FCalcSums, CASE WHEN ISNULL(zjsums,'') =0 THEN 0 else CONVERT(decimal(18,2),FCalcSums/zjsums)  
                                                       END discount   FROM d_Retail WITH (NOLOCK) WHERE retailid ='{0}' ", TextFBuyID.Text);
            DataTable FBuyID = DevelopHelper.SQL_ReturnDateTable;

            if (FBuyID == null || FBuyID.Rows.Count == 0)
            {
                X.MessageBox.Alert("异常", "首单不存在").Show();
                return;
            }
            else
            {
                if (FBuyID.Rows.Count != 0)
                {
                    FCalcSums = FBuyID.Rows[0]["FCalcSums"].ToString();//授权码
                    discount = FBuyID.Rows[0]["discount"].ToString();//授权码
                    sure_date = FBuyID.Rows[0]["sure_date"].ToString();//授权码
                }
            }
        }

        //验证首单是否绑定了多人

        DevelopHelper.SqlStr = String.Format(@"SELECT COUNT(*) FROM   dbo.vip_user WITH(NOLOCK) WHERE  ISNULL(FBuyID,'') = '{0}' AND FBuyID  !='' ", TextFBuyID.Text);
        //DataTable FBuyIDflag = DevelopHelper.SQL_ReturnDateTable;
        string FBuyIDflag = DevelopHelper.GetDataTableFirstValue;

        if (FBuyIDflag != "0")
        {
            X.MessageBox.Alert("异常", "首单已经绑定了别的顾客！请检查").Show();
            return;
        }

        #region 取配置
        string vipid = "";
        string strMaxvipcode = "";
        string f18pass = ""; string Prefix = ""; string viptypeid = "";


        DevelopHelper.SqlStr = String.Format("SELECT setval  FROM dbo.vip_setup WHERE setid =1");
        string setvaldt = DevelopHelper.GetDataTableFirstValue;//取VIPID前缀


        if (setvaldt == "")
        {
            X.MessageBox.Alert("异常", "vip_setup配置异常，请联系信息管理部！").Show();
            return;
        }

        DevelopHelper.SqlStr = String.Format(@"SELECT [f18pass] ,[Prefix],[viptypeid] FROM [DRP_REPORT].[dbo].[EP_Affiliate_VIP_Config]  WHERE [f18pass]='{0}'", zt);
        DataTable configdt = DevelopHelper.SQL_ReturnDateTable;

        if (configdt.Rows.Count == 0)
        {
            X.MessageBox.Alert("异常", "EP_Affiliate_VIP_Config配置异常，请联系信息管理部！").Show();
            return;
        }

        f18pass = configdt.Rows[0][0].ToString();//授权码
        Prefix = configdt.Rows[0][1].ToString();//卡号前缀
        viptypeid = configdt.Rows[0][2].ToString();//VIP卡类型

        #endregion

        #region 取VIPID

        int nNum = 1;//默认是0
        vipid = setvaldt + userid + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
        for (int j = 0; j < 100000; j++)
        {
            DevelopHelper.SqlStr = String.Format(" SELECT COUNT(*) count  FROM dbo.vip_user WITH(NOLOCK)  WHERE vipid ='{0}'", vipid);
            string strflagvip_cardvip = DevelopHelper.GetDataTableFirstValue;
            if (strflagvip_cardvip == "0")
            {
                break;
            }
            else
            {
                nNum++;
                vipid = setvaldt + userid + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
                continue;
            }
        }

        #endregion

        #region 取VIPCODE

        DevelopHelper.SqlStr = String.Format(@"SELECT MAX(RIGHT(vipcardid,6))+1 FROM vip_cardvip WHERE ISNUMERIC(RIGHT(vipcardid, 6)) = 1 and 
                                              LEFT(vipcardid," + Prefix.Length + ")='{0}'", Prefix);
        string strflag = DevelopHelper.GetDataTableFirstValue;
        if (strflag == "")
        {
            strMaxvipcode = Prefix + "000000";
        }
        else
        {
            strMaxvipcode = Prefix + Convert.ToInt32(strflag).ToString("000000");
        }
        #endregion

        #region 变相解决 等有时间弄

        if (TextFBuyID.Text == "")
        {
            string sql = @"insert into dbo.vip_user 
                       (vipid,vipcode,depotid ,vipsex,vipname,mobtel,vipbirth,tz_name,Employeeid,vipoccupation,
                        add_province,add_city,vipadd,liketalktype, vipgrab, viplove , vipbrand1 , vipbrand2,
                        vipbrand3 ,stature, body,vip_skin , favouritesbook , vip_cosmetic , vip_drink , 
                        vipcolor , vip_news , hopegift,viptypeid,FBuyID,FBuyDate,add_region)
                        ( SELECT
                        '{0}' vipid,'{1}' vipcode,'{2}' depotid ,'{3}' vipsex,'{4}' vipname,'{5}' mobtel,'{6}' vipbirth,'{7}' tz_name,'{8}' Employeeid,'{9}' vipoccupation,
                        '{10}' add_province,'{11}' add_city,'{12}' vipadd,'{13}' liketalktype, '{14}' vipgrab, '{15}' viplove , '{16}' vipbrand1 , '{17}' vipbrand2,
                        '{18}' vipbrand3 ,'{19}' stature, '{20}' Body, '{21}' vip_skin , '{22}' favouritesbook , '{23}' vip_cosmetic ,
                        '{24}'  vip_drink , '{25}'vipcolor , '{26}'vip_news ,'{27}' hopegift ,'{28}'viptypeid,'{29}' FBuyID,'{30}' FBuyDate ,'{31}' add_region)";
            DevelopHelper.SqlStr = String.Format(sql, vipid, strMaxvipcode, depotid, Cbovipsex.Text, Textvipname.Text, Textmobtel.Text, Textvipbirth.Text, Cbotz_name.SelectedItem.Text, Cbotz_name.Value, Cbotvipoccupation.Text,
                            Cboadd_province.SelectedItem.Text, Cboadd_city.SelectedItem.Text, Textvipadd.Text, Cboliketalktype.Text, Cbovipgrab.Text, Cboviplove.Text, Textvipbrand1.Text, Textvipbrand2.Text,
                            Textvipbrand3.Text, Textstature.Text, Cbobody.Text, Textvip_skin.Text, Textfavouritesbook.Text, Textvip_cosmetic.Text, Textvip_drink.Text
                            , Textvipcolor.Text, Textvip_news.Text, Texthopegift.Text, viptypeid, TextFBuyID.Text, sure_date, Cboadd_county.Text);
        }
        else
        {
            string sql = @"insert into dbo.vip_user 
                       (vipid,vipcode,depotid ,vipsex,vipname,mobtel,vipbirth,tz_name,Employeeid,vipoccupation,
                        add_province,add_city,vipadd,liketalktype, vipgrab, viplove , vipbrand1 , vipbrand2,
                        vipbrand3 ,stature, body,vip_skin , favouritesbook , vip_cosmetic , vip_drink , 
                        vipcolor , vip_news , hopegift,viptypeid,FBuyID,FBuyDate,FBuySums,firstDisc,add_region)
                        ( SELECT
                        '{0}' vipid,'{1}' vipcode,'{2}' depotid ,'{3}' vipsex,'{4}' vipname,'{5}' mobtel,'{6}' vipbirth,'{7}' tz_name,'{8}' Employeeid,'{9}' vipoccupation,
                        '{10}' add_province,'{11}' add_city,'{12}' vipadd,'{13}' liketalktype, '{14}' vipgrab, '{15}' viplove , '{16}' vipbrand1 , '{17}' vipbrand2,
                        '{18}' vipbrand3 ,'{19}' stature, '{20}' Body, '{21}' vip_skin , '{22}' favouritesbook , '{23}' vip_cosmetic ,
                        '{24}'  vip_drink , '{25}'vipcolor , '{26}'vip_news ,'{27}' hopegift ,'{28}'viptypeid,'{29}' FBuyID,'{30}' FBuyDate, '{31}' FBuySums,'{32}'firstDisc,'{33}' add_region )";
            DevelopHelper.SqlStr = String.Format(sql, vipid, strMaxvipcode, depotid, Cbovipsex.Text, Textvipname.Text, Textmobtel.Text, Textvipbirth.Text, Cbotz_name.SelectedItem.Text, Cbotz_name.Value, Cbotvipoccupation.Text,
                            Cboadd_province.SelectedItem.Text, Cboadd_city.SelectedItem.Text, Textvipadd.Text, Cboliketalktype.Text, Cbovipgrab.Text, Cboviplove.Text, Textvipbrand1.Text, Textvipbrand2.Text,
                            Textvipbrand3.Text, Textstature.Text, Cbobody.Text, Textvip_skin.Text, Textfavouritesbook.Text, Textvip_cosmetic.Text, Textvip_drink.Text
                            , Textvipcolor.Text, Textvip_news.Text, Texthopegift.Text, viptypeid, TextFBuyID.Text, sure_date, FCalcSums, discount, Cboadd_county.Text);
        }
        #endregion

        int nvip_user = DevelopHelper.SQL_ExecuteSql;

        string strSQL1 = @"
                        INSERT INTO vip_cardvip(vipcardid,viptypeid,vipid,vipemit,vipemitadd,MaxDay,crdate,limitday,crname )
                        ( SELECT  '{0}' vipcardid,  '{1}' viptypeid, '{2}' vipid, '{3}'vipemit, '{4}' vipemitadd,'1000' MaxDay, '{5}' crdate,'9999' limitday,'{6}' crname )";

        DevelopHelper.SqlStr = String.Format(strSQL1, strMaxvipcode, viptypeid, vipid, dtNow, depotid, dtNow, userid);
        int nvip_cardvip = DevelopHelper.SQL_ExecuteSql;

        if (nvip_user > 0 || nvip_cardvip > 0)
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

        DevelopHelper.SqlStr = String.Format(" SELECT name, id FROM dbo.J_ChinaArea WHERE  Grade='2' AND provinceId='{0}'", strprovinceId);
        DataSet cityds = DevelopHelper.SQL_ReturnDateSet;
        city_Store.DataSource = cityds;
        city_Store.DataBind();
    }

    protected void CountyChange(object sender, StoreRefreshDataEventArgs e)
    {
        string strcountyId = e.Parameters["county"].ToString();

        DevelopHelper.SqlStr = String.Format(" SELECT name FROM dbo.J_ChinaArea WHERE  Grade='3' AND ParentID='{0}'", strcountyId);
        DataSet countyds = DevelopHelper.SQL_ReturnDateSet;
        county_Store.DataSource = countyds;
        county_Store.DataBind();
    }
}


