using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;
using EPReper.Config;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using EPReper.Config;

namespace EPReper.DBUtility
{
    public abstract class DbHelper
    {
        public static void SetTimeoutDefault()
        {
            Timeout = 30;
        }
        public static int Timeout = 30;


        public static DbConnection Conn = null;
        public static SqlConnection Connection = null;

        /// <summary>
        /// 执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static int GetMaxID(string FieldName, string TableName)
        {
            string strsql = "select max(" + FieldName + ")+1 from " + TableName;
            object obj = ExecuteScalar(CommandType.Text, strsql,null);
            if (obj == null)
            {
                return 1;
            }
            else
            {
                return int.Parse(obj.ToString());
            }
        }
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            return ExecuteNonQuery(DBConfig.EPErperString, cmdType, cmdText, commandParameters);
        }

        public static int ExecuteNonQuery(string connectionString, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {

            DbCommand cmd = new SqlCommand();
            

            using (DbConnection conn = new SqlConnection())
            {
                try
                {
                    conn.ConnectionString = connectionString;
                    PrepareCommand(cmd, conn, null, cmdType, cmdText, commandParameters);
                    int val = cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    //DbHelper.Conn = conn;
                    return val;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (conn.State == ConnectionState.Open)
                    {
                        conn.Close();
                    }
                    conn.Dispose();
                }
            }
        }

        public static int ExecuteNonQuery(DbConnection connection, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {

            DbCommand cmd = new SqlCommand();

            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            int val = cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            DbHelper.Conn = connection;
            return val;
        }

        public static int ExecuteNonQuery(DbTransaction trans, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();
            PrepareCommand(cmd, trans.Connection, trans, cmdType, cmdText, commandParameters);
            int val = cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            DbHelper.Conn = trans.Connection;
            return val;
        }
        public static DataSet ExecuteDataSet(CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            return ExecuteDataSet(DBConfig.EPErperString, cmdType, cmdText, commandParameters);
        }
        public static DataSet ExecuteDataSet(string connectionString, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();

            using (DbConnection connection = new SqlConnection())
            {
                try
                {
                    connection.ConnectionString = connectionString;
                    PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
                    DbDataAdapter ap = new SqlDataAdapter();
                    ap.SelectCommand = cmd;
                    DataSet st = new DataSet();
                    ap.Fill(st, "Result");
                    cmd.Parameters.Clear();
                    //DbHelper.Conn = connection;
                    return st;
                }
                catch
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                    }
                    connection.Dispose();
                }
            }
        }
        public static DataTable ExecuteTable(CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            return ExecuteTable(DBConfig.EPErperString, cmdType, cmdText, commandParameters);
        }
    

