using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.WS.SSO;

/// 类名：StockToMiddleTable
/// 类说明：蒋库存信息同步到中间表
/// 创建人：马卫清
/// 创建日期：2014-08-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{

    public class StockToMiddleTable : HZYLogicBase, ILogicExecute
    {
        public StockToMiddleTable()
        {
            this.m_SessionCheck = false;

        }

        private Dbconn m_conn = new Dbconn("F22GP");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRetrun = new DataSet();
        private DataSet ds = new DataSet();

        public Boolean Execute()
        {
            bool bReturn = true;
            string strMessage = "";
            try
            {
                Dbconn conn_DRP_EC = new Dbconn("DRP_EC");

                string strDepotID = "";
                DataTable dt = conn_DRP_EC.GetDataTable(@"
                     SELECT [CfgValue]
                      FROM [DRP_EC].[dbo].[Config]
                      WHERE Type='StockSync_DRPToWCS'
                      AND CfgName='Depot'
                ");

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (strDepotID != "")
                    {
                        strDepotID += ",";
                    }
                    strDepotID += "'" + dt.Rows[i]["CfgValue"].ToString() + "'";
                }

                string strSQL = @"
                        SELECT  clothingid AS SKU ,
                                SUM(k_num) AS totalInventory 
                        FROM    dbo.j_stock WITH(NOLOCK)
                        WHERE   depotid in (" + strDepotID + @")
                        GROUP BY clothingid
                        HAVING SUM(k_num)>0
                ";

                DataTable dt1 = m_conn.GetDataTable(strSQL);

                conn_DRP_EC.BeginTransaction();
                conn_DRP_EC.InsertBYSQLBC("Put_SkuStock", dt1);
                conn_DRP_EC.CommitTransaction();

                return bReturn;
            }
            catch (Exception ex)
            {
                m_conn.RollbackTransaction();
                bReturn = false;
                strMessage = ex.ToString();
                throw ex;
            }
            finally
            {
                //HZY.COM.Common.Log.WirteLogWS(bReturn.ToString() + strMessage,null);
            }
        }

        #region 内部函数

        #endregion


    }

}