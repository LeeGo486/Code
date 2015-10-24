using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using HZY.COM.DBAccess;

public partial class VipticktMotelRecord : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            GetData();
        }
    }
    protected void GetData()
    {
        //Dbconn conn = new Dbconn("ConnectionString_CUSSMS");

        string strConnstr = ConfigurationManager.AppSettings["ConnectionString_CUSSMS"];
        Dbconn conn = new Dbconn(strConnstr, true);

        string strMessage = "";
        string strPhone = this.txtPhone.Text;

        if (strPhone.Trim() != "")
        {
            DataTable dt = conn.GetDataTable(@"SELECT [VM1_CONO]
                                              ,[VM1_DIVI]
                                              ,[VM1_Ticketid]
                                              ,[VM1_Mobtel]
                                              ,[VM1_Rgdt]
                                              ,[VM1_LMDT]
                                          FROM [CUSSMS].[B01_MDM].[VM1_VipticktMotelRecord]
                                          WHERE VM1_Mobtel=@Param0
                                            AND VM1_CONO=100
                                            AND VM1_DIVI='D01'", new string[1] { strPhone });

            if (dt.Rows.Count > 0)
            {
                strMessage = "<div>查询结果<p>";
                strMessage += "手 机 号：" + dt.Rows[0]["VM1_Mobtel"].ToString() + "<p>";
                strMessage += "券　　号：" + dt.Rows[0]["VM1_Ticketid"].ToString() + "<p>";
                strMessage += "申请时间：" + dt.Rows[0]["VM1_LMDT"].ToString() + "<p></div>";
            }
            else
            {
                strMessage = "<font color='red'>没有查询到手机号为" + strPhone + "的相关信息，请重试</font>";
            }
        }
        else
        {
            strMessage = "<font color='red'>手机号不能为空</font>";
        }

        this.lblMessage.Text = strMessage;
    }
}