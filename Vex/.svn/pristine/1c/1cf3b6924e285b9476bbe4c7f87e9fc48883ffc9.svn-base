using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：FluxWMSDSellDToWInterface
/// 类说明：门店发货出库单导入WMS	DRP->WMS	发货单白单
/// 创建人：郭琦琦
/// 创建日期：2014-03-12
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class FluxWMSDSellDToWInterface : HZYLogicBase, ILogicExecute
    {
        #region 构造函数
        public FluxWMSDSellDToWInterface()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("DRP_EC");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        //string strMaxRequestid;
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
                int nExecuteRowCount = 200;//定义执行条数，如果没有配置，就默认200

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

                //获取主表信息
                string strSQL = @" SELECT  * into #tmp FROM    ( SELECT top " + nExecuteRowCount.ToString() + @"
                                                    ROW_NUMBER() OVER ( PARTITION BY [SOReference1] ORDER BY requestid DESC ) AS a ,
                                                    [NewID]
                                                  ,[CreateTime]
                                                  ,[Timestamps]
                                                  ,[requestid]
                                                  ,[SOReference1]
                                                  ,[SOReference2]
                                                  ,[CustomerID]
                                                  ,[OrderType]
                                                  ,[ConsigneeID]
                                                  ,[ConsigneeName]
                                                  ,[C_Address1]
                                                  ,[OrderTime]
                                                  ,[H_EDI_01]
                                                  ,[H_EDI_02]
                                                  ,[H_EDI_03]
                                                  ,[H_EDI_04]
                                                  ,[LotAtt05]
                                                  ,[LotAtt06]
                                                  ,[WMSFLAG]
                                                  ,[NOTES]                      
                                          FROM      PUT_DRPd_Sell
                                          WHERE     ISNULL(WMSFlag, 0) = 0 
                                        ) f  
                                 WHERE   a = 1 
                                 ORDER BY [requestid] DESC 
                                 SELECT* FROM #tmp ";
                DataTable dtData = m_conn.GetDataTable(strSQL);
                //string strMaxRequestid = dtData.Rows[0]["requestid"].ToString();
                if (dtData.Rows.Count > 0)
                {

                    WMSWS.CERPWSService2Service ws = new WMSWS.CERPWSService2Service();
                    WMSWS.wmsSecurityInfo wmsSecurityInfo = new WMSWS.wmsSecurityInfo();//	系统级参数
                    WMSWS.wmsParamInfo wmsParamInfo = new WMSWS.wmsParamInfo();//	系统级参数
                    wmsParamInfo.customerid = "PAND";
                    wmsParamInfo.messageid = "1061";
                    wmsParamInfo.stdno = "SO";
                    wmsParamInfo.warehouseid = "WH01";
                    wmsSecurityInfo.password = "hc";
                    wmsSecurityInfo.username = "flux";

                    WMSWS.wmsSOInfo wmsSOInfo = new WMSWS.wmsSOInfo();
                    wmsSOInfo.wmsSOHeaders = new WMSWS.wmsSOHeader[dtData.Rows.Count];//定义主表行数

                    for (int i = 0; i < dtData.Rows.Count; i++)
                    {
                        WMSWS.wmsSOHeader SOHeader = new WMSWS.wmsSOHeader();
                        //表头主表信息

                        SOHeader.SOREFERENCE1 = dtData.Rows[i]["SOReference1"].ToString();
                        SOHeader.SOREFERENCE2 = dtData.Rows[i]["SOReference2"].ToString();
                        SOHeader.CUSTOMERID = dtData.Rows[i]["CustomerID"].ToString();
                        SOHeader.ORDERTYPE = dtData.Rows[i]["OrderType"].ToString();
                        SOHeader.CONSIGNEEID = dtData.Rows[i]["ConsigneeID"].ToString();
                        SOHeader.CONSIGNEENAME = dtData.Rows[i]["ConsigneeName"].ToString();
                        SOHeader.c_ADDRESS1 = dtData.Rows[i]["C_Address1"].ToString();
                        SOHeader.ORDERTIME = Convert.ToDateTime(dtData.Rows[i]["OrderTime"]).ToString("yyyy-MM-dd HH:mm:ss");
                        SOHeader.h_EDI_01 = dtData.Rows[i]["H_EDI_01"].ToString();
                        SOHeader.h_EDI_02 = dtData.Rows[i]["H_EDI_02"].ToString();
                        SOHeader.h_EDI_03 = dtData.Rows[i]["H_EDI_03"].ToString();
                        SOHeader.h_EDI_04 = dtData.Rows[i]["H_EDI_04"].ToString();

                        //按照主表订单号和状态值获取子表信息
                        string strRequestid = dtData.Rows[i]["requestid"].ToString();
                        string strSQLSub = @"SELECT  b.NewID ,b.Timestamps ,b.requestid ,b.SOReference1 ,b.SKU ,b.QtyOrdered ,b.D_EDI_01 ,b.D_EDI_02 ,a.LotAtt05 ,a.LotAtt06
                                             FROM    PUT_DRPd_Sell a LEFT JOIN PUT_DRPd_Sellsub b ON b.SOReference1 = a.SOReference1 AND b.requestid = a.requestid
                                             WHERE  ISNULL(b.QtyOrdered, '') != '' and  a.SOReference1='" + dtData.Rows[i]["SOReference1"].ToString() + "' AND a.requestid='" + strRequestid + "'";
                        DataTable dtDataSub = m_conn.GetDataTable(strSQLSub);

                        SOHeader.detailsItem = new WMSWS.wmsSODetails[dtDataSub.Rows.Count];//定义子表行数
                        for (int j = 0; j < dtDataSub.Rows.Count; j++)
                        {
                            WMSWS.wmsSODetails SODetails = new WMSWS.wmsSODetails();
                            SODetails.SKU = dtDataSub.Rows[j]["SKU"].ToString();
                            SODetails.QTYORDERED = dtDataSub.Rows[j]["QtyOrdered"].ToString();
                            SODetails.LOTATT05 = dtDataSub.Rows[j]["LotAtt05"].ToString();
                            SODetails.LOTATT06 = dtDataSub.Rows[j]["LotAtt06"].ToString();
                            SODetails.d_EDI_01 = dtDataSub.Rows[j]["D_EDI_01"].ToString();
                            SODetails.d_EDI_02 = dtDataSub.Rows[j]["D_EDI_02"].ToString();
                            SOHeader.detailsItem[j] = SODetails;//把子表放入主表容器中
                        }
                        wmsSOInfo.wmsSOHeaders[i] = SOHeader;//把一个订单放入头文件中
                    }

                    ws.Timeout = 3600 * 1000;
                    WMSWS.wmsResultInfo resultInfo = ws.putSOData(wmsSecurityInfo, wmsSOInfo, wmsParamInfo);//传入接口
                    
                    HZY.COM.Common.Log.WirteLogWS(resultInfo.returnDesc, null);

                    //执行失败
                    if (resultInfo.returnDesc != "成功")
                    {
                        m_conn.RollbackTransaction();
                        return false;
                    }
                    else
                    {
                        string strSQLflag = @"
                            UPDATE [dbo].[PUT_DRPd_Sell]
                            SET WMSFlag=1
                            --WHERE EXISTS(SELECT 1 FROM #tmp WHERE #tmp.NewID = PUT_DRPd_Sell.newid)
                            Where requestid <='" + dtData.Rows[0]["requestid"].ToString() + @"'
                            DROP TABLE #tmp ";
                        m_conn.ExcuteQuerryByTran(strSQLflag, new object[] { });
                    }
                    // HZY.COM.Common.Log.WirteLogWS(resultInfo.returnDesc, null);

                }

                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

            }
            catch (Exception ex)
            {
                m_conn.RollbackTransaction();
                HZY.COM.Common.Log.WirteLogWS(ex, null);

                throw ex;
            }

            return true;
        }
        #endregion

    }
}
