using System;
using System.Globalization;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Web.UI.HtmlControls;
using System.Configuration;

public partial class ReportMakeSKU : System.Web.UI.Page
{
    //public static string connstr = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey86"], "001", "EP_ERP_AS", "PROD");//"Data Source=192.168.0.86;User ID=epuser;Password=epuser.report100319;DataBase=elegant_prod;";
    public static string connstr = ConfigurationManager.AppSettings["elegant_prod"];

    //public static string connstr2 = DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey102"], "004", "EP_DRP_ZH", "PROD");//"Data Source=192.168.0.102;User ID=ERPuser;Password=ERPuser2010;DataBase=F22;";
    public static string connstr2 = ConfigurationManager.AppSettings["F22"];
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    public string GetCount(string SKC)
    {
        SqlConnection connection = new SqlConnection(connstr2);
        string SQLString = " SELECT COUNT(*) FROM j_clothing  WHERE STYLEID+COLORID='" + SKC + "'";
        DataSet ds = new DataSet();
        try
        {
            connection.Open();
            SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
            command.Fill(ds, "ds");
            return ds.Tables[0].Rows[0][0].ToString();
        }
        catch
        {
            return "0";
        }
        finally
        {
            connection.Close();
        }

    }
    public DataSet GetList(string storeProcName, string strSKC, string strSize)
    {
        using (SqlConnection connection1 = new SqlConnection(connstr))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = storeProcName;
            cmd.CommandType = CommandType.StoredProcedure;//存储过程
            cmd.Connection = connection1;//数据库连接

            cmd.Parameters.Add("@SKC", SqlDbType.VarChar, 1000);
            cmd.Parameters["@SKC"].Value = strSKC;

            cmd.Parameters.Add("@sizeid", SqlDbType.VarChar, 10);
            cmd.Parameters["@sizeid"].Value = strSize;


            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            connection1.Open();
            adapter.Fill(ds);
            connection1.Close();
            return ds;

        }
    }
    protected void Detail_InfoBind(object sender, EventArgs e)
    {
        DataSet dt = new DataSet();

        string SKC = this.TextBox_skc.Text.ToString().Trim();
        string Size = this.TextBox_Size.Text.ToString().Trim();
        if ((Size == "" && SKC == "") || (Size != "" && SKC == ""))
        {
            MsgShow("提示", "请输入款式颜色编号");
        }
        else
        {
            if (Size == "")
            {
                Size = " ";
            }
            if (SKC != "")
            {
                if (GetCount(SKC) == "0")
                {
                    MsgShow("提示", "输入的款式颜色编号不存在");
                }
                else
                {
                    int count = 0;
                    string numBer = SKC.Substring(5, 1);//判断款式编号第六位
                    string[] numBerCompare = new string[8] { "1", "2", "3", "4", "5", "6", "7", "8" };
                    foreach (string a in numBerCompare)
                    {
                        if (numBer == a)
                        {
                            count++;
                        }
                    }
                    if (count != 0)//判断款式编号第六位
                    {
                        dt = GetList("sP_SKC_WUKC", SKC, Size);
                        if (dt.Tables[0].Rows.Count == 0)// 判断是否有明细
                        {
                            MsgShow("提示", "此款式客定需要确认,请与公司相关人员联系！");
                        }
                        else
                        {
                            int count2 = 0;
                            for (int i = 0; i < dt.Tables[0].Rows.Count; i++)
                            {
                                if (dt.Tables[0].Rows[i][6].ToString() == "面料")
                                {
                                    count2++;
                                }
                            }


                            if (count2 == 0)//没有面料
                            {
                                MsgShow("提示", "此款式客定需要确认,请与公司相关人员联系！");
                            }
                            else
                            {
                                int count3 = 0;
                                for (int k = 0; k < dt.Tables[0].Rows.Count; k++)
                                {
                                    if (dt.Tables[0].Rows[k][12].ToString() == "0")
                                    {
                                        count3++;
                                    }
                                }
                                if (count3 == 0)
                                {
                                    MsgShow("提示", "此款式满足定制条件，可以定制！");
                                }
                                else
                                {
                                    MsgShow("提示", "此款式客定需要确认,请与公司相关人员联系！");
                                }
                                RpInfos.DataSource = dt;
                                RpInfos.DataBind();
                            }
                        }
                    }
                    else
                    {
                        MsgShow("提示", "此款式客定需要确认,请与公司相关人员联系！");
                    }
                }

            }

        }
    }


    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        string AccountCode = ((DataRowView)e.Item.DataItem).Row["可造件数"].ToString();
        if (AccountCode.Trim() == "0")
        {
            HtmlTableRow col = (HtmlTableRow)e.Item.FindControl("tr1");
            //取列值   HtmlTableCell col1 = (HtmlTableCell)e.Item.FindControl("td1");
            col.BgColor = "#FF9999";
            // col1.BgColor = "black";
        }
    }

    /// <summary>

    /// 显示消息提示对话框 AJAX 使用时 用第一行的
    /// </summary>

    /// <param name="page">当前页面指针，一般为this</param>

    /// <param name="msg">提示信息</param>

    private void MsgShow(string title, string infos)
    {
        this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language='javascript' defer> alert('" + infos + "');</script>");
    }

    private void Show(string msg, string close)
    {
        this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language='javascript' defer>alert('" + msg + "');" + close + "</script>");
    }
}