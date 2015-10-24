using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：IBMWCSSKUInterface
/// 类说明：富勒WMS商品接口
/// 创建人：马卫清
/// 创建日期：2014-10-13
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class IBMWCSSKUInterface : HZYLogicBase, ILogicExecute
    {
        #region 构造函数
        public IBMWCSSKUInterface()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("DRP_EC");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public Boolean Execute()
        {
            try
            {


                int nExecuteRowCount = 200;

                if (m_request != null && m_request.Tables.Count > 0 && m_request.Tables[0].Rows.Count == 1)
                {
                    if (m_request.Tables[0].Columns.Contains("executeRowCount"))
                    {
                        try
                        {
                            nExecuteRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["executeRowCount"]);
                        }
                        catch (Exception ex)
                        {
                        }
                    }

                }


                m_conn.TimeOut = 60;
                //事务开始
                m_conn.BeginTransaction();

                string strSQL = @"
                        SELECT top " + nExecuteRowCount.ToString() + @" [NewID]
                              ,[CreateTime]
                              ,[Timestamps]
                              ,[WMSFlag]
                              ,[WCSFlag]
                              ,[SKU]
                              ,[Descr_C]
                              ,[SKU_GROUP4]
                              ,[SKU_GROUP1]
                              ,[Price]
                              ,[Alternate_SKU1]
                              ,[ReservedField01]
                              ,[ReservedField02]
                              ,[ReservedField03]
                              ,[ReservedField04]
                              ,[ReservedField05]
                              ,[NOTES]
                          INTO #tmp
                          FROM [dbo].[Put_SKU]
                          WHERE isnull(WMSFlag,0)=0
 --AND NOT EXISTS(
--						  SELECT 1 FROM FLUX_WMS.dbo.BAS_SKU WITH(NOLOCK)
--						  WHERE [Put_SKU].SKU=bas_sku.sku
--						  )

                          ORDER BY CreateTime ASC,Timestamps ASC 

                          UPDATE [dbo].[Put_SKU]
                          SET WMSFlag=1
                          WHERE EXISTS(SELECT 1 FROM #tmp WHERE #tmp.NewID = Put_SKU.newid)
                          SELECT * FROM #tmp
                          DROP TABLE #tmp
                                                        ";

                DataTable dtData = m_conn.GetDataTable(strSQL);
                if (dtData.Rows.Count > 0)
                {
                    WMSWS.CERPWSService2Service ws = new WMSWS.CERPWSService2Service();
                    WMSWS.wmsSecurityInfo wmsSecurityInfo = new WMSWS.wmsSecurityInfo();
                    WMSWS.wmsParamInfo wmsParamInfo = new WMSWS.wmsParamInfo();
                    WMSWS.wmsSkuInfo wmsSkuInfo = new WMSWS.wmsSkuInfo();
                    wmsParamInfo.customerid = "PAND";
                    wmsParamInfo.messageid = "102";
                    wmsParamInfo.stdno = "SKU";
                    wmsParamInfo.warehouseid = "WH01";

                    wmsSecurityInfo.password = "hc";
                    wmsSecurityInfo.username = "flux";

                    wmsSkuInfo.wmsSkuHeaders = new WMSWS.wmsSkuHeader[dtData.Rows.Count];
                    for (int i = 0; i < dtData.Rows.Count; i++)
                    {
                        WMSWS.wmsSkuHeader skuHeader = new WMSWS.wmsSkuHeader();
                        skuHeader.SKU = dtData.Rows[i]["SKU"].ToString();
                        skuHeader.DESCR_C = dtData.Rows[i]["DESCR_C"].ToString();
                        skuHeader.SKU_GROUP1 = dtData.Rows[i]["SKU_GROUP1"].ToString();
                        skuHeader.SKU_GROUP4 = dtData.Rows[i]["SKU_GROUP4"].ToString();
                        skuHeader.CUSTOMERID = "EP";
                        skuHeader.PRICE = dtData.Rows[i]["PRICE"].ToString();
                        skuHeader.ALTERNATE_SKU1 = dtData.Rows[i]["ALTERNATE_SKU1"].ToString();
                        skuHeader.RESERVEDFIELD01 = dtData.Rows[i]["RESERVEDFIELD01"].ToString();
                        skuHeader.RESERVEDFIELD02 = dtData.Rows[i]["RESERVEDFIELD02"].ToString();
                        skuHeader.RESERVEDFIELD03 = dtData.Rows[i]["RESERVEDFIELD03"].ToString();
                        skuHeader.RESERVEDFIELD04 = dtData.Rows[i]["RESERVEDFIELD04"].ToString();
                        skuHeader.RESERVEDFIELD05 = dtData.Rows[i]["RESERVEDFIELD05"].ToString();

                        wmsSkuInfo.wmsSkuHeaders[i] = skuHeader;
                    }
                    ws.Timeout = 3600 * 1000;
                    WMSWS.wmsResultInfo resultInfo = ws.putSKUData(wmsSecurityInfo, wmsSkuInfo, wmsParamInfo);

                    //执行失败
                    if (resultInfo.returnDesc != "成功")
                    {
                        m_conn.RollbackTransaction();
                        return false;
                    }
                }


                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }

            return true;
        }
        #endregion


        #region  内部函数

        #region  Insert 插入数据
        /// <summary>
        /// 插入数据
        /// </summary>
        private void Insert()
        {
            DataTable dtList = ds.Tables["List"];

            m_conn.InsertBYSQLBC("FLUXOrder", dtList);

            dt_EditResult.Rows.Add(new object[] { 0, "成功！" });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #endregion
    }
}
