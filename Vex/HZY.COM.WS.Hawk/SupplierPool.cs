using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using System.Web;
using HZY.COM.Common.Base;

// 类名：SupplierPool
// 类说明：雅斓ERP供应商资金池
// 创建人： 郭琦琦
// 创建日期：2014-05-09
// 修改人：
// 修改日期：

namespace HZY.COM.WS.Hawk
{
    public class SupplierPool : HZYLogicBase, ILogicGetData
    {

        #region 构造函数
        public SupplierPool()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("Hawk");
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();

        #endregion

        #region GetData
        /// <summary>
        /// 主函数入口vex
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            string strXML = "";
            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")//取供应商资金池数据
            {
                GET();
            }
            return ds_Return;
        }
        #endregion

        #region 内部函数

        #region GET
        /// <summary>
        /// 取供应商资金池数据
        /// </summary>
        private void GET()
        {
            string strSQL = @"
                                    SELECT  SP2_ID ,
                                            SP2_CONO ,
                                            SP2_DIVI ,
                                            SP2_SP1_SupplierCode ,
                                            SP2_Currency ,
                                            SP2_PoolAmount ,
                                            SP2_State ,
                                            SP2_RgDt ,
                                            SP2_RgUser ,
                                            SP2_LmDt ,
                                            SP2_LmUser ,
                                            SP2_UptNo	
                                      FROM [B01_MDM].[SP2_SupplierPool]   
                                           where 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #endregion

    }
}
