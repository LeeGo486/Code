using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSRRDebugLog
/// 类说明：查询Debug日志
/// 创建人：马卫清
/// 创建日期：2014-09-29
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 对WSSrc的CRUD,为Easyui专用
    /// </summary>
    public class WSRRDebugLog : HZYLogicBase, ILogicGetData
    {
        public WSRRDebugLog()
        {
            this.m_SessionCheck = false;

        }

        public Dbconn conn = null;
        public DataSet m_ds = new DataSet();
        DataSet ds_Return = new DataSet();

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 查询Debug日志
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                //DataSet ds = new DataSet();

                string strXML = "";
                string strRouteCode = "";

                conn = new Dbconn("WSRR");

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_ds = Common.Common.GetDSByExcelXML(strXML);

                conn.HZYMessage = this.m_hzyMessage;

                DataTable dt_OPTYPE = m_ds.Tables["OPTYPE"];
                for (int i = 0; i < m_ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GetWSRRDemo".ToUpper())
                    {
                        GetWSRRDemo();
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        Get();
                    }
                    
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }

        #region GetWSRRDemo
        private void GetWSRRDemo()
        {
            string strSQL = @"
                             
                                SELECT  
	                                wshelp WSName,
	                                CallSample XmlInput ,
	                                '' Result , 
	                                WSID AS WS_Id
                                FROM [B01_MDM].[WS1_WSDevHead]
                                WHERE isDemo = '是'

                                " + m_hzyPageInfo.Where + "";

            ds_Return = conn.GetDataSetForPageList(strSQL, new string[] {  }, m_hzyPageInfo);

        }

        #endregion

        #region Get
        private void Get()
        {
            string strClientID = m_ds.Tables["LIst"].Rows[0]["ClientID"].ToString();
            if (strClientID == "")
            {
                return;
            }

            string strSQL = @"
                             
                                SELECT  
                                    dev,
                                    Log_NewID ,
                                    Log_Time ,
                                    XmlInput ,
                                    Result ,
                                    end_time ,
                                    DATEDIFF(ms, Log_Time, end_time) AS MS ,
                                    WS_Id
                                FROM    ( SELECT   
                                                '测试' AS dev,
                                                Log_NewID ,
                                                Log_Time ,
                                                XmlInput ,
                                                Result ,
                                                end_time ,
                                                WS_Id
                                        FROM      [M03_GOVERN].[WRL_WSDevRunLog] WITH ( NOLOCK )
                                        WHERE     Client_ID = @param0
                                        UNION ALL
                                        SELECT  
                                                '正式' AS dev,
                                                Log_NewID ,
                                                Log_Time ,
                                                XmlInput ,
                                                Result ,
                                                end_time ,
                                                WS_Id
                                        FROM      [M03_GOVERN].WRL_WSProdRunLog WITH ( NOLOCK )
                                        WHERE     Client_ID = @param0
                                    ) t1


                                " + m_hzyPageInfo.Where + "";

            ds_Return = conn.GetDataSetForPageList(strSQL, new string[] { strClientID }, m_hzyPageInfo);

        }

        #endregion
    }

}