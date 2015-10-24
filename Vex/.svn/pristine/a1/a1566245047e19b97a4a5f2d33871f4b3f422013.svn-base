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

/// 类名：EHRForDLShopPay
/// 类说明：贝爱店铺薪资
/// 创建人：郭琦琦
/// 创建日期：2014-09-017 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.PointToPoint
{
    public class EHRForDLShopPay : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public EHRForDLShopPay()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("EHRDLPAY");
        private Dbconn m_conn_MDM = new Dbconn("MDM");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataSet ds_Return_mdm = new DataSet();

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
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRForDLShopPay".ToUpper())//贝爱店铺薪资
                {
                    GetEHRForDLShopPay(dtList);
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

        #region 薪资
        /// <summary>
        /// 薪资
        /// </summary>
        private void GetEHRForDLShopPay(DataTable pdt)
        {
            string stryear = "";
            string strmonth = "";
            string strname = "";
            string strPage = "";
            string strPageRowCount = "";
            strname = pdt.Rows[0]["name"].ToString();
            if (pdt.Columns.Contains("year") && pdt.Columns.Contains("month"))
            {
                stryear = pdt.Rows[0]["year"].ToString();
                strmonth = pdt.Rows[0]["month"].ToString();
            }
            else
            {
                stryear = "2014";
                strmonth = "6";
            }

            if (pdt.Columns.Contains("page") && pdt.Columns.Contains("pagerows"))
            {
                strPage = pdt.Rows[0]["page"].ToString();
                strPageRowCount = pdt.Rows[0]["pagerows"].ToString();
                m_hzyPageInfo.Page = Convert.ToInt32(strPage);
                m_hzyPageInfo.PageRowCount = Convert.ToInt32(strPageRowCount);

            }

            string strSQL = @" SELECT F_COSTCENTER FROM dbo.DEPOT 
                                    WHERE M_SUPERVISOR = '" + strname + "'OR z_char17 = '" + strname + "'";
            ds_Return_mdm = m_conn_MDM.GetDataSet(strSQL);

            string strList = "'0'";
            for (int i = 0; i < ds_Return_mdm.Tables[0].Rows.Count; i++)
            {
                if (strList.Length > 0)
                {
                    strList += ",";
                }
                strList += "'" + ds_Return_mdm.Tables[0].Rows[i]["F_COSTCENTER"].ToString() + "'";
            }
            //m_hzyPageInfo.Order="DESC"
            m_hzyPageInfo.Sort = " 部门,岗位 ";

            string strEHRSQL = @"SELECT * FROM ehr.dbo.EHRForDLShopPay
                               WHERE  月份 = '" + strmonth + "' and 年份 = '" + stryear + "' and  c_code IN (" + strList + ")"
                                               + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strEHRSQL, new string[0], m_hzyPageInfo);

        }
        #endregion

        #endregion
    }
}
