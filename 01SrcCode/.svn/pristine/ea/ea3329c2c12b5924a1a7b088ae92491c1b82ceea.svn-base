using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.IO;
using System.Data;
using CJ;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;

public partial class saleback : System.Web.UI.Page
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
                lblistno.Html = "单号：" + Request["listno"].ToString() + "   <a href='Temp/saleback.xls' target='_blank'>点击下载模版文件</a>";
        }
    }
    protected void checknum_DataBind(object sender, StoreRefreshDataEventArgs e)
    {

    }
    protected void Btnsave_Click(object sender, DirectEventArgs e)
    {
        try
        {
            string filename = UpFile.PostedFile.FileName;
            string ext = Path.GetExtension(filename).ToLower();
            if (ext != ".xls" && ext != ".xlsx")
            {
                X.Msg.Notify("失败", "<font color='red'>文件格式不正确，仅支持.xls(Excel)格式文件！</font>").Show();
                return;
            }
            filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
            UpFile.PostedFile.SaveAs(Server.MapPath("File/" + filename));
            DataTable dt = new DataTable();
            
            CJ_DevelopHelper.OtherCon_Str = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("File/" + filename) + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=1;'";
            CJ_DevelopHelper.SqlStr = "select 款式编号 as sku,色号 as color,F,F4,F5,F6,F7,F8,F9 from [sheet1$] where 款式编号<>''";
            dt = CJ_DevelopHelper.Other_ReturnDateTable;
            
            if (dt.Rows.Count <= 0)
            {
                X.Msg.Alert("提醒", "导入的文件无记录！").Show();
                return;
            }
            string errorSKU = "";
            CJ_DevelopHelper.SqlConn_Str = ConfigurationManager.AppSettings["YLF22"];
            string allsku = "";
            int rowcount = 0;
            StringBuilder errtxt = new StringBuilder();
            errtxt.AppendLine("款式编号\t色号\t尺码\t错因");
            foreach (DataRow dr in dt.Rows)
            {
                string sku = dr[0].ToString().ToUpper();
                if (sku.Length <= 0) { continue; }
                for (int i = 2; i <= 8; i++)
                {
                    string size = i == 2 ? "F" : (i - 1).ToString();
                    
                    if (dr[i].ToString().Trim().Length > 0)
                    {
                        if (int.Parse(dr[i].ToString()) < 0)
                        {
                            errorSKU += sku + dr[1].ToString().Trim() + size + " 数量为负;<br />";
                            errtxt.AppendLine(sku + "\t" + dr[1].ToString().Trim() + "\t" + size + "\t数量为负");
                        }
                        else
                        {
                            allsku += "'" + sku + dr[1].ToString().Trim() + size + "',";
                            rowcount++;
                        }
                    }
                }
            }
            CJ_DevelopHelper.SqlStr = "select clothingid,styleid,colorid from j_clothing where clothingid in (" + allsku.TrimEnd(',') + ")";
            DataTable dtDB = CJ_DevelopHelper.SQL_ReturnDateTable;
            //找到错款编号
            if (rowcount != dtDB.Rows.Count)
            { 
                    string [] sku=allsku.TrimEnd(',').Split(',');
                    for (int i = 0; i < sku.Length; i++)
                    {
                        int isfind = 0;
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (dr[0].ToString().ToUpper() == sku[i].ToUpper().Trim('\''))
                            { isfind = 1; break; }
                        }
                        if (isfind == 0)
                        {
                            errorSKU += sku[i].Trim('\'') + " 款式错误;<br />";
                            errtxt.AppendLine(sku[i].Trim('\'').Substring(0, sku[i].Trim('\'').Length - 2)
                                              + "\t" + sku[i].Trim('\'').Substring(sku[i].Trim('\'').Length - 2, 1)
                                              + "\t" + sku[i].Trim('\'').Substring(sku[i].Trim('\'').Length - 1, 1)
                                              + "\t该款式无此尺码");
                        }
                    }
            }
            if (errorSKU != "")
            {
                string str = DateTime.Now.ToString("yyyyMMddHHmmss") + "Back_ERROR" + ".txt";
                CJ_DevelopHelper.FilePath = Server.MapPath("File/") + str;
                CJ_DevelopHelper.FileContent = errtxt.ToString();
                if (!CJ_DevelopHelper.WriteFile)
                {
                    X.Msg.Alert("提醒", "数据部分存在错误！<br />但生成异常文件时错误,请重试！").Show();
                    return;
                }
                X.Msg.Alert("提醒", "存在错误记录，请先检查！<br />请下载异常款文件<a href='File/" + str + "' target='_blank'>" + str + "</a>，修改后重新提交<br />错误提示：<br />" + errorSKU).Show();
                return;
            }
            checknum_MainStore.DataSource = dt;
            checknum_MainStore.DataBind();
            if (File.Exists(Server.MapPath("File/" + filename)))
                File.Delete(Server.MapPath("File/" + filename));
        }
        catch (Exception error)
        {
            X.Msg.Alert("错误", error.Message + "！请认真检查文档格式<br />各个款式退货数量是否存在非数字").Show();
        }
    }
    private string errskc(DataRow dr)
    {
        return dr[0].ToString() + "\t" + dr[1].ToString() + "\t" + dr[2].ToString()
            + "\t" + dr[3].ToString() + "\t" + dr[4].ToString() + "\t" + dr[5].ToString()
            + "\t" + dr[6].ToString() + "\t" + dr[7].ToString() + "\t" + dr[8].ToString();
    }
    protected void BtnInsert_Click(object sender, DirectEventArgs e)
    {
        try
        {
            object obj = JSON.Deserialize(ExcelGridData.Value.ToString());
            List<backskc> jsArray = (List<backskc>)JSON.Deserialize(ExcelGridData.Value.ToString(), typeof(List<backskc>));
            if (jsArray.Count <= 0)
            {
                X.Msg.Alert("提醒", "没有退货记录，无法保存！").Show();
                return;
            }
            List<string> sqlist = new List<string>();
            string sql = "if exists (select boxid from d_outindentprosub where outindentid='" + Request["listno"].ToString() + "' and clothingid='{1}') "
                       + " update d_outindentprosub set nums={0}+isnull(nums,0)  where outindentid='" + Request["listno"].ToString() + "' and clothingid='{1}' ;"
                       + " else "
                       + " insert into d_outindentprosub (outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,nums,j_price,x_price,crdate)"
                       + " select '" + Request["listno"].ToString() + "','000000',clothingid,styleid,colorid,sizeid,j_cost,{0},j_price,x_price,getdate() "
                       + " from j_clothing where clothingid ='{1}' ;";
            foreach (backskc skc in jsArray)
            {
                if (skc.sku==null||skc.sku.ToString().Trim().Length <= 0) continue;
                if (skc.F!=null&&skc.F.ToString().Trim().Length > 0)  
                    sqlist.Add(string.Format(sql, skc.F.Trim(), skc.sku+skc.color.Trim()+"F"));
                if (skc.F4 != null && skc.F4.ToString().Trim().Length > 0)
                    sqlist.Add(string.Format(sql, skc.F4.Trim(), skc.sku + skc.color.Trim() + "2"));
                if (skc.F5 != null && skc.F5.ToString().Trim().Length > 0) 
                    sqlist.Add(string.Format(sql, skc.F5.Trim(), skc.sku + skc.color.Trim() + "3"));
                if (skc.F6 != null && skc.F6.ToString().Trim().Length > 0) 
                    sqlist.Add(string.Format(sql, skc.F6.Trim(), skc.sku + skc.color.Trim() + "4"));
                if (skc.F7 != null && skc.F7.ToString().Trim().Length > 0) 
                    sqlist.Add(string.Format(sql, skc.F7.Trim(), skc.sku + skc.color.Trim() + "5"));
                if (skc.F8 != null && skc.F8.ToString().Trim().Length > 0) 
                    sqlist.Add(string.Format(sql, skc.F8.Trim(), skc.sku + skc.color.Trim() + "6"));
                if (skc.F9 != null && skc.F9.ToString().Trim().Length > 0) 
                    sqlist.Add(string.Format(sql, skc.F9.Trim(), skc.sku + skc.color.Trim() + "7"));
            }
            if (ExecuteSqlTran(sqlist) > 0)
            {
                sqlist.Clear();
                sqlist.Add("exec F22_RefreshDj 'd_outindentpro','" + Request["listno"].ToString() + "' ;");
                ExecuteSqlTran(sqlist);
                X.AddScript("alert('恭喜您！数据保存成功！');window.opener=null;window.open('','_self');window.close();");
            }
            else
                X.Msg.Alert("失败", "数据保存失败，请重试！").Show();
        }
        catch (Exception error)
        {
            X.Msg.Alert("错误", error.Message + "！请认真检查文档格式").Show();
        }
    }

    /// <summary>
    /// 执行多条SQL语句，实现数据库事务。
    /// </summary>
    /// <param name="SQLStringList">多条SQL语句</param>		
    public int ExecuteSqlTran(List<String> SQLStringList)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["YLF22"]))
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
        }
    }
}