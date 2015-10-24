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

/// 类名：MDM2_Depot_Info_forGW
/// 创建人：郭琦琦
/// 创建日期：2014-09-26 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.MDM2
{
    public class MDM2_Depot_Info_forGW : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDM2_Depot_Info_forGW()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("MDM_Market2");
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


                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Get".ToUpper())
                {
                    Get();
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

        #region Get
        /// <summary>
        /// Get
        /// </summary>
        private void Get()
        {
            string strSQL = @"
                                 SELECT  *
                                FROM    [MDM_Market2].[dbo].[V_L0013_FOR_EPSHOP]";
            ds_Return = m_conn.GetDataSet(strSQL);

        }
        #endregion

        #endregion
    }
}