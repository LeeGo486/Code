using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using System.Web;
using System.Data;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;

// 类名：Payment
// 类说明：雅斓ERP付款
// 创建人： 郭琦琦
// 创建日期：2014-05-07
// 修改人：
// 修改日期： 
namespace HZY.COM.WS.GL_ERP2
{
    public class Payment : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Payment()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("GL_ERP");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPaymentInfo".ToUpper())//获取付款单信息
                {
                    Get();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "InsertPR1_PaymentRequisit".ToUpper())//新增付款申请单
                {
                    InsertPR1_PaymentRequisit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdatePR1_PaymentRequisit".ToUpper())//修改付款申请单
                {
                    UpdatePR1_PaymentRequisit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "InsertPB1_PaymentBill".ToUpper())//新增付款单
                {
                    InsertPB1_PaymentBill();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdatePB1_PaymentBill".ToUpper())//更新付款单
                {
                    UpdatePB1_PaymentBill();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeletePR1_PaymentRequisit".ToUpper())//付款申请单删除
                {
                    DeletePR1_PaymentRequisit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckPR1_PaymentRequisit".ToUpper())//付款单删除CHECK
                {
                    CheckPR1_PaymentRequisit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EndPohead".ToUpper())//完结
                {
                    EndPohead();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();//事务回滚
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region Check列
        /// <summary>
        ///  check 列是否为空，如果为空，就附上0
        /// </summary>
        private void CheckNumColumnValue(DataSet pds)
        {
            for (int l = 0; l < pds.Tables["list"].Rows.Count; l++)
            {
                if (pds.Tables["list"].Columns.Contains("PR1_TotalAmount") && pds.Tables["list"].Rows[0]["PR1_TotalAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PR1_TotalAmount"] = "0";
                }
                if (pds.Tables["list"].Columns.Contains("PR1_RequestAmount") && pds.Tables["list"].Rows[0]["PR1_RequestAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PR1_RequestAmount"] = "0";
                }
                if (pds.Tables["list"].Columns.Contains("PR1_PoolAmount") && pds.Tables["list"].Rows[0]["PR1_PoolAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PR1_PoolAmount"] = "0";
                }
                if (pds.Tables["list"].Columns.Contains("PB1_PaymentAmount") && pds.Tables["list"].Rows[0]["PB1_PaymentAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PB1_PaymentAmount"] = "0";
                }
                if (pds.Tables["list"].Columns.Contains("PB1_PaymentTotalAmount") && pds.Tables["list"].Rows[0]["PB1_PaymentTotalAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PB1_PaymentTotalAmount"] = "0";
                }
                if (pds.Tables["list"].Columns.Contains("PB1_PaymentDeductionAmount") && pds.Tables["list"].Rows[0]["PB1_PaymentDeductionAmount"].ToString() == "")
                {
                    pds.Tables["list"].Rows[0]["PB1_PaymentDeductionAmount"] = "0";
                }
            }
        }
        #endregion

        #region Get 获取付款单信息
        /// <summary>
        /// 获取付款单信息
        /// </summary>
        private void Get()
        {
            string strSQL = @"
                                    SELECT  *
                                    FROM    ( SELECT    t2.BR1_Name ,
                                                        t3.CT1_KeyName ,
                                                        t1.PO1_ID ,
                                                        t1.PO1_CONO ,
                                                        t1.PO1_DIVI ,
                                                        t1.PO1_POCode ,
                                                        t1.PO1_POTypeCode ,
                                                        t1.PO1_POTypeName ,
                                                        t1.PO1_SPPOCode ,
                                                        t1.PO1_HState ,
                                                        t1.PO1_LState ,
                                                        t1.PO1_PC1_ContractCode ,
                                                        t1.PO1_BR1_BrandCode ,
                                                        t1.PO1_SupplierCode ,
                                                        t1.PO1_PlanDeliveryDate ,
                                                        t1.PO1_PZNumber ,
                                                        t1.PO1_OCurrencySums ,
                                                        t1.PO1_DCurrencySums ,
                                                        t1.PO1_Currency ,
                                                        t1.PO1_ExchangeRate ,
                                                        t1.PO1_SupplyTax ,
                                                        t1.PO1_TranSportRatio ,
                                                        t1.PO1_PaymentTypeName ,
                                                        t1.PO1_PaymentChannelName ,
                                                        t1.PO1_IncreaseRatio ,
                                                        t1.PO1_TariffRatio ,
                                                        t1.PO1_RgDt ,
                                                        t1.PO1_RgUser ,
                                                        t1.PO1_LmDt ,
                                                        t1.PO1_LmUser ,
                                                        t1.PO1_UptNo ,
                                                        t1.PO1_PayState ,
                                                        t9.PR1_RequestCode ,
                                                        t9.PR1_RequestAmount ,
                                                        t9.PR1_TotalAmount ,
                                                        t9.PR1_PoolAmount ,
                                                        t10.PB1_State,
                                                        '' 入库数量 ,
                                                        '' 入库金额 ,
                                                        ( SELECT    ISNULL(SUM(t4.PR1_TotalAmount), 0)
                                                          FROM      [B02_BILL].[PR1_PaymentRequisit] t4
                                                          WHERE     t1.PO1_POCode = t4.PR1_PO1_POCode
                                                        ) 累计申请金额 ,
                                                        ( SELECT    ISNULL(SUM(t5.PB1_PaymentDeductionAmount), 0)
                                                          FROM      [B02_BILL].PB1_PaymentBill t5
                                                          WHERE     t5.PB1_PayBillCode = t9.PR1_RequestCode
                                                                    AND t9.PR1_PO1_POCode = t1.PO1_POCode
                                                        ) 累计抵扣金额 ,
                                                        ( SELECT    ISNULL(PR1_TotalAmount, 0)
                                                          FROM      ( SELECT    ROW_NUMBER() OVER ( ORDER BY PR1_RgDt DESC ) AS a ,
                                                                                *
                                                                      FROM      [B02_BILL].[PR1_PaymentRequisit]
                                                                      WHERE     t1.PO1_POCode = PR1_PO1_POCode
                                                                                AND PR1_State < 85
                                                                    ) g
                                                          WHERE     a = 1
                                                        ) 当前申请金额 ,
                                                        ( SELECT    CASE WHEN PR1_State < 85 THEN '申请中'
                                                                         WHEN PR1_State > 85 THEN '已付款'
                                                                    END PR1_State
                                                          FROM      ( SELECT    ROW_NUMBER() OVER ( ORDER BY PR1_RgDt DESC ) AS a ,
                                                                                *
                                                                      FROM      [B02_BILL].[PR1_PaymentRequisit]
                                                                      WHERE     t1.PO1_POCode = PR1_PO1_POCode
                                                                    ) g
                                                          WHERE     a = 1
                                                        ) 付款状态 ,
                                                        ( SELECT    ISNULL(SUM(t8.PB1_PaymentTotalAmount), 0)
                                                          FROM      [B02_BILL].[PB1_PaymentBill] t8
                                                          WHERE     t9.PR1_RequestCode = t8.PB1_PR1_RequestCode
                                                        ) 已付金额 ,
                                                        ( SELECT    t1.PO1_OCurrencySums
                                                                    - SUM(t10.PB1_PaymentTotalAmount)
                                                          FROM      [B02_BILL].[PB1_PaymentBill] t10
                                                          WHERE     t9.PR1_RequestCode = t10.PB1_PR1_RequestCode
                                                                    AND t1.PO1_POCode = t9.PR1_PO1_POCode
                                                        ) 未付金额 ,
                                                        '' 未入库金额 ,
                                                        '' 结转金额 ,
                                                        '' 退货件数 ,
                                                        '' 付款状态PO ,
                                                        '' 退货金额 ,
                                                        t10.PB1_PayBillCode
                                              FROM      [B02_BILL].[PO1_POHead] t1
                                                        LEFT JOIN [B01_MDM].[BR1_Brand] t2 ON t1.PO1_BR1_BrandCode = t2.BR1_BrandCode
                                                        LEFT JOIN [M01_CONF].[CT0_CSYTAB] t3 ON t1.PO1_Currency = t3.CT1_KeyID
                                                                                                AND t3.ct1_code = 'CUCD'
                                                        LEFT JOIN [B02_BILL].[PR1_PaymentRequisit] t9 ON t1.PO1_POCode = t9.PR1_PO1_POCode
                                                        LEFT JOIN [B02_BILL].PB1_PaymentBill t10 ON T1.PO1_POCode = t9.PR1_PO1_POCode
                                                                                                  AND t9.PR1_RequestCode = t10.PB1_PR1_RequestCode  and t10.PB1_State < 99
                                            ) t12
                                    WHERE   1 = 1
                                            AND PO1_LState >= 35
                                            AND PO1_HState >= 35 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { }, m_hzyPageInfo);
        }
        #endregion

        #region 付款申请单
        /// <summary>
        /// 付款申请单新增修改删除
        /// </summary>
        private void InsertPR1_PaymentRequisit()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisit]");//锁表
            string strGuid = System.Guid.NewGuid().ToString();//取GUID
            m_conn.BeginTransaction();
            string strPR1_PO1_POCode = ds.Tables["list"].Rows[0]["pr1_po1_pocode"].ToString();//获取采购单号
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["pr1_requestcode"].ToString();//取付款单号
            string sreMAXPB1_PR1_RequestCode = "";
            //判断付款单是否存在如果不存在就新增
            if (strPR1_RequestCode == "")
            {
                //获取此采购单最大号付款申请单号
                sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, "", "", m_conn);
                ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;
                ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["pr1_id"] = strGuid;
                ds.Tables["list"].Columns.Add("PR1_State");
                ds.Tables["List"].Rows[0]["PR1_State"] = "15";
                CheckNumColumnValue(ds);
                bResult = m_conn.Insert("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"]);//insert
            }
            else
            {
                //如果存在，首先判断最大号的付款申请单申请总金额是否为0，如果为0，就先删除，再新增，如果总金额不为0，提示
                string strCheckPR1_RequestCode = m_conn.GetDataTableFirstValue(@"
                                    SELECT  [PR1_RequestCode] FROM  
                                            [B02_BILL].[PR1_PaymentRequisit]
                                            WHERE   PR1_TotalAmount = 0  
                                                        AND PR1_PO1_POCode = '" + strPR1_PO1_POCode + "'").ToString();
                if (strCheckPR1_RequestCode == "")
                {
                    //检查数据库最新数据的付款申请单总金额是否为0
                    string strCheckPR1_State = m_conn.GetDataTableFirstValue(@"
                                    SELECT  [PR1_State] FROM  
                                            [B02_BILL].[PR1_PaymentRequisit]
                                            WHERE   PR1_State = 85  
                                                        AND PR1_RequestCode = '" + strPR1_RequestCode + "'").ToString();
                    //如果为0.说明没有总金额为0的，直接最大号加1.
                    if (strCheckPR1_State != "")
                    {
                        sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, "", "", m_conn);
                        ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;
                        ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name_CN;
                        ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name_CN;
                        ds.Tables["List"].Rows[0]["pr1_id"] = strGuid;
                        ds.Tables["list"].Columns.Add("PR1_State");
                        ds.Tables["List"].Rows[0]["PR1_State"] = "15";//默认付款申请单15状态
                        CheckNumColumnValue(ds);//检查传过来的列是否为空，如果为空，默认赋值0
                        bResult = m_conn.Insert("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"]);
                    }
                    else
                    {
                        throw new Exception("已有未付款的付款申请单，不能再申请！");
                    }
                }
                else//如果申请总金额为0，删除该单据，再生成。
                {
                    m_conn.Delete("[B02_BILL].[PR1_PaymentRequisit]", "PR1_RequestCode=" + "'" + strCheckPR1_RequestCode + "'");
                    //传入类型，生成最大号
                    sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, "", "", m_conn);
                    ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;//赋值最大付款单号
                    ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name_CN;//更新人
                    ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name_CN;//创建人
                    ds.Tables["List"].Rows[0]["pr1_id"] = strGuid;//GUID
                    ds.Tables["list"].Columns.Add("PR1_State");
                    ds.Tables["List"].Rows[0]["PR1_State"] = "15";//默认15状态
                    CheckNumColumnValue(ds);//检查列，如果有空值，附上NULL
                    bResult = m_conn.Insert("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"]);
                }
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { sreMAXPB1_PR1_RequestCode });//生成的编号，返回给前台，刷新form
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "编号生成失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 更新付款申请单
        /// <summary>
        /// 更新付款申请单
        /// </summary>
        private void UpdatePR1_PaymentRequisit()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisit]");
            m_conn.BeginTransaction();
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["pr1_requestcode"].ToString();
            DateTime timeNow = DateTime.Now;//取本地当前时间
            ds.Tables["list"].Columns.Remove("pr1_requestcode");//移除付款申请单列
            ds.Tables["list"].Columns.Add("pr1_lmuser");//增加更新人列
            ds.Tables["list"].Columns.Add("pr1_lmdt");//增加更新时间列
            ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name_CN;//系统登入人
            ds.Tables["List"].Rows[0]["pr1_lmdt"] = timeNow;

            if (!ds.Tables["list"].Columns.Contains("PR1_PoolAmount"))
            {
                ds.Tables["list"].Columns.Add("PR1_PoolAmount");//增加更新时间列
                ds.Tables["list"].Rows[0]["PR1_PoolAmount"] = "0";
            }
            if (ds.Tables["list"].Columns.Contains("PR1_PoolAmount") && ds.Tables["list"].Rows[0]["PR1_PoolAmount"].ToString() == "")
            {
                ds.Tables["list"].Rows[0]["PR1_PoolAmount"] = "0";
            }
            //按照付款申请单做修改
            bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"], "pr1_requestcode=" + "'" + strPR1_RequestCode + "'");
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 新增付款单
        /// <summary>
        /// 新增付款单
        /// </summary>
        private void InsertPB1_PaymentBill()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PB1_PaymentBill]");
            string strGuid = System.Guid.NewGuid().ToString();//取GUID
            m_conn.BeginTransaction();//开启事务
            string strPR1_PO1_POCode = ds.Tables["list"].Rows[0]["pb1_pr1_requestcode"].ToString().Substring(2, 7);//截取付款申请单获取采购单号
            string strPB1_PayBillCode = ds.Tables["list"].Rows[0]["pb1_paybillcode"].ToString();//获取付款单号
            string strMAXPB1_PayBillCode = "";
            //如果为空，默认生成新的付款单
            if (strPB1_PayBillCode == "")
            {
                //传入类型，生成最大号
                strMAXPB1_PayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPR1_PO1_POCode, "", "", m_conn);
                ds.Tables["List"].Rows[0]["pb1_paybillcode"] = strMAXPB1_PayBillCode;
                ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["pb1_id"] = strGuid;
                CheckNumColumnValue(ds);
                bResult = m_conn.Insert("[B02_BILL].[PB1_PaymentBill]", ds.Tables["List"]);
            }
            //如果不为空，先判断最新的一行数据，总金额是否为空，如果为空，先删除，再新增，如果不为空提示用户
            else
            {
                string strCheckPB1_PayBillCode = m_conn.GetDataTableFirstValue(@"

                                    SELECT  [PB1_PayBillCode] FROM  
                                            [B02_BILL].[PB1_PaymentBill]
                                            WHERE   PB1_PaymentTotalAmount = 0  
                                                        AND PB1_PayBillCode = '" + strPB1_PayBillCode + "'").ToString();
                if (strCheckPB1_PayBillCode == "")
                {
                    string strCheckPB1_PayBillState = m_conn.GetDataTableFirstValue(@"
                                    SELECT  [PB1_State] FROM  
                                            [B02_BILL].[PB1_PaymentBill]
                                            WHERE   PB1_State = 99  
                                                        AND PB1_PayBillCode = '" + strPB1_PayBillCode + "'").ToString();
                    if (strCheckPB1_PayBillState == "")
                    {
                        strMAXPB1_PayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPR1_PO1_POCode, "", "", m_conn);
                        ds.Tables["List"].Rows[0]["pb1_paybillcode"] = strMAXPB1_PayBillCode;
                        ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name_CN;
                        ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name_CN;
                        ds.Tables["List"].Rows[0]["pb1_id"] = strGuid;
                        CheckNumColumnValue(ds);
                        bResult = m_conn.Insert("[B02_BILL].[PB1_PaymentBill]", ds.Tables["List"]);
                    }
                    else
                    {
                        throw new Exception("已付款申请！");
                    }
                }
                else
                {
                    m_conn.Delete("[B02_BILL].[PB1_PaymentBill]", "PB1_PayBillCode=" + "'" + strCheckPB1_PayBillCode + "'");
                    strMAXPB1_PayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPR1_PO1_POCode, "", "", m_conn);
                    ds.Tables["List"].Rows[0]["pb1_paybillcode"] = strMAXPB1_PayBillCode;
                    ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name_CN;
                    ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name_CN;
                    ds.Tables["List"].Rows[0]["pb1_id"] = strGuid;
                    CheckNumColumnValue(ds);
                    bResult = m_conn.Insert("[B02_BILL].[PB1_PaymentBill]", ds.Tables["List"]);
                }
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { strMAXPB1_PayBillCode });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "编号生成失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 更新付款单
        /// <summary>
        /// 更新付款单
        /// </summary>
        private void UpdatePB1_PaymentBill()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PB1_PaymentBill]");
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisit]");
            m_conn.LockTableList.Add("[B01_MDM].[SP2_SupplierPool]");

            m_conn.BeginTransaction();
            string strPB1_PaymentDeductionAmount = ds.Tables["list"].Rows[0]["pb1_paymentdeductionamount"].ToString();//获取本次资金池抵扣金额
            string strPB1_PayBillCode = ds.Tables["list"].Rows[0]["pb1_paybillcode"].ToString();//获取付款单号
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["pr1_requestcode"].ToString();//获取付款申请单号
            string strPR1_State = ds.Tables["list"].Rows[0]["pr1_state"].ToString();//获取付款单更新状态
            string strSP2_SP1_SupplierCode = ds.Tables["list"].Rows[0]["sp2_sp1_suppliercode"].ToString();//获取供应商 编号
            string strSP2_Currency = ds.Tables["list"].Rows[0]["sp2_currency"].ToString();//获取采购单币种
            string strPOcode = strPB1_PayBillCode.Substring(2, 7);
            ds.Tables["list"].Columns.Remove("sp2_sp1_suppliercode");
            ds.Tables["list"].Columns.Remove("sp2_currency");

            DateTime timeNow = DateTime.Now;
            //跟新付款申请单状态
            DataTable dtPR1_PaymentRequisit = new DataTable();
            dtPR1_PaymentRequisit.Columns.Add("PR1_State");
            dtPR1_PaymentRequisit.Columns.Add("PR1_LmDt");
            dtPR1_PaymentRequisit.Columns.Add("PR1_LmUser");
            DataRow drPR1_PaymentRequisit = dtPR1_PaymentRequisit.NewRow();
            drPR1_PaymentRequisit["PR1_LmUser"] = hzyMessage.User_Name_CN;
            drPR1_PaymentRequisit["PR1_LmDt"] = timeNow;
            drPR1_PaymentRequisit["PR1_State"] = strPR1_State;
            dtPR1_PaymentRequisit.Rows.Add(drPR1_PaymentRequisit);
            bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisit]", dtPR1_PaymentRequisit, "PR1_RequestCode=" + "'" + strPR1_RequestCode + "'");

            //更新付款单
            ds.Tables["list"].Columns.Remove("pr1_requestcode");
            ds.Tables["list"].Columns.Remove("pr1_state");
            ds.Tables["list"].Columns.Remove("pb1_paybillcode");
            ds.Tables["list"].Columns.Add("pb1_lmuser");
            ds.Tables["list"].Columns.Add("pb1_lmdt");
            ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name_CN;
            ds.Tables["List"].Rows[0]["pb1_lmdt"] = timeNow;
            //按照付款单做修改


            if (!ds.Tables["list"].Columns.Contains("pb1_paymentdeductionamount"))
            {
                ds.Tables["list"].Columns.Add("pb1_paymentdeductionamount");//增加更新时间列
                ds.Tables["list"].Rows[0]["pb1_paymentdeductionamount"] = "0";
            }
            if (ds.Tables["list"].Columns.Contains("pb1_paymentdeductionamount") && ds.Tables["list"].Rows[0]["pb1_paymentdeductionamount"].ToString() == "")
            {
                ds.Tables["list"].Rows[0]["pb1_paymentdeductionamount"] = "0";
            }

            bResult = m_conn.Update("[B02_BILL].[PB1_PaymentBill]", ds.Tables["List"], "pb1_paybillcode=" + "'" + strPB1_PayBillCode + "'");

            //相应减去改供应商资金池金额
            //或许该供应商相应货币的资金池金额

            string strSP2_PoolAmount = m_conn.GetDataTableFirstValue(@"
                                                          SELECT    [SP2_PoolAmount]
                                                  FROM      [B01_MDM].[SP2_SupplierPool]
                                                  WHERE   SP2_SP1_SupplierCode = '" + strSP2_SP1_SupplierCode + "' AND SP2_Currency = '" + strSP2_Currency + "'").ToString();
            if (strSP2_PoolAmount == "")
            {
                strSP2_PoolAmount = "0";
            }
            if (strPB1_PaymentDeductionAmount == "")
            {
                strPB1_PaymentDeductionAmount = "0";
            }

            decimal nUpdateSP2_PoolAmount = Convert.ToDecimal(strSP2_PoolAmount) - Convert.ToDecimal(strPB1_PaymentDeductionAmount);

            //构造跟新资金池数据的表，供应商编号，币种，跟新时间，跟新人，最新资金池金额
            DataTable dtSP2_SupplierPool = new DataTable();
            dtSP2_SupplierPool.Columns.Add("SP2_SP1_SupplierCode");
            dtSP2_SupplierPool.Columns.Add("SP2_Currency");
            dtSP2_SupplierPool.Columns.Add("SP2_LmDt");
            dtSP2_SupplierPool.Columns.Add("SP2_LmUser");
            dtSP2_SupplierPool.Columns.Add("SP2_PoolAmount");
            DataRow drSP2_SupplierPool = dtSP2_SupplierPool.NewRow();
            drSP2_SupplierPool["SP2_LmUser"] = hzyMessage.User_Name_CN;
            drSP2_SupplierPool["SP2_LmDt"] = timeNow;
            drSP2_SupplierPool["SP2_SP1_SupplierCode"] = strSP2_SP1_SupplierCode;
            drSP2_SupplierPool["SP2_Currency"] = strSP2_Currency;
            drSP2_SupplierPool["SP2_PoolAmount"] = nUpdateSP2_PoolAmount;
            dtSP2_SupplierPool.Rows.Add(drSP2_SupplierPool);
            ArrayList listKey = new ArrayList();//增加主键
            listKey.Add("SP2_SP1_SupplierCode");
            listKey.Add("SP2_Currency");

            bResult = m_conn.Update("[B01_MDM].[SP2_SupplierPool]", dtSP2_SupplierPool, listKey);


            //插入资金池交易历史表
            if (strPB1_PaymentDeductionAmount != "0")
            {
                string strGuidForSP3_SupplierPoolTrans = System.Guid.NewGuid().ToString();//取GUID
                //插入资金池
                string strSQLForSP3_SupplierPoolTrans = @"
                                  INSERT  INTO [B03_TRANS].[SP3_SupplierPoolTrans]([SP3_ID]
                                              ,[SP3_CONO]
                                              ,[SP3_DIVI]
                                              ,[SP3_SP1_SupplierCode]
                                              ,[SP3_Currency]
                                              ,[SP3_RefCODE]
                                              ,[SP3_RefType]
                                              ,[SP3_TransAmount]
                                              ,[SP3_SurplusAmount]
                                              ,[SP3_RgDt]
                                              ,[SP3_RgUser]
                                              ,[SP3_LmDt]
                                              ,[SP3_LmUser]
                                             )
                                    ( SELECT    @Param0 SP3_ID ,
                                                'GL' SP3_CONO ,
                                                'D01' SP3_DIVI ,
                                                @Param1 SP3_SP1_SupplierCode,
                                                @Param2 SP3_Currency ,
                                                @Param3 SP3_RefCODE ,
                                                @Param4 SP3_RefType ,
                                                @Param5 SP3_TransAmount ,
                                                @Param6 SP3_SurplusAmount,
                                                @Param7  SP3_RgDt,
										        @Param8   SP3_RgUser,
										        @Param9   SP3_LmDt,
										        @Param10   SP3_LmUser
                                    )";
                m_conn.ExcuteQuerryByTran(strSQLForSP3_SupplierPoolTrans, new string[] { 
                                    strGuidForSP3_SupplierPoolTrans,strSP2_SP1_SupplierCode,strSP2_Currency,strPOcode,"采购单","-"+ strPB1_PaymentDeductionAmount,
                                nUpdateSP2_PoolAmount.ToString(),timeNow.ToString(),hzyMessage.User_Name_CN,
                                timeNow.ToString(),hzyMessage.User_Name_CN });
            }
            //更新采购单，付款状态改为未付款
            string strSQLForEndPO1_POHead = @" 
                                            UPDATE  [B02_BILL].[PO1_POHead]
                                            SET     PO1_PayState = '未完结' ,
                                                    PO1_LmDt = @Param0 ,
                                                    PO1_LmUser = @Param1
                                            WHERE   PO1_POCode = @Param2
                                                    AND PO1_HState != '99'
                                                    AND PO1_LState != '99'";
            m_conn.ExcuteQuerryByTran(strSQLForEndPO1_POHead, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name_CN,strPOcode});

            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 付款申请单删除
        /// <summary>
        /// 付款申请单删除
        /// </summary>
        private void DeletePR1_PaymentRequisit()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisit]");//锁表
            m_conn.BeginTransaction();//开启事务
            DateTime timeNow = DateTime.Now;//取本地当前时间
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["pr1_requestcode"].ToString();//获取付款申请单号
            string strPB1_PayBillCode = ds.Tables["list"].Rows[0]["pb1_paybillcode"].ToString();//获取付款单号

            ds.Tables["list"].Columns.Add("pr1_lmdt");//增加更新时间列
            ds.Tables["list"].Columns.Add("pr1_lmuser");//增加更新人列
            ds.Tables["list"].Columns.Remove("pb1_paybillcode");
            ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name_CN;//给跟新人附上后台登入姓名
            ds.Tables["List"].Rows[0]["pr1_lmdt"] = timeNow;//给更新时间附上本地时间
            bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"], "pr1_requestcode=" + "'" + strPR1_RequestCode + "'");

            //如果删除付款申请单，付款单相应的也要删除
            DataTable dsPaymentBill = new DataTable();
            dsPaymentBill.Columns.Add("PB1_LmDt");
            dsPaymentBill.Columns.Add("PB1_LmUser");
            dsPaymentBill.Columns.Add("PB1_State");
            DataRow drPaymentBill = dsPaymentBill.NewRow();

            drPaymentBill["PB1_LmDt"] = timeNow;//给更新时间附上本地时间
            drPaymentBill["PB1_LmUser"] = hzyMessage.User_Name_CN;//给跟新人附上后台登入姓名;
            drPaymentBill["PB1_State"] = "99";
            dsPaymentBill.Rows.Add(drPaymentBill);
            bResult = m_conn.Update("[B02_BILL].[PB1_PaymentBill]", dsPaymentBill, "PB1_PayBillCode=" + "'" + strPB1_PayBillCode + "'");

            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 采购单付款完结
        /// <summary>
        ///采购单付款完结
        /// </summary>
        private void EndPohead()
        {
            bool bResult = true;
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisit]");//锁表付款申请表
            m_conn.LockTableList.Add("[B02_BILL].[PB1_PaymentBill]");//锁表付款单表
            m_conn.LockTableList.Add("[B02_BILL].[PO1_POHead]");//锁表
            m_conn.BeginTransaction();//开启事务
            DateTime timeNow = DateTime.Now;//取本地当前时间

            string strState = ds.Tables["list"].Rows[0]["state"].ToString();//获取临时状态1代表直接结案，2代表未入库金额有差异
            string strPr1_Po1_PoCode = ds.Tables["list"].Rows[0]["pr1_po1_pocode"].ToString();//获取采购单号

            //更新付款申请单
            string strSQLForEndPR1_PaymentRequisit = @" 
                                                        UPDATE  [B02_BILL].[PR1_PaymentRequisit]
                                                        SET     PR1_State = '85' ,
                                                                PR1_LmDt = @Param0 ,
                                                                PR1_LmUser = @Param1
                                                        WHERE   PR1_PO1_POCode = @Param2
                                                                AND PR1_State != '99' ";
            m_conn.ExcuteQuerryByTran(strSQLForEndPR1_PaymentRequisit, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name_CN,strPr1_Po1_PoCode});

            //更新付款单
            string strSQLForEndPB1_PaymentBill = @" 
                                                        UPDATE  [B02_BILL].[PB1_PaymentBill]
                                                        SET     PB1_State = '85' ,
                                                                PB1_LmDt = @Param0 ,
                                                                PB1_LmUser = @Param1
                                                       WHERE PB1_PR1_RequestCode LIKE '%@Param2%' AND PB1_State != '99'
                                                                AND PB1_State != '99' ";
            m_conn.ExcuteQuerryByTran(strSQLForEndPB1_PaymentBill, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name_CN,strPr1_Po1_PoCode});
            //更新采购单
            string strSQLForEndPO1_POHead = @" 
                                                        UPDATE  [B02_BILL].[PO1_POHead]
                                                        SET     PO1_PayState = '已完结' ,
                                                                PO1_LmDt = @Param0 ,
                                                                PO1_LmUser = @Param1
                                                        WHERE   PO1_POCode = @Param2
                                                                AND PO1_HState != '99'
                                                                AND PO1_LState != '99'";
            m_conn.ExcuteQuerryByTran(strSQLForEndPO1_POHead, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name_CN,strPr1_Po1_PoCode});

            if (strState == "2")
            {
                string strUnrptotalAmount = ds.Tables["list"].Rows[0]["unrptotalamount"].ToString();//未入库金额
                string strSP2_SP1_Suppliercode = ds.Tables["list"].Rows[0]["sp2_sp1_suppliercode"].ToString();//获取采购单号
                string strSP2_Currency = ds.Tables["list"].Rows[0]["sp2_currency"].ToString();//获取采购单号
                //获取该供应商相应货币的资金池金额
                //加上未入库金额
                string strSP2_PoolAmount = m_conn.GetDataTableFirstValue(@"
                                                          SELECT    [SP2_PoolAmount]
                                                  FROM      [B01_MDM].[SP2_SupplierPool]
                                                  WHERE   SP2_SP1_SupplierCode = '" + strSP2_SP1_Suppliercode + "' AND SP2_Currency = '" + strSP2_Currency + "'").ToString();


                if (strSP2_PoolAmount == "")
                {
                    strSP2_PoolAmount = "0";
                }
                decimal nUpdateSP2_PoolAmount = Convert.ToDecimal(strSP2_PoolAmount) + Convert.ToDecimal(strUnrptotalAmount);

                //构造跟新资金池数据的表，供应商编号，币种，跟新时间，跟新人，最新资金池金额
                DataTable dtSP2_SupplierPool = new DataTable();
                dtSP2_SupplierPool.Columns.Add("SP2_SP1_SupplierCode");
                dtSP2_SupplierPool.Columns.Add("SP2_Currency");
                dtSP2_SupplierPool.Columns.Add("SP2_LmDt");
                dtSP2_SupplierPool.Columns.Add("SP2_LmUser");
                dtSP2_SupplierPool.Columns.Add("SP2_PoolAmount");
                DataRow drSP2_SupplierPool = dtSP2_SupplierPool.NewRow();
                drSP2_SupplierPool["SP2_LmUser"] = hzyMessage.User_Name_CN;
                drSP2_SupplierPool["SP2_LmDt"] = timeNow;
                drSP2_SupplierPool["SP2_SP1_SupplierCode"] = strSP2_SP1_Suppliercode;
                drSP2_SupplierPool["SP2_Currency"] = strSP2_Currency;
                drSP2_SupplierPool["SP2_PoolAmount"] = nUpdateSP2_PoolAmount;
                dtSP2_SupplierPool.Rows.Add(drSP2_SupplierPool);
                ArrayList listKey = new ArrayList();
                listKey.Add("SP2_SP1_SupplierCode");
                listKey.Add("SP2_Currency");
                bResult = m_conn.Update("[B01_MDM].[SP2_SupplierPool]", dtSP2_SupplierPool, listKey);

                //插入供应商资金池交易历史表
                string strGuidForSP3_SupplierPoolTrans = System.Guid.NewGuid().ToString();//取GUID完结
                string strSQLForSP3_SupplierPoolTrans = @"
                                  INSERT  INTO [B03_TRANS].[SP3_SupplierPoolTrans]([SP3_ID]
                                              ,[SP3_CONO]
                                              ,[SP3_DIVI]
                                              ,[SP3_SP1_SupplierCode]
                                              ,[SP3_Currency]
                                              ,[SP3_RefCODE]
                                              ,[SP3_RefType]
                                              ,[SP3_TransAmount]
                                              ,[SP3_SurplusAmount]
                                              ,[SP3_RgDt]
                                              ,[SP3_RgUser]
                                              ,[SP3_LmDt]
                                              ,[SP3_LmUser]
                                             )
                                    ( SELECT    @Param0 SP3_ID ,
                                                'GL' SP3_CONO ,
                                                'D01' SP3_DIVI ,
                                                @Param1 SP3_SP1_SupplierCode,
                                                @Param2 SP3_Currency ,
                                                @Param3 SP3_RefCODE ,
                                                @Param4 SP3_RefType ,
                                                @Param5 SP3_TransAmount ,
                                                @Param6 SP3_SurplusAmount,
                                                @Param7  SP3_RgDt,
										        @Param8   SP3_RgUser,
										        @Param9   SP3_LmDt,
										        @Param10   SP3_LmUser
                                    )";
                m_conn.ExcuteQuerryByTran(strSQLForSP3_SupplierPoolTrans, new string[] { 
                                    strGuidForSP3_SupplierPoolTrans,strSP2_SP1_Suppliercode,strSP2_Currency,strPr1_Po1_PoCode,"采购单结案", strUnrptotalAmount,
                                nUpdateSP2_PoolAmount.ToString(),timeNow.ToString(),hzyMessage.User_Name_CN,
                                timeNow.ToString(),hzyMessage.User_Name_CN });
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "完结成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "完结失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 付款申请单删除CHECK
        /// <summary>
        /// 付款申请单删除CHECK
        /// </summary>
        private void CheckPR1_PaymentRequisit()
        {
            string strSQL = @"
                                SELECT COUNT(*)  count FROM [B02_BILL].[PB1_PaymentBill]
                                WHERE PB1_PaymentDeductionAmount !=0  and 1=1  " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { }, m_hzyPageInfo);
        }
        #endregion

        #endregion
    }
}

