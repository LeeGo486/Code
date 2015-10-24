using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Lib_AUZ_AUZ_GetListByAUZ
/// 类说明：根据权限和Market表名，获取Filter信息
/// 创建人：马卫清
/// 创建日期：2013-08-13
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据权限和Market表名，获取Filter信息
    /// </summary>
    public class MDM_Lib_AUZ_AUZ_GetListByAUZ : LogicBase, ILogicGetData
    {
        public MDM_Lib_AUZ_AUZ_GetListByAUZ()
        {
            this.m_SessionCheck = true;

        }
        
        /// <summary>
        /// 根据权限和Market表名，获取Filter信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strAUZ = m_request.Tables[0].Rows[0]["AUZ"].ToString();
                string strMarketTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();

                Dbconn conn = new Dbconn("MDM_Master");
                DataSet returnDs = conn.GetDataSet(@"
                        SELECT  Main_Entity ,
                                t3.Table_Property_Name + ' ' + t1.Fittler AS Filter
                        FROM    dbo.Lib_AUZ_Fittler t1 WITH ( NOLOCK )
                                FULL JOIN dbo.Lib_View_TableColumn t3 WITH ( NOLOCK ) ON t3.Porperty_ID = t1.property_ID
                                LEFT JOIN [dbo].[Lib_View_Table] t4 WITH ( NOLOCK ) ON t4.Table_ID = t3.Table_ID
                                LEFT JOIN dbo.Lib_ExdPropertyList t2 WITH ( NOLOCK ) ON t1.property_ID = t2.Property_ID
                        WHERE   Table_Name = '" + strMarketTableName + @"'
                                AND AUZ LIKE '%【" + strAUZ + @"】%'

                ");
                return returnDs;
            }
            catch  
            {
                throw;

            }



        }

    }

}