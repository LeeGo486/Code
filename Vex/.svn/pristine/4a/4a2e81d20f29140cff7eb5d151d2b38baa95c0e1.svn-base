using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetEntityList
/// 类说明：获取MDM实体的列表
/// 创建人：马卫清
/// 创建日期：2013-04-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取MDM实体的列表
    /// </summary>
    public class MDM_GetEntityList : LogicBase, ILogicGetData
    {
        public MDM_GetEntityList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取MDM实体的列表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                Dbconn conn = new Dbconn("MDM_Master");
                DataSet returnDs = conn.GetDataSet(@"
                        SELECT 
                            MDM_Entity + ' ' + MDM_Content as MDM_Content
                            ,[MDM_Entity]      
                        FROM [MDM_Master].[dbo].[Lib_MDM_Config]
                        order by MDM_Entity
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