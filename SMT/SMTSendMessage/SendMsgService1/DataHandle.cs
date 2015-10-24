using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SendMsgService
{

    //public abstract class Handle
    //{
    //    public abstract void Save();
    //}

    public class DBconn
    {

        private static string strConn = ConfigurationManager.AppSettings["RDSMS"];
        
        private static bool isOpen = false;

        static SqlConnection sqlCon = new SqlConnection(strConn);

        //static SqlTransaction myTran;

        

        #region ConnOpen
        public static void ConnOpen()
        {

            try
            {
                if (!isOpen)
                {
                    sqlCon.Open();
                    isOpen = true;
                }
            }
            catch (Exception)
            {
                isOpen = false;
                throw;
            }
        }
        #endregion

        #region ConnClose
        public static void ConnClose()
        {
            try
            {
                if (isOpen)
                {
                    sqlCon.Close();
                    isOpen = false;
                }
            }
            catch (Exception)
            {
                isOpen = false;
                throw;
            }
        }
        #endregion

        #region getDataView
        internal DataTable getDataView(string sql)
        {

            DataSet dsRst = new DataSet();
            DataTable dtRst = new DataTable();

            try
            {
                ConnOpen();

                SqlCommand cmd = new SqlCommand(sql, sqlCon);
                cmd.CommandTimeout = 60*24;
                SqlDataAdapter myDataAdapter = new SqlDataAdapter(cmd);
                ConnClose();
                myDataAdapter.Fill(dsRst);

                dtRst = dsRst.Tables[0];

            }
            catch (SqlException e)
            {
                dtRst = null;

                using (System.IO.StreamWriter sw 
                    = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("DBconn在 "
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "getDataView操作时发生错误，" + e.ToString());
                };

                
            }
            finally
            {
                ConnClose();
            }


            return dtRst;
        }
        #endregion

        #region Insert
        public static bool Insert(string table, List<String> field,List<String> value) {
            
            bool bRst = false;

            string sql = "INSERT INTO " + table + "(";

            if (field.Count > 0) {
                for (int i = 0; i < field.Count; i++) {
                    if (i == field.Count - 1)
                    {
                        sql += field[i] + ")";
                    }
                    else {
                        sql += field[i] + ",";
                    };
                };
            };

            sql += " VALUES (";

            if (value.Count > 0) {
                for (int i = 0; i < value.Count; i++) {
                    if (i == value.Count - 1)
                    {
                        sql += "'" + value[i] + "')";
                    }
                    else {
                        sql += "'" + value[i] + "',";
                    }
                };
            };


            if (!isOpen)
            {
                ConnOpen();
                isOpen = true;
            }

            

            
            try
            {
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = sqlCon;

                MyCommand.CommandText = sql;

                //myTran = sqlCon.BeginTransaction();
                int iRst = MyCommand.ExecuteNonQuery();
                //提交事务
                //myTran.Commit();
                if (iRst > 0)
                {
                    bRst = true;
                }
                else {
                    bRst = false;
                }
            }
            catch (Exception e)
            {
                bRst = false;
                using (System.IO.StreamWriter sw
                    = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("DBconn在 "
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "Insert操作时发生错误，" + e.ToString());
                }
                //throw;
            }
            finally {
                if (isOpen)
                {
                    ConnClose();
                    isOpen = false;
                }
            }

            return bRst;
        }
        #endregion
                
        #region Update

        public static bool Update(string table, string where) {
            bool bRst = false;

            string sql = @" UPDATE " + table + " SET " + where;

            
            //myTran = sqlCon.BeginTransaction();
            try
            {
                if (!isOpen)
                {
                    ConnOpen();
                    isOpen = true;
                }
                
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = sqlCon;

                MyCommand.CommandText = sql;

                int iRst = MyCommand.ExecuteNonQuery();

                if (isOpen)
                {
                    ConnClose();
                    isOpen = false;
                }
                //myTran.Commit();

                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                }
            }
            catch (Exception e)
            {
                bRst = false;
                using (System.IO.StreamWriter sw
                    = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("DBconn在 "
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "Update操作时发生错误，" + e.ToString());
                }
                //throw;
            }
            finally
            {
                if (isOpen)
                {
                    ConnClose();
                    isOpen = false;
                }
            }

            return bRst;
        }
        #endregion

        #region Delete
        public static bool Delete(string table, string where) {
            bool bRst = false;

            string sql = @" DELETE  FROM " + table + " WHERE " + where;

            
            //myTran = sqlCon.BeginTransaction();
            try
            {
                if (!isOpen) 
                {
                    ConnOpen();
                    isOpen = true;
                };
                
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令
                
                MyCommand.Connection = sqlCon;

                MyCommand.CommandText = sql;
                
                int iRst = MyCommand.ExecuteNonQuery();

                if (isOpen) {
                    ConnClose();
                    isOpen = false;
                }
                

                //myTran.Commit();

                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                }
            }
            catch (Exception e)
            {
                bRst = false;
                using (System.IO.StreamWriter sw
                    = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("DBconn在 "
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "Delete操作时发生错误，" + e.ToString());
                }
            }
            finally
            {
                if (isOpen)
                {
                    ConnClose();
                    isOpen = false;
                }
            }

            return bRst;
        }
        #endregion

    }

}
