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

public partial class UniqueCodeTracking_ : System.Web.UI.Page
{
    public static string conn = ConfigurationManager.AppSettings["F22AS"];

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GetList(string strUniqCode)
    {
        using (SqlConnection connection = new SqlConnection(conn))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SP_InquiryOnlyCode_Sell";
            cmd.CommandType = CommandType.StoredProcedure;//存储过程
            cmd.Connection = connection;//数据库连接

            cmd.Parameters.Add("@GBID", SqlDbType.NVarChar, 12);
            cmd.Parameters["@GBID"].Value = strUniqCode;

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            connection.Open();
            adapter.Fill(ds);
            connection.Close();

            DataTable dtResult = ds.Tables[0];

            int rowCount = dtResult.Rows.Count;

            if (rowCount == 0)
            {
                Response.Write("<script>alert('查询无数据，请核对唯一码编号！')</script>");
            }

            RpInfos.DataSource = dtResult;
            RpInfos.DataBind();
        }
    }

    protected void UniqCodeSearch(object sender, EventArgs e)
    {
        string strUniqCode = txtUniqueCode.Text.ToString();
        int iUCLength = strUniqCode.Length;

        if (iUCLength == 0)
        {
            Response.Write("<script>alert('请输入唯一码编号')</script>");
            return;
        }
        else if (iUCLength > 0)
        {
            GetList(strUniqCode);
        }

    }
}

