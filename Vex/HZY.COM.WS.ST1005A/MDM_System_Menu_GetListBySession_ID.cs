﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_GetListBySession_ID 
/// 类说明：取到系统菜单
/// 创建人：马卫清
/// 创建日期：2012-12-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_GetListBySession_ID 根据用户登录信息取到系统菜单
    /// </summary>
    public class MDM_System_Menu_GetListBySession_ID : LogicBase, ILogicGetData
    {
        public MDM_System_Menu_GetListBySession_ID()
        {
            this.m_SessionCheck = true;

        }

        public DataSet GetData()
        {

            string strVexSSONewID = m_hzyMessage.VexSSONewID;
            string strEnv_ID = m_hzyMessage.Env_ID;
            string strApp_UserID = m_hzyMessage.User_ID;

            if (string.IsNullOrEmpty(strVexSSONewID))
            {
                strVexSSONewID = "00000000-0000-0000-0000-000000000000"; //默认不存在的值
            }
            if (strApp_UserID == "0" || strApp_UserID == "")
            {
                strApp_UserID = "-1";
            }

            Dbconn conn = new Dbconn("VexSSO");
            string strSQL = "";


            //特殊处理的数据

            //店务系统的店铺登录

            if (hzyMessage.Env_SN == "HZY_SBS" && Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1)) == 'Y')
            {
                strSQL = @"
                    SELECT  
                            DISTINCT
                            t4.Menu_Id ,
                            Menu_Code ,
                            Menu_Name ,
                            Menu_Father_ID ,
                            ActionURL ,
                            MenuType
                    FROM    dbo.MDM_System_Menu t4
                    WHERE   t4.Env_ID = @param1
                            AND (Menu_Name = '维修单' or Menu_Name = '吊牌打印申请查询'or Menu_Name = '店铺盘点赔偿' 
                                or Menu_Name = '吊牌打印申请'
                                or Menu_Name = '导购提成分配'
                                or Menu_Name = '导购提成分配报表'
                                or Menu_Name = 'VIP积分兑换'
                                or Menu_Name = '会员维护')
                    ORDER BY Menu_Code ASC ,
                            Menu_Name
            ";
            }
            else if (hzyMessage.Env_SN == "HZY_SBS" && Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1)) <= 'Z')
            {
                strSQL = @"
                    SELECT  
                            DISTINCT
                            t4.Menu_Id ,
                            Menu_Code ,
                            Menu_Name ,
                            Menu_Father_ID ,
                            ActionURL ,
                            MenuType
                    FROM    dbo.MDM_System_Menu t4
                    WHERE   t4.Env_ID = @param1
                            AND (Menu_Name = '维修单' or Menu_Name = '吊牌打印申请查询'or Menu_Name = '店铺盘点赔偿' 
                                or Menu_Name = '吊牌打印申请'
                                or Menu_Name = '导购提成分配'
                                or Menu_Name = '导购提成分配报表'
                                or Menu_Name = '库存查询'
                                )
                    ORDER BY Menu_Code ASC ,
                            Menu_Name
            ";
            }
            else if ((hzyMessage.Env_SN == "HZY_CMT" || hzyMessage.Env_SN == "JoCMT") && Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1)) <= 'Z')
            {
                strSQL = @"
                    SELECT  
                            DISTINCT
                            t4.Menu_Id ,
                            Menu_Code ,
                            Menu_Name ,
                            Menu_Father_ID ,
                            ActionURL ,
                            MenuType
                    FROM    dbo.MDM_System_Menu t4
                    WHERE   t4.Env_ID = @param1
                            AND (Menu_Name = '店铺活动反馈')
                    ORDER BY Menu_Code ASC ,
                            Menu_Name
            ";
            }
            else if ((hzyMessage.Env_SN == "SPWX" || hzyMessage.Env_SN == "SPWX") && Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1)) <= 'Z')
            {
                strSQL = @"
                    SELECT  
                            DISTINCT
                            t4.Menu_Id ,
                            Menu_Code ,
                            Menu_Name ,
                            Menu_Father_ID ,
                            ActionURL ,
                            MenuType
                    FROM    dbo.MDM_System_Menu t4
                    WHERE   t4.Env_ID = @param1
                            AND (Menu_Name = '成衣维修登记' or Menu_Name = '快递签收' )
                    ORDER BY Menu_Code ASC ,
                            Menu_Name
            ";
            }
            else
            {
                strSQL = @"
                SELECT  
                        DISTINCT
                        t4.Menu_Id ,
                        Menu_Code ,
                        Menu_Name ,
                        Menu_Father_ID ,
                        ActionURL,MenuType,
                        ISNULL(OpenNewWindow,0) as OpenNewWindow
                FROM    dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK )
                        JOIN dbo.MDM_System_Menu_AUZ t3 WITH ( NOLOCK ) ON t2.Authorization_ID = t3.Authorization_ID
                                                                           AND t3.havaFlag = 1
                        JOIN dbo.MDM_System_Menu t4 WITH ( NOLOCK ) ON t3.Menu_ID = t4.Menu_Id
                WHERE   t2.havaFlag = 1
                        AND (t2.VexSSONewID = @param0 OR t2.App_UserID =@param2)
                        AND t4.Env_ID = @param1
                        --AND MenuType=1
                ORDER BY Menu_Code ASC,Menu_Name
            ";

            }
            DataSet ds = conn.GetDataSet(strSQL, new string[3] { strVexSSONewID, strEnv_ID, strApp_UserID });

            FindFatherMenu(ds, conn);//添加父节点的菜单信息

            ds.Tables[0].Columns.Add("Leaver", typeof(Int32));
            SetLeaver(ds, "0", 0);

            DeleteModel(ds);

            return ds;

        }

        private void DeleteModel(DataSet pds)
        {
            pds.Tables[0].AcceptChanges();
            for (int i = 0; i < pds.Tables[0].Rows.Count; i++)
            {
                if (pds.Tables[0].Rows[i]["MenuType"].ToString() == "2")
                {
                    pds.Tables[0].Rows[i].Delete();
                }
            }
            pds.Tables[0].AcceptChanges();

        }

        private void FindFatherMenu(DataSet ds, Dbconn conn)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string strMenu_Father_ID = ds.Tables[0].Rows[i]["Menu_Father_ID"].ToString();
                DataRow[] dr = ds.Tables[0].Select("Menu_ID=" + strMenu_Father_ID); //找到是否已经存在父节点
                if (dr.Length > 0)
                {
                    continue;
                }
                DataTable dt = conn.GetDataTable(@"
                         SELECT Menu_Id ,
                                Menu_Code ,
                                Menu_Name ,
                                Menu_Father_ID ,
                                ActionURL
                         FROM   dbo.MDM_System_Menu
                         WHERE Menu_ID='" + strMenu_Father_ID + @"'
                ", new string[0]);

                if (dt.Rows.Count > 0)
                {
                    ds.Tables[0].ImportRow(dt.Rows[0]);
                }
            }
        }

        private void SetLeaver(DataSet ds, string strMenuID, int nLeaver)
        {
            DataRow[] dr = ds.Tables[0].Select("Menu_Father_ID=" + strMenuID);
            for (int i = 0; i < dr.Length; i++)
            {
                dr[i]["Leaver"] = nLeaver + 1;
                string strMenuID1 = dr[i]["Menu_Id"].ToString();
                SetLeaver(ds, strMenuID1, nLeaver + 1);
            }
        }

    }

}