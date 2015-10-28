using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;



namespace HZY.COM.WS.SPWX
{
    class DBHandle
    {

        private string appName;

        public DBHandle(string appName)
        {
            this.appName = appName;
        }



        //获取行数

        internal int GetRows(string select, object[] objParam)
        {
            int iRst = 0;

            DBConn cn = new DBConn(this.appName);

            using (cn.sqlCon)
            {
                SqlCommand cmd 
                    = new SqlCommand(select, cn.sqlCon);

                for (int i = 0; i < objParam.Length; i++)
                {
                    cmd.Parameters.Add(
                        new SqlParameter("@Param" + i.ToString(), objParam[i]));
                };
                cn.sqlCon.Open();
                    object oRst = cmd.ExecuteScalar();
                cn.sqlCon.Close();

                if (oRst != null)
                {
                    iRst = Int32.Parse(oRst.ToString());
                }
            };

            return iRst;
        
        }

        //调取存储过程获取数据集
        internal DataTable GetDataBySP
            (string SPName, object[] objParamName, object[] objParamValue)
        { 
            DataTable dt = new DataTable();
            DBConn cn = new DBConn(this.appName);

            using (cn.sqlCon)
            {
                SqlCommand cmd
                    = new SqlCommand(SPName, cn.sqlCon);
                cmd.CommandType
                    = CommandType.StoredProcedure;
                cmd.CommandText = SPName;

                if (objParamName.Length == objParamValue.Length)
                {
                    for (int i = 0; i < objParamName.Length; i++)
                    {
                        cmd.Parameters.Add(new SqlParameter(
                            "@" + objParamName[i],
                            objParamValue[i]));
                    };

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    
                    cn.sqlCon.Open();
                        da.Fill(dt);
                    cn.sqlCon.Close();
                }
                else
                {
                    dt = null;
                };
            };

            return dt;
        }

        //获取数据集
        internal DataTable GetData
            (string select, object[] objParam)
        {
            DataTable dtRst = new DataTable();

            DBConn cn = new DBConn(this.appName);

            using (cn.sqlCon)
            {
                SqlCommand cmd = new SqlCommand(select, cn.sqlCon);

                for (int i = 0; i < objParam.Length; i++)
                {
                    cmd.Parameters.Add(
                        new SqlParameter("@Param" + i.ToString(), objParam[i]));
                };

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                cn.sqlCon.Open();
                    da.Fill(dtRst);
                cn.sqlCon.Close();
            };
            return dtRst;
        }
        
        //获取表头
        internal DataTable GetTabHead(string tabName)
        {
            string select = @"SELECT TOP 0 * FROM " + tabName
                            + " WHIT(NOLOCK)";
            
            DataTable dt = new DataTable();
            
            DBConn cn = new DBConn(this.appName);
            using (cn.sqlCon)
            {
                SqlCommand cmd = new SqlCommand(select, cn.sqlCon);

                SqlDataAdapter adapter
                    = new SqlDataAdapter(cmd);
                cn.sqlCon.Open();
                    adapter.Fill(dt);
                cn.sqlCon.Close();

                return dt;
            }
        }
        
        /// <summary>
        /// 单表新增数据
        /// </summary>
        /// <param name="tabName">目标表名</param>
        /// <param name="dt">数据</param>
        /// <returns></returns>
        internal bool Insert(string tabName, DataTable dt)
        {
            bool bRst = false;

            string select = @"SELECT TOP 0 * FROM " + tabName
                            + " WHIT(NOLOCK)";
            DataTable dtSubmit = new DataTable();

            DBConn cn = new DBConn(this.appName);
            using (cn.sqlCon)
            {
                cn.sqlCon.Open();

                    SqlCommand cmd = new SqlCommand(select, cn.sqlCon);

                    SqlTransaction sqlTransaction = cn.sqlCon.BeginTransaction();

                    cmd.Transaction = sqlTransaction;
                try
                {
                    SqlDataAdapter adapter
                        = new SqlDataAdapter(cmd);

                    adapter.Fill(dt);
                        SqlCommandBuilder builder 
                            = new SqlCommandBuilder(adapter);
                    adapter.Update(dt);
                    
                    sqlTransaction.Commit();
                    cn.sqlCon.Close();

                    bRst = true;
                }
                catch (Exception)
                {
                    sqlTransaction.Rollback();
                    cn.sqlCon.Close();
                    throw;
                }
                
            };


            return bRst;
        }
        
    
        /// <summary>
        /// 单表操作，速度快，占用稀缺资源少
        /// </summary>
        /// <param name="tabName">更新的表名</param>
        /// <param name="pkColumn">字段</param>
        /// <param name="dtUpdate">数据</param>
        /// <returns></returns>
        internal bool Update
            (string tabName, string pkColumn, DataTable dtUpdate)
        {
            bool bRst = false;

            DataTable dtSoucre = new DataTable();
            DataTable dtSubmit = new DataTable();

            string select = @"SELECT * FROM " + tabName
                    + " WITH(NOLOCK) ";
            dtSoucre = GetData(select, new object[0]);

            for (int i = 0; i < dtUpdate.Rows.Count; i++)
            {
                string updatePK = dtUpdate.Rows[i][pkColumn].ToString();

                for (int j = 0; j < dtSoucre.Rows.Count; j++)
                {
                    string sourePK = dtSoucre.Rows[j][pkColumn].ToString();
                    if (updatePK == sourePK)
                    {
                        for (int k = 0; k < dtUpdate.Columns.Count; k++)
                        {
                            string ColName = dtUpdate.Columns[k].ColumnName;

                            dtSoucre.Rows[j][ColName] = dtUpdate.Rows[i][ColName];
                        };
                    };
                };
            };


            DBConn cn = new DBConn(this.appName);
            
            using (cn.sqlCon)
            {
                string query = @"SELECT TOP 0 * FROM " 
                        + tabName + "WITH(NOLOCK) ";

                cn.sqlCon.Open();

                    SqlCommand cmd = new SqlCommand(query, cn.sqlCon);
                
                    SqlTransaction sqlTransaction
                        = cn.sqlCon.BeginTransaction();

                    cmd.Transaction = sqlTransaction;

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                try
                {
                    //获取表架构
                    adapter.Fill(dtSubmit);
                    
                    ////将更新的值插入表
                    dtSubmit = dtSoucre.GetChanges();

                    //设置主键
                    ManufacturePrimaryKey(pkColumn, dtSubmit);
               

                    //自动处理行状态
                    SqlCommandBuilder builder = new SqlCommandBuilder(adapter);
                
                    //将数据写入数据库
                    adapter.Update(dtSubmit);

                        sqlTransaction.Commit();  
                    cn.sqlCon.Close();

                    bRst = true;

                }
                catch (Exception e)
                {
                    bRst = false;
                    sqlTransaction.Rollback();
                    cn.sqlCon.Close();
                }
                
            };


            return bRst;
        }

