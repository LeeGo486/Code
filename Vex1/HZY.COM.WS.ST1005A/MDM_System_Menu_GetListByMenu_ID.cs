using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_GetListByMenu_ID 
/// 类说明：取到系统菜单
/// 创建人：马卫清
/// 创建日期：2013-01-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_GetListByMenu_ID 根据用户登录信息及菜单取到菜单下所有的模块信息
    /// </summary>
    public class MDM_System_Menu_GetListByMenu_ID : LogicBase, ILogicGetData
    {
        public MDM_System_Menu_GetListByMenu_ID()
        {
            this.m_SessionCheck = true;

        }

        public DataSet GetData()
        {

            string strVexSSONewID = m_hzyMessage.VexSSONewID;
            string strApp_UserID = m_hzyMessage.User_ID;
            string strEnv_ID = m_hzyMessage.Env_ID;

            string strMenu_ID = m_request.Tables[0].Rows[0]["Menu_ID"].ToString();

            Dbconn conn = new Dbconn("VexSSO");
            DataSet ds = new DataSet();
            DataTable dtReturn = null;


            if (string.IsNullOrEmpty(strVexSSONewID))
            {
                strVexSSONewID = "00000000-0000-0000-0000-000000000000";
            }
            if (strApp_UserID == "0" || strApp_UserID == "")
            {
                strApp_UserID = "-1";
            }

            string[] strMenu_IDList = new string[] { strVexSSONewID, strApp_UserID, strEnv_ID, strMenu_ID };
            string strMenu_IDListParam = "@param3";

            //根据MemuID做循环，直到没有子节点为止
            while (strMenu_IDList.Length >3 )
            {

                
                string strSQL = @"
                SELECT  t4.Menu_Id ,
                        Menu_Code ,
                        Menu_Name ,
                        Menu_Father_ID ,
                        ActionURL
                FROM    dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK )
                        JOIN dbo.MDM_System_Menu_AUZ t3 WITH ( NOLOCK ) ON t2.Authorization_ID = t3.Authorization_ID
                                                                           AND t3.havaFlag = 1
                        JOIN dbo.MDM_System_Menu t4 WITH ( NOLOCK ) ON t3.Menu_ID = t4.Menu_Id
                WHERE   t2.havaFlag = 1
                        AND (t2.VexSSONewID = @param0
                        OR t2.App_UserID = @param1)
                        AND t4.Env_ID = @param2
                        AND isnull(MenuType,0)<>1
                        AND Menu_Father_ID in (" + strMenu_IDListParam+@")
            ";


                DataTable dt1 = conn.GetDataTable(strSQL,strMenu_IDList);

                if (dtReturn == null)
                {
                    dtReturn = dt1.Clone();
                }


                strMenu_IDList = new string[3];

                for (int i = 0; i < dt1.Rows.Count; i++)
                {
                    dtReturn.ImportRow(dt1.Rows[i]);

                    if (i == 0)
                    {
                        strMenu_IDList = new string[3 + dt1.Rows.Count];

                        strMenu_IDList[0] = strVexSSONewID;
                        strMenu_IDList[1] = strApp_UserID;
                        strMenu_IDList[2] = strEnv_ID;
                    }
                    strMenu_IDList[i+3]  = dt1.Rows[i]["Menu_ID"].ToString();
                }


            }

            ds.Tables.Add(dtReturn);
            return ds;

        }

    }

}