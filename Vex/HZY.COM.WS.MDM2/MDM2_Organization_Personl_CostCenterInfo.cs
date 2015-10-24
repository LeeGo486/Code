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

/// 类名：MDM2_CostCenterInfo
/// 类说明：加载成本中心信息
/// 创建人：郭琦琦
/// 创建日期：2014-08-26
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.MDM2
{
    public class MDM2_Organization_Personl_CostCenterInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDM2_Organization_Personl_CostCenterInfo()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("MDM_Market2");
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
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETCOSTCENTER".ToUpper())      //加载成本中心信息
                {
                    GETCOSTCENTER(filter);
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

        #region 加载成本中心信息
        /// <summary>
        /// 加载成本中心信息
        /// </summary>
        private void GETCOSTCENTER(string pstrfilter)
        {
            string strSQL = @"
                                    SELECT  系统编号 ,
                                            编码 ,
                                            名称 ,
                                            状态
                                    FROM    [MKT_0025] 
                                    WHERE  1=1 and 状态=1 AND  
                            系统编号 LIKE '%" + pstrfilter + "%' OR 编码 LIKE '%" + pstrfilter + "%'  OR 名称 LIKE '%" + pstrfilter + "%'  Order by 系统编号 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }
        #endregion

        #endregion
    }
}