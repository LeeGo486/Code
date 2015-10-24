using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DAO;
using EPReper.Model;
using System.Data.SqlClient;
using System.Configuration;

namespace EPReper.Web.View
{
    public partial class PinHistory : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        static string userid = "";
        string username = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }
                SetDropList();
                UserDateBind();
                GetAdmin();
            }
        }

        public void GetAdmin()
        {
            EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
            CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (int.Parse(healadminmgr.GetTotalCount(" username='" + username + "' ")) > 0)
            {
                admins.Visible = true;
                admins1.Visible = true;
                admins2.Visible = true;
            }

        }


        public void UserDateBind()
        {
            CommonDao<V_HealthScoreHistory> HealthUserScoremgr = new CommonDao<V_HealthScoreHistory>();
            string condition = " 1=1 ";
            if (this.TextBox1.Text.Trim() != "")
            {
                condition = condition + " and  USERNAME like '%" + this.TextBox1.Text.ToString() + "%'";
            }
            if (this.TextBox2.Text.Trim() != "")
            {
                condition = condition + " and  STARTTIME >'" + this.TextBox2.Text.ToString() + "'";
            }
            if (this.TextBox3.Text.Trim() != "")
            {
                condition = condition + " and  STARTTIME <'" + this.TextBox3.Text.ToString() + "'";
            }
            if (this.DropDownList2.Text.Trim() != "")
            {
                condition = condition + " and  USERDOCTOR ='" + this.DropDownList2.Text.ToString() + "'";
            }
            if (this.TextBox4.Text.Trim() != "")
            {
                string value = this.TextBox4.Text.ToString();
                condition = condition + " and  ( LIDAO <" + value + " or SHUSHIDU  <" + value + " or  LIAOXIAO  <" + value + " or  JIFA <" + value + "  or  FUWUTAIDU   <" + value + ")";

            }

            if (this.TextBox5.Text.Trim() != "")
            {
                string value = this.TextBox5.Text.ToString();
                condition = condition + " and  ( TOTALSUM < " + value + ")";

            }

            //if (this.DropDownList1.Text.Trim() != "")
            //{
            //    condition = condition + " and  userstate='" + this.DropDownList1.Text.ToString() + "'";
            //}
            AspNetPager1.RecordCount = int.Parse(HealthUserScoremgr.GetTotalCount(condition));
            Repeater1.DataSource = HealthUserScoremgr.FindAllByPageDesc(((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize).ToString(), AspNetPager1.PageSize.ToString(), condition);
            Repeater1.DataBind();

        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            UserDateBind();
        }

        protected void BtnSearch_Clik(object sender, EventArgs e)
        {
            UserDateBind();

        }

        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
        private void Show(string msg, string close)
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language='javascript' defer>alert('" + msg + "');" + close + "</script>");
        }

        private void SetDropList()
        {
            string Sql = "SELECT  distinct ORDERDOCTOR  FROM [EPHealth].[dbo].[HealthSchedule]  ";
            DataTable dt = Query(Sql).Tables[0];
            this.DropDownList2.Items.Clear();
            DropDownList2.DataSource = dt;
            DropDownList2.DataTextField = "ORDERDOCTOR";
            DropDownList2.DataValueField = "ORDERDOCTOR";
            DropDownList2.DataBind();
            DropDownList2.Items.Insert(0, new ListItem("", ""));

        }

        public static DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]))
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

        protected void BtnSaveToExcel(object sender, EventArgs e)
        {

            string SqlString = "  SELECT USERNAME as 用户 ,USERTEL as 电话号码,USERDEPT as 部门,USERDOCTOR as 医师 ,"
                        + " USERDATE as 星期 ,USERTIME as 时间段 ,USERSTATE as 状态,CONVERT(varchar(100), STARTTIME, 23)  as 日期 ,"
                        + " LIDAO AS 力道,SHUSHIDU  as 舒适度,LIAOXIAO as 疗效,JIFA as 技法,FUWUTAIDU as 服务态度 ,TOTALSUM as 总体满意度,DESCRIPTION as 评价描述 "
                        + " FROM [EPHealth].[dbo].[V_HealthScoreHistory] where 1=1 ";
            string condition = "";
            DataSet ds1 = new DataSet();

            if (this.TextBox1.Text.Trim() != "")
            {
                condition = condition + " and  USERNAME like '%" + this.TextBox1.Text.ToString() + "%'";
            }
            if (this.TextBox2.Text.Trim() != "")
            {
                condition = condition + " and  STARTTIME >'" + this.TextBox2.Text.ToString() + "'";
            }
            if (this.TextBox3.Text.Trim() != "")
            {
                condition = condition + " and  STARTTIME <'" + this.TextBox3.Text.ToString() + "'";
            }
            if (this.DropDownList2.Text.Trim() != "")
            {
                condition = condition + " and  USERDOCTOR ='" + this.DropDownList2.Text.ToString() + "'";
            }
            if (this.TextBox4.Text.Trim() != "") {
                string value=this.TextBox4.Text.ToString();
                condition = condition + " and  ( LIDAO<" + value + " or SHUSHIDU  <" + value + " or  LIAOXIAO  <" + value + " or  JIFA <" + value + "  or  FUWUTAIDU   <" + value + ")"; 

            }
            if (this.TextBox5.Text.Trim() != "")
            {
                string value = this.TextBox5.Text.ToString();
                condition = condition + " and  ( TOTALSUM <" + value + ")";
            }

            //if (this.DropDownList1.Text.Trim() != "")
            //{
            //    condition = condition + " and  userstate='" + this.DropDownList1.Text.ToString() + "'";
            //}
            ds1 = Query(SqlString + condition);

            CreateExcel(ds1, "HealthPinJia" + DateTime.Now.Date.ToShortDateString() + ".xls");

        }

        public void CreateExcel(DataSet ds, string FileName)
        {
            HttpResponse resp;
            resp = Page.Response;
            resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            resp.ContentType = "application/ms-excel";//设置输出文件类型为excel文件。 
            resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);
            string colHeaders = "", ls_item = "";

            DataTable dt = ds.Tables[0];
            DataRow[] myRow = dt.Select();//可以类似dt.Select("id>10")之形式达到数据筛选目的

            int i = 0;
            int cl = dt.Columns.Count;

            //取得数据表各列标题，各标题之间以\t分割，最后一个列标题后加回车符 
            for (i = 0; i < cl; i++)
            {
                if (i == (cl - 1))//最后一列，加\n
                {
                    colHeaders += dt.Columns[i].Caption.ToString() + "\n";
                }
                else
                {
                    colHeaders += dt.Columns[i].Caption.ToString() + "\t";
                }

            }
            resp.Write(colHeaders);
            //向HTTP输出流中写入取得的数据信息 

            //逐行处理数据   
            foreach (DataRow row in myRow)
            {
                //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据     
                for (i = 0; i < cl; i++)
                {
                    if (i == (cl - 1))//最后一列，加\n
                    {
                        ls_item += row[i].ToString() + "\n";
                    }
                    else
                    {
                        ls_item += "'" + row[i].ToString() + "\t";
                    }

                }
                resp.Write(ls_item.ToString());
                ls_item = "";

            }
            resp.End();
        }

    }
}