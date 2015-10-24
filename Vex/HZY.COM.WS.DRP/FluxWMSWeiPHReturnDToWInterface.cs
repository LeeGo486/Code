using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：FluxWMSWeiPHReturnDToWInterface
/// 类说明：唯品会退货订单导入WMS	DRP->WMS	退货发货单登账
/// 创建人：郭琦琦
/// 创建日期：2014-03-12
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class FluxWMSWeiPHReturnDToWInterface : HZYLogicBase, ILogicExecute
    {
        #region 构造函数
        public FluxWMSWeiPHReturnDToWInterface()
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
                string strSQL = @"
                       SELECT  *  into #tmp FROM    ( SELECT top " + nExecuteRowCount.ToString() + @"
                                                    ROW_NUMBER() OVER ( PARTITION BY [ASNREFERENCE1] ORDER BY requestid DESC ) AS a ,
                            [NewID] 
                          ,[CreateTime]
                          ,[Timestamps]
                          ,[requestid]
                          ,[ASNREFERENCE1]
                          ,[ASNREFERENCE2]
                          ,[CustomerID]
                          ,[ASNType]
                          ,[H_EDI_01]
                          ,[SupplierId]
                          ,[Supplier_Name]
                          ,[UserDefine1]
                          ,[Notes]
                          ,[ASNCreationTime]
                          ,[LotAtt05]
                          ,[LotAtt06]
                          ,[WMSFLAG]
                          FROM [dbo].[PUT_DRPd_OUTINDENTSET] 
                          WHERE isnull(WMSFlag,0)=0
                          AND ASNType='VR' 
                           ) f
                        WHERE   a = 1
                        ORDER BY [requestid] DESC 
                        SELECT* FROM #tmp ";

                DataTable dtData = m_conn.GetDataTable(strSQL);
                if (dtData.Rows.Count > 0)
                {
                    WMSWS.CERPWSService2Service ws = new WMSWS.CERPWSService2Service();
                    WMSWS.wmsSecurityInfo wmsSecurityInfo = new WMSWS.wmsSecurityInfo();//	系统级参数
                    WMSWS.wmsParamInfo wmsParamInfo = new WMSWS.wmsParamInfo();//	系统级参数
                    wmsParamInfo.customerid = "PAND";
                    wmsParamInfo.messageid = "1044";
                    wmsParamInfo.stdno = "ASN";
                    wmsParamInfo.warehouseid = "WH01";
                    wmsSecurityInfo.password = "hc";
                    wmsSecurityInfo.username = "flux";

                    WMSWS.wmsASNInfo wmsASNInfo = new WMSWS.wmsASNInfo();
                    wmsASNInfo.wmsASNHeaders = new WMSWS.wmsASNHeader[dtData.Rows.Count];//定义主表行数

                    for (int i = 0; i < dtData.Rows.Count; i++)
                    {
                        WMSWS.wmsASNHeader ASNHeader = new WMSWS.wmsASNHeader();
                        //表头主表信息

                        ASNHeader.ASNREFERENCE1 = dtData.Rows[i]["ASNREFERENCE1"].ToString();
                        ASNHeader.ASNREFERENCE2 = dtData.Rows[i]["ASNREFERENCE2"].ToString();
                        ASNHeader.CUSTOMERID = dtData.Rows[i]["CUSTOMERID"].ToString();
                        ASNHeader.ASNTYPE = dtData.Rows[i]["ASNType"].ToString();
                        ASNHeader.SUPPLIERID = dtData.Rows[i]["SupplierId"].ToString();
                        ASNHeader.h_EDI_01 = dtData.Rows[i]["H_EDI_01"].ToString();
                        ASNHeader.USERDEFINE1 = dtData.Rows[i]["UserDefine1"].ToString();
                        ASNHeader.SUPPLIER_NAME = dtData.Rows[i]["Supplier_Name"].ToString();
                        ASNHeader.ASNREFERENCE3 = dtData.Rows[i]["Notes"].ToString();                       
                        ASNHeader.ASNCREATIONTIME = Convert.ToDateTime(dtData.Rows[i]["ASNCreationTime"]).ToString("yyyy-MM-dd HH:mm:ss");
                        //按照主表订单号和状态值获取子表信息
                        string strRequestid = dtData.Rows[i]["requestid"].ToString();
                        string strSQLSub = @"SELECT   b.NewID ,b.Timestamps ,b.requestid ,b.ASNREFERENCE1 ,b.SKU ,b.ExpectedQty ,b.D_EDI_01 ,b.D_EDI_02
                                             ,a.LotAtt05,a.LotAtt06
                                             FROM  [PUT_DRPd_OUTINDENTSET] a LEFT JOIN [PUT_DRPd_OUTINDENTSETSUB] b ON b.ASNREFERENCE1 = a.ASNREFERENCE1
                                             AND b.requestid = a.requestid
                                             WHERE ISNULL(b.ExpectedQty, '') != '' and a.ASNREFERENCE1='" + dtData.Rows[i]["ASNREFERENCE1"].ToString() + "' AND a.requestid='" + strRequestid + "'";
                        DataTable dtDataSub = m_conn.GetDataTable(strSQLSub);

                        ASNHeader.detailsItem = new WMSWS.wmsASNDetails[dtDataSub.Rows.Count];//定义子表行数
                        for (int j = 0; j < dtDataSub.Rows.Count; j++)
                        {
                            WMSWS.wmsASNDetails ASNDetail = new WMSWS.wmsASNDetails();
                            ASNDetail.SKU = dtDataSub.Rows[j]["SKU"].ToString();
                            ASNDetail.EXPECTEDQTY = dtDataSub.Rows[j]["ExpectedQty"].ToString();
                            ASNDetail.LOTATT05 = dtDataSub.Rows[j]["LotAtt05"].ToString();
                            ASNDetail.LOTATT06 = dtDataSub.Rows[j]["LotAtt06"].ToString();
                            ASNDetail.d_EDI_01 = dtDataSub.Rows[j]["D_EDI_01"].ToString();
                            ASNDetail.d_EDI_02 = dtDataSub.Rows[j]["D_EDI_02"].ToString();
                            ASNHeader.detailsItem[j] = ASNDetail;//把子表放入主表容器中
                        }
                        wmsASNInfo.wmsASNHeaders[i] = ASNHeader;//把一个订单放入头文件中
                    }
                    ws.Timeout = 3600 * 1000;
                    WMSWS.wmsResultInfo resultInfo = ws.putASNData(wmsSecurityInfo, wmsASNInfo, wmsParamInfo);//传入接口

                    //执行失败
                    if (resultInfo.returnDesc != "成功")
                    {
                        m_conn.RollbackTransaction();
                        return false;
                    }
                    else
                    {
                        string strSQLflag = @"
                            UPDATE [dbo].[PUT_DRPd_OUTINDENTSET]
                            SET WMSFlag=1
                            WHERE ASNType='VR' 
                            And requestid <='" + dtData.Rows[0]["requestid"].ToString() + @"'
                            --and EXISTS(SELECT 1 FROM #tmp WHERE #tmp.NewID = PUT_DRPd_OUTINDENTSET.newid)
                            DROP TABLE #tmp ";
                        m_conn.ExcuteQuerryByTran(strSQLflag, new object[] { });
                    }
                    HZY.COM.Common.Log.WirteLogWS(resultInfo.returnDesc, null);

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
