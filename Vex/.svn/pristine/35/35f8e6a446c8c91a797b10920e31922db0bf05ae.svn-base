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

/// 类名：MDMBaseInfo
/// 类说明：MDMBaseInfo
/// 创建人：Cookie
/// 创建日期：2015-03-28 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.CommonInterface
{
    public class MDMBaseInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDMBaseInfo()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_Conn = new Dbconn("MDM_Market2");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        DateTime timeNow = DateTime.Now;

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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDepotInfo".ToUpper())//获取店铺信息
                {
                    GetDepotInfo(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetProvince".ToUpper())//获取省份
                {
                    GetProvince(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCity".ToUpper())//获取市
                {
                    GetCity(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCounty".ToUpper())//获取县区
                {
                    GetCounty(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_Conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 获取店铺信息
        /// <summary>
        /// 获取店铺信息
        /// </summary>
        private void GetDepotInfo(DataTable pdt)
        {
            string Where = "where  1=1 ";
            if (pdt.Columns.Contains("Where"))
            {
                if (pdt.Rows[0]["Where"].ToString().ToUpper() != "")
                {
                    Where += " and " + pdt.Rows[0]["Where"].ToString().ToUpper();//获取省编号
                }
            }
            string strSQL = @"SELECT *
                                  FROM [MDM_Market2].[dbo].[V_L0013_BASE] WITH(NOLOCK)";
            ds_Return = m_Conn.GetDataSet(strSQL + Where);
        }
        #endregion

        #region 获取省信息
        /// <summary>
        /// 获取省信息
        /// </summary>
        private void GetProvince(DataTable pdt)
        {
            string strSQL = @"SELECT  [Body_ID]
                                      ,[名称]
                                  FROM [MDM_Market2].[dbo].[V_0014]";
            ds_Return = m_Conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取市信息
        /// <summary>
        /// 获取市信息
        /// </summary>
        private void GetCity(DataTable pdt)
        {
            string Where = "where 1=1 ";
            if (pdt.Columns.Contains("Where"))
            {
                if (pdt.Rows[0]["Where"].ToString().ToUpper() != "")
                {
                    Where += " and " + pdt.Rows[0]["Where"].ToString().ToUpper();
                }
            }
            string strSQL = @"  SELECT  Body_ID ,
                                名称  ,
                                Body_ID_0015
                                FROM [dbo].[V_0015]";
            ds_Return = m_Conn.GetDataSet(strSQL + Where);
        }
        #endregion

        #region 获取县区信息
        /// <summary>
        /// 获取县区信息
        /// </summary>
        private void GetCounty(DataTable pdt)
        {
            string Where = "where 1=1 ";
            if (pdt.Columns.Contains("Where"))
            {
                if (pdt.Rows[0]["Where"].ToString().ToUpper() != "")
                {
                    Where += " and " + pdt.Rows[0]["Where"].ToString().ToUpper();
                }
            }
            string strSQL = @"  SELECT  Body_ID ,
                                名称
                                FROM [dbo].[V_0016]";
            ds_Return = m_Conn.GetDataSet(strSQL + Where);
        }
        #endregion


        #endregion

        #region 内部函数


        #endregion
    }
}