using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Lib_AUZ_Body_GetListByAUZ
/// 类说明：根据权限获取MDM实体权限表
/// 创建人：马卫清
/// 创建日期：2013-08-02
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据权限获取MDM实体权限表
    /// </summary>
    public class MDM_Lib_AUZ_Body_GetListByAUZ : LogicBase, ILogicGetData
    {
        public MDM_Lib_AUZ_Body_GetListByAUZ()
        {
            this.m_SessionCheck = true;

        }

        
        /// <summary>
        /// 根据权限获取MDM实体权限表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strAUZ = m_request.Tables[0].Rows[0]["AUZ"].ToString();
                string strMianEntity = m_request.Tables[0].Rows[0]["Entity"].ToString();

                Dbconn conn = new Dbconn("MDM_Master");
                DataSet returnDs = conn.GetDataSet(@"
                        DECLARE @str VARCHAR(max)

                        SELECT  Entity
                        INTO #tmp
                        FROM    dbo.Lib_AUZ_Body WITH(NOLOCK)
                        WHERE   Insert_AUZ LIKE '%【" + strAUZ + @"】%'
                                AND Main_Entity = '" + strMianEntity + @"'
                                AND Entity NOT LIKE 'L%'
                        UNION ALL
                        SELECT  Ref_Base_Entity
                        FROM    dbo.Lib_MDM_Config  WITH(NOLOCK)
                        WHERE   MDM_Entity IN ( SELECT  Entity
                                                FROM    dbo.Lib_AUZ_Body  WITH(NOLOCK)
                                                WHERE   Insert_AUZ LIKE '%【" + strAUZ + @"】%'
                                                        AND Main_Entity = '" + strMianEntity + @"'
                                                        AND Entity LIKE 'L%' )


                        SELECT @str = ISNULL(@str,'')+',' + Entity FROM #tmp
                        DROP TABLE #tmp
  
                        SELECT STUFF(@str, 1, 1, '') AS Entity    

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