        public static DataTable ExecuteTable(string connectionString, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();

            using (DbConnection connection = new SqlConnection())
            {
                try
                {
                    connection.ConnectionString = connectionString;
                    PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
                    DbDataAdapter ap = new SqlDataAdapter();
                    ap.SelectCommand = cmd;
                    DataSet st = new DataSet();
                    ap.Fill(st, "Result");
                    cmd.Parameters.Clear();
                    //DbHelper.Conn = connection;
                    return st.Tables["Result"];
                }
                catch
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                    }
                    connection.Dispose();
                }
            }
        }

        public static DataTable ExecuteTable(DbConnection connection, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {

            DbCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            DbDataAdapter ap = new SqlDataAdapter();
            ap.SelectCommand = cmd;
            DataSet st = new DataSet();
            ap.Fill(st, "Result");
            cmd.Parameters.Clear();
            DbHelper.Conn = connection;
            return st.Tables["Result"];
        }

        /// <summary>
        /// 执行对默认数据库有自定义排序的分页的查询
        /// </summary>
        /// <param name="SqlAllFields">查询字段，如果是多表查询，请将必要的表名或别名加上，如:a.id,a.name,b.score</param>
        /// <param name="SqlTablesAndWhere">查询的表如果包含查询条件，也将条件带上，但不要包含order by子句，也不要包含"from"关键字，如:students a inner join achievement b on a.... where ....</param>
        /// <param name="IndexField">用以分页的不能重复的索引字段名，最好是主表的自增长字段，如果是多表查询，请带上表名或别名，如:a.id</param>
        /// <param name="OrderASC">排序方式,如果为true则按升序排序,false则按降序排</param>
        /// <param name="OrderFields">排序字段以及方式如：a.OrderID desc,CnName desc</OrderFields>
        /// <param name="PageIndex">当前页的页码</param>
        /// <param name="PageSize">每页记录数</param>
        /// <param name="RecordCount">输出参数，返回查询的总记录条数</param>
        /// <param name="PageCount">输出参数，返回查询的总页数</param>
        /// <returns>返回查询结果</returns>
        public static DataTable ExecutePage(string SqlAllFields, string SqlTablesAndWhere, string IndexField, string OrderFields, int PageIndex, int PageSize, out int RecordCount, out int PageCount, params DbParameter[] commandParameters)
        {
            return ExecutePage(DBConfig.EPErperString, SqlAllFields, SqlTablesAndWhere, IndexField, OrderFields, PageIndex, PageSize, out  RecordCount, out  PageCount, commandParameters);
        }

        /// <summary>
        /// 执行有自定义排序的分页的查询
        /// </summary>
        /// <param name="connectionString">SQL数据库连接字符串</param>
        /// <param name="SqlAllFields">查询字段，如果是多表查询，请将必要的表名或别名加上，如:a.id,a.name,b.score</param>
        /// <param name="SqlTablesAndWhere">查询的表如果包含查询条件，也将条件带上，但不要包含order by子句，也不要包含"from"关键字，如:students a inner join achievement b on a.... where ....</param>
        /// <param name="IndexField">用以分页的不能重复的索引字段名，最好是主表的自增长字段，如果是多表查询，请带上表名或别名，如:a.id</param>
        /// <param name="OrderASC">排序方式,如果为true则按升序排序,false则按降序排</param>
        /// <param name="OrderFields">排序字段以及方式如：a.OrderID desc,CnName desc</OrderFields>
        /// <param name="PageIndex">当前页的页码</param>
        /// <param name="PageSize">每页记录数</param>
        /// <param name="RecordCount">输出参数，返回查询的总记录条数</param>
        /// <param name="PageCount">输出参数，返回查询的总页数</param>
        /// <returns>返回查询结果</returns>
        public static DataTable ExecutePage(string connectionString, string SqlAllFields, string SqlTablesAndWhere, string IndexField, string OrderFields, int PageIndex, int PageSize, out int RecordCount, out int PageCount, params DbParameter[] commandParameters)
        {
            using (DbConnection connection = new SqlConnection())
            {
                try
                {
                    connection.ConnectionString = connectionString;
                    connection.Open();
                    //DbHelper.Conn = connection;
                    return ExecutePage(connection, SqlAllFields, SqlTablesAndWhere, IndexField, OrderFields, PageIndex, PageSize, out RecordCount, out PageCount, commandParameters);
                }
                catch
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                        connection.Dispose();
                    }
                }
            }
        }

        /// <summary>
        /// 执行有自定义排序的分页的查询
        /// </summary>
        /// <param name="connection">SQL数据库连接对象</param>
        /// <param name="SqlAllFields">查询字段，如果是多表查询，请将必要的表名或别名加上，如:a.id,a.name,b.score</param>
        /// <param name="SqlTablesAndWhere">查询的表如果包含查询条件，也将条件带上，但不要包含order by子句，也不要包含"from"关键字，如:students a inner join achievement b on a.... where ....</param>
        /// <param name="IndexField">用以分页的不能重复的索引字段名，最好是主表的自增长字段，如果是多表查询，请带上表名或别名，如:a.id</param>
        /// <param name="OrderASC">排序方式,如果为true则按升序排序,false则按降序排</param>
        /// <param name="OrderFields">排序字段以及方式如：a.OrderID desc,CnName desc</OrderFields>
        /// <param name="PageIndex">当前页的页码</param>
        /// <param name="PageSize">每页记录数</param>
        /// <param name="RecordCount">输出参数，返回查询的总记录条数</param>
        /// <param name="PageCount">输出参数，返回查询的总页数</param>
        /// <returns>返回查询结果</returns>
        public static DataTable ExecutePage(DbConnection connection, string SqlAllFields, string SqlTablesAndWhere, string IndexField, string OrderFields, int PageIndex, int PageSize, out int RecordCount, out int PageCount, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, null, CommandType.Text, "", commandParameters);
            string Sql = GetPageSql(connection, cmd, SqlAllFields, SqlTablesAndWhere, IndexField, OrderFields, PageIndex, PageSize, out  RecordCount, out  PageCount);
            cmd.CommandText = Sql;
            DbDataAdapter ap = new SqlDataAdapter();
            ap.SelectCommand = cmd;
            DataSet st = new DataSet();
            ap.Fill(st, "PageResult");
            cmd.Parameters.Clear();
            DbHelper.Conn = connection;
            return st.Tables["PageResult"];
        }

        public static DbDataReader ExecuteReader(CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            return ExecuteReader(DBConfig.EPErperString, cmdType, cmdText, commandParameters);
        }

        public static DbDataReader ExecuteReader(string connectionString, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();
            DbConnection conn = new SqlConnection();
            conn.ConnectionString = connectionString;
            // we use a try/catch here because if the method throws an exception we want to 
            // close the connection throw code, because no datareader will exist, hence the 
            // commandBehaviour.CloseConnection will not work
            try
            {
                PrepareCommand(cmd, conn, null, cmdType, cmdText, commandParameters);
                DbDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                DbHelper.Conn = conn;
                return rdr;
            }
            catch
            {

                throw;
            }
            finally
            {
                //conn.Close();
                //conn.Dispose();
                //conn = null;
            }
        }

        /// <summary>
        /// 执行对默认数据库有自定义排序的分页的查询
        /// </summary>
        /// <param name="connectionString">连接字符串
        /// <param name="SqlAllFields">查询字段，如果是多表查询，请将必要的表名或别名加上，如:a.id,a.name,b.score</param>
        /// <param name="SqlTablesAndWhere">查询的表如果包含查询条件，也将条件带上，但不要包含order by子句，也不要包含"from"关键字，如:students a inner join achievement b on a.... where ....</param>
        /// <param name="IndexField">用以分页的不能重复的索引字段名，最好是主表的自增长字段，如果是多表查询，请带上表名或别名，如:a.id</param>
        /// <param name="OrderASC">排序方式,如果为true则按升序排序,false则按降序排</param>
        /// <param name="OrderFields">排序字段以及方式如：a.OrderID desc,CnName desc</OrderFields>
        /// <param name="PageIndex">当前页的页码</param>
        /// <param name="PageSize">每页记录数</param>
        /// <param name="RecordCount">输出参数，返回查询的总记录条数</param>
        /// <param name="PageCount">输出参数，返回查询的总页数</param>
        /// <returns>返回查询结果</returns>
        public static DbDataReader ExecuteReaderPage(string connectionString, string SqlAllFields, string SqlTablesAndWhere, string IndexField, string GroupClause, string OrderFields, int PageIndex, int PageSize, out int RecordCount, out int PageCount, params DbParameter[] commandParameters)
        {
            DbConnection conn = new SqlConnection();
            conn.ConnectionString = connectionString;
            try
            {
                conn.Open();
                DbCommand cmd = new SqlCommand();
                PrepareCommand(cmd, conn, null, CommandType.Text, "", commandParameters);
                string Sql = GetPageSql(conn, cmd, SqlAllFields, SqlTablesAndWhere, IndexField, OrderFields, PageIndex, PageSize, out  RecordCount, out  PageCount);
                if (GroupClause != null && GroupClause.Trim() != "")
                {
                    int n = Sql.ToLower().LastIndexOf(" order by ");
                    Sql = Sql.Substring(0, n) + " " + GroupClause + " " + Sql.Substring(n);
                }
                cmd.CommandText = Sql;
                DbDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                //DbHelper.Conn = conn;
                return rdr;
            }
            catch
            {
                //if (conn.State == ConnectionState.Open)
                //    conn.Close();
                throw;
            }
            finally
            {
                //if (conn.State == ConnectionState.Open)
                //    conn.Close();
                //conn.Dispose();
                //conn = null;
            }
        }

        public static DbDataReader ExecuteReader(DbConnection connection, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();
            // we use a try/catch here because if the method throws an exception we want to 
            // close the connection throw code, because no datareader will exist, hence the 
            // commandBehaviour.CloseConnection will not work
            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            DbDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            cmd.Parameters.Clear();
            //DbHelper.Conn = connection;
            return rdr;
        }
        public static object ExecuteScalar(CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            return ExecuteScalar(DBConfig.EPErperString, cmdType, cmdText, commandParameters);
        }

        public static object ExecuteScalar(string connectionString, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();

            using (DbConnection connection = new SqlConnection())
            {
                try
                {
                    connection.ConnectionString = connectionString;
                    PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
                    object val = cmd.ExecuteScalar();
                    cmd.Parameters.Clear();
                    //DbHelper.Conn = connection;
                    return val;
                }
                catch
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                    }
                    connection.Dispose();
                }
            }
        }

        public static object ExecuteScalar(DbConnection connection, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {

            DbCommand cmd = new SqlCommand();

            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            object val = cmd.ExecuteScalar();
            cmd.Parameters.Clear();
            DbHelper.Conn = connection;
            return val;
        }

        public static object ExecuteScalar(DbTransaction trans, CommandType cmdType, string cmdText, params DbParameter[] commandParameters)
        {
            DbCommand cmd = new SqlCommand();

            PrepareCommand(cmd, trans.Connection, trans, cmdType, cmdText, commandParameters);
            object val = cmd.ExecuteScalar();
            cmd.Parameters.Clear();
            DbHelper.Conn = trans.Connection;
            return val;
        }

        /// <summary>
        /// 取得分页的SQL语句
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="cmd"></param>
        /// <param name="SqlAllFields"></param>
        /// <param name="SqlTablesAndWhere"></param>
        /// <param name="IndexField"></param>
        /// <param name="OrderFields"></param>
        /// <param name="PageIndex"></param>
        /// <param name="PageSize"></param>
        /// <param name="RecordCount"></param>
        /// <param name="PageCount"></param>
        /// <returns></returns>
        private static string GetPageSql(DbConnection connection, DbCommand cmd, string SqlAllFields, string SqlTablesAndWhere, string IndexField, string OrderFields, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            RecordCount = 0;
            PageCount = 0;
            if (PageSize <= 0)
            {
                PageSize = 10;
            }
            string SqlCount = "select count(" + IndexField + ") from " + SqlTablesAndWhere;
            cmd.CommandText = SqlCount;
            RecordCount = (int)cmd.ExecuteScalar();
            if (RecordCount % PageSize == 0)
            {
                PageCount = RecordCount / PageSize;
            }
            else
            {
                PageCount = RecordCount / PageSize + 1;
            }
            if (PageIndex > PageCount)
                PageIndex = PageCount;
            if (PageIndex < 1)
                PageIndex = 1;
            string Sql = null;
            if (PageIndex == 1)
            {
                Sql = "select top " + PageSize + " " + SqlAllFields + " from " + SqlTablesAndWhere + " " + OrderFields;
            }
            else
            {
                Sql = "select top " + PageSize + " " + SqlAllFields + " from ";
                if (SqlTablesAndWhere.ToLower().IndexOf(" where ") > 0)
                {
                    string _where = Regex.Replace(SqlTablesAndWhere, @"\ where\ ", " where (", RegexOptions.IgnoreCase | RegexOptions.Compiled);
                    Sql += _where + ") and (";
                }
                else
                {
                    Sql += SqlTablesAndWhere + " where (";
                }
                Sql += IndexField + " not in (select top " + (PageIndex - 1) * PageSize + " " + IndexField + " from " + SqlTablesAndWhere + " " + OrderFields;
                Sql += ")) " + OrderFields;
            }
            return Sql;
        }
        private static void PrepareCommand(DbCommand cmd, DbConnection conn, DbTransaction trans, CommandType cmdType, string cmdText, DbParameter[] cmdParms)
        {

            if (conn.State != ConnectionState.Open)
                conn.Open();

            cmd.Connection = conn;
            cmd.CommandText = cmdText;

            if (trans != null)
                cmd.Transaction = trans;

            cmd.CommandType = cmdType;
            cmd.CommandTimeout = Timeout;
            if (cmdParms != null)
            {
                foreach (DbParameter parm in cmdParms)
                    if (parm != null)
                        cmd.Parameters.Add(parm);
            }
        }

        //公有方法，调用存储过程(带参数)
        //输入：
        //      ProcName - 存储过程名
        //      Params   - 用来调用存储过程的参数表
        //输出：
        //      对Update、Insert、Delete操作返回影响到的行数，其他情况为-1
        public static int RunProc(string ProcName, SqlParameter[] Params) 
        {

            int Count = -1;
            SqlCommand Cmd = CreateCommand(ProcName, Params);
            Count = Cmd.ExecuteNonQuery();
            Close();
            return Count;
        }
        //私有方法，获得一个用来调用存储过程的SqlCommand
        //输入：
        //      ProcName - 存储过程名
        //      Params   - 用来调用存储过程的参数表
        private static SqlCommand CreateCommand(string ProcName, SqlParameter[] Prams)
        {
            Open();
            SqlCommand Cmd = new SqlCommand(ProcName, Connection);
            Cmd.CommandType = CommandType.StoredProcedure;

            if (Prams != null)
            {
                foreach (SqlParameter Parameter in Prams)
                    Cmd.Parameters.Add(Parameter);
            }

            return Cmd;
        }
        //保护方法，打开数据库连接
        private static void Open()
        {
            //判断数据库连接是否存在
            if (Connection == null)
            {
                //不存在，新建并打开
                Connection = new SqlConnection(DBConfig.EPErperString);
                Connection.Open();
            }
            else
            {
                //存在，判断是否处于关闭状态
                if (Connection.State.Equals(ConnectionState.Closed))
                    Connection.Open();    //连接处于关闭状态，重新打开
            }
        }
        //公有方法，关闭数据库连接
        public static void Close()
        {
            if (Connection.State.Equals(ConnectionState.Open))
            {
                Connection.Close();     //连接处于打开状态，关闭连接
            }
        }
        /// <summary>
        /// 关闭连接
        /// </summary>
        public static void CloseConn()
        {
            if (DbHelper.Conn != null)
            {
                if (DbHelper.Conn.State == ConnectionState.Open)
                {
                    DbHelper.Conn.Close();
                }
            }
        }
        /// 公有方法，获取数据，返回一个DataTable。
        /// </summary>
        /// <param name="SqlString">Sql语句</param>
        /// <returns>DataTable</returns>
        public static DataTable GetDataTable(String SqlString)
        {
            DataSet dataset = GetDataSet(SqlString);
            dataset.CaseSensitive = false;
            return dataset.Tables[0];
        }
        //公有方法，调用存储过程(不带参数)
        //输入：
        //			ProcName存储过程名
        //输出：
        //			将执行结果以DataSet返回  
  
        public static DataSet GetDataSet(string ProcName)
        {
            Open();
            SqlDataAdapter adapter = new SqlDataAdapter(ProcName, Connection);
            DataSet dataset = new DataSet();
            adapter.Fill(dataset);
            Close();
            return dataset;
        }
        
    }
}