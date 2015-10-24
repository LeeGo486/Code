using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM2_Lib_MDM_Config_GetListForEeayUITree
/// 类说明：获取MDM实体的列表EasyUI构建树专用
/// 创建人：马卫清
/// 创建日期：2013-09-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 获取MDM实体的列表EasyUI构建树专用
    /// </summary>
    public class MDM2_Lib_MDM_Config_GetListForEeayUITree : LogicBase, ILogicGetData
    {
        public MDM2_Lib_MDM_Config_GetListForEeayUITree()
        {
            this.m_SessionCheck = true;

        }

        /// <summary>
        /// 获取MDM实体的列表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                Dbconn conn = new Dbconn("MDM_Master2");
                DataSet returnDs = conn.GetDataSet(@"
                        SELECT MDM_Entity,MDM_Content,0 AS ParentID FROM Lib_MDM_Config
                        ORDER BY MDM_Entity ASC
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