using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：CheckAuz
/// 类说明：对CheckAuz验证是否有权限
/// 创建人：郭琦琦
/// 创建日期：2014-09-26 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.HZY_CMT
{
    public class CheckAuz : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public CheckAuz()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("MDM");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckAuzbyuserid".ToUpper())
                {
                    CheckAuzbyuserid();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region
        /// <summary>
        /// 
        /// </summary>
        private void CheckAuzbyuserid()
        {
            string strSQL = @"
	                            SELECT  DISTINCT t1.Authorization_ID ,
			                            t1.Authorization_Name  
	                            FROM    VexSSO.dbo.MDM_System_Authorization t1 WITH ( NOLOCK )
			                            JOIN VexSSO.dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK ) ON t1.Authorization_ID = t2.Authorization_ID
			                            JOIN VexSSO.[dbo].[MDM_System_User] t3 WITH (NOLOCK) ON t3.App_UserID = t2.App_UserID
	                            WHERE   t3.Env_ID = 154
			                            AND t3.App_UserName=@Param0
			                            AND ISNULL(HavaFlag, 0)=1";
            ds_Return = m_conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion


        #endregion
    }
}