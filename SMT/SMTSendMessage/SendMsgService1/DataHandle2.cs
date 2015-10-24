using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SendMsgService
{

        public class DBconnGet
        {

            #region Insert
            internal bool Insert(string table, List<String> field, List<String> value)
            {

                bool bRst = false;

                Conn cn = new Conn();

                string sql = "INSERT INTO " + table + "(";

                if (field.Count > 0)
                {
                    for (int i = 0; i < field.Count; i++)
                    {
                        if (i == field.Count - 1)
                        {
                            sql += field[i] + ")";
                        }
                        else
                        {
                            sql += field[i] + ",";
                        };
                    };
                };

                sql += " VALUES (";

                if (value.Count > 0)
                {
                    for (int i = 0; i < value.Count; i++)
                    {
                        if (i == value.Count - 1)
                        {
                            sql += "'" + value[i] + "')";
                        }
                        else
                        {
                            sql += "'" + value[i] + "',";
                        }
                    };
                };



                using (cn.Connection)
                {
                    SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                    MyCommand.Connection = cn.Connection;

                    MyCommand.CommandText = sql;

                    cn.Connection.Open();
                        int iRst = MyCommand.ExecuteNonQuery();
                    cn.Connection.Close();

                    if (iRst > 0)
                    {
                        bRst = true;
                    }
                    else
                    {
                        bRst = false;
                    };
                };
                //myTran = sqlCon.BeginTransaction();
                //try
                //{
                //    SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                //    MyCommand.Connection = cn.Connection;

                //    MyCommand.CommandText = sql;

                //    if (!cn.isOpen)
                //    {
                //        cn.Connection.Open();
                //        cn.isOpen = true;
                //    }
                    
                   
                //    int iRst = MyCommand.ExecuteNonQuery();

                //    if (cn.isOpen)
                //    {
                //        cn.Connection.Close();
                //        cn.isOpen = false;
                //    }
                    
                //    if (iRst > 0)
                //    {
                //        bRst = true;
                //    }
                //    else
                //    {
                //        bRst = false;
                //    }
                //}
                //catch (Exception e)
                //{
                //    //bRst = false;
                //    using (System.IO.StreamWriter sw = new System.IO.StreamWriter(Service1.strPath+"logError.txt", true))
                //    {
                //        sw.WriteLine("DBconnGet在 "
                //            + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ") 
                //            + "Insert操作时发生错误，" + e.ToString());
                //    }
                //    //throw;
                //}
                //finally
                //{
                //    if (cn.isOpen)
                //    {
                //        cn.Connection.Close();
                //        cn.isOpen = false;
                //    };
                //}

                return bRst;
            }
            #endregion

            #region getDataView
            internal DataTable getDataView(string sql)
            {

                DataSet dsRst = new DataSet();
                DataTable dtRst = new DataTable();
                Conn cn = new Conn();

                using (cn.Connection)
                {
                    SqlDataAdapter myDataAdapter = new SqlDataAdapter(sql, cn.Connection);

                    cn.Connection.Open();
                        myDataAdapter.Fill(dsRst);
                    cn.Connection.Close();

                    dtRst = dsRst.Tables[0];
                };
                //try
                //{
                //    if (!cn.isOpen)
                //    {
                //        cn.Connection.Open();
                //        cn.isOpen = true;
                //    }
                //    SqlDataAdapter myDataAdapter = new SqlDataAdapter(sql, cn.Connection);
                //    if (cn.isOpen)
                //    {
                //        cn.Connection.Close();
                //        cn.isOpen = false;
                //    }
                //    myDataAdapter.Fill(dsRst);

                //    dtRst = dsRst.Tables[0];

                //}
                //catch (Exception e)
                //{
                //    using (System.IO.StreamWriter sw = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                //    {
                //        sw.WriteLine("DBconnGet在 "
                //            + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                //            + "getDataView操作时发生错误，" + e.ToString());
                //    }
                //}
                //finally
                //{
                //    if (cn.isOpen)
                //    {
                //        cn.Connection.Close();
                //        cn.isOpen = false;
                //    };
                //}


                return dtRst;
            }
            #endregion

            
        }


        internal class Conn
        {
            internal bool isOpen = false;

            private readonly static string strConn
                = ConfigurationManager.AppSettings["RDSMS"];

            private SqlConnection sqlCon
                = new SqlConnection(strConn);

            internal SqlConnection Connection
            {
                get
                {
                    return sqlCon;
                }
            }
        }
    }

