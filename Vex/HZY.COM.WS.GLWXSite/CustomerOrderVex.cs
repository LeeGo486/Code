using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：ShoppingCart
/// 类说明：雅斓订单Vex
/// 创建人：郭琦琦
/// 创建日期：2015-05-11
namespace HZY.COM.WS.GLWXSite
{
    public class CustomerOrderVex : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public CustomerOrderVex()
        {
            this.m_SessionCheck = true;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("GLWXSite");//微站数据库
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerOrder".ToUpper())      //获取客户订单
                {
                    GetCustomerOrder();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditCustomerOrder".ToUpper())      //修改客户订单
                {
                    EditCustomerOrder();
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

        #region 查询客户订单
        private void GetCustomerOrder()
        {
            string strSQL = @"SELECT A.[ID]
                          ,A.[ORB1_ID]
                          ,A.[Code]
                          ,A.[WeiXinID]
                          ,A.[DeliveryDate]
                          ,A.[MinState]
                          ,A.[MaxState]
                          ,A.[Amount]
                          ,A.[DEPT_ID]
                          ,A.[Phone]
                          ,A.[Desp]
                          ,A.[Rgdt]
                          ,A.[RgUser]
                          ,A.[LmDt]
                          ,A.[LmUser]
                          ,A.[UptNo]
                        ,B.[ID] AS DetailID
                        ,B.[Seq]
                        ,B.[SubSeq]
                        ,B.[STL2_ID]
                        ,B.[Number]
                        ,B.[Price]
                        ,B.[SellPrice]
                        ,B.[SettlementPrice]
                        ,B.[Amount] AS subAmount
                        ,Case When B.[State] = '20' Then '待取'
                              When B.[State] = '90' Then '完成'
                              When B.[State] = '99' Then '取消'
                         END AS State
                        ,C.[STL2_Color]
                        ,C.[STL2_Size]
                        ,D.[STYL_Name]
                        ,D.[STYL_Code]
                        ,D.[STYL_PicturePath]
                        ,E.j_name
                        ,E.g_sf
                        ,E.g_cs
                        ,E.g_address
                        ,E.m_shoptel
                FROM [B02_BILL].[CO1_CustomerOrderHead] A with(NOLOCK)
                LEFT JOIN [B02_BILL].[CO2_CustomerOrderDetail] B with(NOLOCK) ON A.[ID]=B.[CO1_ID]
                LEFT JOIN [B01_MDM].[STL2_StyleSKU] C with(NOLOCK) ON B.[STL2_ID]=C.[STL2_ID]
                LEFT JOIN [B01_MDM].[STYL_Style] D with(NOLOCK) ON C.[STL2_STYL_ID]=D.[STYL_ID]
                LEFT JOIN mdm.MDM_Market2.dbo.V_L0013_BASE E with(NOLOCK) ON A.[DEPT_ID]=E.j_depotid
                WHERE 1=1 " + m_hzyPageInfo.Where;
            m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 编辑客户订单
        private void EditCustomerOrder()
        {
            DataTable dtList = ds.Tables["List"];

            //操作结果

            if (dtList.Rows.Count == 0)
            {
                dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
            }
            else
            {
                string strResulte = dtList.Rows[0]["Result"].ToString();

                if (strResulte == "完成")
                {
                    strResulte = "90";
                }
                else
                {
                    strResulte = "99";
                }

                DataTable dtHead = new DataTable();
                DataTable dtDetail = new DataTable();



                //添加列
                dtHead.Columns.Add("ID");
                dtHead.Columns.Add("MinState");
                dtHead.Columns.Add("MaxState");
                dtHead.Columns.Add("LmDt");
                dtHead.Columns.Add("LmUser");

                dtDetail.Columns.Add("ID");
                dtDetail.Columns.Add("State");
                dtDetail.Columns.Add("LmDt");
                dtDetail.Columns.Add("LmUser");



                for (int i = 0; i < dtList.Rows.Count; i++)
                {
                    string strHeadId = dtList.Rows[i]["HeadId"].ToString();
                    string strDetailId = dtList.Rows[i]["DetailId"].ToString();

                    //添加行
                    DataRow newRow;
                    newRow = dtHead.NewRow();
                    dtHead.Rows.Add(newRow);

                    DataRow newRowD;
                    newRowD = dtDetail.NewRow();
                    dtDetail.Rows.Add(newRowD);

                    dtHead.Rows[i]["ID"] = strHeadId;
                    dtHead.Rows[i]["MinState"] = strResulte;
                    dtHead.Rows[i]["MaxState"] = strResulte;
                    dtHead.Rows[i]["LmDt"] = timeNow;
                    dtHead.Rows[i]["LmUser"] = m_hzyMessage.User_Name;

                    dtDetail.Rows[i]["ID"] = strDetailId;
                    dtDetail.Rows[i]["State"] = strResulte;
                    dtDetail.Rows[i]["LmDt"] = timeNow;
                    dtDetail.Rows[i]["LmUser"] = m_hzyMessage.User_Name;
                };

                bool bResult = false;
                ArrayList listKey = new ArrayList();
                listKey.Add("ID");

                conn.LockTableList.Add("[B02_BILL].[CO1_CustomerOrderHead]");// 锁表
                conn.LockTableList.Add("[B02_BILL].[CO2_CustomerOrderDetail]");
                conn.BeginTransaction(); // 开启事务

                bResult = conn.Update("[B02_BILL].[CO1_CustomerOrderHead]", dtHead, listKey);
                bResult = conn.Update("[B02_BILL].[CO2_CustomerOrderDetail]", dtDetail, listKey);


                conn.CommitTransaction();
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "更新成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
                };
            };

            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}
