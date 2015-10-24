using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_GetListByEnv_ID 
/// 类说明：根据系统编号信息取到系统菜单
/// 创建人：马卫清
/// 创建日期：2012-12-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_GetListBySystem_ID 根据环境编号信息取到系统菜单
    /// </summary>
    public class MDM_System_Menu_GetListByEnv_ID : LogicBase, ILogicGetData
    {
        public MDM_System_Menu_GetListByEnv_ID()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {

            string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();

            Dbconn conn = new Dbconn("MDM");
            string strSQL = @"
                SELECT Menu_Id,Menu_Code, Menu_Name,Menu_Father_ID,ActionURL,ISNULL(MenuType,1) MenuType,Menu_Code+ ''+Menu_Name AS Menu_NameShow,ISNULL(OpenNewWindow,0) as OpenNewWindow FROM MDM_System_Menu
                WHERE Env_ID = @param0
            ";

            DataSet ds = conn.GetDataSet(strSQL, new string[1] { strEnv_ID });

            //添加根目录行
            ds.Tables[0].Rows.Add(new object[] { "0", "0", "根目录", "-1", "","1","00 根目录" });

            return ds;

        }

    }

}