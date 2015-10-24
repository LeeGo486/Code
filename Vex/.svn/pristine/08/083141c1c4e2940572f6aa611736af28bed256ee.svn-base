using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Market_MKT_Org_CN_For_HZY_F222_GetList 
/// 类说明：获取Market的用户信息
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取Market的用户信息
    /// </summary>
    public class MDM_Market_MKT_Org_CN_For_HZY_F222_GetList : LogicBase, ILogicGetData
    {
        public MDM_Market_MKT_Org_CN_For_HZY_F222_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取MDM人员信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strOrg_App = "EP_F22_Prod";
                if (m_request.Tables.Count > 0 && m_request.Tables[0].Rows.Count > 0
                    && m_request.Tables[0].Columns.Contains("Org_App"))
                {
                    strOrg_App = m_request.Tables[0].Rows[0]["Org_App"].ToString();
                }

                Dbconn conn = new Dbconn("MDM_Market");
                DataSet ds = conn.GetDataSet(@"SELECT * FROM MKT_Org_CN_For_HZY_F22 WHERE org_app ='" + strOrg_App + "'");
                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}