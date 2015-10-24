using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：InventoryInfo
/// 类说明：F22查询NPaia的后台类
/// 创建人：刘洪
/// 创建日期：2014-10-21
/// WSID: 1b4b1e63-da9f-40e2-a4f2-c4bdaa7ce16e
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class InventoryInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public InventoryInfo()
        {
            this.m_SessionCheck = true;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("F22GP");

        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_dsRequturn = new DataSet();
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
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetInventory".ToUpper())      //查询恩派雅库存量
                {
                    GetInventory();
                }
                
                return m_dsRequturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion


        #region  内部函数

            #region 查询微信店铺市信息
            private void GetInventory()
            {
                DataTable dtList = ds.Tables["LIST"];
                string strWhere = dtList.Rows[0]["Where"].ToString();
                string strSQL = @"
                        SELECT d_name
                        From j_depot WHERE depotid = '" + strWhere + "'";
                //店铺名
                string strDName = conn.GetDataTableFirstValue(strSQL).ToString();

                if (strDName == "") {
                    dt_EditResult.Rows.Add(new object[] { false, "查无该店" });
                };

                if (strDName != "") {
                    dt_EditResult.Rows.Add(new object[] { true, strDName });
                };

                m_dsRequturn.Tables.Add(dt_EditResult);
            }
            #endregion

        #endregion
    }

}