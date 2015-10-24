using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Lib_AUZ_Body_GetListBySessionID
/// 类说明：获取SessionID获取MKT的Body权限表
/// 创建人：马卫清
/// 创建日期：2013-08-29
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取SessionID获取MKT的Body权限表
    /// </summary>
    public class MDM_Lib_AUZ_Body_GetListBySessionID : LogicBase, ILogicGetData
    {
        public MDM_Lib_AUZ_Body_GetListBySessionID()
        {
            this.m_SessionCheck = true;

        }

        string m_UpdateAUZ = "";
        string m_InsertAUZ = "";
        string m_DeleteAUZ = "";
        string m_ViewAUZ = "";
        
        /// <summary>
        /// 获取SessionID获取MKT的Body权限表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strMarketTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();
                this.GetAUZList();

                if (m_UpdateAUZ == "")
                {
                    throw new Exception("您没有任何权限");
                }
                Dbconn conn = new Dbconn("MDM_Master");
                DataSet returnDs = conn.GetDataSet(@"

                        SELECT  Main_Entity ,
                                Entity ,
                                CASE WHEN " + m_UpdateAUZ + @" THEN 1
                                     ELSE 0
                                END AS Update_AUZ,
                                CASE WHEN " + m_InsertAUZ + @" THEN 1
                                     ELSE 0
                                END AS Insert_AUZ,
                                CASE WHEN " + m_DeleteAUZ + @" THEN 1
                                     ELSE 0
                                END AS Delete_AUZ,
                                CASE WHEN " + m_ViewAUZ + @" THEN 1
                                     ELSE 0
                                END AS ViewAUZ
                        FROM    [MDM_Master].[dbo].[Lib_AUZ_Body] t1
                                LEFT JOIN dbo.Lib_View_Table t2 ON t1.Main_Entity = t2.MainEntity
                        WHERE   Table_Name = 'Store_For_FM'
                                AND (  " + m_UpdateAUZ + @"
                                      OR " + m_ViewAUZ + @"
                                      OR " + m_InsertAUZ + @"
                                      OR " + m_DeleteAUZ + @"
                                    )

                        
     
                ");
                return returnDs;
            }
            catch  
            {
                throw;

            }



        }

        private void GetAUZList()
        {
             
            ST1005A.MDM_System_User_Authorization_GetListBySession_ID cls = new ST1005A.MDM_System_User_Authorization_GetListBySession_ID();
            cls.hzyMessage = this.hzyMessage;
            DataSet ds = cls.GetData();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (m_UpdateAUZ != "")
                {
                    m_UpdateAUZ += " OR ";
                }
                if (m_DeleteAUZ != "")
                {
                    m_DeleteAUZ += " OR ";
                }
                if (m_InsertAUZ != "")
                {
                    m_InsertAUZ += " OR ";
                }

                if (m_ViewAUZ != "")
                {
                    m_ViewAUZ += " OR ";
                }

                m_UpdateAUZ += " Update_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
                m_InsertAUZ += " Insert_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
                m_DeleteAUZ += " Delete_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
                m_ViewAUZ += " View_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
            }

            
        }

    }

}