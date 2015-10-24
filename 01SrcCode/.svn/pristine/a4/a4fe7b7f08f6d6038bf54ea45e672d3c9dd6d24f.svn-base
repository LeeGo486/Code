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
using DBPWDHelper;

public partial class ReportMakeSKU : System.Web.UI.Page
{
    //M3
    public static string connstr = GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthCode86"].ToString(),
                                                                     ConfigurationManager.AppSettings["UserName86"].ToString(),
                                                                     ConfigurationManager.AppSettings["DB86"].ToString(),
                                                                     ConfigurationManager.AppSettings["Env86"].ToString());

    // 贝爱 多加一个EP的M3
    public static string epconnstr = GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["EP_AuthCode86"].ToString(),
                                                                     ConfigurationManager.AppSettings["EP_UserName86"].ToString(),
                                                                     ConfigurationManager.AppSettings["EP_DB86"].ToString(),
                                                                     ConfigurationManager.AppSettings["EP_Env86"].ToString());



    //DRP
    public static string connstr2 = GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthCode"].ToString(),
                                                                     ConfigurationManager.AppSettings["UserName"].ToString(),
                                                                     ConfigurationManager.AppSettings["DB"].ToString(),
                                                                     ConfigurationManager.AppSettings["Env"].ToString());

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
      public DataSet GetList(string storeProcName, string strSKC, string strSize,String erp)
        {
            SqlConnection connection1= null;
            if (erp == "dlerp")
            {
                connection1 = new SqlConnection(connstr);
            }
            else
            {
                connection1 = new SqlConnection(epconnstr);
            };  
            

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
                    if (GetCount(SKC) == "0")//drp中检索 款式是否存在
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
                            dt = GetList("sP_SKC_WUKC", SKC, Size,"dlerp");//ERP中检索
                            if (dt.Tables[0].Rows.Count == 0)// 判断是否有明细
                            {
                                //没有明细再去eperp找找
                                dt = GetList("sP_SKC_WUKC", SKC, Size, "eperp");
                                                         
                            }


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
                                    int count3 = 0;  //判断可造件数是否都为0
                                    for (int k = 0; k < dt.Tables[0].Rows.Count; k++)
                                    {
                                        if (dt.Tables[0].Rows[k][13].ToString() == "0")
                                        {
                                            count3++;
                                        }
                                    }
                                    if (count3 == 0)   // 可造件数都不为0
                                    {
                                        MsgShow("提示", "此款式满足定制条件，可以定制！");
                                    }
                                    else // 可造件数部分为0
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
        // string AccountCode = ((DataRowView)e.Item.DataItem).Row["可造件数"].ToString();
        //颜色条件：在库库存为0，待检库存不为0，显示黄色。其余维护不变
        string n1 = ((DataRowView)e.Item.DataItem).Row["在库库存"].ToString();
        string n2 = ((DataRowView)e.Item.DataItem).Row["待检库存"].ToString();
        if (n1.Trim() == "0.000000" && n2.Trim() == "0.000000")
        {
            HtmlTableRow col = (HtmlTableRow)e.Item.FindControl("tr1");
            //取列值   HtmlTableCell col1 = (HtmlTableCell)e.Item.FindControl("td1");
            col.BgColor = "#FF9999";
            // col1.BgColor = "black";
        }


        if (n1.Trim() == "0.000000" && n2.Trim() != "0.000000")
        {
            HtmlTableRow col = (HtmlTableRow)e.Item.FindControl("tr1");
            col.BgColor = "#FFFF00";
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
