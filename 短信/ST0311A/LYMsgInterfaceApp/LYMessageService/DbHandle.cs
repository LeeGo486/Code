using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LYMessageService
{
    
    
    #region 交互操作
    class DbHandle
    {

        //当前服务的路径
        public static readonly string strPath
            = System.AppDomain.CurrentDomain.BaseDirectory;

        #region 获取数据表
        internal DataTable GetData(string _sql)
        {
            DataSet dsRst = new DataSet();
            DataTable dtRst = new DataTable();

            Conn cn = new Conn();

            if (!cn.isOpen)
            {
                cn.Connection.Open();
                cn.isOpen = true;
            };

            SqlCommand cmd 
                = new SqlCommand(_sql, cn.Connection);
            cmd.CommandTimeout = 1;

            SqlDataAdapter myDataAdapter
                = new SqlDataAdapter(cmd);

            myDataAdapter.Fill(dsRst);

            if (cn.isOpen)
            {
                cn.Connection.Close();
            };

            dtRst = dsRst.Tables[0];

            cn = null;

            return dtRst;
        }

        #endregion  

        #region 插入数据 

        internal bool Insert
            (string _tableName, List<string> _field, object[] obj)
        {
            bool bRst = false;

            //拼装语句
            string sql = "INSERT INTO " + _tableName + " (";

            if (_field.Count > 0)
            {
                for (int i = 0; i < _field.Count; i++)
                {
                    if (i == _field.Count - 1)
                    {
                        sql += _field[i] + ")";
                    }
                    else
                    {
                        sql += _field[i] + ",";
                    };
                };
            };

            sql += " VALUES (";

            if (_field.Count > 0)
            {
                for (int i = 0; i < _field.Count; i++)
                {
                    if (i == _field.Count - 1)
                    {
                        sql += "@parm" + i + ")";
                    }
                    else
                    {
                        sql += "@parm" + i + "',";
                    }
                };
            };

            int iRst = ExcuteQuerryByTran(sql, obj);
                
                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                };
            
            return bRst;
        }
        #endregion

        #region 插入操作1
        internal bool Insert2
            (string _tableName, List<string> _field, object[] obj)
        {
            bool bRst = false;

            //拼装语句
            string sql = "INSERT INTO " + _tableName + " (";

            if (_field.Count > 0)
            {
                for (int i = 0; i < _field.Count; i++)
                {
                    if (i == _field.Count - 1)
                    {
                        sql += _field[i] + ")";
                    }
                    else
                    {
                        sql += _field[i] + ",";
                    };
                };
            };

            sql += " VALUES (";

            if (_field.Count > 0)
            {
                for (int i = 0; i < _field.Count; i++)
                {
                    if (i == _field.Count - 1)
                    {
                        sql += "@Param" + i + ")";
                    }
                    else
                    {
                        sql += "@Param" + i + ",";
                    }
                };
            };

            int iRst = 0;

            try
            {
                iRst = ExcuteQuerryByTran(sql, obj);
            }
            catch (Exception e)
            {
                using (System.IO.StreamWriter sw = 
                    new System.IO.StreamWriter(strPath + "DataBaseError.txt", true))
                {
                    sw.WriteLine(e);
                };
                throw;
            };

            


            if (iRst > 0)
            {
                bRst = true;
            }
            else
            {
                bRst = false;
            };

            return bRst;
        }
        #endregion

        #region 获取行数

        internal int GetCount(string _table, string _where)
        {
            int iRst = 0;
            string strSql = "SELECT COUNT(1) FROM "
                + _table + " WITH(NOLOCK) WHERE " + _where;

            Conn cn = new Conn();

            try
            {
                SqlCommand MyCommand = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = cn.Connection;

                MyCommand.CommandText = strSql;

                if (!cn.isOpen)
                {
                    cn.Connection.Open();
                    cn.isOpen = true;
                }

                var rst = MyCommand.ExecuteScalar();

                iRst = Int32.Parse(rst.ToString());
            }
            catch (Exception e)
            {
                iRst = 0;
                throw;
            }
            finally
            {
                if (cn.isOpen)
                {
                    cn.Connection.Close();
                };
            }

            return iRst;
        }
        #endregion

        #region 更新一个数据
        internal bool Update(string _tabName, string _where)
        {
            bool bRst = false;

            string sql = @" UPDATE " + _tabName + " SET " + _where;

            Conn cn = new Conn();

            try
            {
                if (!cn.isOpen)
                {
                    cn.Connection.Open();
                    cn.isOpen = true;
                }

                SqlCommand MyCommand
                    = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection
                    = cn.Connection;

                MyCommand.CommandText = sql;

                int iRst = MyCommand.ExecuteNonQuery();

                if (cn.isOpen)
                {
                    cn.Connection.Close();
                };

                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                };
            }
            catch (Exception)
            {
                bRst = false;
                throw;
            }
            finally
            {
                if (cn.isOpen)
                {
                    cn.Connection.Close();
                };

            };

            return bRst;
        }
        #endregion

        #region 更新多个字段
        internal bool UpdateMany
            (string _tabName, List<string> _field, List<string> _value,
            string _where)
        {
            bool bRst = false;



            string strSQL = @"UPDATE " + _tabName + " SET ";

            for (int i = 0; i < _field.Count; i++)
            {


                if (i < _field.Count - 1)
                {
                    strSQL += _field[i] + " = '" + _value[i] + "', ";
                }

                else if (i == _field.Count - 1)
                {
                    strSQL += _field[i] + " = '" + _value[i] + "' ";
                    break;
                };

            };


            strSQL += " WHERE " + _where;

            Conn cn = new Conn();


            try
            {

                if (!cn.isOpen)
                {
                    cn.Connection.Open();
                    cn.isOpen = true;
                };



                SqlCommand MyCommand
                    = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection
                    = Conn.sqlCon;

                MyCommand.CommandText = strSQL;

                int iRst = MyCommand.ExecuteNonQuery();

                if (cn.isOpen)
                {
                    cn.Connection.Close();
                };

                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                };

            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                if (cn.isOpen)
                {
                    cn.Connection.Close();
                };

            };


            return bRst;
        }
        #endregion

        #region 删除数据
        internal bool Delete(string _tabName, string _where) 
        {
            bool bRst = false;

            string sql = @" DELETE  FROM " + _tabName + " WHERE " + _where;

            Conn cn = new Conn();

            try
            {
                if (!cn.isOpen)
                {
                    cn.Connection.Open();
                    cn.isOpen = true;
                };

                SqlCommand MyCommand 
                    = new SqlCommand(); //定义一个数据库操作指令

                MyCommand.Connection = cn.Connection;

                MyCommand.CommandText = sql;

                int iRst = MyCommand.ExecuteNonQuery();

                if (cn.isOpen)
                {
                    cn.Connection.Close();
                    cn.isOpen = false;
                };

                if (iRst > 0)
                {
                    bRst = true;
                }
                else
                {
                    bRst = false;
                };

            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                if (cn.isOpen)
                {
                    cn.Connection.Close();
                    cn.isOpen = false;
                };
            }

            return bRst;
        }
        #endregion

        #region 操作
        internal int ExcuteQuerryByTran(string sql, object[] objParam)
        {
            try
            {
                Conn cn = new Conn();

                if (!cn.isOpen)
                {
                    cn.Connection.Open();
                    cn.isOpen = true;
                };

                SqlCommand cmd = new SqlCommand(sql, cn.Connection);

                for (int j = 0; j < objParam.Length; j++)
                {
                    if (objParam[j] == null)
                    {
                        objParam[j] = "";
                    }
                    cmd.Parameters.Add(new SqlParameter("Param" + j.ToString(), objParam[j]));
                };


                int iRst = cmd.ExecuteNonQuery();

                if (cn.isOpen)
                {
                    cn.Connection.Close();
                    cn.isOpen = false;
                };

                return iRst;
            }
            catch (Exception ex)
            {
                if (!ex.Data.Contains("sql"))
                {

                    ex.Data.Add("sql", sql);
                }

                throw ex;
            };

        }
        #endregion
    }
    #endregion
    
    #region 连接数据库
    internal class Conn
    {
        internal bool isOpen = false;

        private readonly static string strConn
            = ConfigurationManager.AppSettings["LYSMS"];

        internal static SqlConnection sqlCon
            = new SqlConnection(strConn);

        internal SqlConnection Connection
        {
            get
            {
                return sqlCon;
            }
        }

    }
    #endregion
    
}
