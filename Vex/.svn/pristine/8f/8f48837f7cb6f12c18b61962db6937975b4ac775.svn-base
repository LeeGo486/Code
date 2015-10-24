using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_GetListBySession_IDForEasyUITree 
/// 类说明：根据用户登录信息取到系统菜单专为EasyUI的tree控件
/// 创建人：马卫清
/// 创建日期：2013-09-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_GetListBySession_IDForEasyUITree 根据用户登录信息取到系统菜单专为EasyUI的tree控件
    /// </summary>
    public class MDM_System_Menu_GetListBySession_IDForEasyUITree : LogicBase, ILogicGetData
    {
        public MDM_System_Menu_GetListBySession_IDForEasyUITree()
        {
            this.m_SessionCheck = true;

        }

        public DataSet GetData()
        {
            string strMenuCodeContains = "1";
            if (m_request != null && m_request.Tables.Count > 0
                && m_request.Tables[0].Rows.Count > 0
                && m_request.Tables[0].Columns.Contains("MenuCodeContains"))
            {
                strMenuCodeContains = m_request.Tables[0].Rows[0]["MenuCodeContains"].ToString();
            }


            MDM_System_Menu_GetListBySession_ID cls = new MDM_System_Menu_GetListBySession_ID();
            cls.hzyMessage = this.hzyMessage;
            cls.Request = this.m_request;
            DataSet ds = cls.GetData();

            if (ds.Tables.Count > 0)
            {

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (strMenuCodeContains != "0")
                    {
                        ds.Tables[0].Rows[i]["Menu_Name"] = ds.Tables[0].Rows[i]["Menu_Code"].ToString() + " " + ds.Tables[0].Rows[i]["Menu_Name"].ToString();
                    }
                }

                ds.Tables[0].Columns.Remove("Menu_Code");
            }

            return ds;


        }
 

    }

}