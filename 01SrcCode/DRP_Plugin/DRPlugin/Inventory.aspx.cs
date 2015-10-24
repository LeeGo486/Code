using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using CJ;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.Odbc;
using System.Text.RegularExpressions;
using System.Text;
using System.Data.SqlClient;
using System.Threading;

public partial class Inventory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["listno"] == null || Request["depotid"] == null)
        {
            X.Msg.Alert("异常", "参数错误！请关闭重试！").Show();
            return;
        }
        else
        {
            if (!IsPostBack)
                lblistno.Html = "盘点单号：" + Request["listno"].ToString() + "   <a href='Temp/temp.xls' target='_blank'>点击下载盘点模版文件</a>";
        }
    }
    
    protected void StartLongAction(object sender, DirectEventArgs e)
    {
        if (Request["listno"] == null || Request["depotid"] == null)
        {
            X.Msg.Alert("异常", "参数错误！请关闭重试！").Show();
            return;
        }
        string filename = UpFile.PostedFile.FileName;
        string ext = Path.GetExtension(filename).ToLower();
        if (ext != ".xls" && ext != ".xlsx" && ext != ".txt")
        {
            X.Msg.Alert("提示", "文件格式不正确，仅支持.xls,.txt格式文件！").Show();
            return;
        }
        filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
        UpFile.PostedFile.SaveAs(Server.MapPath("File/" + filename));
        DataTable dt = new DataTable();
        if (Path.GetExtension(filename).ToLower().Contains("xls"))
        {
            CJ_DevelopHelper.OtherCon_Str = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("File/" + filename) + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=1;'";
            CJ_DevelopHelper.SqlStr = "select 条码 as sku,数量 as amount from [sheet1$] where 条码<>''";
            dt = CJ_DevelopHelper.Other_ReturnDateTable;
        }
        else if (Path.GetExtension(filename).ToLower().Contains("txt"))
            dt = ImportTxt(Server.MapPath("File/" + filename), filename);
        File.Delete(Server.MapPath("File/" + filename));//删除文档
        if (dt.Rows.Count <= 0)
        {
            X.Msg.Alert("提示", "导入的文件无记录！").Show();
            return;
        }
        this.Session["mainDT"] = dt;
        this.Session["LongActionProgress"] = 0;
        this.Session["listno"] = Request["listno"].ToString();        
        ThreadPool.QueueUserWorkItem(LongAction);
        MainResourceMgr.AddScript("{0}.startTask('longactionprogress');", TaskManager1.ClientID);
    }

    private void LongAction(object state)
    {
        try
        {
            DataTable dt = (DataTable)Session["mainDT"];
            string errorSKU = "";
            //CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["YLF22"];
            CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["F22"];
            int totalnum = 0;
            StringBuilder errtxt = new StringBuilder();
            errtxt.AppendLine("条码\t数量");
            int i = 1;//记录
            List<string> sqlist = new List<string>();
            this.Session["Total"] = dt.Rows.Count;
            foreach (DataRow dr in dt.Rows)
            {
                string sku = dr[0].ToString().ToUpper();
                if (sku.Length <= 0) { continue; }
                if (int.Parse(dr[1].ToString()) <= 0)
                {
                    errorSKU += sku + " 盘点数量为负或零;<br />";
                    continue;
                }
                else
                {
                    sqlist.Add("exec SP_Y_Inventory '" + Session["listno"].ToString() + "','" + sku + "'," + dr[1].ToString().Trim() + "");
                    if (i % 50 == 0)//每50条，提交到数据库执行
                    {
                        string temp = ExecuteProcdure(sqlist);
                        if (temp != "")
                            errorSKU += temp;
                        sqlist.Clear();
                        this.Session["LongActionProgress"] = i;
                    }
                }
                i++;
                totalnum += int.Parse(dr[1].ToString());
            }
            if (sqlist.Count > 0)
            {
                string temp = ExecuteProcdure(sqlist);
                if (temp != "")
                    errorSKU += temp;
                sqlist.Clear();
                this.Session["LongActionProgress"] = i;
            }
            sqlist.Add("exec F22_RefreshDj 'd_inventory','" + Session["listno"].ToString() + "' ;");
            ExecuteSqlTran(sqlist);
            if (errorSKU != "")
                this.Session["result"] = "盘点数据部分存在错误，请先检查,修改后重新提交<br />错误提示：<br />" + errorSKU;
            else
                this.Session["result"] = "恭喜您，导入成功";
        }
        catch (Exception error)
        {
            this.Session["result"] = "异常：" + error.Message + "！请认真检查盘点文档格式";
        }
        finally
        {
            this.Session.Remove("mainDT");
            this.Session.Remove("LongActionProgress");
            this.Session.Remove("listno");
        }
    }

    protected void RefreshProgress(object sender, DirectEventArgs e)
    {
        object progress = this.Session["LongActionProgress"];
        if (this.Session["Total"] == null) return;
        int totalnum = (int)this.Session["Total"];
        if (progress != null)
        {
            Progress1.UpdateProgress(((int)progress) / (float)totalnum, string.Format("已完成 {0} 条，共计 {1} 条", progress.ToString(), totalnum));
        }
        else
        {
            MainResourceMgr.AddScript("{0}.stopTask('longactionprogress');", TaskManager1.ClientID);
            Progress1.UpdateProgress(1, "完成");
            X.Msg.Alert("提示", this.Session["result"].ToString()).Show();
            this.Session.Remove("result");
        }
    }

    public DataTable ImportTxt(string filePath, string fileName)
    {
        CJ_DevelopHelper.FilePath = Server.MapPath("File/" + fileName);
        CJ_DevelopHelper.FileContent = CJ_DevelopHelper.ReadFile.Replace("\t", ",");
        if (!CJ_DevelopHelper.WriteFile) return null;
        DataTable dt = null;
        string strConn = @"Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=";
        strConn += Server.MapPath("File/");
        strConn += ";Extensions=asc,csv,tab,txt;";
        OdbcConnection objConn = new OdbcConnection(strConn);
        try
        {
            DataSet ds = new DataSet();
            string strSQL = "select 条码 as sku,数量 as amount from " + fileName + "  where 条码<>''";//文件名，不要带目录
            OdbcDataAdapter da = new OdbcDataAdapter(strSQL, objConn);
            da.Fill(ds);//在这里出现异常....
            dt = ds.Tables[0];
        }
        catch (Exception e)
        {
            X.Msg.Alert("错误", e.Message + "！请认真检查盘点文档格式").Show();
        }
        finally
        {
            File.Delete(filePath);//删除文档
        }
        return dt;
    }

    #region 执行sql
    //exec SP_Y_Inventory 'PD1111-2011-12-02-0001','aaaaaa',0
    /// <summary>
    /// 执行多条SQL语句，实现数据库事务。
    /// </summary>
    /// <param name="SQLStringList">多条SQL语句</param>		
    public string ExecuteProcdure(List<String> SQLStringList)
    {
        string result = "";
        //using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["YLF22"]))
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["F22"]))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            try
            {
                for (int n = 0; n < SQLStringList.Count; n++)
                {
                    string strsql = SQLStringList[n];
                    if (strsql.Trim().Length > 1)
                    {
                        cmd.CommandText = strsql;
                        string Temp = cmd.ExecuteScalar().ToString();
                        if (Temp != "0")
                            result += Temp + " 条码错误;<br />";
                    }
                }
                return result;
            }
            catch (Exception)
            {
                return "";
            }
            finally
            {
                conn.Close();
            }
        }
    }
    /// <summary>
    /// 执行多条SQL语句，实现数据库事务。
    /// </summary>
    /// <param name="SQLStringList">多条SQL语句</param>		
    public int ExecuteSqlTran(List<String> SQLStringList)
    {
        //using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["YLF22"]))
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["F22"]))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            SqlTransaction tx = conn.BeginTransaction();
            cmd.Transaction = tx;
            try
            {
                int count = 0;
                for (int n = 0; n < SQLStringList.Count; n++)
                {
                    string strsql = SQLStringList[n];
                    if (strsql.Trim().Length > 1)
                    {
                        cmd.CommandText = strsql;
                        int current = cmd.ExecuteNonQuery();
                        count += current == -1 ? 0 : current;
                    }
                }
                tx.Commit();
                return count;
            }
            catch (Exception)
            {
                tx.Rollback();
                return 0;
            }
            finally
            {
                conn.Close();
            }
        }
    }
    #endregion
}