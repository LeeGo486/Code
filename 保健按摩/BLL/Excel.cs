using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Data;
using System.IO;
using System.Data.SqlClient;

namespace EPReper.BLL
{
    public class Excel
    {
        SqlDataAdapter myAdapter = null;
        SqlConnection myConnection = new SqlConnection(EPReper.Config.DBConfig.EPErperString);
        DataSet ds = null;
        StringWriter sw = null;
        BLL.ReperClass RC = new ReperClass();
        BLL.Userinfo UI = new Userinfo();
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
            strCols.Append("报修人部门\t");
            strCols.Append("报修人\t");
            strCols.Append("报修人电话\t");
            strCols.Append("维修人\t");
            strCols.Append("维修人电话\t");
            strCols.Append("报修时间\t");
            strCols.Append("要求完成时间\t");
            strCols.Append("完成时间\t");
            strCols.Append("问题描述\t");
            strCols.Append("维修描述\t");
            strCols.Append("维修状态\t");
            strCols.Append("是否取消\t");
            sw.WriteLine(strCols);


            //写入数据
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn myCol in dt.Columns)
                {
                    if (myCol.ColumnName == "bigid")
                    {

                        strLine = strLine + RC.GetList("id =" + dr[myCol]).Tables[0].Rows[0]["classname"] + "\t";
                        continue;
                    }
                    if (myCol.ColumnName == "classid")
                    {
                        DataTable dts = RC.GetList("id =" + dr[myCol]).Tables[0];
                        strLine = strLine + RC.GetList("id =" + dts.Rows[0]["parentID"].ToString()).Tables[0].Rows[0]["classname"] + "\t";
                        strLine = strLine + dts.Rows[0]["classname"] + "\t";
                        continue;
                    }
                    if (myCol.ColumnName == "userid")
                    {
                        DataTable dtui = UI.GetInfo("CN_ID =" + dr[myCol]);
                        strLine += dtui.Rows[0]["CN_DEPTINFO"] + "\t";
                        strLine = strLine + dtui.Rows[0]["CN_LOGIN"] + "\t";
                        //strLine = strLine + UI.GetList("CN_ID =" + dr[myCol]).Tables[0].Rows[0]["CN_LOGIN"] + "\t";
                        continue;
                    }
                    if (myCol.ColumnName == "reperid")
                    {
                        if (dr[myCol].ToString() != "")
                        {
                            strLine = strLine + UI.GetList("CN_ID =" + dr[myCol]).Tables[0].Rows[0]["CN_LOGIN"] + "\t";
                        }
                        else
                        {
                            strLine = strLine + dr[myCol] + "\t";
                        }
                        continue;
                    }
                    if (myCol.ColumnName == "finish")
                    {

                        if (dr[myCol].ToString() == "0")
                        {
                            strLine = strLine + "未接受" + "\t";
                        }
                        if (dr[myCol].ToString() == "1")
                        {
                            strLine = strLine + "已接受" + "\t";
                        }
                        if (dr[myCol].ToString() == "2")
                        {
                            strLine = strLine + "已完成" + "\t";
                        }
                        continue;
                    }
                    if (myCol.ColumnName == "isdel")
                    {

                        if (dr[myCol].ToString() == "0")
                        {
                            strLine = strLine + "否" + "\t";
                        }
                        if (dr[myCol].ToString() == "1")
                        {
                            strLine = strLine + "是" + "\t";
                        }
                        continue;
                    }
                    if (myCol.ColumnName == "startcomment")
                    {
                        strLine += dr[myCol].ToString().Replace("\r\n", "") + "\t";
                        continue;
                    }
                    if (myCol.ColumnName == "overcomment")
                    {
                        strLine += dr[myCol].ToString().Replace("\r\n", "") + "\t";
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
