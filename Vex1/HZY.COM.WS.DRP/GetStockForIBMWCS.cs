﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using System.Data.SqlClient;


/// 类名：GetStockForIBMWCS
/// 类说明：获取库存数据，IBMWCS专用
/// 创建人：马卫清
/// 创建日期：2014-12-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class GetStockForIBMWCS : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public GetStockForIBMWCS()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("F22GP");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            Dbconn conn_DRP_EC = new Dbconn("DRP_EC");

            string strDepotID = "";
            DataTable dt = conn_DRP_EC.GetDataTable(@"
                     SELECT [CfgValue]
                      FROM [DRP_EC].[dbo].[Config]
                      WHERE Type='StockSync_DRPToWCS'
                      AND CfgName='Depot'
                ");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (strDepotID != "")
                {
                    strDepotID += ",";
                }
                strDepotID += "'" + dt.Rows[i]["CfgValue"].ToString() + "'";
            }

            string strSQL = @"
                        SELECT  clothingid AS SKU ,
                                k_num AS totalInventory 
                        FROM    dbo.j_stock
                        WHERE   depotid in (" + strDepotID + @")
                                AND k_num > 0
                ";

            m_dsRequturn = m_conn.GetDataSet(strSQL);



            return m_dsRequturn;
        }
        #endregion

        #region  内部函数

        #region  Insert 插入数据
        /// <summary>
        /// 插入数据
        /// </summary>
        private void Insert()
        {
            DataTable dtList = ds.Tables["List"];

            if (dtList == null || dtList.Rows.Count == 0)
            {
                throw new Exception("请传入需要导入的数据！");
            }

            m_conn.InsertBYSQLBC("Get_FLUXWMSOrder", dtList);

            dt_EditResult.Rows.Add(new object[] { 0, "成功！" });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #endregion
    }

}