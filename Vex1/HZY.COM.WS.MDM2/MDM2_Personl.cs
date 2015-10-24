using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：获取人员
/// 类说明：获取人员
/// 创建人：郭琦琦
/// 创建日期：2014-08-22 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.MDM2
{
    public class MDM2_Personl : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDM2_Personl()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("MDM_Market2");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;//创建时间
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData

        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "getPersonl".ToUpper())
                {
                    Get(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 获取人员信息按照部门
        /// <summary>
        /// 获取人员信息按照部门
        /// </summary>
        private void Get(DataTable pdt)
        {
            var strid = "";
            string strWhereTmp = "";
            if (pdt.Columns.Contains("现所在组织单元系统编号"))
            {
                strid = pdt.Rows[0]["现所在组织单元系统编号"].ToString();
                strWhereTmp = "AND (现所在组织单元系统编号 = '" + strid + "')";
            }
            m_conn.BeginTransaction();
            string strSQL = @"
                            SELECT  t1.* ,
                                    t2.名称
                            INTO    #treeview
                            FROM    [dbo].[MKT_0020] t1
                                    LEFT JOIN [dbo].[MKT_0019] t2 ON t2.系统编号 = t1.组织单元系统编号
                            WHERE   t1.是否有效 = '1';
                            WITH    cte ( 组织单元系统编号, 上级组织单元系统编号, 名称 )
                                      AS ( SELECT   组织单元系统编号 ,
                                                    上级组织单元系统编号 ,
                                                    名称
                                           FROM     #treeview AS t WITH(NOLOCK)
                                           WHERE    组织单元系统编号 = '" + strid + @"'
                                           UNION ALL
                                           SELECT   t.组织单元系统编号 ,
                                                    t.上级组织单元系统编号 ,
                                                    t.名称
                                           FROM     #treeview AS t WITH(NOLOCK)
                                                    INNER JOIN cte AS c ON t.上级组织单元系统编号 = c.组织单元系统编号
                                         )
                                SELECT  组织单元系统编号 ,
                                        上级组织单元系统编号 ,
                                        名称
                                INTO    #temp1
                                FROM    cte;";
            m_conn.ExcuteQuerryByTran(strSQL, new string[] { });

            string strSQL1 = @"
                    SELECT  *
                    FROM    dbo.V_L0023 WITH(NOLOCK)
                    WHERE   现所在组织单元系统编号 IN ( SELECT 组织单元系统编号 FROM   #temp1 ) and 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL1, new string[0], m_hzyPageInfo);
            m_conn.CommitTransaction();
        }
        #endregion

        #endregion
    }
}