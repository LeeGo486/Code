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

/// 类名：Contract
/// 类说明：店铺信息模糊查询MDM(新)
/// 创建人：郭琦琦
/// 创建日期：2014-11-03 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.MDM2
{
    public class MDM2_Depot_Info_Fuzzy : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDM2_Depot_Info_Fuzzy()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("MDM_Market2");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;//创建时间
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData

        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                string filter = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDepotInfo".ToUpper())      //店铺数据
                {
                    GetDepotInfo(filter);
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

        #region 供应商信息查询(无分页)
        /// <summary>
        /// 供应商信息查询(无分页)
        /// </summary>
        private void GetDepotInfo(string pstrfilter)
        {
            string strSQL = @"
                                SELECT  top 50 
                                        店铺ID ,
                                        店铺名称
                                FROM    [MDM_Market2].[dbo].[V_L0013]
                                WHERE   冻结状态 = '0'
                                        AND 店铺名称 NOT LIKE '%仓%'
                                        AND 店铺名称 NOT LIKE '%shop%'
                                        AND 店铺名称 NOT LIKE '%停%'
                                        AND 店铺名称 NOT LIKE '%接口%'
                                        AND 店铺ID  LIKE '%" + pstrfilter + "%' OR 店铺名称 LIKE '%" + pstrfilter + "%'  Order by  店铺id ";
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }
        #endregion


        #endregion
    }
}