using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetMarketDataByTableNameMKT 
/// 类说明：根据表名的获取MDMMarket中对应表所有数据，直接从MDM_Market数据库里面取
/// 创建人：马卫清
/// 创建日期：2013-08-23
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据表名的获取MDMMarket中对应表所有数据
    /// </summary>
    public class MDM_GetMarketDataByTableNameMKT : LogicBase, ILogicGetData
    {
        public MDM_GetMarketDataByTableNameMKT()
        {
            this.m_SessionCheck = true;

        }

     
        /// <summary>
        /// 根据Entity的编号获取MDM中Entity的所有数据
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();

                string strTableName = "";
                strTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();

                Dbconn conn = new Dbconn("MDM_Market");
                string strSQL = "SELECT * FROM MKT_" + strTableName + " FOR XML PATH('rows')";

                return conn.GetDataSet(strSQL);
            }
            catch
            {
                throw;

            }



        }
         
    }

}