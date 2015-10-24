using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MDM2_GetCombox_ByEntityPropertyName
/// 类说明：根据实体编号和属性名获取数据供下拉框使用
/// 创建人：马卫清
/// 创建日期：2013-11-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 根据实体编号和属性名获取数据供下拉框使用
    /// </summary>
    public class MDM2_GetCombox_ByEntityPropertyName : LogicBase, ILogicGetData
    {
        public MDM2_GetCombox_ByEntityPropertyName()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        /// <summary>
        /// 根据实体编号和属性名获取数据供下拉框使用
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();

            string strMDMClass = m_request.Tables[0].Rows[0]["MDMClass"].ToString();
            string strPropertyName = m_request.Tables[0].Rows[0]["PropertyName"].ToString();
            string strWhere = " 1=1 ";

            if (m_request.Tables[0].Columns.Contains("WHERE"))
            {
                strWhere = m_request.Tables[0].Rows[0]["WHERE"].ToString();
            }

            ds_Return = GetMktData(strMDMClass, strPropertyName, strWhere);

            return ds_Return;
        }


        private DataSet GetMktData(string pMDMClass, string pPropertyName, string pWhere)
        {
            DataSet ds_Return = new DataSet();

            if (pMDMClass == "" || pPropertyName == "")
            {
                throw new Exception("列表类型不能为空!");
            }

            Dbconn conn = new Dbconn("MDM_Market2");
            ds_Return = conn.GetDataSet(@"
                    SELECT  
                            CONVERT(VARCHAR(MAX),Body_ID) AS ID,
                            " + pPropertyName + @" AS TEXT 
                    FROM dbo.V_" + pMDMClass + @"
                    WHERE " + pPropertyName + @"!= '' AND " + pWhere + @"
                   
            ", new string[0] { });

            return ds_Return;
        }
    }

}