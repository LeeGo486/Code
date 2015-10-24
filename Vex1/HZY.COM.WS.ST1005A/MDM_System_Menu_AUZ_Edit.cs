using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_AUZ_Edit 
/// 类说明：编辑系统菜单权限
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_Edit 编辑系统菜单权限
    /// </summary>
    public class MDM_System_Menu_AUZ_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Menu_AUZ_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑系统菜单权限
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strAuthorization_ID = m_request.Tables[0].Rows[0]["Authorization_ID"].ToString();

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Menu_AUZ");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " Authorization_ID=" + strAuthorization_ID;

                conn.Delete("MDM_System_Menu_AUZ", strWhere);

                ArrayList listMenu = new ArrayList();

                for (int i = 0; i < m_request.Tables[0].Rows.Count; i++)
                {
                    string strMenuId = m_request.Tables[0].Rows[i]["Menu_Id"].ToString();
                    if (!listMenu.Contains(strMenuId))
                    {
                        listMenu.Add(strMenuId);
                    }
                }

//                for (int i = 0; i < m_request.Tables[0].Rows.Count; i++)
//                {
//                    string strMenuId = m_request.Tables[0].Rows[i]["Menu_Id"].ToString();
//                    while (true)
//                    {
//                        if (!listMenu.Contains(strMenuId))
//                        {
//                            listMenu.Add(strMenuId);

//                            DataTable dt = conn.GetDataTable(@"
//                            SELECT DISTINCT Menu_Father_ID FROM dbo.MDM_System_Menu
//                            WHERE Menu_Id = " + strMenuId + @"
//                            AND Menu_Father_ID != 0", new string[0]);

//                            if (dt.Rows.Count == 0)
//                            {
//                                break;
//                            }
//                            if (dt.Rows[0]["Menu_Father_ID"].ToString() == strMenuId)
//                            {
//                                break;
//                            }

//                            strMenuId = dt.Rows[0]["Menu_Father_ID"].ToString();
//                        }
//                        else
//                        {
//                            break;
//                        }                       
//                    }
//                } 

                for (int i = 0; i < listMenu.Count; i++)
                {
                    DataTable dt = m_request.Tables[0].Clone();
                    DataRow dr = dt.NewRow();
                    dr["Menu_ID"] = listMenu[i];
                    dr["Authorization_ID"] = strAuthorization_ID;
                    dr["HavaFlag"] = 1;
                    dt.Rows.Add(dr);
                   
                    conn.Insert("MDM_System_Menu_AUZ", dt);
                }
                conn.CommitTransaction();
                return true;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }



        }

        

    }

}