using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Lib_AUZ_Property_GetListBySessionID
/// 类说明：获取SessionID获取MKT的权限表
/// 创建人：马卫清
/// 创建日期：2013-08-29
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取SessionID获取MKT的权限表
    /// </summary>
    public class MDM_Lib_AUZ_Property_GetListBySessionID : LogicBase, ILogicGetData
    {
        public MDM_Lib_AUZ_Property_GetListBySessionID()
        {
            this.m_SessionCheck = true;

        }

        string m_UpdateAUZ = "";
        string m_ViewAUZ = "";

        /// <summary>
        /// 获取SessionID获取MKT的权限表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strMarketTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();
                this.GetAUZList();

                DataSet returnDs = new DataSet();
                DataTable dt = new DataTable();
                dt.Columns.Add("权限");
                dt.Columns.Add("用户");
                dt.Columns.Add("列名");
                string strView = "";
                string strUpdate = "";

                if (m_UpdateAUZ != "")
                {


                    Dbconn conn = new Dbconn("MDM_Master");
                    DataSet ds = conn.GetDataSet(@"
                         SELECT MainEntity ,
                                Entity ,
                                t3.Property_ID ,
                                Table_Property_Name ,
                                CASE WHEN " + m_UpdateAUZ + @" THEN 1
                                     ELSE 0
                                END AS Update_AUZ ,
                                CASE WHEN " + m_ViewAUZ + @" THEN 1
                                     ELSE 0
                                END AS View_AUZ
                         FROM   dbo.Lib_View_Table t1
                                JOIN dbo.Lib_View_TableColumn t2 ON t1.Table_ID = t2.Table_ID
                                JOIN dbo.Lib_ExdPropertyList t3 ON t2.Porperty_ID = t3.Property_ID
                                JOIN Lib_AUZ_Property t4 ON t3.Property_ID = t4.Property_ID
                         WHERE  Table_Name = 'Store_For_FM'
                                AND ( " + m_UpdateAUZ + @"
                                      OR " + m_ViewAUZ + @"
                                    )
     
                ");



                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (ds.Tables[0].Rows[i]["Update_AUZ"].ToString() == "1")
                        {
                            strUpdate += "【" + ds.Tables[0].Rows[i]["Table_Property_Name"].ToString() + "】";
                        }
                        if (ds.Tables[0].Rows[i]["View_AUZ"].ToString() == "1")
                        {
                            strView += "【" + ds.Tables[0].Rows[i]["Table_Property_Name"].ToString() + "】";
                        }
                    }
                }

                dt.Rows.Add(new object[] { "查看", hzyMessage.User_Name, strView });
                dt.Rows.Add(new object[] { "保存", hzyMessage.User_Name, strUpdate });

                returnDs.Tables.Add(dt);
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

                if (m_ViewAUZ != "")
                {
                    m_ViewAUZ += " OR ";
                }

                m_UpdateAUZ += " Update_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
                m_ViewAUZ += " View_AUZ LIKE '%【" + ds.Tables[0].Rows[i]["Authorization_Name"].ToString() + "】%'";
            }


        }

    }

}