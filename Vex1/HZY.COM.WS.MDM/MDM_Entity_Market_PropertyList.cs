using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Entity_Market_PropertyList 
/// 类说明：获取某个Market的Entity的所有属性列表
/// 创建人：马卫清
/// 创建日期：2013-06-19
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取某个Market的Entity的所有属性列表
    /// </summary>
    public class MDM_Entity_Market_PropertyList : LogicBase, ILogicGetData
    {
        public MDM_Entity_Market_PropertyList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取某个Market的Entity的所有属性列表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();

                string strEntity = "";
                string strMarketTableName = "";
                strEntity = m_request.Tables[0].Rows[0]["Entity"].ToString();
                strMarketTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();

                //获取所有的列
                Dbconn conn = new Dbconn("MDM_Master");
                ds = conn.GetDataSet(@"
                    SELECT t1.MainEntity,t2.Porperty_Name,t2.Table_Property_Name FROM dbo.Lib_View_Table t1
                    LEFT JOIN dbo.Lib_View_TableColumn t2 ON t1.Table_ID = t2.Table_ID
                    WHERE Table_Name='" + strMarketTableName + @"'
                    AND Entity='" + strEntity + @"'
                    AND Table_Type='Market'
                    ");

                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}