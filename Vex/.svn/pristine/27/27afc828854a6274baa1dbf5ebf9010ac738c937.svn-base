using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using System.Data.SqlClient;


/// 类名：CommonInterfaceForGet
/// 类说明：WMS等通用获取数据专用
/// 创建人：郭琦琦
/// 创建日期：2015-04-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class CommonInterfaceForGet : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public CommonInterfaceForGet()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22GP_DRP_REPORT");
        private Dbconn m_conn_FLUX_WMS = new Dbconn("DRP_WMS");
        private Dbconn m_conn_DRP_EC = new Dbconn("DRP_EC");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();

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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetStockForIBMWCS".ToUpper()) //WCS获取库存数据 
                {
                    GetStockForIBMWCS(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_conn_DRP_EC.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数


        #region WMS获取库存数据
        /// <summary>
        /// 
        /// </summary>
        private void GetStockForIBMWCS(DataTable pdt)
        {

            string strSKU = pdt.Rows[0]["sku"].ToString();

            DataSet WMSStockDS = m_conn_FLUX_WMS.GetDataSetBySP("SPCUS_GETWMSINV", new string[4] { "@SKU", "@Language", "@UserID", "@Return_Code" }, new string[4] { strSKU, "cn", "OMS", "" });
            DataSet GPStockDS = m_conn.GetDataSetBySP("SP_PutWCS_Stock", new string[1] { "@SKU" }, new string[1] { strSKU });

            m_conn_DRP_EC.BeginTransaction();


            m_conn_DRP_EC.ExcuteQuerryByTran(" Truncate Table  Put_SkuStock ", new object[] { });//清空表

            for (int i = 0; i < WMSStockDS.Tables[0].Columns.Count; i++)
            {
                WMSStockDS.Tables[0].Columns[i].ColumnName = WMSStockDS.Tables[0].Columns[i].ColumnName.ToUpper();
            }

            for (int i = 0; i < WMSStockDS.Tables[0].Columns.Count; i++)
            {
                GPStockDS.Tables[0].Columns[i].ColumnName = GPStockDS.Tables[0].Columns[i].ColumnName.ToUpper();
            }

            m_conn_DRP_EC.InsertBYSQLBC("Put_SkuStock", WMSStockDS.Tables[0]);//库存写入临时表
            m_conn_DRP_EC.InsertBYSQLBC("Put_SkuStock", GPStockDS.Tables[0]);//库存写入临时表

            ds_Return = m_conn_DRP_EC.GetDataSet(@"  SELECT  SKU , SUM(CONVERT(INT, QTY)) QTY  FROM    Put_SkuStock GROUP BY SKU  ", new string[0]);//生成数据

            m_conn_DRP_EC.CommitTransaction();

        }
        #endregion

        #endregion
    }
}