        /// <summary>
        ///  多表操作用该方法
        /// </summary>
        /// <param name="pkColumn">Update时的主键，请在数据库表中设置相应的主键</param>
        /// <param name="dsUpdate">需要操作的数据表集合</param>
        /// <returns></returns>
        internal bool UpdateDB
            (string pkColumn, DataSet dsUpdate)
        {
            bool bRst = false;

            int haveDt = dsUpdate.Tables.Count;

            DataTable dtSoucre = new DataTable();
            DataTable dtSubmit = new DataTable();

            

            if (haveDt > 0)
            {
                DBConn cn = new DBConn(this.appName);
                using (cn.sqlCon)
                {
                    cn.sqlCon.Open();
                        SqlTransaction sqlTransaction
                            = cn.sqlCon.BeginTransaction();
                    try
                    {
                        //处理表情况
                        for (int i = 0; i < dsUpdate.Tables.Count; i++)
                        {
                            string tabName = dsUpdate.Tables[i].TableName;
                            string RowStatus = dsUpdate.Tables[i].Rows[0].RowState.ToString();
                            
                            string select = "SELECT TOP 0 * FROM ";
                            select += tabName + " WHIT(NOLOCK)";

                            DataTable dt = dsUpdate.Tables[i].Copy();

                            if (RowStatus == "Modified")
                            {
                                string soucre = @"SELECT * FROM " + tabName
                                                + " WITH(NOLOCK) ";
                                dtSoucre = GetData(soucre, new object[0]);

                                for (int j = 0; j < dt.Rows.Count; j++)
                                {
                                    string updatePK = dt.Rows[j][pkColumn].ToString();

                                    for (int k = 0; k < dtSoucre.Rows.Count; k++)
                                    {
                                        string sourePK = dtSoucre.Rows[k][pkColumn].ToString();
                                        if (updatePK == sourePK)
                                        {
                                            for (int l = 0; l < dt.Columns.Count; l++)
                                            {
                                                string ColName = dt.Columns[l].ColumnName;

                                                dtSoucre.Rows[k][ColName] = dt.Rows[j][ColName];
                                            };
                                        };
                                    };
                                };
                            };

                            SqlCommand cmd = new SqlCommand(select, cn.sqlCon);
                                cmd.Transaction = sqlTransaction;

                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                            if (RowStatus == "Added")
                            {
                                adapter.Fill(dt);
                                dtSubmit = dt.Copy();
                            }
                            else if (RowStatus == "Modified")
                            {
                                adapter.Fill(dtSubmit);
                                dtSubmit = dtSoucre.GetChanges();

                                //设置主键
                                ManufacturePrimaryKey(pkColumn, dtSubmit);
                            };

                            SqlCommandBuilder builder
                                = new SqlCommandBuilder(adapter);
                            adapter.Update(dtSubmit);
                        };
                        sqlTransaction.Commit();
                        cn.sqlCon.Close();
                        bRst = true;
                    }
                    catch (Exception)
                    {
                        bRst = false;
                        sqlTransaction.Rollback();
                        cn.sqlCon.Close();
                       
                    }; 
                };
            };
            return bRst;
        }

        //设置主键
        internal void ManufacturePrimaryKey
            (string pkName,DataTable dt)
        {
            DataColumn[] pk = new DataColumn[1];

            pk[0] = dt.Columns[pkName];

            dt.PrimaryKey = pk;
        }

    }
}
