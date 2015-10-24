using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_AUZ_GetList 
/// 类说明：根据环境编号和权限编号信息取到系统菜单权限对应表
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_AUZ_GetList 根据环境编号和权限编号信息取到系统菜单权限对应表
    /// </summary>
    public class MDM_System_Menu_AUZ_GetList : LogicBase, ILogicGetData
    {
        public MDM_System_Menu_AUZ_GetList()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {

            string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();
            string strAuthorization_ID = m_request.Tables[0].Rows[0]["Authorization_ID"].ToString();

            Dbconn conn = new Dbconn("MDM");
            string strSQL = @"
                SELECT  t1.Menu_Id ,
                        t1.Menu_Code +' ' + t1.Menu_Name Menu_Name,
                        t1.Menu_Father_ID ,
                        ISNULL(t2.HavaFlag, 0) HavaFlag
                FROM    MDM_System_Menu t1 WITH ( NOLOCK )
                        LEFT JOIN dbo.MDM_System_Menu_AUZ t2 WITH ( NOLOCK ) ON t1.Menu_Id = t2.Menu_ID
                        AND Authorization_ID=@param0
                WHERE   t1.env_id = @param1
            ";

            DataSet ds = conn.GetDataSet(strSQL, new string[2] { strAuthorization_ID,strEnv_ID });

            //添加根目录行
            ds.Tables[0].Rows.Add(new object[] { "0",  "根目录", "-1", "0" });

            return ds;

        }

    }

}