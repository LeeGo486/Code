using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST0000A
{
    /// <summary>
    ///DBDict_Execute 数据字典收集器
    /// </summary>
    public class DBDict_Execute : LogicBase, ILogicExecute
    {
        public DBDict_Execute()
        {
            this.m_SessionCheck = false;
        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("DBDict");

            //取到所有的数据库服务器
            DataTable dt_DBServer = conn.GetDataTable("SELECT * FROM DBServer ", new string[0]);

            //清空数据
            conn.ExcuteQuerryByTran(@"
                    TRUNCATE TABLE DBDict.dbo.TableDict
                    TRUNCATE TABLE DBDict.dbo.TableSize
                    TRUNCATE TABLE DBDict.dbo.DBInfo
                    TRUNCATE TABLE DBDict.dbo.TableIndex
                    TRUNCATE TABLE DBDict.dbo.DBOtherInfo
                    TRUNCATE TABLE DBDict.dbo.LinkServers
                ");


            if (dt_DBServer.Rows.Count > 0)
            {

                for (int i = 0; i < dt_DBServer.Rows.Count; i++)
                {
                    string strConnString = "DataBase=master;Password=" + dt_DBServer.Rows[i]["sql密码"].ToString() + ";User ID=" + dt_DBServer.Rows[i]["sql用户名"].ToString() + ";Data Source=" + dt_DBServer.Rows[i]["ip"].ToString() + ";";

                    string strSQL = "SELECT Name FROM Master..SysDatabases ORDER BY Name";


                    Dbconn conn_AllDB = new Dbconn(strConnString, true);

                    //所有的数据库名
                    DataTable dt_AllDB = conn_AllDB.GetDataTable(strSQL, new string[0]);

                    for (int k = 0; k < dt_AllDB.Rows.Count; k++)
                    {

                        if (dt_AllDB.Rows[k][0].ToString() == "tempdb")
                        {
                            continue;
                        }

                        strConnString = "DataBase=" + dt_AllDB.Rows[k][0].ToString() + ";Password=" + dt_DBServer.Rows[i]["sql密码"].ToString() + ";User ID=" + dt_DBServer.Rows[i]["sql用户名"].ToString() + ";Data Source=" + dt_DBServer.Rows[i]["ip"].ToString() + ";";

                        Dbconn conn_DB = new Dbconn(strConnString, true);


                        string str_获取数据库中所有表的字段属性 = @"
SELECT  @@SERVERNAME 服务器,db_name() 数据库名,d.name AS 表名, 
      CASE WHEN a.colorder = 1 THEN isnull(f.value, '') ELSE '' END AS 表说明, 
      a.colorder AS 字段序号, a.name AS 字段名, CASE WHEN COLUMNPROPERTY(a.id, 
      a.name, 'IsIdentity') = 1 THEN '√' ELSE '' END AS 标识, 
      CASE WHEN EXISTS
          (SELECT 1
         FROM dbo.sysindexes si INNER JOIN
               dbo.sysindexkeys sik ON si.id = sik.id AND si.indid = sik.indid INNER JOIN
               dbo.syscolumns sc ON sc.id = sik.id AND sc.colid = sik.colid INNER JOIN
               dbo.sysobjects so ON so.name = si.name AND so.xtype = 'PK'
         WHERE sc.id = a.id AND sc.colid = a.colid) THEN '√' ELSE '' END AS 主键, 
      b.name AS 类型, a.length AS 长度, COLUMNPROPERTY(a.id, a.name, 'PRECISION') 
      AS 精度, ISNULL(COLUMNPROPERTY(a.id, a.name, 'Scale'), 0) AS 小数位数, 
      CASE WHEN a.isnullable = 1 THEN '√' ELSE '' END AS 允许空, ISNULL(e.text, '') 
      AS 默认值, ISNULL(g.[value], '') AS 字段说明, d.crdate AS 创建时间, 
      CASE WHEN a.colorder = 1 THEN d.refdate ELSE NULL END AS 更改时间,
      GETDATE() 采集时间
FROM dbo.syscolumns a with(nolock)  LEFT OUTER JOIN
      dbo.systypes b with(nolock)  ON a.xtype = b.xusertype INNER JOIN
      dbo.sysobjects d with(nolock)  ON a.id = d.id AND d.xtype = 'U' AND 
      d.status >= 0 LEFT OUTER JOIN
      dbo.syscomments e with(nolock)  ON a.cdefault = e.id LEFT OUTER JOIN
      sys.extended_properties g with(nolock)  ON a.id = g.major_id AND a.colid = g.minor_id AND 
      g.name = 'MS_Description' LEFT OUTER JOIN
      sys.extended_properties f with(nolock)  ON d.id = f.major_id AND f.minor_id = 0 AND 
      f.name = 'MS_Description'
ORDER BY d.name, 字段序号	
        ";


                        string str_显示当前数据库中用户表的记录数量及大小 = @"
SELECT @@servername 服务器,db_name() 数据库,OBJECT_NAME(id) AS 表名,
       rowcnt AS 记录数量,
       8 * reserved / 1024 AS '大小(MB)',
       GETDATE() 采集时间
FROM   sysindexes a with(nolock) 
       LEFT JOIN sys.objects b with(nolock) 
            ON  a.name = b.name
WHERE  indid < 2
       AND OBJECTPROPERTY(id, 'isusertable ') = 1
ORDER BY
       rowcnt DESC
";


                        string str_查询所有表的索引 = @"
SELECT @@SERVERNAME AS 服务器,DB_NAME() AS 数据库, 
      c.name AS 表名, 
      a.name AS 索引名称, d.name AS 列名, 
      b.keyno AS 索引顺序, CASE indexkey_property(c.id, b.indid, b.keyno, 'isdescending') 
      WHEN 1 THEN '降序' WHEN 0 THEN '升序' END AS 排序, CASE WHEN p.id IS NULL 
      THEN '' ELSE '√' END AS 主键, CASE INDEXPROPERTY(c.id, a.name, 'IsClustered') 
      WHEN 1 THEN '√' WHEN 0 THEN '' END AS 聚集, CASE INDEXPROPERTY(c.id, 
      a.name, 'IsUnique') WHEN 1 THEN '√' WHEN 0 THEN '' END AS 唯一, 
      CASE WHEN e.id IS NULL THEN '' ELSE '√' END AS 唯一约束, 
      a.OrigFillFactor AS 填充因子, c.crdate AS 创建时间, c.refdate AS 更改时间,
      GETDATE() AS 采集时间
FROM dbo.sysindexes a with(nolock)  INNER JOIN
      dbo.sysindexkeys b with(nolock) ON a.id = b.id AND a.indid = b.indid INNER JOIN
      dbo.syscolumns d with(nolock) ON b.id = d.id AND b.colid = d.colid INNER JOIN
      dbo.sysobjects c with(nolock) ON a.id = c.id AND c.xtype = 'U' LEFT OUTER JOIN
      dbo.sysobjects e with(nolock) ON e.name = a.name AND e.xtype = 'UQ' LEFT OUTER JOIN
      dbo.sysobjects p with(nolock) ON p.name = a.name AND p.xtype = 'PK'
WHERE (OBJECTPROPERTY(a.id, N'IsUserTable') = 1) AND (OBJECTPROPERTY(a.id, 
      N'IsMSShipped') = 0) AND (INDEXPROPERTY(a.id, a.name, 'IsAutoStatistics') = 0)
ORDER BY c.name, a.name, b.keyno
";

                        string str_表视图函数存储过程触发器主键外键约束规则 = @"
SELECT DISTINCT @@SERVERNAME AS 服务器,DB_NAME() AS 数据库,
      isnull(p.name,'') AS 父对象, o.xtype, 
      CASE o.xtype WHEN 'C' THEN 'CHECK 约束' WHEN 'D' THEN '默认值或DEFAULT约束'
       WHEN 'F' THEN 'FOREIGNKEY约束' WHEN 'L' THEN '日志' WHEN 'FN' THEN '标量函数'
       WHEN 'IF' THEN '内嵌表函数' WHEN 'P' THEN '存储过程' WHEN 'PK' THEN 'PRIMARYKEY约束'
       WHEN 'RF' THEN '复制筛选存储过程' WHEN 'S' THEN '系统表' WHEN 'TF' THEN '表函数'
       WHEN 'TR' THEN '触发器' WHEN 'U' THEN '用户表' WHEN 'UQ' THEN 'UNIQUE 约束'
       WHEN 'V' THEN '视图' WHEN 'X' THEN '扩展存储过程' WHEN 'R' THEN '规则' ELSE NULL
       END AS 类型, o.name AS 对象名, o.crdate AS 创建时间, o.refdate AS 更改时间, 
      c.text AS 声明语句,
      GETDATE() AS 采集时间
FROM dbo.sysobjects o with(nolock) Left JOIN
      dbo.sysobjects p with(nolock)  ON o.parent_obj = p.id LEFT OUTER JOIN
      dbo.syscomments c with(nolock)   ON o.id = c.id
WHERE --(o.xtype IN ('C','D','F','PK','UQ','L','FN','IF','TF','TR','P','R','RF','X','S','U','V')) AND 
      (OBJECTPROPERTY(o.id, N'IsMSShipped') = 0) AND (isnull(p.name,'') <> N'dtproperties')
ORDER BY o.xtype DESC 
    
";


                        string str_取本机已建立的链接服务器 = @"
SELECT @@servername AS SeverName,s.name linkedServerName,
       s.data_source linkedserver_source,
       s.is_linked,
       s.modify_date,
       ll.remote_name,
       ll.local_principal_id,
       ll.uses_self_credential,
       p.name localLoginName,
       GETDATE() AS CollecterDate
FROM   sys.Linked_logins ll with(nolock) 
       INNER JOIN sys.servers s with(nolock) 
            ON  s.server_id = ll.server_id
       LEFT JOIN sys.server_principals p with(nolock) 
            ON  p.principal_id = ll.local_principal_id
WHERE  s.is_linked = 1
";

                        DataTable dt_获取数据库中所有表的字段属性 = conn_DB.GetDataTable(str_获取数据库中所有表的字段属性, new string[0]);
                        DataTable dt_显示当前数据库中用户表的记录数量及大小 = conn_DB.GetDataTable(str_显示当前数据库中用户表的记录数量及大小, new string[0]);
                        DataTable dt_查询所有表的索引 = conn_DB.GetDataTable(str_查询所有表的索引, new string[0]);
                        DataTable dt_表视图函数存储过程触发器主键外键约束规则 = conn_DB.GetDataTable(str_表视图函数存储过程触发器主键外键约束规则, new string[0]);
                        DataTable dt_取本机已建立的链接服务器 = conn_DB.GetDataTable(str_取本机已建立的链接服务器, new string[0]);

                        DataTable dt_数据库名 = dt_获取数据库中所有表的字段属性.DefaultView.ToTable(true, new string[1] { "数据库名" });
                        DataTable dt_DBInfo = new DataTable();
                        if(dt_数据库名.Rows.Count>0)
                        {
                            string str_DBInfo = @"

     SELECT @@servername AS ServerName,
            DB_NAME() AS DBName,
            type_desc,
            name,
            physical_name,
            size,
            growth,
            GETDATE() AS CollecterDate
     FROM   " + dt_数据库名.Rows[0][0].ToString() + @".sys.database_files with(nolock) 
            ";
                            dt_DBInfo = conn_DB.GetDataTable(str_DBInfo, new string[0]);
                        }

                        ArrayList listTable = new ArrayList();
                        listTable.Add("TableDict");
                        listTable.Add("TableSize");
                        listTable.Add("DBInfo");
                        listTable.Add("TableIndex");
                        listTable.Add("DBOtherInfo");
                        listTable.Add("LinkServers");

                        //conn.ConnOpen();
                        conn.BeginTransaction();
                        try
                        {
                            conn.TableLock(listTable);


                            if (dt_DBInfo.Rows.Count > 0)
                            {
                                conn.InsertBYSQLBC("DBInfo", dt_DBInfo);
                            }



                            conn.InsertBYSQLBC("TableDict", dt_获取数据库中所有表的字段属性);
                            conn.InsertBYSQLBC("TableSize", dt_显示当前数据库中用户表的记录数量及大小);
                            conn.InsertBYSQLBC("TableIndex", dt_查询所有表的索引);
                            conn.InsertBYSQLBC("DBOtherInfo", dt_表视图函数存储过程触发器主键外键约束规则);
                            conn.InsertBYSQLBC("LinkServers", dt_取本机已建立的链接服务器);

                            conn.CommitTransaction();
                            //conn.ConnClose();

                        }
                        catch
                        {

                            conn.RollbackTransaction();
                        }

                    }

                }
            }

            return true;
        }

    }

}