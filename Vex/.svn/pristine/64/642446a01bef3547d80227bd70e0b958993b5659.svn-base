using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSRRManagerUserAdmin
/// 类说明：对WSRRManager刷新用户数据
/// 创建人：马卫清
/// 创建日期：2014-03-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 对WSSrc的CRUD,为Easyui专用
    /// </summary>
    public class WSRRManagerUserAdmin : HZYLogicBase, ILogicExecute
    {
        public WSRRManagerUserAdmin()
        {
            this.m_SessionCheck = false;

        }

        public Dbconn conn = new Dbconn("WSRR");
        public DataSet m_ds = new DataSet();


        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 对MgrWSSrcParam的CRUD 
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            string strSQL = @"
                DELETE  FROM WSRR_Manage.F01_CERT.[User] 

                INSERT  INTO WSRR_Manage.F01_CERT.[User]
                ( [UserName] ,
                    [PassWord] ,
                    CreateTime ,
                    CreateUser ,
                    UpdateTime ,
                    UpdateUser
                )
                SELECT DISTINCT
                        AM_login ,
                        AM_Password ,
                        GETDATE() ,
                        'system' ,
                        GETDATE() ,
                        'system'
                FROM    [MDM].[dbo].[AM_User] t1
                        LEFT JOIN [MDM].[dbo].[AM_User_Dept] t2 ON t2.AM_USER_ID = t1.AM_User_id
                        LEFT JOIN [MDM].dbo.AM_Dept t3 ON t2.AM_S_Dept_ID = t3.AM_S_Dept_ID
                WHERE   AM_Dept_NAME_All LIKE '%信息管理%'";

            conn.Excute(strSQL);
            return true;
        }
    }

}