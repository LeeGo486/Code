using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SMTSendMessage
{

    public abstract class Handle
    {
        public abstract void Save();
    }


    public class DBconn
    {

        private static string strConn = ConfigurationManager.AppSettings["RDSMS"];
        
        private static bool isOpen = false;

        static SqlConnection sqlCon = new SqlConnection(strConn);

        #region ConnOpen
        private static void ConnOpen()
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


        private static void ConnClose()
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

        #region getCount

        public static int getCount(string table, string where)
        {
            int iRst = 0;
            try
            {
                ConnOpen();
                string Sql = "SELECT COUNT(1) FROM " + table + " WITH(NOLOCK) WHERE " + where;


                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = sqlCon;
                
                MyCommand.CommandText = Sql;

                var rst = MyCommand.ExecuteScalar();

                iRst = Int32.Parse(rst.ToString());
                
            }
            catch (Exception)
            {

                throw;
            }
            finally {
                ConnClose();
            }



            return iRst;

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


            ConnOpen();
            try
            {
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = sqlCon;

                MyCommand.CommandText = sql;

                int iRst = MyCommand.ExecuteNonQuery();


                if (iRst > 0)
                {
                    bRst = true;
                }
                else {
                    bRst = false;
                }
            }
            catch (Exception)
            {
                bRst = false;
                throw;
            }
            finally {
                ConnClose();
            }

            return bRst;
        }
        #endregion

        #region getData
        public static DataTable getData(string table, string where)
        {

            DataSet dsRst = new DataSet();
            DataTable dtRst = new DataTable();

            string sql = "SELECT * FROM " + table;
            if (where != "")
            {
                sql += " WHERE " + where;
            };

            try
            {
                ConnOpen();
                SqlDataAdapter myDataAdapter = new SqlDataAdapter(sql, sqlCon);

                myDataAdapter.Fill(dsRst);

                dtRst = dsRst.Tables[0];

            }
            catch (Exception)
            {
                dtRst = null;
                throw;
            }
            finally
            {
                ConnClose();
            }


            return dtRst;
        }
        #endregion

        #region getDataView
        public static DataTable getDataView(string sql) {

            DataSet dsRst = new DataSet();
            DataTable dtRst = new DataTable();

            try
            {
                ConnOpen();
                SqlDataAdapter myDataAdapter = new SqlDataAdapter(sql, sqlCon);

                myDataAdapter.Fill(dsRst);

                dtRst = dsRst.Tables[0];

            }
            catch (Exception)
            {
                dtRst = null;
                //throw;
            }
            finally
            {
                ConnClose();
            }


            return dtRst;
        }
        #endregion

        #region Update

        public static bool Update(string table, string where) {
            bool bRst = false;

            string sql = @" UPDATE " + table + " SET " + where;

            ConnOpen();
            try
            {
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = sqlCon;

                MyCommand.CommandText = sql;

                int iRst = MyCommand.ExecuteNonQuery();


                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                }
            }
            catch (Exception)
            {
                bRst = false;
                throw;
            }
            finally
            {
                ConnClose();
            }

            return bRst;
        }
        #endregion

    }

}
