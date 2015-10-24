using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：ShoppingCart
/// 类说明：恩派雅购物车
/// 创建人：金敏杰
/// 创建日期：2014-09-24
/// WSID:1284d288-da3f-4ce0-893f-8d96cf2ec2cd
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.GLWXSite
{
    public class ShoppingCart : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public ShoppingCart()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("NPaia");

        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddShoppingCart".ToUpper())      //添加购物车信息
                {
                    AddShoppingCart();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DelShoppingCart".ToUpper())      //删除购物车信息
                {
                    DelShoppingCart();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetShoppingCart".ToUpper())      //查询购物车信息
                {
                    GetShoppingCart();
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

        #region 添加购物车信息
        private void AddShoppingCart()
        {
            DataTable dtList = ds.Tables["List"];
            string seq;//项次最大值

            conn.BeginTransaction(); // 开启事务
            #region 取项次最大值

            DataTable dt1 = conn.GetDataTable("SELECT CAST(ISNULL(MAX(Seq),0) AS INT) + 1 AS Seq FROM [B02_BILL].[SHPC_ShoppingCart] WHERE WeiXinID='" + dtList.Rows[0]["WeiXinID"].ToString() + "'");
            seq = dt1.Rows[0]["Seq"].ToString();

            #endregion

            #region 新增购物车信息

            dtList.Columns.Add("ID");
            dtList.Columns.Add("M01P_ID");
            dtList.Columns.Add("M02C_ID");
            dtList.Columns.Add("Seq");
            dtList.Columns.Add("SettlementPrice");
            dtList.Columns.Add("Amount");
            dtList.Columns.Add("Currency");
            dtList.Columns.Add("Rgdt");
            dtList.Columns.Add("LmDt");
            dtList.Columns.Add("LmUser");
            dtList.Columns.Add("UptNo");

            dtList.Rows[0]["ID"] = System.Guid.NewGuid().ToString();
            dtList.Rows[0]["M01P_ID"] = System.Guid.NewGuid().ToString();
            dtList.Rows[0]["M02C_ID"] = System.Guid.NewGuid().ToString();
            dtList.Rows[0]["Seq"] = seq;
            dtList.Rows[0]["SettlementPrice"] = dtList.Rows[0]["SellPrice"].ToString();
            dtList.Rows[0]["Amount"] = float.Parse(dtList.Rows[0]["SellPrice"].ToString()) * float.Parse(dtList.Rows[0]["Number"].ToString());
            dtList.Rows[0]["Currency"] = "RMB";
            dtList.Rows[0]["Rgdt"] = timeNow;
            dtList.Rows[0]["LmDt"] = timeNow;
            dtList.Rows[0]["LmUser"] = dtList.Rows[0]["RgUser"].ToString();
            dtList.Rows[0]["UptNo"] = 0;

            Boolean bResult = false;
            bResult = conn.Insert("[B02_BILL].[SHPC_ShoppingCart]", dtList);
            conn.CommitTransaction();

            #endregion

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "添加成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "添加失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 删除购物车信息
        private void DelShoppingCart()
        {
            DataTable dtList = ds.Tables["List"];

            string id = dtList.Rows[0]["ID"].ToString();

            Boolean bResult = false;

            conn.BeginTransaction(); // 开启事务
            bResult = conn.Delete("[B02_BILL].[SHPC_ShoppingCart]", "ID=" + "'" + id + "'");
            conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "删除失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 查询购物车信息
        private void GetShoppingCart()
        {
            string strSQL = @"SELECT A.[ID]
                          ,A.[M01P_ID]
                          ,A.[M02C_ID]
                          ,A.[WeiXinID]
                          ,A.[Seq]
                          ,A.[SubSeq]
                          ,A.[STL2_ID]
                          ,A.[Number]
                          ,A.[Unit]
                          ,C.[STYL_Price]
                          ,C.[STYL_SellPrice]
                          ,A.[SettlementPrice]
                          ,A.[Amount]
                          ,A.[Currency]
                          ,A.[Rgdt]
                          ,A.[RgUser]
                          ,A.[LmDt]
                          ,A.[LmUser]
                          ,A.[UptNo]
                        ,B.[STL2_Color]
                        ,B.[STL2_Size]
                        ,C.[STYL_Code]
                        ,C.[STYL_Name]
                        ,C.[STYL_PicturePath]
                FROM [B02_BILL].[SHPC_ShoppingCart] A
                LEFT JOIN [B01_MDM].[STL2_StyleSKU] B ON A.[STL2_ID]=B.[STL2_ID]
                LEFT JOIN [B01_MDM].[STYL_Style] C ON B.[STL2_STYL_ID]=C.[STYL_ID]
                WHERE 1=1 " + m_hzyPageInfo.Where;
            m_dsRequturn = conn.GetDataSet(strSQL);
        }
        #endregion
        
        #endregion
    }
}
