using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Data;
using System.IO;
using System.Data.SqlClient;

namespace EPReper.Common
{
    public class Excel
    {
        SqlDataAdapter myAdapter = null;
        SqlConnection myConnection = new SqlConnection(EPReper.Config.DBConfig.EPErperString);
        DataSet ds = null;
        StringWriter sw = null;
        
        #region -------------------------------------文件操作函数---------------------------------------
        /// <summary>
        /// 按照SQL的结果集生成Excel文件
        /// </summary>
        /// <param name="str_SQL">Sql语句</param>
        /// <param name="FileName">Excel文件名</param>
        public void WriteToExcel(string str_SQL, string FileName)
        {
            StringBuilder strCols = new StringBuilder(); ;
            string strLine = "";

            myAdapter = new SqlDataAdapter(str_SQL, myConnection);
            ds = new DataSet();
            myAdapter.Fill(ds);
            DataTable dt = ds.Tables[0];

            sw = new StringWriter();
            //写入字段名

            //foreach (DataColumn myCol in dt.Columns)
            //{
            //    strCols = strCols + myCol.ColumnName + "\t";
            //}
            strCols.Append("维修单号\t");
            strCols.Append("维修主类别\t");
            strCols.Append("维修次类别\t");
            strCols.Append("维修类别\t");
            strCols.Append("报修人\t");
            strCols.Append("报修人电话\t");
            strCols.Append("报修人部门\t");
            strCols.Append("维修人\t");
            strCols.Append("维修人电话\t");            
            sw.WriteLine(strCols);


            //写入数据
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn myCol in dt.Columns)
                {
                    if (myCol.ColumnName == "bigid")
                    {
                       
                        //strLine = strLine + "=RIGHT(\"'" + dr[myCol] + "\",LEN(\"" + dr[myCol] + "\"))" + "\t";
                        continue;
                    }
                    strLine = strLine + dr[myCol] + "\t";
                }
                strLine = strLine + "\r\n";
            }
            sw.WriteLine(strLine);


            dt.Dispose();
            ds.Dispose();

            //生成Excel文件
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            HttpContext.Current.Response.Write(sw);
            HttpContext.Current.Response.End();

            sw.Close();
        }
        public void WriteToExcel(string str_SQL, string FileName, string Title)
        {
            string strCols = "";
            string strLine = "";
            string strTemp = "\t\t";

            myAdapter = new SqlDataAdapter(str_SQL, myConnection);
            ds = new DataSet();
            myAdapter.Fill(ds);
            DataTable dt = ds.Tables[0];

            sw = new StringWriter();
            //写入文件头
            strTemp += Title;
            sw.WriteLine(strTemp);
            //写入字段名
            foreach (DataColumn myCol in dt.Columns)
            {
                strCols = strCols + myCol.ColumnName + "\t";
            }
            sw.WriteLine(strCols);


            //写入数据
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn myCol in dt.Columns)
                {
                    strLine = strLine + dr[myCol] + "\t";
                }
                strLine = strLine + "\r\n";
            }
            sw.WriteLine(strLine);


            dt.Dispose();
            ds.Dispose();

            //生成Excel文件
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            HttpContext.Current.Response.Write(sw);
            HttpContext.Current.Response.End();

            sw.Close();
        }


        #endregion
    }
}
