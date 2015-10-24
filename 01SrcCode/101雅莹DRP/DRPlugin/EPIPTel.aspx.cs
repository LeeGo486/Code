
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class EPIPTel : System.Web.UI.Page
{
    //static DataBaseService.GetDBPwdSoapClient soap = new DataBaseService.GetDBPwdSoapClient();
    public static string connectionString = ConfigurationManager.AppSettings["ConnectionString"];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShopBind();
            HeadBind();
            TreeDateBind();
            this.TextBox1.Attributes.Add("onkeydown", "if(event.which||event.keyCode){if ((event.which==13 ) || (event.keyCode==13)) { document.getElementById('" + this.Button1.ClientID + "').click();return false;}}else{return true};");
        }
    }
    private void TreeDateBind()
    {
        string sqlDQ = "SELECT DISTINCT (DQ)  FROM [EPSysAccounts].[dbo].[CallCenterSearch] ORDER BY DQ ";
        DataTable dtDQ = Query(sqlDQ).Tables[0];
        string divhiml = "<ul id='browser' class='filetree' >";
        for (int i = 0; i < dtDQ.Rows.Count; i++)
        {
            divhiml = divhiml + "  <li class='closed' ><span>" + dtDQ.Rows[i][0].ToString() + "</span><ul>";
            string sqlSHOPCS = "SELECT DISTINCT SHOPCS FROM [EPSysAccounts].[dbo].[CallCenterSearch] WHERE DQ='" + dtDQ.Rows[i][0].ToString() + "' ORDER BY SHOPCS";
            DataTable dtSHOPCS = Query(sqlSHOPCS).Tables[0];
            for (int j = 0; j < dtSHOPCS.Rows.Count; j++)
            {
                divhiml = divhiml + "  <li  class='closed' ><span>" + dtSHOPCS.Rows[j][0].ToString() + "</span><ul>";
                string sqlCallNum = " SELECT  SHOPNAME,CALLCENTERNUM  FROM [EPSysAccounts].[dbo].[CallCenterSearch] WHERE DQ='" + dtDQ.Rows[i][0].ToString() + "' and SHOPCS='" + dtSHOPCS.Rows[j][0].ToString() + "' ORDER BY CALLCENTERNUM ";
                DataTable dtCallNum = Query(sqlCallNum).Tables[0];
                for (int k = 0; k < dtCallNum.Rows.Count; k++)
                {
                    divhiml = divhiml + " <li >" + dtCallNum.Rows[k][0].ToString() + "(" + dtCallNum.Rows[k][1].ToString() + ")" + "<a href=\"javascript:;\" onclick=\"CopayValue('" + dtCallNum.Rows[k][1].ToString() + "')\">复制</a></li>";
                }
                divhiml = divhiml + " </ul></li>";
            }
            divhiml = divhiml + " </ul></li>";
        }
        divhiml = divhiml + " </ul>";
        this.DivTree.InnerHtml = divhiml;
    }

    public static DataSet Query(string SQLString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            DataSet ds = new DataSet();
            try
            {
                connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.Fill(ds, "ds");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {

            }
            return ds;
        }
    }


    public void ShopBind()
    {
        string condition = "";
        string SQLstring = "";
        if (this.TextBox1.Text.Trim().ToString() != "")
        {

            condition = " WHERE SHOPNAME LIKE '%" + this.TextBox1.Text.Trim().ToString() + "%' "
                 + " OR PINYIN  LIKE '%" + this.TextBox1.Text.Trim().ToString() + "%' ";
            SQLstring = "SELECT [DQ],SUPERVISOR,CHANNEL,[CALLCENTERNUM],[SHOPNAME],[SHOPSF],[SHOPCS],[PINYIN] FROM [EPSysAccounts].[dbo].[SSH_CallCenterSearch] " + condition;
            Repeater1.DataSource = Query(SQLstring);
            Repeater1.DataBind();
        }
        else
        {

            condition = " WHERE 1=1 ";
            SQLstring = "SELECT [DQ],SUPERVISOR,CHANNEL,[CALLCENTERNUM],[SHOPNAME],[SHOPSF],[SHOPCS],[PINYIN] FROM [EPSysAccounts].[dbo].[SSH_CallCenterSearch] " + condition;
            Repeater1.DataSource = Query(SQLstring);
            Repeater1.DataBind();
        }
    }

    public void HeadBind()
    {
        string SQLstring = "";
        SQLstring = "SELECT [Department],[Name],[Postion] ,[CallCenterNum] FROM [EPSysAccounts].[dbo].[CALLCENTERHEAD] where remark=0 ";
        Repeater2.DataSource = Query(SQLstring);
        Repeater2.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ShopBind();
    }

}
