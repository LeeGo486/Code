using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using System.Web;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;

// 类名：Payment
// 类说明：集团版ERP
// 创建人： 俞佳伟
// 创建日期：2015-03-07
// 修改人：
// 修改日期： 
namespace HZY.COM.WS.GroupERP
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

        private Dbconn m_conn = new Dbconn();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                m_conn = new Dbconn(m_hzyMessage.Env_SN);
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                string optype = dt_OPTYPE.Rows[0][0].ToString().ToUpper(); //获取操作方法               

                #region 以前的方法注释 备份
                //if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPaymentInfo".ToUpper())//获取付款单信息
                //{
                //    //Get();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "InsertPR1_PaymentRequisit".ToUpper())//新增付款申请单
                //{
                //    //InsertPR1_PaymentRequisit();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdatePR1_PaymentRequisit".ToUpper())//修改付款申请单
                //{
                //    //UpdatePR1_PaymentRequisit();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "InsertPB1_PaymentBill".ToUpper())//新增付款单
                //{
                //    //InsertPB1_PaymentBill();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdatePB1_PaymentBill".ToUpper())//更新付款单
                //{
                //    //UpdatePB1_PaymentBill();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeletePR1_PaymentRequisit".ToUpper())//付款申请单删除
                //{
                //    //DeletePR1_PaymentRequisit();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckPR1_PaymentRequisit".ToUpper())//付款单删除CHECK
                //{
                //    //CheckPR1_PaymentRequisit();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EndPohead".ToUpper())//完结
                //{
                //    //EndPohead();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditPaymentRequisit".ToUpper())
                //{
                //    //EditPaymentRequisit();//付款申请单(Hawk2集团版)
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPR1_PaymentRequisit".ToUpper())
                //{
                //    //GetPR1_PaymentRequisit();
                //}

                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDeposit".ToUpper())
                //{
                //    //GetDeposit();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDepositDetail".ToUpper())
                //{
                //    //GetDepositDetail();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditPaymentRequest".ToUpper())
                //{
                //    //EditPaymentRequest();
                //}
                // else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetFinanceReport".ToUpper())
                //{
                //    //GetFinanceReport();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPaymentData".ToUpper())
                //{
                //    //GetPaymentData();
                //}
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckRequestIsOK".ToUpper())
                //{
                //    CheckRequestIsOK();
                //}
                #endregion

                if (optype == "Insert_PBDetail".ToUpper())
                {
                    Insert_PBDetail();
                }
                else if (optype == "AddEditPayRequest".ToUpper())  //付款申请、维护
                {
                    AddEditPayRequest();
                }

                else if (optype == "EndPay".ToUpper()) //付款完结
                {
                    EndPay();
                }
                else if (optype == "IsPaid".ToUpper()) //判断是否已付款
                {
                    IsPaid();
                }
                else if (optype == "ApplyForPayment".ToUpper())
                {
                    ApplyForPayment();
                }
                else if (optype == "EditPaymentApply".ToUpper())
                {
                    EditPaymentApply();
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

        #region 内部函数(新20150729)

        #region 付款申请
        private void ApplyForPayment()
        {
            bool bResult = false;
            CheckResult ckRt;
            string strRequestCode = "";//付款申请单号

            //获取数据
            DataTable dt_List = ds.Tables["list"];
            string strPOCode = dt_List.Rows[0]["pocode"].ToString();
            double dblApplyMoney = Convert.ToDouble(dt_List.Rows[0]["PR1_RequestAmount"].ToString());
            double dblPurchaseMoney = Convert.ToDouble(dt_List.Rows[0]["PurchaseMoney"].ToString());

            //在申请之前 数据判断
            //1.本次申请支付金额+已申请支付金额 是否超过采购金额
            ckRt = CheckForApplyMoney(m_hzyMessage.Env_SN, strPOCode, dblApplyMoney, dblPurchaseMoney);
            //2.本次使用资金池金额 是否超过供应商资金池余额

            if (ckRt.boolResult)
            {
                //生成付款申请单号
                strRequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单2", strPOCode, m_hzyMessage.Env_SN, "", m_conn); //获取最大付款申请单号

                DataTable dt = new DataTable();
                dt.Columns.Add("PR1_CONO");
                dt.Columns.Add("PR1_DIVI");
                dt.Columns.Add("PR1_RequestCode");
                dt.Columns.Add("PR1_PO1_POCode");
                dt.Columns.Add("PR1_PO1_SPPOCode");
                //dt.Columns.Add("PR1_AP1_APOCode");
                dt.Columns.Add("PR1_RequestAmoun");
                dt.Columns.Add("PR1_PayAmount");
                dt.Columns.Add("PR1_PoolAmount");
                //dt.Columns.Add("PR1_PaymentRatio");
                dt.Columns.Add("PR1_PO1_Currency");
                dt.Columns.Add("PR1_State");
                dt.Columns.Add("PR1_Comment");
                dt.Columns.Add("PR1_RgDt");
                dt.Columns.Add("PR1_RgUser");
                dt.Columns.Add("PR1_LmDt");
                dt.Columns.Add("PR1_LmUser");
                dt.Columns.Add("PR1_UptNo");

                DataRow dr = dt.NewRow();
                dr["PR1_CONO"] = "HYFG";
                dr["PR1_DIVI"] = m_hzyMessage.Env_SN;
                dr["PR1_RequestCode"] = strRequestCode;
                dr["PR1_PO1_POCode"] = strPOCode;
                dr["PR1_PO1_SPPOCode"] = dt_List.Rows[0]["PR1_PO1_SPPOCode"].ToString();
                //dr["PR1_AP1_APOCode"] = "";
                dr["PR1_RequestAmount"] = Convert.ToDouble(dt_List.Rows[0]["PR1_RequestAmount"].ToString());
                dr["PR1_PayAmount"] = Convert.ToDouble(dt_List.Rows[0]["PR1_RequestAmount"].ToString()) - Convert.ToDouble(dt_List.Rows[0]["PR1_RequestAmount"].ToString());
                dr["PR1_PoolAmount"] = Convert.ToDouble(dt_List.Rows[0]["PR1_RequestAmount"].ToString());
                //dr["PR1_PaymentRatio"] = "";
                dr["PR1_PO1_Currency"] = dt_List.Rows[0]["PO1_Currency"].ToString();
                dr["PR1_State"] = "15";
                dr["PR1_Comment"] = "非定金";
                dr["PR1_RgDt"] = timeNow;
                dr["PR1_RgUser"] = m_hzyMessage.User_Name;
                dr["PR1_LmDt"] = timeNow;
                dr["PR1_LmUser"] = m_hzyMessage.User_Name;
                dr["PR1_UptNo"] = "0";

                dt.Rows.Add(dr);

                m_conn.BeginTransaction();
                bResult = m_conn.Insert("B02_BILL.PR1_PaymentRequisitHead", dt);
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, strRequestCode });
                    m_conn.CommitTransaction();
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "申请失败" });
                    m_conn.RollbackTransaction();
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, ckRt.msgResult });
            }

            ds_Return.Tables.Add(dt_EditResult);

        }
        #endregion

        #region 付款申请编辑
        private void EditPaymentApply()
        {
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["PR1_RequestCode"].ToString();
            double dblPR1_RequestAmount = Convert.ToDouble(ds.Tables["list"].Rows[0]["PR1_RequestAmount"].ToString());
            double dblPR1_PoolAmount = Convert.ToDouble(ds.Tables["list"].Rows[0]["PR1_PoolAmount"].ToString());
            double bdlPR1_PayAmount = dblPR1_RequestAmount - dblPR1_PoolAmount;

            string strUpdate = @"   UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                    SET PR1_RequestAmount=" + dblPR1_RequestAmount
                                    + @" ,PR1_PoolAmount=" + dblPR1_PoolAmount
                                    + @" ,PR1_PayAmount =" + bdlPR1_PayAmount
                                    + @" ,PR1_LmDt=GETDATE(),PR1_UptNo=PR1_UptNo+1,PR1_LmUser='" + m_hzyMessage.User_Name
                                    + @"' WHERE PR1_RequestCode='" + dblPR1_RequestAmount + "' AND PR1_DIVI='" + m_hzyMessage.Env_SN + "'";
            try
            {
                int n = m_conn.Excute(strUpdate);
                if (n > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "找不到" + strPR1_RequestCode + "的申请单" });
                }
            }
            catch (Exception ex)
            {
                dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region 财务付款
        private void Pay()
        {
            bool bResult = false;
            DataTable inputTable = ds.Tables["list"];
            if (inputTable.Rows.Count > 0)
            {
                string strSupplier = inputTable.Rows[0]["PO1_SupplierCode"].ToString(); //供应商编号
                string strCurrency = inputTable.Rows[0]["PO1_Currency"].ToString();   //币种
                string strDIVI = inputTable.Rows[0]["PO1_DIVI"].ToString();    //环境
                string strPOCode = inputTable.Rows[0]["PO1_Code"].ToString();  //采购单号
                string strPB1_PR1_RequestCode = inputTable.Rows[0]["PB1_PR1_RequestCode"].ToString();//付款申请单号
                double dblPoolMoney = Convert.ToDouble(inputTable.Rows[0]["PB1_PaymentDeductionAmount"].ToString()); //供应商资金池抵扣金额

                //验证资金池抵扣金额是否超过资金池可用余额
                string strSQL = @"  SELECT SP2_PoolAmount 
                                    FROM B01_MDM.SP2_SupplierPool WITH(NOLOCK)
                                    WHERE SP2_SP1_SupplierCode='" + strSupplier + "' AND SP2_Currency='" + strCurrency + "' AND SP2_DIVI='" + strDIVI + "'";
                double dblCanUsePoolMoney = Convert.ToDouble(m_conn.GetDataTableFirstValue(strSQL).ToString());  //供应商资金池金额

                if (dblPoolMoney > dblCanUsePoolMoney)
                {
                    dt_EditResult.Rows.Add(new object[] { false, "供应商抵扣金额超过供应商余额,可用余额为:" + dblCanUsePoolMoney });
                }
                else
                {
                    //生成付款号
                    string strMaxPayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPOCode, strDIVI, "", m_conn);

                    DataTable dt = new DataTable();
                    dt.Columns.Add("PB1_CONO");
                    dt.Columns.Add("PB1_DIVI");
                    dt.Columns.Add("PB1_PayBillCode");
                    dt.Columns.Add("PB1_PR1_RequestCode");
                    dt.Columns.Add("PB1_State");
                    dt.Columns.Add("PB1_PaymentAmount");
                    dt.Columns.Add("PB1_PaymentTotalAmount");
                    dt.Columns.Add("PB1_PaymentDeductionAmount");
                    dt.Columns.Add("PB1_PaymentDepositAmount");
                    dt.Columns.Add("PB1_Comment");
                    dt.Columns.Add("PB1_RgDt");
                    dt.Columns.Add("PB1_RgUser");
                    dt.Columns.Add("PB1_LmDt");
                    dt.Columns.Add("PB1_LmUser");
                    dt.Columns.Add("PB1_UptNo");

                    DataRow dr = dt.NewRow();
                    dr["PB1_CONO"] = "HYFG";
                    dr["PB1_DIVI"] = strDIVI;
                    dr["PB1_PayBillCode"] = strMaxPayBillCode;
                    dr["PB1_PR1_RequestCode"] = inputTable.Rows[0]["PB1_PR1_RequestCode"].ToString();
                    dr["PB1_State"] = "85";
                    dr["PB1_PaymentAmount"] = Convert.ToDecimal(inputTable.Rows[0]["PB1_PaymentAmount"].ToString());
                    dr["PB1_PaymentTotalAmount"] = Convert.ToDecimal(inputTable.Rows[0]["PB1_PaymentTotalAmount"].ToString());
                    dr["PB1_PaymentDeductionAmount"] = Convert.ToDecimal(inputTable.Rows[0]["PB1_PaymentDeductionAmount"].ToString());
                    dr["PB1_PaymentDepositAmount"] = Convert.ToDecimal(inputTable.Rows[0]["PB1_PaymentDepositAmount"].ToString());
                    dr["PB1_Comment"] = "非定金";
                    dr["PB1_RgDt"] = timeNow;
                    dr["PB1_RgUser"] = m_hzyMessage.User_Name;
                    dr["PB1_LmDt"] = timeNow;
                    dr["PB1_LmUser"] = m_hzyMessage.User_Name;
                    dr["PB1_UptNo"] = "0";

                    dt.Rows.Add(dr);

                    m_conn.BeginTransaction();
                    bResult = m_conn.Insert("B02_BILL.PB1_PaymentBill", dt);
                    if (bResult)
                    {
                        //插供应商交易历史表 
                        DataTable dtSP3 = new DataTable();
                        dtSP3.Columns.Add("SP3_CONO");
                        dtSP3.Columns.Add("SP3_DIVI");
                        //dtSP3.Columns.Add("SP3_Seq");
                        dtSP3.Columns.Add("SP3_SP1_SupplierCode");
                        dtSP3.Columns.Add("SP3_Currency");
                        dtSP3.Columns.Add("SP3_RefCODE");
                        dtSP3.Columns.Add("SP3_RefType");
                        dtSP3.Columns.Add("SP3_TransAmount");
                        dtSP3.Columns.Add("SP3_SurplusAmount");
                        dtSP3.Columns.Add("SP3_RgDt");
                        dtSP3.Columns.Add("SP3_RgUser");
                        dtSP3.Columns.Add("SP3_LmDt");
                        dtSP3.Columns.Add("SP3_LmUser");
                        dtSP3.Columns.Add("SP3_UptNo");

                        DataRow drSP3 = dtSP3.NewRow();
                        drSP3["SP3_CONO"] = "HYFG";
                        drSP3["SP3_DIVI"] = strDIVI;
                        //drSP3["SP3_Seq"] = "";
                        drSP3["SP3_SP1_SupplierCode"] = strSupplier;
                        drSP3["SP3_Currency"] = strCurrency;
                        drSP3["SP3_RefCODE"] = strMaxPayBillCode;
                        drSP3["SP3_RefType"] = "财务付款";
                        drSP3["SP3_TransAmount"] = dblPoolMoney;
                        drSP3["SP3_SurplusAmount"] = dblCanUsePoolMoney - dblPoolMoney;
                        drSP3["SP3_RgDt"] = timeNow;
                        drSP3["SP3_RgUser"] = m_hzyMessage.User_Name;
                        drSP3["SP3_LmDt"] = timeNow;
                        drSP3["SP3_LmUser"] = m_hzyMessage.User_Name;
                        drSP3["SP3_UptNo"] = "0";

                        dtSP3.Rows.Add(drSP3);

                        bResult = m_conn.Insert("B03_TRANS.SP3_SupplierPoolTrans", dtSP3);
                        if (bResult)
                        {
                            //更新供应商资金池金额
                            string strUpdateSP2 = @"UPDATE B01_MDM.SP2_SupplierPool 
                                                SET SP2_PoolAmount=SP2_PoolAmount-" + dblPoolMoney
                                                    + "WHERE SP2_DIVI='" + strDIVI + "' AND SP2_Currency='" + strCurrency + "' AND SP2_SP1_SupplierCode='" + strSupplier + "' ";
                            try
                            {
                                m_conn.Excute(strUpdateSP2);
                                bResult = true;
                            }
                            catch (Exception exc)
                            {
                                bResult = false;

                            }
                            if (bResult)
                            {
                                //更新付款申请表状态
                                string strUpdatePR1 = @"UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                                        SET PR1_State='85'
                                                        WHERE PR1_DIVI='" + strDIVI + "' AND PR1_RequestCode='" + strPB1_PR1_RequestCode + "' AND PR1_PO1_POCode='" + strPOCode + "'";
                                try
                                {
                                    m_conn.Excute(strUpdatePR1);
                                    bResult = true;
                                }
                                catch (Exception e)
                                {
                                    bResult = false;
                                    dt_EditResult.Rows.Add(new object[] { false, "更新付款申请表状态" });
                                }
                            }
                            else
                            {
                                //更新供应商资金池金额失败
                                dt_EditResult.Rows.Add(new object[] { false, "供应商资金池金额更新失败" });
                            }
                        }
                        else
                        {
                            //插供应商资金池交易表出错
                            bResult = false;
                            dt_EditResult.Rows.Add(new object[] { false, "插供应商资金池交易表出错" });
                        }
                    }
                    else
                    {
                        //付款失败
                        dt_EditResult.Rows.Add(new object[] { false, "付款失败" });
                    }


                    if (bResult)
                    {
                        //更新采购单状态
                        dt_EditResult.Rows.Add(new object[] { false, "付款成功" });
                        m_conn.CommitTransaction();
                    }
                    else
                    {
                        m_conn.RollbackTransaction();
                    }
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "没有可以保存的数据" });
            }
        }
        #endregion

        /// <summary>
        /// 检查付款申请金额是否正确
        /// </summary>
        /// <param name="strDIVI">环境</param>
        /// <param name="strPOCode">采购单号</param>
        /// <param name="dblApplyMoney">本次申请金额</param>
        /// <param name="dblPurchaseMoney">采购金额</param>
        /// <returns>CheckResult</returns>
        private CheckResult CheckForApplyMoney(string strDIVI, string strPOCode, double dblApplyMoney, double dblPurchaseMoney)
        {
            CheckResult ckrt;
            ckrt.boolResult = true;
            ckrt.msgResult = "";
            if (dblApplyMoney <= dblPurchaseMoney)
            {
                string strSQL = @"
                            SELECT PR1_CONO,PR1_DIVI,PR1_PO1_POCode
	                            ,SUM(ISNULL(PR1_RequestAmount,0)) RequestAmount  
	                            ,SUM(ISNULL(PR1_PayAmount,0)) PayAmount
	                            ,SUM(ISNULL(PR1_PoolAmount,0)) PoolAmount
                            FROM B02_BILL.PR1_PaymentRequisitHead WITH(NOLOCK)
                            WHERE PR1_DIVI='" + strDIVI + "' AND PR1_PO1_POCode='" + strPOCode + @"'
                            GROUP BY PR1_CONO,PR1_DIVI,PR1_PO1_POCode";
                DataTable dt = m_conn.GetDataTable(strSQL);
                if (dt.Rows.Count > 0)
                {
                    if (Convert.ToDouble(dt.Rows[0]["RequestAmount"].ToString()) + dblApplyMoney > dblPurchaseMoney)
                    {
                        ckrt.boolResult = false;
                        ckrt.msgResult = "该采购单申请金额大于采购金额";
                    }
                }
            }
            else
            {
                ckrt.boolResult = false;
                ckrt.msgResult = "申请金额大于采购金额";
            }
            return ckrt;
        }

        private struct CheckResult
        {
            public bool boolResult;
            public string msgResult;
        }

        #endregion

        #region 内部函数

        #region Insert_PBDetail新增付款单子表(Hawk2集团版)
        /// <summary>
        /// Insert_PBDetail新增付款单子表(Hawk2集团版)
        /// </summary>
        private void Insert_PBDetail()
        {
            bool bResult = false;
            string strPOcode = ds.Tables["list"].Rows[0]["pocode"].ToString(); //获取采购单号
            string strPB1_PayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPOcode, m_hzyMessage.Env_SN, "", m_conn);
            string strCurrency = ds.Tables["list"].Rows[0]["po2_purchasecurrency"].ToString();  //结算币种
            string strSupplierCode = ds.Tables["list"].Rows[0]["suppliercode"].ToString(); //供应商编号
            decimal poolAmount = 0;

            //创建付款单表子表  
            DataTable dtPB2 = new DataTable();
            dtPB2.Columns.Add("PB2_ID");
            dtPB2.Columns.Add("PB2_CONO");
            dtPB2.Columns.Add("PB2_DIVI");
            dtPB2.Columns.Add("PB2_PayBillCode");
            dtPB2.Columns.Add("PB2_PR2_LISeq");
            dtPB2.Columns.Add("PB2_PR2_LSSeq");
            dtPB2.Columns.Add("PB2_PR2_ProductCode");
            dtPB2.Columns.Add("PB2_PR1_RequestCode");
            dtPB2.Columns.Add("PB2_State");
            dtPB2.Columns.Add("PB2_PaymentAmount");
            dtPB2.Columns.Add("PB2_PaymentTotalAmount");
            dtPB2.Columns.Add("PB2_PaymentDeductionAmount"); //资金池抵扣金额
            dtPB2.Columns.Add("PB2_PaymentDepositAmount");
            dtPB2.Columns.Add("PB2_Comment");
            dtPB2.Columns.Add("PB2_RgDt");
            dtPB2.Columns.Add("PB2_RgUser");
            dtPB2.Columns.Add("PB2_LmDt");
            dtPB2.Columns.Add("PB2_LmUser");
            dtPB2.Columns.Add("PB2_UptNo");

            //创建付款申请单更新表(付款之后付款申请单子表状态改成85)
            DataTable dtPR2 = new DataTable();
            dtPR2.Columns.Add("PR2_CONO");
            dtPR2.Columns.Add("PR2_DIVI");
            dtPR2.Columns.Add("PR2_RequestCode");
            dtPR2.Columns.Add("PR2_PO2_ProductCode");
            dtPR2.Columns.Add("PR2_PO2_LISeq");
            dtPR2.Columns.Add("PR2_PO2_LSSeq");
            dtPR2.Columns.Add("PR2_Comment");
            dtPR2.Columns.Add("PR2_State");
            dtPR2.Columns.Add("PR2_LmDt");
            dtPR2.Columns.Add("PR2_LmUser");

            //创建供应商资金池交易记录表
            DataTable dtSP3 = new DataTable();
            dtSP3.Columns.Add("SP3_ID");
            dtSP3.Columns.Add("SP3_CONO");
            dtSP3.Columns.Add("SP3_DIVI");
            dtSP3.Columns.Add("SP3_SP1_SupplierCode");
            dtSP3.Columns.Add("SP3_Currency");
            dtSP3.Columns.Add("SP3_RefCODE");
            dtSP3.Columns.Add("SP3_RefType");
            dtSP3.Columns.Add("SP3_TransAmount");
            dtSP3.Columns.Add("SP3_SurplusAmount");
            dtSP3.Columns.Add("SP3_RgDt");
            dtSP3.Columns.Add("SP3_RgUser");
            dtSP3.Columns.Add("SP3_LmDt");
            dtSP3.Columns.Add("SP3_LmUser");
            dtSP3.Columns.Add("SP3_UptNo");


            for (int i = 0; i < ds.Tables["list"].Rows.Count; i++)
            {
                //构建需要更新的付款申请单子表
                DataRow dr = dtPR2.NewRow();
                dr["PR2_CONO"] = ds.Tables["list"].Rows[i]["cono"].ToString();
                dr["PR2_DIVI"] = ds.Tables["list"].Rows[i]["divi"].ToString();
                dr["PR2_RequestCode"] = ds.Tables["list"].Rows[i]["PR2_RequestCode"].ToString(); ; //获取付款申请单号
                dr["PR2_PO2_ProductCode"] = ds.Tables["list"].Rows[i]["po2_pd1_productcode"].ToString(); //获取SKU
                dr["PR2_PO2_LISeq"] = ds.Tables["list"].Rows[i]["PO2_LIseq"].ToString();
                dr["PR2_PO2_LSSeq"] = ds.Tables["list"].Rows[i]["PO2_LSSeq"].ToString();
                dr["PR2_Comment"] = "非定金";
                dr["PR2_State"] = "85";
                dr["PR2_LmDt"] = timeNow;
                dr["PR2_LmUser"] = hzyMessage.User_Name;

                dtPR2.Rows.Add(dr);

                DataRow dr1 = dtPB2.NewRow();
                dr1["PB2_ID"] = System.Guid.NewGuid();//strPB1_PayBillCode
                dr1["PB2_CONO"] = ds.Tables["list"].Rows[i]["cono"].ToString();
                dr1["PB2_DIVI"] = ds.Tables["list"].Rows[i]["divi"].ToString();
                dr1["PB2_PayBillCode"] = strPB1_PayBillCode;
                dr1["PB2_PR1_RequestCode"] = ds.Tables["list"].Rows[i]["PR2_RequestCode"].ToString(); //获取付款申请单号
                dr1["PB2_PR2_LISeq"] = ds.Tables["list"].Rows[i]["PO2_LIseq"].ToString();
                dr1["PB2_PR2_LSSeq"] = ds.Tables["list"].Rows[i]["PO2_LSSeq"].ToString();
                dr1["PB2_PR2_ProductCode"] = ds.Tables["list"].Rows[i]["po2_pd1_productcode"].ToString();
                dr1["PB2_State"] = "85";
                dr1["PB2_PaymentAmount"] = ds.Tables["list"].Rows[i]["pr2_paymoney"].ToString();
                dr1["PB2_PaymentTotalAmount"] = ds.Tables["list"].Rows[i]["pr2_shareamount"].ToString();
                dr1["PB2_PaymentDeductionAmount"] = ds.Tables["list"].Rows[i]["pr2_poolmoney"].ToString();
                dr1["PB2_PaymentDepositAmount"] = ds.Tables["list"].Rows[i]["pr2_depositmoney"].ToString();
                dr1["PB2_Comment"] = "非定金";
                dr1["PB2_RgDt"] = timeNow;
                dr1["PB2_RgUser"] = hzyMessage.User_Name;
                dr1["PB2_LmDt"] = timeNow;
                dr1["PB2_LmUser"] = hzyMessage.User_Name;
                dr1["PB2_UptNo"] = "0";
                dtPB2.Rows.Add(dr1);

                poolAmount += Convert.ToDecimal(ds.Tables["list"].Rows[i]["pr2_poolmoney"].ToString());
            }

            ArrayList alist = new ArrayList();
            alist.Add("PR2_CONO");
            alist.Add("PR2_DIVI");
            alist.Add("PR2_RequestCode");
            alist.Add("PR2_PO2_ProductCode");
            alist.Add("PR2_PO2_LISeq");
            alist.Add("PR2_PO2_LSSeq");
            alist.Add("PR2_Comment");

            m_conn.BeginTransaction();
            bResult = m_conn.Update("[B02_BILL].[PR2_PaymentRequisitDetail]", dtPR2, alist);

            if (bResult)
            {
                bResult = m_conn.Insert("[B02_BILL].[PB2_PaymentBillDetail]", dtPB2);
                //当付款单子表插入成功后,插入付款单主表
                string strInPB1 = @"
                                    INSERT INTO B02_BILL.PB1_PaymentBill(PB1_CONO,PB1_DIVI,PB1_PayBillCode,PB1_State,
	                                    PB1_PaymentAmount,PB1_PaymentTotalAmount,PB1_PaymentDeductionAmount,PB1_PaymentDepositAmount,
	                                    PB1_Comment,PB1_RgUser,PB1_LmUser,PB1_UptNo)
                                    SELECT PB2_CONO,PB2_DIVI,PB2_PayBillCode,'85'
                                          ,SUM(ISNULL(PB2_PaymentAmount,0)) PaymentAmount
                                          ,SUM(ISNULL(PB2_PaymentTotalAmount,0)) PaymentTotalAmount
                                          ,SUM(ISNULL(PB2_PaymentDeductionAmount,0)) PaymentDeductionAmount
                                          ,SUM(ISNULL(PB2_PaymentDepositAmount,0)) PaymentDepositAmount
                                          ,'非定金','" + hzyMessage.User_Name + @"','" + hzyMessage.User_Name + @"','0'
                                    FROM B02_BILL.PB2_PaymentBillDetail WITH(NOLOCK)
                                    WHERE PB2_CONO='HYFG' AND PB2_DIVI='" + m_hzyMessage.Env_SN +
                                        @"' AND PB2_PayBillCode='" + strPB1_PayBillCode +
                                        @"' AND PB2_Comment='非定金' GROUP BY PB2_CONO,PB2_DIVI,PB2_PayBillCode";
                int RCount = m_conn.Excute(strInPB1);
                if (RCount != 1)
                {
                    bResult = false;
                }

                if (bResult)
                {
                    //获取供应商资金池金额
                    string sql = @"SELECT SP2_PoolAmount 
                            FROM B01_MDM.SP2_SupplierPool WITH(NOLOCK)
                            WHERE SP2_CONO='HYFG' AND SP2_DIVI='" + m_hzyMessage.Env_SN + "' AND SP2_SP1_SupplierCode='"
                                                                         + strSupplierCode + "' AND SP2_Currency='" + strCurrency + "'";
                    string poolMoney = m_conn.GetDataTableFirstValue(sql).ToString();
                    if (poolMoney == "") //表示供应商资金池表中没有相关记录,需要插入该供应商的该币种资金,初始值为0
                    {
                        string INSERTsql = @"INSERT INTO B01_MDM.SP2_SupplierPool( 
                                        SP2_CONO ,SP2_DIVI ,SP2_SP1_SupplierCode ,SP2_Currency ,
                                        SP2_PoolAmount ,SP2_State ,SP2_RgUser ,SP2_LmUser 
                                    )
                                    VALUES ( 'HYFG', '" + m_hzyMessage.Env_SN + "','" + strSupplierCode
                                                                + "','" + strCurrency + "',0,'15', '" + m_hzyMessage.User_Name
                                                                + "','" + m_hzyMessage.User_Name + "')";
                        m_conn.Excute(INSERTsql);
                        poolMoney = "0";
                    }
                    decimal pool = Convert.ToDecimal(poolMoney); //获取资金池金额

                    //插供应商资金池交易表
                    if (poolAmount != 0)
                    {
                        DataRow stSP3 = dtSP3.NewRow();
                        stSP3["SP3_ID"] = System.Guid.NewGuid();
                        stSP3["SP3_CONO"] = "HYFG";
                        stSP3["SP3_DIVI"] = m_hzyMessage.Env_SN;
                        stSP3["SP3_SP1_SupplierCode"] = strSupplierCode;
                        stSP3["SP3_Currency"] = strCurrency;
                        stSP3["SP3_RefCODE"] = strPB1_PayBillCode;
                        stSP3["SP3_RefType"] = "财务付款";
                        stSP3["SP3_TransAmount"] = -poolAmount;
                        stSP3["SP3_SurplusAmount"] = pool - poolAmount;
                        stSP3["SP3_RgDt"] = timeNow;
                        stSP3["SP3_RgUser"] = m_hzyMessage.User_Name;
                        stSP3["SP3_LmDt"] = timeNow;
                        stSP3["SP3_LmUser"] = m_hzyMessage.User_Name;
                        stSP3["SP3_UptNo"] = "0";

                        dtSP3.Rows.Add(stSP3);

                        bResult = m_conn.Insert("[B03_TRANS].[SP3_SupplierPoolTrans]", dtSP3);
                    }

                    if (bResult)  //更新供应商资金池
                    {
                        string uptSQL = @"
                                            UPDATE B01_MDM.SP2_SupplierPool SET SP2_PoolAmount =SP2_PoolAmount-" + poolAmount + ",SP2_LmDt=GETDATE(),SP2_LmUser='" + m_hzyMessage.User_Name + @"' 
                                            WHERE SP2_CONO='HYFG' AND SP2_DIVI='" + m_hzyMessage.Env_SN + "' AND SP2_SP1_SupplierCode='" + strSupplierCode + "' AND SP2_Currency='" + strCurrency + "'";
                        int nresult = m_conn.Excute(uptSQL);
                        if (nresult != 1)
                        {
                            bResult = false;
                        }
                    }
                }
            }

            if (bResult)
            {
                m_conn.CommitTransaction();
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
            }
            else
            {
                m_conn.RollbackTransaction();
                dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
            }

            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region AddEditPayRequest付款申请(非定金)
        /// <summary>
        /// EditPayRequest付款申请(非定金)
        /// </summary>
        private void AddEditPayRequest()
        {
            bool bResult = false;
            DataTable dtList = ds.Tables["list"];  //最后一行为汇总数据           
            string strRequestCode = dtList.Rows[0]["PR2_RequestCode"].ToString(); //获取付款申请单号
            string strPOcode = dtList.Rows[0]["pocode"].ToString();
            string strDIVI = m_hzyMessage.Env_SN;
            double dblPoolAmount = isNull(dtList.Rows[dtList.Rows.Count - 1]["poolAmount"].ToString()); //获取本次使用资金池金额
            double dblRequestAmout = isNull(dtList.Rows[dtList.Rows.Count - 1]["requestAmount"].ToString());  //获取本次申请总额

            DataTable dt = new DataTable();
            dt.Columns.Add("PR2_CONO");
            dt.Columns.Add("PR2_DIVI");
            dt.Columns.Add("PR2_RequestCode");
            dt.Columns.Add("PR2_PO2_LISeq");
            dt.Columns.Add("PR2_PO2_LSSeq");
            dt.Columns.Add("PR2_PO2_ProductCode");
            dt.Columns.Add("PR2_ShareAmount");
            dt.Columns.Add("PR2_PayMoney");
            dt.Columns.Add("PR2_PoolMoney");
            dt.Columns.Add("PR2_DepositMoney");
            dt.Columns.Add("PR2_State");
            dt.Columns.Add("PR2_Comment");
            dt.Columns.Add("PR2_RgDt");
            dt.Columns.Add("PR2_RgUser");
            dt.Columns.Add("PR2_LmDt");
            dt.Columns.Add("PR2_LmUser");
            dt.Columns.Add("PR2_UptNo");

            m_conn.BeginTransaction();
            if (strRequestCode == "") //新增插入
            {
                double dblSumPayMoney = 0;
                strRequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单2", strPOcode, strDIVI, "", m_conn); //获取最大付款申请单号 
                for (int i = 0; i < dtList.Rows.Count - 1; i++)
                {
                    //根据每个SKU本次申请支付金额占所有SKU本次申请支付总额的比例,分摊资金池金额
                    double poolMoney = 0;
                    if (dblRequestAmout != 0)
                    {
                        poolMoney = isNull(dtList.Rows[i]["pr2_shareamount"].ToString()) / dblRequestAmout * dblPoolAmount;
                    }

                    double depositMoney = isNull(dtList.Rows[i]["pr2_depositmoney"].ToString()); //定金抵扣金额

                    DataRow dr = dt.NewRow();
                    dr["PR2_CONO"] = "HYFG";
                    dr["PR2_DIVI"] = dtList.Rows[i]["divi"].ToString();
                    dr["PR2_RequestCode"] = strRequestCode;
                    dr["PR2_PO2_LISeq"] = dtList.Rows[i]["po2_liseq"].ToString();
                    dr["PR2_PO2_LSSeq"] = dtList.Rows[i]["po2_lsseq"].ToString();
                    dr["PR2_PO2_ProductCode"] = dtList.Rows[i]["po2_pd1_productcode"].ToString();
                    dr["PR2_ShareAmount"] = isNull(dtList.Rows[i]["pr2_shareamount"].ToString());
                    dr["PR2_PayMoney"] = isNull(dtList.Rows[i]["pr2_shareamount"].ToString()) - poolMoney - depositMoney; //支付金额
                    dr["PR2_PoolMoney"] = poolMoney;
                    dr["PR2_DepositMoney"] = depositMoney;//每个sku的定金金额*到货计划数量(如果没有做到货计划,则直接用分摊金额)
                    dr["PR2_State"] = "15";
                    dr["PR2_Comment"] = "非定金";
                    dr["PR2_RgDt"] = timeNow;
                    dr["PR2_RgUser"] = m_hzyMessage.User_Name;
                    dr["PR2_LmDt"] = timeNow;
                    dr["PR2_LmUser"] = m_hzyMessage.User_Name;
                    dr["PR2_UptNo"] = "0";

                    dt.Rows.Add(dr);
                    dblSumPayMoney += (isNull(dtList.Rows[i]["pr2_shareamount"].ToString()) - poolMoney - depositMoney);
                }
                bResult = m_conn.Insert("B02_BILL.PR2_PaymentRequisitDetail", dt);
                if (bResult) //如果成功插入付款申请单子表,更新付款申请主表
                {
                    DataTable PR1Tabel = new DataTable();
                    PR1Tabel.Columns.Add("PR1_CONO");
                    PR1Tabel.Columns.Add("PR1_DIVI");
                    PR1Tabel.Columns.Add("PR1_RequestCode");
                    PR1Tabel.Columns.Add("PR1_PO1_POCode");
                    PR1Tabel.Columns.Add("PR1_PO1_SPPOCode");
                    PR1Tabel.Columns.Add("PR1_AP1_APOCode");
                    PR1Tabel.Columns.Add("PR1_RequestAmount");
                    PR1Tabel.Columns.Add("PR1_PayAmount");
                    PR1Tabel.Columns.Add("PR1_PoolAmount");
                    PR1Tabel.Columns.Add("PR1_PO1_Currency");
                    PR1Tabel.Columns.Add("PR1_State");
                    PR1Tabel.Columns.Add("PR1_Comment");
                    PR1Tabel.Columns.Add("PR1_RgDt");
                    PR1Tabel.Columns.Add("PR1_RgUser");
                    PR1Tabel.Columns.Add("PR1_LmDt");
                    PR1Tabel.Columns.Add("PR1_LmUser");
                    PR1Tabel.Columns.Add("PR1_UptNo");

                    DataRow PR1dr = PR1Tabel.NewRow();
                    PR1dr["PR1_CONO"] = "HYFG";
                    PR1dr["PR1_DIVI"] = strDIVI;
                    PR1dr["PR1_RequestCode"] = strRequestCode;
                    PR1dr["PR1_PO1_POCode"] = dtList.Rows[0]["pocode"].ToString();
                    PR1dr["PR1_PO1_SPPOCode"] = dtList.Rows[0]["po2_pd1_supperierstyle"].ToString();  //2015-07-17 suppliercode改成po2_pd1_supperierstyle
                    PR1dr["PR1_AP1_APOCode"] = dtList.Rows[0]["apcode"].ToString();
                    PR1dr["PR1_RequestAmount"] = isNull(dtList.Rows[dtList.Rows.Count - 1]["requestAmount"].ToString());
                    PR1dr["PR1_PayAmount"] = dblSumPayMoney;  //本次申请支付总额-本次资金池使用金额-本次定金抵扣总额
                    PR1dr["PR1_PoolAmount"] = isNull(dtList.Rows[dtList.Rows.Count - 1]["poolAmount"].ToString());
                    PR1dr["PR1_PO1_Currency"] = dtList.Rows[0]["po2_purchasecurrency"].ToString();
                    PR1dr["PR1_State"] = "15";
                    PR1dr["PR1_Comment"] = "非定金";
                    PR1dr["PR1_RgDt"] = timeNow;
                    PR1dr["PR1_RgUser"] = m_hzyMessage.User_Name;
                    PR1dr["PR1_LmDt"] = timeNow;
                    PR1dr["PR1_LmUser"] = m_hzyMessage.User_Name;
                    PR1dr["PR1_UptNo"] = "0";

                    PR1Tabel.Rows.Add(PR1dr);

                    bResult = m_conn.Insert("B02_BILL.PR1_PaymentRequisitHead", PR1Tabel);
                }
            }
            else
            {
                DataTable uptTable = dt;
                uptTable.Columns.Remove("PR2_State");
                uptTable.Columns.Remove("PR2_Comment");
                uptTable.Columns.Remove("PR2_RgDt");
                uptTable.Columns.Remove("PR2_RgUser");

                for (int i = 0; i < dtList.Rows.Count - 1; i++)
                {
                    //根据每个SKU本次申请支付金额占所有SKU本次申请支付总额的比例,分摊资金池金额
                    double poolMoney = 0;
                    if (dblRequestAmout != 0)
                    {
                        poolMoney = isNull(dtList.Rows[i]["pr2_shareamount"].ToString()) / dblRequestAmout * dblPoolAmount;
                    }

                    double depositMoney = isNull(dtList.Rows[i]["pr2_depositmoney"].ToString()); //定金抵扣金额

                    DataRow dr = uptTable.NewRow();
                    dr["PR2_CONO"] = dtList.Rows[i]["cono"].ToString();
                    dr["PR2_DIVI"] = dtList.Rows[i]["divi"].ToString();
                    dr["PR2_RequestCode"] = strRequestCode;
                    dr["PR2_PO2_LISeq"] = dtList.Rows[i]["po2_liseq"].ToString();
                    dr["PR2_PO2_LSSeq"] = dtList.Rows[i]["po2_lsseq"].ToString();
                    dr["PR2_PO2_ProductCode"] = dtList.Rows[i]["po2_pd1_productcode"].ToString();
                    dr["PR2_ShareAmount"] = isNull(dtList.Rows[i]["pr2_shareamount"].ToString());
                    dr["PR2_PayMoney"] = isNull(dtList.Rows[i]["pr2_shareamount"].ToString()) - poolMoney - depositMoney; //支付金额
                    dr["PR2_PoolMoney"] = poolMoney;
                    dr["PR2_DepositMoney"] = depositMoney;
                    dr["PR2_LmDt"] = timeNow;
                    dr["PR2_LmUser"] = m_hzyMessage.User_Name;
                    dr["PR2_UptNo"] = 1;


                    dt.Rows.Add(dr);
                }
                ArrayList aList = new ArrayList();
                aList.Add("PR2_CONO");
                aList.Add("PR2_DIVI");
                aList.Add("PR2_RequestCode");
                aList.Add("PR2_PO2_LISeq");
                aList.Add("PR2_PO2_LSSeq");
                aList.Add("PR2_PO2_ProductCode");

                bResult = m_conn.Update("B02_BILL.PR2_PaymentRequisitDetail", dt, aList);

                //更新主表
                string upt = @" UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                SET PR1_RequestAmount=RequestAmount,PR1_PayAmount=PayAmount,PR1_PoolAmount=PoolMoney
                                FROM B02_BILL.PR1_PaymentRequisitHead WITH(NOLOCK),
	                                (SELECT PR2_CONO,PR2_DIVI,PR2_RequestCode,
		                                SUM(ISNULL(PR2_ShareAmount,0)) RequestAmount,
		                                SUM(ISNULL(PR2_PayMoney,0)) PayAmount,
		                                SUM(ISNULL(PR2_PoolMoney,0)) PoolMoney,
		                                SUM(ISNULL(PR2_DepositMoney,0)) DepositMoney
	                                FROM B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK)
	                                WHERE PR2_Comment='非定金'
	                                GROUP BY PR2_CONO,PR2_DIVI,PR2_RequestCode) PR2
                                WHERE PR1_CONO=PR2.PR2_CONO AND PR2.PR2_DIVI=PR2.PR2_DIVI AND PR1_RequestCode=PR2.PR2_RequestCode";

                m_conn.Excute(upt);

            }


            if (bResult)
            {
                m_conn.CommitTransaction();
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
            }
            else
            {
                m_conn.RollbackTransaction();
                dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
            }


            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region 付款完结(Hawk2)
        private void EndPay()
        {
            bool bResult = false;
            DataTable dtList = ds.Tables["list"];
            //string strSKUs = ""; //sku+项次+子项次
            //double deposit = 0;

            string poolMoney = "0";

            //从dtList表中的最后一行取数据
            int index = dtList.Rows.Count - 1; //最后一行
            string strjzMoney = dtList.Rows[index]["jzMoney"].ToString();//结转金额
            string strPOCode = dtList.Rows[index]["pocode"].ToString();   //获取采购单号
            string strCONO = dtList.Rows[index]["CONO"].ToString();  //cono
            string strDIVI = dtList.Rows[index]["DIVI"].ToString();  //divi
            string strSupplierCode = dtList.Rows[index]["suppliercode"].ToString();  //供应商编号
            string strCurrency = dtList.Rows[index]["po2_purchasecurrency"].ToString();  //币种

            //创建付款申请单更新表
            DataTable dtPR2 = new DataTable();
            dtPR2.Columns.Add("PR2_CONO");
            dtPR2.Columns.Add("PR2_DIVI");
            dtPR2.Columns.Add("PR2_RequestCode");
            dtPR2.Columns.Add("PR2_PO2_ProductCode");
            dtPR2.Columns.Add("PR2_PO2_LISeq");
            dtPR2.Columns.Add("PR2_PO2_LSSeq");
            dtPR2.Columns.Add("PR2_State");
            dtPR2.Columns.Add("PR2_LmDt");
            dtPR2.Columns.Add("PR2_LmUser");

            for (int i = 0; i < dtList.Rows.Count - 1; i++)
            {
                DataRow dr = dtPR2.NewRow();
                dr["PR2_CONO"] = dtList.Rows[i]["CONO"].ToString();
                dr["PR2_DIVI"] = dtList.Rows[i]["DIVI"].ToString();
                dr["PR2_RequestCode"] = dtList.Rows[i]["PR2_RequestCode"].ToString();
                dr["PR2_PO2_ProductCode"] = dtList.Rows[i]["PO2_PD1_ProductCode"].ToString();
                dr["PR2_PO2_LISeq"] = dtList.Rows[i]["PO2_LIseq"].ToString();
                dr["PR2_PO2_LSSeq"] = dtList.Rows[i]["PO2_LSSeq"].ToString();
                dr["PR2_State"] = "95";
                dr["PR2_LmDt"] = timeNow;
                dr["PR2_LmUser"] = m_hzyMessage.User_Name;

                dtPR2.Rows.Add(dr);

                //strSKUs += "'" + dtList.Rows[i]["PO2_PD1_ProductCode"].ToString() + dtList.Rows[i]["PO2_LIseq"].ToString() + dtList.Rows[i]["PO2_LSSeq"].ToString() + "',";
            }

            //strSKUs = strSKUs.Remove(strSKUs.Length - 1);
            //获取采购单各款的定金余额
            //string strGet = @"SELECT * FROM VIEW_DEPOSIT_REMAINED WHERE pocode='" + strPOCode 
            //    + "' AND PB2_PR2_ProductCode+CONVERT(VARCHAR(10),PB2_PR2_LISeq)+CONVERT(VARCHAR(10),PB2_PR2_LSSeq) IN(" + strSKUs + ")";
            //string strDeposit = m_conn.GetDataTableFirstValue(strGet).ToString();
            //if (strDeposit != "")
            //{
            //    deposit = Convert.ToDouble(strDeposit);
            //}
            //else
            //{
            //    deposit = 0;
            //}

            ArrayList aList = new ArrayList();
            aList.Add("PR2_CONO");
            aList.Add("PR2_DIVI");
            aList.Add("PR2_RequestCode");
            aList.Add("PR2_PO2_ProductCode");
            aList.Add("PR2_PO2_LISeq");
            aList.Add("PR2_PO2_LSSeq");

            m_conn.BeginTransaction();
            bResult = m_conn.Update("B02_BILL.PR2_PaymentRequisitDetail", dtPR2, aList);

            if (bResult)
            {
                if (strjzMoney != "" && strjzMoney != "0")
                {
                    string strSQL = @"
                                        UPDATE B01_MDM.SP2_SupplierPool 
                                        SET SP2_PoolAmount=SP2_PoolAmount+" + strjzMoney +
                                             ",SP2_LmDt='" + timeNow +
                                            "',SP2_LmUser='" + m_hzyMessage.User_Name +
                                            "',SP2_UptNo=SP2_UptNo+1 " +
                                        "WHERE SP2_CONO='" + strCONO +
                                                "' AND SP2_DIVI='" + strDIVI +
                                                "' AND SP2_SP1_SupplierCode='" + strSupplierCode +
                                                "' AND SP2_Currency='" + strCurrency + "'";
                    int n = m_conn.Excute(strSQL);
                    if (n == 0) //如果供应商资金池不存在
                    {
                        string addSql = @"
                                            INSERT INTO B01_MDM.SP2_SupplierPool( 
                                                      SP2_CONO ,
                                                      SP2_DIVI ,
                                                      SP2_SP1_SupplierCode ,
                                                      SP2_Currency ,
                                                      SP2_PoolAmount ,
                                                      SP2_State ,
                                                      SP2_RgUser ,
                                                      SP2_LmUser ,
                                                      SP2_UptNo
                                                    )
                                            VALUES  ( '" + strCONO + "','" + strDIVI + "','" + strSupplierCode + "','" + strCurrency + "','" + strjzMoney + "','15','" +
                                                        m_hzyMessage.User_Name + "','" + m_hzyMessage.User_Name + "',0)";
                        m_conn.Excute(addSql);
                        poolMoney = strjzMoney;
                    }
                    else if (n == 1)
                    {
                        bResult = true;
                        string strSLT = @"  SELECT SP2_PoolAmount FROM [B01_MDM].[SP2_SupplierPool] WITH(NOLOCK)
                                            WHERE SP2_CONO='" + strCONO +
                                                             "' AND SP2_DIVI='" + strDIVI +
                                                             "' AND SP2_SP1_SupplierCode='" + strSupplierCode +
                                                             "' AND SP2_Currency='" + strCurrency + "'";
                        poolMoney = m_conn.GetDataTableFirstValue(strSLT).ToString();

                    }
                    else
                    {
                        bResult = false;
                    }
                    //插入供应商资金池交易历史表
                    DataTable SP3_SupplierPoolTrans = new DataTable();
                    SP3_SupplierPoolTrans.Columns.Add("SP3_ID");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_CONO");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_DIVI");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_SP1_SupplierCode");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_Currency");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_RefCODE");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_RefType");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_TransAmount");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_SurplusAmount");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_RgDt");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_RgUser");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_LmDt");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_LmUser");
                    SP3_SupplierPoolTrans.Columns.Add("SP3_UptNo");

                    DataRow dr = SP3_SupplierPoolTrans.NewRow();

                    dr["SP3_ID"] = System.Guid.NewGuid();
                    dr["SP3_CONO"] = strCONO;
                    dr["SP3_DIVI"] = strDIVI;
                    dr["SP3_SP1_SupplierCode"] = strSupplierCode;
                    dr["SP3_Currency"] = strCurrency;
                    dr["SP3_RefCODE"] = strPOCode;
                    dr["SP3_RefType"] = "付款完结";
                    dr["SP3_TransAmount"] = strjzMoney;
                    dr["SP3_SurplusAmount"] = poolMoney;
                    dr["SP3_RgDt"] = timeNow;
                    dr["SP3_RgUser"] = m_hzyMessage.User_Name;
                    dr["SP3_LmDt"] = timeNow;
                    dr["SP3_LmUser"] = m_hzyMessage.User_Name;
                    dr["SP3_UptNo"] = "0";

                    SP3_SupplierPoolTrans.Rows.Add(dr);

                    bResult = m_conn.Insert("[B03_TRANS].[SP3_SupplierPoolTrans]", SP3_SupplierPoolTrans);

                    //更新付款申请单主表 状态
                    string uptSQL = @"
                                            UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                            SET PR1_State=myState 
                                            FROM B02_BILL.PR1_PaymentRequisitHead A WITH(NOLOCK),
	                                            (SELECT PR2_CONO,PR2_DIVI,PR2_RequestCode,MIN(PR2_State) myState
	                                            FROM B02_BILL.PR2_PaymentRequisitDetail  WITH(NOLOCK)
	                                            WHERE PR2_Comment='非定金'
	                                            GROUP BY PR2_CONO,PR2_DIVI,PR2_RequestCode) T
                                            WHERE A.PR1_CONO=T.PR2_CONO AND A.PR1_DIVI=T.PR2_DIVI AND A.PR1_RequestCode=T.PR2_RequestCode 
                                                AND PR1_Comment='非定金' AND PR1_PO1_POCode='" + strPOCode + "'";
                    m_conn.Excute(uptSQL);
                }
            }

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                m_conn.CommitTransaction();
            }

            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                m_conn.RollbackTransaction();
            }

            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region 判断是否付款
        /// <summary>
        /// 根据付款申请单号,在付款单表中找,  如果存在此付款申请单号,说明此次申请已付款,否则,则未付款
        /// </summary>
        private void IsPaid()
        {
            bool bResult = false;
            DataTable dt = ds.Tables["list"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string strSQL = @"
                                SELECT *
                                FROM B02_BILL.PB2_PaymentBillDetail WITH(NOLOCK)
                                WHERE PB2_PR2_LISeq='" + dt.Rows[i]["po2_liseq"].ToString()
                                                      + @"' AND PB2_PR2_LSSeq='" + dt.Rows[i]["po2_lsseq"].ToString()
                                                      + @"' AND PB2_DIVI='" + m_hzyMessage.Env_SN
                                                      + @"' AND PB2_Comment='非定金'"
                                                      + @" AND PB2_PR1_RequestCode='" + dt.Rows[i]["PR2_RequestCode"].ToString() + "'";
                int RCount = m_conn.GetDataTable(strSQL).Rows.Count;
                if (RCount > 0)
                {
                    bResult = true;
                    break;
                }
            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "已付款" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "未付款" });
            }

            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region isNull把空的字符转换成0
        /// <summary>
        /// isNull把空的字符转换成0
        /// </summary>
        /// <param name="strNum">要转换数字的字符串</param>
        /// <returns>double</returns>
        private double isNull(string strNum)
        {
            if (strNum.Trim() == "")
            {
                return 0;
            }
            else
            {
                return Convert.ToDouble(strNum);
            }
        }
        #endregion


        /*---------------------------------------------------------------------------------------------------------------------------------------------------*/

        /*
          #region 验证是否已经做付款申请、检验存在是否存在还未付款的付款申请单
//        private void CheckRequestIsOK()
//        {
//            string strPOCODE = ds.Tables["list"].Rows[0]["PR1_PO1_POCode"].ToString();
//            string strAPCODE = ds.Tables["list"].Rows[0]["PR1_AP1_APOCode"].ToString();
//            string strDIVI = m_hzyMessage.Env_SN;
//            string strCONO = ds.Tables["list"].Rows[0]["PR2_CONO"].ToString();
//            string strSQL = @"
//                                SELECT PR2_CONO,PR2_DIVI,PR2_RequestCode,PR1_PO1_POCode,PR1_AP1_APOCode,PR2_PO2_ProductCode,PR2_State 
//                                FROM B02_BILL.PR1_PaymentRequisitHead 
//	                                JOIN B02_BILL.PR2_PaymentRequisitDetail ON PR1_CONO=PR2_CONO AND PR1_DIVI=PR2_DIVI AND PR1_RequestCode=PR2_RequestCode
//                                WHERE 1=1 AND PR2_Comment<>'定金' AND PR2_CONO='" + strCONO + "' AND PR2_DIVI='" + strDIVI + "' AND PR1_PO1_POCode='" + strPOCODE + "' AND PR1_AP1_APOCode='"
//                                                              + strAPCODE + "' AND PR2_State='15'";
//            DataTable dt = m_conn.GetDataTable(strSQL);
//            if (dt.Rows.Count > 0)
//            {
//                dt_EditResult.Rows.Add(new object[] { true, "存在还未付款" });
//            }
//            else
//            {
//                dt_EditResult.Rows.Add(new object[] { false, "不存在未付款的付款申请单" });
//            }
//            ds_Return.Tables.Add(dt_EditResult);
//        }
        #endregion
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
            string strDIVI = m_hzyMessage.Env_SN; //获取事业体
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
                                                                  WHERE     t1.PO1_POCode = t4.PR1_PO1_POCode AND t4.PR1_DIVI=@param0
                                                                ) 累计申请金额 ,
                                                                ( SELECT    ISNULL(SUM(t5.PB1_PaymentDeductionAmount), 0)
                                                                  FROM      [B02_BILL].PB1_PaymentBill t5
                                                                  WHERE     t5.PB1_PayBillCode = t9.PR1_RequestCode
                                                                            AND t9.PR1_PO1_POCode = t1.PO1_POCode AND t5.PB1_DIVI=@param0
                                                                ) 累计抵扣金额 ,
                                                                ( SELECT    ISNULL(PR1_TotalAmount, 0)
                                                                  FROM      ( SELECT    ROW_NUMBER() OVER ( ORDER BY PR1_RgDt DESC ) AS a ,
                                                                                        *
                                                                              FROM      [B02_BILL].[PR1_PaymentRequisit]
                                                                              WHERE     t1.PO1_POCode = PR1_PO1_POCode
                                                                                        AND PR1_State < 85 AND PR1_DIVI=@param0
                                                                            ) g
                                                                  WHERE     a = 1
                                                                ) 当前申请金额 ,
                                                                ( SELECT    CASE WHEN PR1_State < 85 THEN '申请中'
                                                                                 WHEN PR1_State > 85 THEN '已付款'
                                                                            END PR1_State
                                                                  FROM      ( SELECT    ROW_NUMBER() OVER ( ORDER BY PR1_RgDt DESC ) AS a ,
                                                                                        *
                                                                              FROM      [B02_BILL].[PR1_PaymentRequisit]
                                                                              WHERE     t1.PO1_POCode = PR1_PO1_POCode AND PR1_DIVI='LX'
                                                                            ) g
                                                                  WHERE     a = 1
                                                                ) 付款状态 ,
                                                                ( SELECT    ISNULL(SUM(t8.PB1_PaymentTotalAmount), 0)
                                                                  FROM      [B02_BILL].[PB1_PaymentBill] t8
                                                                  WHERE     t9.PR1_RequestCode = t8.PB1_PR1_RequestCode AND t8.PB1_DIVI=@param0
                                                                ) 已付金额 ,
                                                                ( SELECT    t1.PO1_OCurrencySums
                                                                            - SUM(t10.PB1_PaymentTotalAmount)
                                                                  FROM      [B02_BILL].[PB1_PaymentBill] t10
                                                                  WHERE     t9.PR1_RequestCode = t10.PB1_PR1_RequestCode
                                                                            AND t1.PO1_POCode = t9.PR1_PO1_POCode AND t10.PB1_DIVI=@param0
                                                                ) 未付金额 ,
                                                                '' 未入库金额 ,
                                                                '' 结转金额 ,
                                                                '' 退货件数 ,
                                                                '' 付款状态PO ,
                                                                '' 退货金额 ,
                                                                t10.PB1_PayBillCode
                                                      FROM      [B02_BILL].[PO1_POHead] t1
                                                                LEFT JOIN [B01_MDM].[BR1_Brand] t2 ON t1.PO1_BR1_BrandCode = t2.BR1_BrandCode AND t1.PO1_DIVI=t2.BR1_DIVI
                                                                LEFT JOIN [M01_CONF].[CT0_CSYTAB] t3 ON t1.PO1_Currency = t3.CT1_KeyID
                                                                                                        AND t3.ct1_code = 'CUCD' AND t1.PO1_DIVI=t3.CT1_DIVI
                                                                LEFT JOIN [B02_BILL].[PR1_PaymentRequisit] t9 ON t1.PO1_POCode = t9.PR1_PO1_POCode AND t1.PO1_DIVI=t9.PR1_DIVI
                                                                LEFT JOIN [B02_BILL].PB1_PaymentBill t10 ON T1.PO1_POCode = t9.PR1_PO1_POCode AND t1.PO1_DIVI=t10.PB1_DIVI
                                                                                                          AND t9.PR1_RequestCode = t10.PB1_PR1_RequestCode  and t10.PB1_State < 99
                                                    ) t12
                                            WHERE   1 = 1
                                                    AND PO1_LState >= 35
                                                    AND PO1_HState >= 35 
                                                    AND PO1_DIVI=@param0" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { strDIVI }, m_hzyPageInfo);
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
            string strDIVI = m_hzyMessage.Env_SN;

            string strPR1_PO1_POCode = ds.Tables["list"].Rows[0]["pr1_po1_pocode"].ToString();//获取采购单号
            string strPR1_RequestCode = ds.Tables["list"].Rows[0]["pr1_requestcode"].ToString();//取付款单号
            string sreMAXPB1_PR1_RequestCode = "";
            //判断付款单是否存在如果不存在就新增
            if (strPR1_RequestCode == "")
            {
                //获取此采购单最大号付款申请单号
                sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, strDIVI, "", m_conn);
                ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;
                ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name;
                ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name;
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
                                                        AND PR1_PO1_POCode = '" + strPR1_PO1_POCode + "' AND PR1_DIVI='" + strDIVI + "'").ToString();
                if (strCheckPR1_RequestCode == "")
                {
                    //检查数据库最新数据的付款申请单总金额是否为0
                    string strCheckPR1_State = m_conn.GetDataTableFirstValue(@"
                                    SELECT  [PR1_State] FROM  
                                            [B02_BILL].[PR1_PaymentRequisit]
                                            WHERE   PR1_State = 85  
                                                        AND PR1_RequestCode = '" + strPR1_RequestCode + "' AND PR1_DIVI='" + strDIVI + "'").ToString();
                    //如果为0.说明没有总金额为0的，直接最大号加1.
                    if (strCheckPR1_State != "")
                    {
                        sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, strDIVI, "", m_conn);
                        ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;
                        ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name;
                        ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name;
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
                    m_conn.Delete("[B02_BILL].[PR1_PaymentRequisit]", "PR1_RequestCode=" + "'" + strCheckPR1_RequestCode + "' AND PR1_DIVI='" + strDIVI + "'");
                    //传入类型，生成最大号
                    sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, strDIVI, "", m_conn);
                    ds.Tables["List"].Rows[0]["pr1_requestcode"] = sreMAXPB1_PR1_RequestCode;//赋值最大付款单号
                    ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name;//更新人
                    ds.Tables["List"].Rows[0]["pr1_rguser"] = hzyMessage.User_Name;//创建人
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
            ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name;//系统登入人
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
                ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name;
                ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name;
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
                        ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name;
                        ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name;
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
                    ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name;
                    ds.Tables["List"].Rows[0]["pb1_rguser"] = hzyMessage.User_Name;
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
            string strDIVI = m_hzyMessage.Env_SN; //取事业体

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
            ds.Tables["list"].Columns.Remove("divi"); //获取事业体后立即删除  保持原代码

            DateTime timeNow = DateTime.Now;
            //跟新付款申请单状态
            DataTable dtPR1_PaymentRequisit = new DataTable();
            dtPR1_PaymentRequisit.Columns.Add("PR1_State");
            dtPR1_PaymentRequisit.Columns.Add("PR1_LmDt");
            dtPR1_PaymentRequisit.Columns.Add("PR1_LmUser");
            DataRow drPR1_PaymentRequisit = dtPR1_PaymentRequisit.NewRow();
            drPR1_PaymentRequisit["PR1_LmUser"] = hzyMessage.User_Name;
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
            ds.Tables["List"].Rows[0]["pb1_lmuser"] = hzyMessage.User_Name;
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
            if (strSP2_PoolAmount == "" && strPB1_PaymentDeductionAmount == "")
            {
                strSP2_PoolAmount = "0";
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
            drSP2_SupplierPool["SP2_LmUser"] = hzyMessage.User_Name;
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
                                                'HYFG' SP3_CONO ,
                                                @Param1 SP3_DIVI ,
                                                @Param2 SP3_SP1_SupplierCode,
                                                @Param3 SP3_Currency ,
                                                @Param4 SP3_RefCODE ,
                                                @Param5 SP3_RefType ,
                                                @Param6 SP3_TransAmount ,
                                                @Param7 SP3_SurplusAmount,
                                                @Param8  SP3_RgDt,
										        @Param9   SP3_RgUser,
										        @Param10   SP3_LmDt,
										        @Param11   SP3_LmUser
                                    )";
                m_conn.ExcuteQuerryByTran(strSQLForSP3_SupplierPoolTrans, new string[] { 
                                    strGuidForSP3_SupplierPoolTrans,strDIVI,strSP2_SP1_SupplierCode,strSP2_Currency,strPOcode,"采购单","-"+ strPB1_PaymentDeductionAmount,
                                nUpdateSP2_PoolAmount.ToString(),timeNow.ToString(),hzyMessage.User_Name,
                                timeNow.ToString(),hzyMessage.User_Name });
            }
            //更新采购单，付款状态改为未付款
            string strSQLForEndPO1_POHead = @" 
                                            UPDATE  [B02_BILL].[PO1_POHead]
                                            SET     PO1_PayState = '未完结' ,
                                                    PO1_LmDt = @Param0 ,
                                                    PO1_LmUser = @Param1
                                            WHERE   PO1_POCode = @Param2
                                                    AND PO1_HState != '99'
                                                    AND PO1_LState != '99'
                                                    AND PO1_DIVI = @Param3";
            m_conn.ExcuteQuerryByTran(strSQLForEndPO1_POHead, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name,strPOcode,strDIVI});

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
            ds.Tables["List"].Rows[0]["pr1_lmuser"] = hzyMessage.User_Name;//给跟新人附上后台登入姓名
            ds.Tables["List"].Rows[0]["pr1_lmdt"] = timeNow;//给更新时间附上本地时间
            bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisit]", ds.Tables["List"], "pr1_requestcode=" + "'" + strPR1_RequestCode + "'");

            //如果删除付款申请单，付款单相应的也要删除
            DataTable dsPaymentBill = new DataTable();
            dsPaymentBill.Columns.Add("PB1_LmDt");
            dsPaymentBill.Columns.Add("PB1_LmUser");
            dsPaymentBill.Columns.Add("PB1_State");
            DataRow drPaymentBill = dsPaymentBill.NewRow();

            drPaymentBill["PB1_LmDt"] = timeNow;//给更新时间附上本地时间
            drPaymentBill["PB1_LmUser"] = hzyMessage.User_Name;//给跟新人附上后台登入姓名;
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
            string strDIVI = m_hzyMessage.Env_SN; //获取事业体
            ds.Tables["list"].Columns.Remove("divi");

            //更新付款申请单
            string strSQLForEndPR1_PaymentRequisit = @" 
                                                        UPDATE  [B02_BILL].[PR1_PaymentRequisit]
                                                        SET     PR1_State = '85' ,
                                                                PR1_LmDt = @Param0 ,
                                                                PR1_LmUser = @Param1
                                                        WHERE   PR1_PO1_POCode = @Param2
                                                                AND PR1_State != '99' 
                                                                AND PR1_DIVI = @Param3";
            m_conn.ExcuteQuerryByTran(strSQLForEndPR1_PaymentRequisit, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name,strPr1_Po1_PoCode,strDIVI});

            //更新付款单
            string strSQLForEndPB1_PaymentBill = @" 
                                                        UPDATE  [B02_BILL].[PB1_PaymentBill]
                                                        SET     PB1_State = '85' ,
                                                                PB1_LmDt = @Param0 ,
                                                                PB1_LmUser = @Param1
                                                       WHERE PB1_PR1_RequestCode LIKE '%@Param2%' AND PB1_State != '99'
                                                                AND PB1_State != '99' AND PB1_DIVI = @Param2";
            m_conn.ExcuteQuerryByTran(strSQLForEndPB1_PaymentBill, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name,strPr1_Po1_PoCode,strDIVI});
            //更新采购单
            string strSQLForEndPO1_POHead = @" 
                                                        UPDATE  [B02_BILL].[PO1_POHead]
                                                        SET     PO1_PayState = '已完结' ,
                                                                PO1_LmDt = @Param0 ,
                                                                PO1_LmUser = @Param1
                                                        WHERE   PO1_POCode = @Param2
                                                                AND PO1_HState != '99'
                                                                AND PO1_LState != '99'
                                                                AND PO1_DIVI = @Param3";
            m_conn.ExcuteQuerryByTran(strSQLForEndPO1_POHead, new string[] { 
                    timeNow.ToString(),hzyMessage.User_Name,strPr1_Po1_PoCode,strDIVI});

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
                                                  WHERE   SP2_SP1_SupplierCode = '" + strSP2_SP1_Suppliercode + "' AND SP2_Currency = '" + strSP2_Currency + "' AND SP2_DIVI='" + strDIVI + "'").ToString();


                if (strSP2_PoolAmount == "")
                {
                    strSP2_PoolAmount = "0";
                }
                decimal nUpdateSP2_PoolAmount = Convert.ToDecimal(strSP2_PoolAmount) + Convert.ToDecimal(strUnrptotalAmount);

                //查询资金池中是否已有此供应商
                string strCHKSQL = @" SELECT  COUNT(*) FROM [Hawk].[B01_MDM].[SP2_SupplierPool] WHERE SP2_SP1_Suppliercode='" + strSP2_SP1_Suppliercode + "'";
                int intCHK = m_conn.GetDataTableRowCount(strCHKSQL);
                if (intCHK == 0) // 资金池表中没有供应商 则 新增供应商  俞佳伟2015-01-21添加
                {
                    string strGuidForSP2_SupplierPoolTrans = System.Guid.NewGuid().ToString();
                    string strINSQL = @"  INSERT INTO [B01_MDM].[SP2_SupplierPool] 
                                                        ([SP2_ID]
			                                            ,[SP2_CONO]
			                                            ,[SP2_DIVI]
			                                            ,[SP2_SP1_SupplierCode]
			                                            ,[SP2_Currency]
			                                            ,[SP2_PoolAmount]
			                                            ,[SP2_State]
			                                            ,[SP2_RgDt]
			                                            ,[SP2_RgUser]
			                                            ,[SP2_LmDt]
			                                            ,[SP2_LmUser]
			                                            ,[SP2_UptNo])
                                                     (SELECT   
                                                               @Param0 SP2_ID
                                                              ,'HYFG'  SP2_CONO
                                                              ,@Param1 SP2_DIVI
                                                              ,@Param2 SP2_SP1_SupplierCode
                                                              ,@Param3 SP2_Currency
                                                              ,@Param4 SP2_PoolAmount
                                                              ,@Param5 SP2_State
                                                              ,@Param6 SP2_RgDt
                                                              ,@Param7 SP2_RgUser
                                                              ,@Param8 SP2_LmDt
                                                              ,@Param9 SP2_LmUser
                                                              ,@Param10 SP2_UptNo) ";
                    m_conn.ExcuteQuerryByTran(strINSQL, new string[] { 
                                    strGuidForSP2_SupplierPoolTrans,strDIVI,strSP2_SP1_Suppliercode,strSP2_Currency,nUpdateSP2_PoolAmount.ToString(),"20",
                                timeNow.ToString(),hzyMessage.User_Name,timeNow.ToString(),hzyMessage.User_Name,"0" });
                }

                //构造跟新资金池数据的表，供应商编号，币种，跟新时间，跟新人，最新资金池金额
                DataTable dtSP2_SupplierPool = new DataTable();
                dtSP2_SupplierPool.Columns.Add("SP2_SP1_SupplierCode");
                dtSP2_SupplierPool.Columns.Add("SP2_Currency");
                dtSP2_SupplierPool.Columns.Add("SP2_LmDt");
                dtSP2_SupplierPool.Columns.Add("SP2_LmUser");
                dtSP2_SupplierPool.Columns.Add("SP2_PoolAmount");
                DataRow drSP2_SupplierPool = dtSP2_SupplierPool.NewRow();
                drSP2_SupplierPool["SP2_LmUser"] = hzyMessage.User_Name;
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
                                                'HYFG'  SP3_CONO ,
                                                @Param1 SP3_DIVI ,
                                                @Param2 SP3_SP1_SupplierCode,
                                                @Param3 SP3_Currency ,
                                                @Param4 SP3_RefCODE ,
                                                @Param5 SP3_RefType ,
                                                @Param6 SP3_TransAmount ,
                                                @Param7 SP3_SurplusAmount,
                                                @Param8 SP3_RgDt,
										        @Param9 SP3_RgUser,
										        @Param10 SP3_LmDt,
										        @Param11 SP3_LmUser
                                    )";
                m_conn.ExcuteQuerryByTran(strSQLForSP3_SupplierPoolTrans, new string[] { 
                                    strGuidForSP3_SupplierPoolTrans,strSP2_SP1_Suppliercode,strSP2_Currency,strPr1_Po1_PoCode,"采购单结案", strUnrptotalAmount,
                                nUpdateSP2_PoolAmount.ToString(),timeNow.ToString(),hzyMessage.User_Name,
                                timeNow.ToString(),hzyMessage.User_Name });

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

        #region EditPaymentRequisit付款申请单(Hawk2集团版)
        /// <summary>
        /// EditPaymentRequisit付款申请单(Hawk2集团版)
        /// yjw
        /// </summary>
        private void EditPaymentRequisit()
        {
            bool bResult = false;
            DataTable dtList = ds.Tables["list"]; //list中 第一行为主表数据
            string strPR1_PO1_POCode = dtList.Rows[0]["PR1_PO1_POCode"].ToString();//采购单号
            string strDIVI = m_hzyMessage.Env_SN;
            double pomoney = Convert.ToDouble(dtList.Rows[0]["pomoney"].ToString()); //采购单采购金额
            double paymoney = Convert.ToDouble(dtList.Rows[0]["paymoney"].ToString()); //定金支付总额
            double ratio = paymoney / pomoney; //定金支付比例
            double applyMoney = Convert.ToDouble(dtList.Rows[0]["PR1_PayAmount"].ToString()); //申请支付金额
            double usePoolMoney = Convert.ToDouble(dtList.Rows[0]["PR1_PoolAmount"].ToString());//使用资金池金额
            m_conn.LockTableList.Add("[B02_BILL].[PR1_PaymentRequisitHead]");//锁表
            m_conn.LockTableList.Add("[B02_BILL].[PR2_PaymentRequisitDetail]");
            string strGuid = System.Guid.NewGuid().ToString();//取GUID
            string sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, strDIVI, "", m_conn);
            m_conn.BeginTransaction();

            DataTable dtPRhead = CreatTable("PR1_PaymentRequisitHead"); //创建付款申请单主表
            dtPRhead.Rows[0]["PR1_ID"] = strGuid;
            dtPRhead.Rows[0]["PR1_CONO"] = "HYFG";
            dtPRhead.Rows[0]["PR1_DIVI"] = dtList.Rows[0]["PR1_DIVI"].ToString();
            dtPRhead.Rows[0]["PR1_RequestCode"] = sreMAXPB1_PR1_RequestCode; //付款申请单号
            dtPRhead.Rows[0]["PR1_PO1_POCode"] = dtList.Rows[0]["PR1_PO1_POCode"].ToString(); //采购单号
            dtPRhead.Rows[0]["PR1_PO1_SPPOCode"] = dtList.Rows[0]["PR1_PO1_SPPOCode"].ToString();//供应商采购单编号
            dtPRhead.Rows[0]["PR1_AP1_APOCode"] = dtList.Rows[0]["PR1_AP1_APOCode"].ToString();//到货计划单号
            dtPRhead.Rows[0]["PR1_RequestAmount"] = dtList.Rows[0]["PR1_RequestAmount"].ToString();//申请金额
            dtPRhead.Rows[0]["PR1_PayAmount"] = dtList.Rows[0]["PR1_PayAmount"].ToString();//支付金额
            dtPRhead.Rows[0]["PR1_PoolAmount"] = dtList.Rows[0]["PR1_PoolAmount"].ToString();//使用资金池金额
            dtPRhead.Rows[0]["PR1_PaymentRatio"] = ratio;//定金比例
            dtPRhead.Rows[0]["PR1_PO1_Currency"] = dtList.Rows[0]["PR1_PO1_Currency"].ToString();//币种
            dtPRhead.Rows[0]["PR1_State"] = "已申请";
            dtPRhead.Rows[0]["PR1_Comment"] = "定金";
            dtPRhead.Rows[0]["PR1_RgDt"] = timeNow;
            dtPRhead.Rows[0]["PR1_RgUser"] = hzyMessage.User_Name;
            dtPRhead.Rows[0]["PR1_LmDt"] = timeNow;
            dtPRhead.Rows[0]["PR1_LmUser"] = hzyMessage.User_Name;
            dtPRhead.Rows[0]["PR1_UptNo"] = "0";

            bResult = m_conn.Insert("[B02_BILL].[PR1_PaymentRequisitHead]", dtPRhead);
            if (dtList.Rows.Count > 1) //新建
            {
                if (bResult)
                {
                    DataTable dtPRdetail = CreatTable("PR2_PaymentRequisitDetail");
                    for (int i = 0; i < dtList.Rows.Count - 1; i++)
                    {
                        dtPRdetail.Rows[i]["PR2_ID"] = System.Guid.NewGuid().ToString();//取GUID
                        dtPRdetail.Rows[i]["PR2_CONO"] = "HYFG";
                        dtPRdetail.Rows[i]["PR2_DIVI"] = dtList.Rows[i]["PR2_DIVI"].ToString();
                        dtPRdetail.Rows[i]["PR2_RequestCode"] = sreMAXPB1_PR1_RequestCode;  //付款申请单号
                        dtPRdetail.Rows[i]["PR2_PO2_LISeq"] = dtList.Rows[i]["PR2_PO2_LISeq"].ToString();
                        dtPRdetail.Rows[i]["PR2_PO2_LSSeq"] = dtList.Rows[i]["PR2_PO2_LSSeq"].ToString();
                        dtPRdetail.Rows[i]["PR2_PO2_ProductCode"] = dtList.Rows[i]["PR2_PO2_ProductCode"].ToString();
                        dtPRdetail.Rows[i]["PR2_ShareAmount"] = Convert.ToDouble(dtList.Rows[i]["PO2_OCurrencyAMount"].ToString()) / pomoney * paymoney;  //SKU定金分摊金额=定金支付总金额*（SKU采购金额/总采购金额）
                        dtPRdetail.Rows[i]["PR2_PayMoney"] = Convert.ToDouble(dtList.Rows[i]["PO2_OCurrencyAMount"].ToString()) / pomoney * paymoney - usePoolMoney * ratio; //SKU支付金额=SKU定金分摊金额-SKU使用资金池金额
                        dtPRdetail.Rows[i]["PR2_PoolMoney"] = usePoolMoney * ratio;//使用资金池金额=总使用资金池金额*(定金支付总金额/采购单总金额)
                        //dtPRdetail.Rows[i]["PR2_DepositMoney"] = paymoney * ratio; //使用定金金额=定金支付总金额*(定金支付总金额/采购单总金额)
                        dtPRdetail.Rows[i]["PR2_State"] = "已申请";
                        dtPRdetail.Rows[i]["PR2_Comment"] = "定金";
                        dtPRdetail.Rows[i]["PR2_RgDt"] = timeNow;
                        dtPRdetail.Rows[i]["PR2_RgUser"] = hzyMessage.User_Name;
                        dtPRdetail.Rows[i]["PR2_LmDt"] = timeNow;
                        dtPRdetail.Rows[i]["PR2_LmUser"] = hzyMessage.User_Name;
                        dtPRdetail.Rows[i]["PR2_UptNo"] = "0";

                    }
                    bResult = m_conn.Insert("[B02_BILL].[PR2_PaymentRequisitDetail]", dtPRhead);
                }
            }
            else //修改定金
            {
                string strUptSQL = string.Format(@"
                                    UPDATE B02_BILL.PR2_PaymentRequisitDetail
                                        SET PR2_ShareAmount=T.PO2_OCurrencyAmount*{0},PR2_PoolMoney={1}*{2},PR2_PayMoney=T.PO2_OCurrencyAmount*{3}-{4}*{5} FROM (
                                        SELECT D.PO2_POCode,B.PR1_RequestCode,A.PR2_PO2_ProductCode,D.PO2_OCurrencyAmount 
                                        FROM  B02_BILL.PR2_PaymentRequisitDetail A 
	                                        JOIN B02_BILL.PR1_PaymentRequisitHead B ON A.PR2_RequestCode=B.PR1_RequestCode
	                                        JOIN B02_BILL.PO1_POHead C ON B.PR1_PO1_POCode=C.PO1_POCode
	                                        JOIN B02_BILL.PO2_PODetail D ON D.PO2_POCode=C.PO1_POCode AND D.PO2_PD1_ProductCode=A.PR2_PO2_ProductCode
                                        WHERE D.PO2_POCode='') T
                                        WHERE T.PR2_PO2_ProductCode=B02_BILL.PR2_PaymentRequisitDetail.PR2_PO2_ProductCode
                                    ", ratio, usePoolMoney, ratio, ratio, usePoolMoney, ratio);
                m_conn.Excute(strUptSQL); //, new string[] { ratio, usePoolMoney }
            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "申请成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "申请失败" });
            }

        }


        #endregion

        #region GetData获取各种付款单数据(Hawk2集团版)
        private void GetPR1_PaymentRequisit()
        {
            string strPOcode = ds.Tables["list"].Rows[0]["pocode"].ToString();
            string strDIVI = m_hzyMessage.Env_SN;
            string strSQL = @"
                                SELECT [PR1_ID]
                                      ,[PR1_CONO]
                                      ,[PR1_DIVI]
                                      ,[PR1_RequestCode]
                                      ,[PR1_PO1_POCode]
                                      ,[PR1_PO1_SPPOCode]
                                      ,[PR1_AP1_APOCode]
                                      ,[PR1_RequestAmount]
                                      ,[PR1_PayAmount]
                                      ,[PR1_PoolAmount]
                                      ,[PR1_PaymentRatio]
                                      ,[PR1_PO1_Currency]
                                      ,[PR1_State]
                                      ,[PR1_Comment]
                                      ,[PR1_RgDt]
                                      ,[PR1_RgUser]
                                      ,[PR1_LmDt]
                                      ,[PR1_LmUser]
                                      ,[PR1_UptNo]
                                  FROM [Hawk].[B02_BILL].[PR1_PaymentRequisitHead]
                                  WHERE 1=1 AND PR1_PO1_POCode='" + strPOcode + "' AND PR1_DIVI='" + strDIVI + "'";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion


        #region Refund退款(Hawk2)
        private void Refund()
        {
            string strPOcode = ds.Tables["list"].Rows[0]["pocode"].ToString();
            string strDIVI = m_hzyMessage.Env_SN;
            string strPaymentCode = GetApplyPayCode(strPOcode, strDIVI);//获取付款申请单号 

            //构造交易历史表
            DataTable dtTransaction = new DataTable();
            dtTransaction.Columns.Add("TS1_ID");
            dtTransaction.Columns.Add("TS1_CONO");
            dtTransaction.Columns.Add("TS1_DIVI");
            dtTransaction.Columns.Add("TS1_Seq");
            dtTransaction.Columns.Add("TS1_TransType");
            dtTransaction.Columns.Add("TS1_WH1_WareHouseCode");
            dtTransaction.Columns.Add("TS1_SA1_LocationCode");
            dtTransaction.Columns.Add("TS1_PD1_ProductCode");
            dtTransaction.Columns.Add("TS1_TransNumber");
            dtTransaction.Columns.Add("TS1_BNumber");
            dtTransaction.Columns.Add("TS1_ANumber");
            dtTransaction.Columns.Add("TS1_TransCurrency");
            dtTransaction.Columns.Add("TS1_SupplierTax");
            dtTransaction.Columns.Add("TS1_TransDPrice");
            dtTransaction.Columns.Add("TS1_TransDAMount");
            dtTransaction.Columns.Add("TS1_TransDTaxPrice");
            dtTransaction.Columns.Add("TS1_TransDTaxAmount");

        }
        #endregion

        #region GetApplyPayCode根据采购单号获取付款申请单号(hawk2集团版)
        /// <summary>
        /// 根据采购单号获取付款申请单号
        /// </summary>
        /// <param name="strpocode">采购单号</param>
        /// <param name="strDIVI">环境</param>
        /// <returns>付款单号</returns>
        private string GetApplyPayCode(string strpocode, string strDIVI)
        {
            string strSQL = @"
                                SELECT PR1_RequestCode
                                FROM B02_BILL.PR1_PaymentRequisitHead
                                WHERE PR1_PO1_POCode='" + strpocode + "' AND PR1_DIVI='" + strDIVI + "'";
            string strPaymentCode = m_conn.GetDataTableFirstValue(strSQL).ToString(); //获取付款申请单号
            return strPaymentCode;
        }
        #endregion


        #region GetDeposit获取定金付款数据
        private void GetDeposit()
        {
            string strSQL = @" 
                                SELECT [PR2_CONO]
                                        ,[PR2_DIVI]
                                        ,[PR2_RequestCode]
                                        ,SUM(ISNULL([PR2_ShareAmount],0)) ShareAmountSUM
                                        ,SUM(ISNULL([PR2_PayMoney],0)) PayMoneySUM
                                        ,SUM(ISNULL([PR2_PoolMoney],0)) PoolMoneySUM INTO #TB  
                                FROM [Hawk].[B02_BILL].[PR2_PaymentRequisitDetail]
                                WHERE [PR2_State]='15' AND [PR2_Comment]='定金'
                                GROUP BY [PR2_CONO],[PR2_DIVI],[PR2_RequestCode]
  
                                UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                SET PR1_RequestAmount=ShareAmountSUM,
		                            PR1_PayAmount=PayMoneySUM,
		                            PR1_PoolAmount=PoolMoneySUM
                                FROM B02_BILL.PR1_PaymentRequisitHead PR1,#TB 
                                WHERE PR1.PR1_RequestCode=#TB.PR2_RequestCode 
		                            AND PR1.PR1_CONO=#TB.PR2_CONO
		                            AND PR1.PR1_DIVI=#TB.PR2_DIVI

                                SELECT  PO1_POCode,
	                                    BR1_Name,
	                                    PO1_PC1_ContractCode,
	                                    PO1_SPPOCode,
	                                    PO1_SupplierCode,
	                                    SP1_Name,
	                                    PO1_PZNumber,
	                                    PO1_Currency,
	                                    PO1_OCurrencySums,
	                                    PO1_PaymentTypeName ,
	                                    PO1_PaymentChannelName,
	                                    PR1_RequestCode,
	                                    PR1_RequestAmount,
	                                    PR1_PayAmount,
	                                    PR1_PoolAmount,
	                                    PR1_PaymentRatio,
	                                    PR1_State,
	                                    PO1_RgUser,
                                        PO1_DIVI
                                FROM B02_BILL.PO1_POHead A with(nolock)
	                                LEFT JOIN B02_BILL.PR1_PaymentRequisitHead B with(nolock) ON A.PO1_POCode=B.PR1_PO1_POCode AND A.PO1_DIVI=B.PR1_DIVI
	                                JOIN B01_MDM.SP1_Supplier C with(nolock) ON A.PO1_SupplierCode=C.SP1_SupplierCode AND A.PO1_DIVI=C.SP1_DIVI
                                    JOIN B01_MDM.BR1_Brand D with(nolock) ON A.PO1_BR1_BrandCode=D.BR1_BrandCode AND A.PO1_DIVI=D.BR1_DIVI
                                WHERE 1=1 AND PO1_LState<>99 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region GetDepositDetail获取定金付款明细数据(Hawk2集团版)
        /// <summary>
        /// GetDepositDetail获取定金付款明细数据
        /// </summary>
        private void GetDepositDetail()
        {
            string strSQL = @"
                                SELECT [PR2_ID]
                                      ,[PR2_CONO]
                                      ,[PR2_DIVI]
                                      ,[PR2_RequestCode]
                                      ,[PR2_PO2_LISeq]
                                      ,[PR2_PO2_LSSeq]
                                      ,[PR2_PO2_ProductCode]
                                      ,[PO2_PD1_SupperierStyle]
                                      ,[PO2_PD1_SupperierColor]
                                      ,[PO2_PD1_SupperierSize]
                                      ,[PO2_OCurrencyAMount]
                                      ,[PO2_Number]
                                      ,[PR2_ShareAmount]
                                      ,[PR2_PayMoney]
                                      ,[PR2_PoolMoney]
                                      ,[PR2_State]
                                      ,[PR2_Comment]
                                      ,[PR2_RgDt]
                                      ,[PR2_RgUser]
                                      ,[PR2_LmDt]
                                      ,[PR2_LmUser]
                                      ,[PR2_UptNo]
                                  FROM [Hawk].[B02_BILL].[PR2_PaymentRequisitDetail] A with(nolock)
                                        JOIN [Hawk].[B02_BILL].[PR1_PaymentRequisitHead] WITH(NOLOCK) ON PR2_RequestCode=PR1_RequestCode AND PR2_CONO=PR1_CONO AND PR2_DIVI=PR1_DIVI
                                        JOIN [B02_BILL].[PO2_PODetail] B with(nolock) ON PR1_PO1_POCode=PO2_POCode AND A.PR2_PO2_ProductCode=B.PO2_PD1_ProductCode AND A.PR2_DIVI=B.PO2_DIVI AND PR2_PO2_LISeq=PO2_LISeq AND PR2_PO2_LSSeq=PO2_LSSeq
                                  WHERE 1=1 AND PO2_State>=35 AND PO2_State<=75" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }
        #endregion

        #region EditPaymentRequest付款申请单新增、维护
        /// <summary>
        /// EditPaymentRequest付款申请单新增、维护
        /// </summary>
        private void EditPaymentRequest()
        {
            bool bResult = false;

            DataTable dtList = ds.Tables["list"];
            string strRequestCode = dtList.Rows[0]["pr1_requestcode"].ToString(); //获取付款申请单号
            string strPR1_PO1_POCode = dtList.Rows[0]["po1_pocode"].ToString();//采购单号
            string strGuid = System.Guid.NewGuid().ToString();//取GUID
            string strDIVI = m_hzyMessage.Env_SN;
            double pr1_poolamount = Convert.ToDouble(dtList.Rows[0]["pr1_poolamount"].ToString());
            double po1_ocurrencysums = Convert.ToDouble(dtList.Rows[0]["po1_ocurrencysums"].ToString());  //采购金额
            double pr1_requestamount = Convert.ToDouble(dtList.Rows[0]["pr1_requestamount"].ToString());  //定金
            double ratio = pr1_requestamount / po1_ocurrencysums; //定金比例

            DataTable dt = CreatTable("PR1_PaymentRequisitHead");
            m_conn.BeginTransaction();
            if (strRequestCode == "") //新增
            {
                string sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单", strPR1_PO1_POCode, strDIVI, "", m_conn);
                string strSQL1 = @"SELECT [AP1_APCode] FROM [Hawk].[B02_BILL].[AP1_APOHead] WHERE AP1_PO1_PurchaseCode='" + strPR1_PO1_POCode + "' AND AP1_DIVI='" + strDIVI + "'";
                string strAP1_APCode = m_conn.GetDataTableFirstValue(strSQL1).ToString(); //获取到货计划

                DataRow dr = dt.NewRow();
                dr["PR1_ID"] = strGuid;
                dr["PR1_CONO"] = "HYFG";
                dr["PR1_DIVI"] = strDIVI;
                dr["PR1_RequestCode"] = sreMAXPB1_PR1_RequestCode; //付款申请单号
                dr["PR1_PO1_POCode"] = dtList.Rows[0]["po1_pocode"].ToString(); //采购单号
                dr["PR1_PO1_SPPOCode"] = dtList.Rows[0]["po1_sppocode"].ToString();//供应商采购单编号
                dr["PR1_AP1_APOCode"] = strAP1_APCode;//到货计划单号
                dr["PR1_RequestAmount"] = dtList.Rows[0]["PR1_RequestAmount"].ToString();//申请金额
                dr["PR1_PayAmount"] = dtList.Rows[0]["PR1_PayAmount"].ToString();//支付金额
                dr["PR1_PoolAmount"] = dtList.Rows[0]["PR1_PoolAmount"].ToString();//使用资金池金额
                dr["PR1_PaymentRatio"] = ratio;//定金比例
                dr["PR1_PO1_Currency"] = dtList.Rows[0]["PO1_Currency"].ToString();//币种
                dr["PR1_State"] = "15";
                dr["PR1_Comment"] = "定金";
                dr["PR1_RgDt"] = timeNow;
                dr["PR1_RgUser"] = hzyMessage.User_Name;
                dr["PR1_LmDt"] = timeNow;
                dr["PR1_LmUser"] = hzyMessage.User_Name;
                dr["PR1_UptNo"] = "0";
                dt.Rows.Add(dr);
                bResult = m_conn.Insert("[B02_BILL].[PR1_PaymentRequisitHead]", dt);
                if (bResult)
                {
                    bResult = UpdatePaymentRequisitDetail(strPR1_PO1_POCode, sreMAXPB1_PR1_RequestCode, ratio, pr1_poolamount, pr1_requestamount, strDIVI, "insert");
                    if (!bResult)
                    {
                        m_conn.RollbackTransaction();
                    }
                    else
                    {
                        m_conn.CommitTransaction();
                    }
                }
                else
                {
                    m_conn.RollbackTransaction();

                }
            }
            else  //更新
            {
                dt.Columns.Remove("PR1_ID");
                dt.Columns.Remove("PR1_CONO");
                dt.Columns.Remove("PR1_AP1_APOCode");
                dt.Columns.Remove("PR1_RgDt");
                dt.Columns.Remove("PR1_RgUser");
                dt.Columns.Remove("PR1_State");
                dt.Columns.Remove("PR1_Comment");
                dt.Columns.Remove("PR1_PO1_SPPOCode");
                dt.Columns.Remove("PR1_PO1_Currency");
                dt.Columns.Remove("PR1_PO1_POCode");
                DataRow dr = dt.NewRow();
                dr["PR1_RequestCode"] = strRequestCode;
                dr["PR1_DIVI"] = strDIVI;
                dr["PR1_PaymentRatio"] = ratio;//定金比例
                dr["PR1_RequestAmount"] = dtList.Rows[0]["PR1_RequestAmount"].ToString();//申请金额
                dr["PR1_PayAmount"] = dtList.Rows[0]["PR1_PayAmount"].ToString();//支付金额
                dr["PR1_PoolAmount"] = dtList.Rows[0]["PR1_PoolAmount"].ToString();//使用资金池金额
                dr["PR1_LmDt"] = timeNow;
                dr["PR1_LmUser"] = hzyMessage.User_Name;
                dr["PR1_UptNo"] = "1";
                dt.Rows.Add(dr);
                ArrayList alist = new ArrayList();
                alist.Add("PR1_RequestCode");
                alist.Add("PR1_DIVI");
                bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisitHead]", dt, alist);
                if (bResult)
                {
                    bResult = UpdatePaymentRequisitDetail(strPR1_PO1_POCode, strRequestCode, ratio, pr1_poolamount, pr1_requestamount, strDIVI, "update");
                    if (!bResult)
                    {
                        m_conn.RollbackTransaction();
                    }
                    else
                    {
                        m_conn.CommitTransaction();
                    }
                }
                else
                {
                    m_conn.RollbackTransaction();
                }
            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "申请成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "申请失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region UpdatePaymentRequisitDetail更新(insert/update)付款申请单子表
        /// <summary>
        /// UpdatePaymentRequisitDetail更新(insert/update)付款申请单子表
        /// </summary>
        /// <param name="strPOcode">采购单号</param>
        /// <param name="strPaymentCode">付款申请单号</param>
        /// <param name="ratio">定金支付比例</param>
        /// <param name="useMoney">资金池使用金额</param>
        /// <param name="Deposit_payamount">定金支付</param>
        /// <param name="strDIVI">事业体</param>
        /// <param name="doWhat">insert:新增 update:更新</param>
        /// <returns>bool</returns>
        private bool UpdatePaymentRequisitDetail(string strPOcode, string strPaymentCode, double ratio, double useMoney, double Deposit_payamount, string strDIVI, string doWhat)
        {
            string strSQL = "";
            if (doWhat == "insert")
            {
                strSQL = @"
                            INSERT INTO [B02_BILL].[PR2_PaymentRequisitDetail](
                                       [PR2_CONO]
                                      ,[PR2_DIVI]
                                      ,[PR2_RequestCode]
                                      ,[PR2_PO2_LISeq]
                                      ,[PR2_PO2_LSSeq]
                                      ,[PR2_PO2_ProductCode]
                                      ,[PR2_ShareAmount]     
                                      ,[PR2_PoolMoney]
                                      ,[PR2_PayMoney]
                                      ,[PR2_State]
                                      ,[PR2_RgDt]
                                      ,[PR2_RgUser]
                                      ,[PR2_LmDt]
                                      ,[PR2_LmUser]
                                      ,[PR2_UptNo])";
                strSQL += @"SELECT [PO2_CONO],[PO2_DIVI],'" + strPaymentCode + "',[PO2_LISeq],[PO2_LSSeq],[PO2_PD1_ProductCode],[PO2_OCurrencyAmount]*" + ratio + " shareMoney," +
                                          useMoney + "*" + "[PO2_OCurrencyAmount]*" + ratio + "/" + Deposit_payamount + " poolMoney,[PO2_OCurrencyAmount]*" + ratio + "-" + useMoney + "*" + "[PO2_OCurrencyAmount]*" + ratio + "/" + Deposit_payamount +
                                          " payMoney,'15','" + timeNow + "','" + m_hzyMessage.User_Name + "','" +
                                          timeNow + "','" + m_hzyMessage.User_Name + "',0 FROM B02_BILL.PO2_PODetail WHERE PO2_State>=35 AND PO2_State<=75 AND [PO2_DIVI]='" + strDIVI + "' AND [PO2_POCode]='" + strPOcode + "'";
                int rCount = m_conn.ExcuteQuerryByTran(strSQL, new string[] { });
                if (rCount > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                string strSQL1 = @" UPDATE [B02_BILL].[PR2_PaymentRequisitDetail] SET PR2_ShareAmount=T.shareAmount,PR2_PoolMoney=T.poolMoney,PR2_PayMoney=T.payMoney 
                                    FROM (  SELECT PO2_POCode,PO2_DIVI,PO2_PD1_ProductCode,PO2_LISeq,PO2_LSSeq,PO2_OCurrencyAmount*" + ratio + @" shareAmount," + useMoney + "*" + "PO2_OCurrencyAmount/" + Deposit_payamount + " poolMoney,PO2_OCurrencyAmount*" + ratio + "-" +
                                                   useMoney + "*" + "[PO2_OCurrencyAmount]/" + Deposit_payamount + " payMoney " +
                                          @"FROM B02_BILL.PO2_PODetail 
		                                    WHERE PO2_POCode=(SELECT PR1_PO1_POCode FROM B02_BILL.PR1_PaymentRequisitHead WITH(NOLOCK) WHERE PR1_RequestCode='" + strPaymentCode + "' AND PR1_DIVI='" + strDIVI + @"')) t,[B02_BILL].[PR2_PaymentRequisitDetail]
		                            WHERE T.PO2_DIVI=PR2_DIVI AND T.PO2_PD1_ProductCode=PO2_PD1_ProductCode AND T.PO2_LISeq=PR2_PO2_LISeq AND T.PO2_LSSeq=PR2_PO2_LSSeq";
                if (m_conn.Excute(strSQL1) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
        }
        #endregion

        #region CreatTable创建付款申请单
        /// <summary>
        /// 创建付款申请单主表和子表
        /// </summary>
        /// <param name="tabName">
        /// 表名：
        ///     PR1_PaymentRequisitHead：付款申请单主表
        ///     PR2_PaymentRequisitDetail：付款申请单子表
        /// </param>
        /// <returns>返回创建的表</returns>
        private DataTable CreatTable(string tabName)
        {
            DataTable dt = new DataTable();
            if (tabName == "PR1_PaymentRequisitHead")
            {
                dt.Columns.Add("PR1_ID");
                dt.Columns.Add("PR1_CONO");
                dt.Columns.Add("PR1_DIVI");
                dt.Columns.Add("PR1_RequestCode");
                dt.Columns.Add("PR1_PO1_POCode");
                dt.Columns.Add("PR1_PO1_SPPOCode");
                dt.Columns.Add("PR1_AP1_APOCode");
                dt.Columns.Add("PR1_RequestAmount");
                dt.Columns.Add("PR1_PayAmount");
                dt.Columns.Add("PR1_PoolAmount");
                dt.Columns.Add("PR1_PaymentRatio");
                dt.Columns.Add("PR1_PO1_Currency");
                dt.Columns.Add("PR1_State");
                dt.Columns.Add("PR1_Comment");
                dt.Columns.Add("PR1_RgDt");
                dt.Columns.Add("PR1_RgUser");
                dt.Columns.Add("PR1_LmDt");
                dt.Columns.Add("PR1_LmUser");
                dt.Columns.Add("PR1_UptNo");
            }
            else
            {
                dt.Columns.Add("PR2_ID");
                dt.Columns.Add("PR2_CONO");
                dt.Columns.Add("PR2_DIVI");
                dt.Columns.Add("PR2_RequestCode");
                dt.Columns.Add("PR2_PO2_LISeq");
                dt.Columns.Add("PR2_PO2_LSSeq");
                dt.Columns.Add("PR2_PO2_ProductCode");
                dt.Columns.Add("PR2_ShareAmount");
                dt.Columns.Add("PR2_PayMoney");
                dt.Columns.Add("PR2_PoolMoney");
                dt.Columns.Add("PR2_DepositMoney");
                dt.Columns.Add("PR2_State");
                dt.Columns.Add("PR2_Comment");
                dt.Columns.Add("PR2_RgDt");
                dt.Columns.Add("PR2_RgUser");
                dt.Columns.Add("PR2_LmDt");
                dt.Columns.Add("PR2_LmUser");
                dt.Columns.Add("PR2_UptNo");
            }
            return dt;
        }
        #endregion



        #region UpdatePaymentRequisitHead当更新付款申请单时,刷新付款申请单主表(Hawk2)
        /// <summary>
        /// UpdatePaymentRequisitHead当更新付款申请单时,刷新付款申请单主表(Hawk2)
        /// </summary>
        /// <param name="strRequestCode">付款申请单号</param>
        /// <param name="strDIVI">事业体</param>
        /// <param name="shareMoney">付款申请单主表申请金额变动值</param>
        /// <param name="payMoney">付款申请单主表支付金额变动值</param>
        /// <param name="poolMoney">付款申请单主表资金池抵扣变动值</param>
        /// <returns>true:执行成功;false:执行失败</returns>
        private bool UpdatePaymentRequisitHead(string strRequestCode, string strDIVI, double shareMoney, double payMoney, double poolMoney)
        {
            bool bResult = false;
            string sltSql = @"SELECT COUNT(*) TOTAL,
	                                (SELECT COUNT(*) FROM B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK) WHERE PR2_RequestCode=@param0 AND PR2_DIVI=@param1 AND PR2_State='99') CANCEL,
	                                (SELECT COUNT(*) FROM B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK) WHERE PR2_RequestCode=@param0 AND PR2_DIVI=@param1 AND PR2_State='85') PAID 
                                FROM B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK) WHERE PR2_RequestCode=@param0 AND PR2_DIVI=@param1";
            DataTable dt = m_conn.GetDataTable(sltSql, new string[] { strRequestCode, strDIVI });
            int total = Convert.ToInt32(dt.Rows[0]["TOTAL"].ToString());
            int cancel = Convert.ToInt32(dt.Rows[0]["CANCEL"].ToString());
            int paid = Convert.ToInt32(dt.Rows[0]["PAID"].ToString());
            string state = "15";
            if (cancel == total) //表示付款申请单子表的SKU全部取消
            {
                state = "99";
            }
            else if (paid == total) //表示全部付款
            {
                state = "85";
            }
            else if (paid > 0 && paid < total - cancel)
            {
                state = "80";
            }
            string strSQLPR1 = @"UPDATE [B02_BILL].[PR1_PaymentRequisitHead] SET PR1_RequestAmount=PR1_RequestAmount+" + shareMoney +
                            ",PR1_PayAmount=PR1_PayAmount+" + payMoney + ",PR1_State='" + state + "'," +
                            "PR1_PoolAmount=PR1_PoolAmount+" + poolMoney + " WHERE PR1_RequestCode='" + strRequestCode + "' AND PR1_DIVI='" +
                            strDIVI + "'";
            int Rcount = m_conn.Excute(strSQLPR1);
            if (Rcount == 1)
            {
                bResult = true;
            }
            else
            {
                bResult = false;
            }
            return bResult;


        }
        #endregion



        

        #region GetFinanceReport获取财务报表数据
        /// <summary>
        /// GetFinanceReport获取财务报表数据
        /// </summary>
        private void GetFinanceReport()
        {
            m_conn.BeginTransaction();
            string strSQL = @" 
                                SELECT [TS1_ID]
                                      ,[TS1_CONO]
                                      ,[TS1_DIVI]
                                      ,[TS1_PO1_POCode]
                                      ,[TS1_Seq]
                                      ,(CASE [TS1_TransType] 
			                                WHEN 'PPS' THEN '采购入库' 
			                                WHEN 'STN' THEN '换货' 
			                                WHEN 'MVL' THEN '移库' 
			                                WHEN 'RT' THEN '退货'
			                                WHEN 'RM' THEN '退款'
		                                END) [TS1_TransType]
                                      ,[TS1_WH1_WareHouseCode]
                                      ,[WH1_Name]
                                      ,[TS1_SA1_LocationCode]
                                      ,[SA1_Name]
                                      ,[TS1_PD1_ProductCode]
                                      ,[TS1_TransNumber]
                                      ,[TS1_BNumber]
                                      ,[TS1_ANumber]
                                      ,[TS1_TransCurrency]
                                      ,[TS1_SupplierTax]
                                      ,[TS1_TransDPrice]
                                      ,[TS1_TransDAMount]
                                      ,[TS1_TransDTaxPrice]
                                      ,[TS1_TransDTaxAmount]
                                      ,[TS1_TransOPrice]
                                      ,[TS1_TransOAMount]
                                      ,[TS1_TransOTaxPrice]
                                      ,[TS1_TransOTaxAmount]
                                      ,[TS1_RefCODE]
                                      ,[TS1_RefType]
                                      ,[TS1_LINumber]
                                      ,[TS1_LSNumber]
                                      ,[TS1_RgDt]
                                      ,[TS1_RgUser]
                                      ,[TS1_LmDt]
                                      ,[TS1_LmUser]
                                      ,[TS1_UptNo]
                                      ,[ST1_SupplierCode]
                                      ,[SP1_Name]      
                                      ,[ST1_BR1_BrandCode]
                                      ,[BR1_Name]
                                      ,[ST1_Unit]
                                      ,[ST1_Season]
                                      ,[ST1_Years]        
                                      ,[PO2_LISeq]
                                      ,[PO2_LSSeq]
                                      ,[PO2_OCurrencyPrice]
                                      ,[PO2_Number]
                                      ,[PO2_OCurrencyAMount]
                                      ,[PO1_PaymentTypeName] 
                                  FROM [B03_TRANS].[TS1_Transaction] TS1
                                  LEFT JOIN B01_MDM.ST3_StyleColorSize ST3 ON TS1.TS1_PD1_ProductCode=ST3.ST3_SKUCode AND TS1.TS1_CONO=ST3.ST3_CONO AND TS1.TS1_DIVI=ST3.ST3_DIVI
                                  LEFT JOIN B01_MDM.ST1_Style ST1 ON ST1.ST1_StyleCode=ST3.ST3_ST1_StyleCode AND ST1.ST1_CONO=ST3.ST3_CONO AND ST1.ST1_DIVI=ST3.ST3_DIVI
                                  LEFT JOIN B01_MDM.BR1_Brand BR1 ON BR1_BrandCode=ST1.ST1_BR1_BrandCode AND BR1.BR1_CONO=ST1.ST1_CONO AND BR1.BR1_DIVI=ST1.ST1_DIVI
                                  LEFT JOIN B01_MDM.SP1_Supplier SP1 ON SP1.SP1_SupplierCode=ST1.ST1_SupplierCode AND SP1.SP1_CONO=ST1.ST1_CONO AND SP1.SP1_DIVI=ST1.ST1_DIVI 
                                  LEFT JOIN B01_MDM.SA1_Location SA1 ON TS1.TS1_SA1_LocationCode=SA1.SA1_LocationCode AND TS1.TS1_CONO=SA1.SA1_CONO AND TS1.TS1_DIVI=SA1.SA1_DIVI AND TS1.TS1_WH1_WareHouseCode=SA1.SA1_WH1_WareHouseCode                                  
                                  LEFT JOIN B01_MDM.WH1_WareHouse WH1 ON WH1.WH1_CONO=TS1.TS1_CONO AND WH1.WH1_DIVI=TS1.TS1_DIVI AND WH1.WH1_WareHouseCode=TS1.TS1_WH1_WareHouseCode
                                  LEFT JOIN B02_BILL.PO2_PODetail PO2 ON PO2.PO2_POCode=TS1.TS1_PO1_POCode AND PO2.PO2_DIVI=TS1.TS1_DIVI AND PO2.PO2_CONO=TS1.TS1_CONO AND TS1.TS1_PD1_ProductCode=PO2.PO2_PD1_ProductCode
                                  LEFT JOIN B02_BILL.PO1_POHead PO1 ON PO1.PO1_POCode=PO2.PO2_POCode AND PO1.PO1_DIVI=PO2.PO2_DIVI AND PO1.PO1_CONO=PO2.PO2_CONO
                                  WHERE 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }

        #endregion

        #region GetPaymentData获取付款管理界面数据

        private void GetPaymentData()
        {
            string strSQL = @"  
                               --取到货计划表中的数据
                                SELECT AP1_APCode,AP1_PO1_PurchaseCode,AP2_PD1_ProductCode,AP2_APlanNumber,AP2_CONO,AP2_DIVI
                                INTO #TEMP_AP
                                FROM B02_BILL.AP2_APODetail
	                                JOIN B02_BILL.AP1_APOHead ON AP2_APCode=AP1_APCode AND AP2_CONO=AP1_CONO AND AP2_DIVI=AP1_DIVI

                                --从付款单子表中获取每个SKU的已付金额(不包含定金),
                                SELECT PB2_PayBillCode,PB2_PR1_RequestCode,PR1_PO1_POCode,PB2_PR2_ProductCode,PB2_PaymentTotalAmount,PB2_PaymentDeductionAmount,PB2_CONO,PB2_DIVI
                                INTO #TEMP_PB1
                                FROM B02_BILL.PB2_PaymentBillDetail
	                                JOIN B02_BILL.PR1_PaymentRequisitHead ON PB2_PR1_RequestCode=PR1_RequestCode AND PB2_CONO=PR1_CONO AND PB2_DIVI=PR1_DIVI
                                WHERE PR1_Comment<>'定金'


                                --从付款单子表中获取每个SKU的定金金额
                                SELECT PB2_PayBillCode PayBillCode,PB2_PR1_RequestCode RequestCode,PR1_PO1_POCode POCode,PB2_PR2_ProductCode ProductCode,
		                                PB2_PaymentTotalAmount PaymentTotalAmount,PB2_PaymentDeductionAmount PaymentDeductionAmount,PB2_CONO CONO,PB2_DIVI DIVI
                                INTO #TEMP_PB2
                                FROM B02_BILL.PB2_PaymentBillDetail
	                                JOIN B02_BILL.PR1_PaymentRequisitHead ON PB2_PR1_RequestCode=PR1_RequestCode AND PB2_CONO=PR1_CONO AND PB2_DIVI=PR1_DIVI
                                WHERE PR1_Comment='定金'

	
                                --从付款申请单中获取申请支付金额,资金池抵扣金额	,
                                SELECT PR2_RequestCode,PR1_PO1_POCode,PR2_PO2_ProductCode,PR2_PayMoney,PR2_PoolMoney,PR1_CONO,PR2_DIVI,PR2_State
                                INTO #TEMP_PR
                                FROM B02_BILL.PR2_PaymentRequisitDetail
	                                JOIN B02_BILL.PR1_PaymentRequisitHead ON PR1_RequestCode=PR2_RequestCode AND PR1_CONO=PR2_CONO AND PR2_DIVI=PR1_DIVI
                                WHERE PR2_Comment='非定金'


                                --从收货单表中获取每个采购单下的每个SKU已收货入库数量 DROP TABLE #TEMP_RP
                                SELECT RP1_PO1_POCode,RP2_PD1_ProductCode,RP2_Number,RP2_ReceiptCode,RP1_SA1_LocationCode,RP1_RgDt,RP2_CONO,RP2_DIVI
                                INTO #TEMP_RP
                                FROM B02_BILL.RP2_POReceiptDetail 
	                                JOIN B02_BILL.RP1_POReceiptHead ON RP2_ReceiptCode=RP1_ReceiptCode AND RP2_CONO=RP1_CONO AND RP2_DIVI=RP1_DIVI
	
                                --从退货表中获取每个采购单下的每个SKU已退库数量 DROP TABLE #TEMP_RT
                                SELECT RT1_RetreatCode,RT1_PO1_POCode,RT2_PD1_ProductCode,RT2_Number,RT2_CONO,RT2_DIVI,RT2_RgDt
                                INTO #TEMP_RT
                                FROM B02_BILL.RT2_RetreatDetail
	                                JOIN B02_BILL.RT1_RetreatHEAD ON RT2_RetreatCode=RT1_RetreatCode AND RT2_CONO=RT1_CONO AND RT2_DIVI=RT1_DIVI

                                SELECT PO1_SupplierCode,SP1_Name,PO1_BR1_BrandCode,BR1_Name,PO2_POCode,PO2_LISeq,PO2_LSSeq,PO2_PD1_SupperierStyle,PO2_PD1_SupperierColor,PO2_PD1_SupperierSize,
	                                    PO2_PD1_ProductCode,PO2_Number,PO2_Unit,PO2_OCurrencyPrice,PO2_OCurrencyAmount,PO2_PurchaseCurrency,PO2_RgUser,PO2_State,
	                                    PO1_PaymentTypeName,PO2_CONO,PO2_DIVI,
	                                    AP1_APCode,AP2_APlanNumber,AP2_APlanNumber*PO2_OCurrencyPrice AP_OCurrencyAmount, --计划到货金额
	                                    RP2_ReceiptCode,RP2_Number,RP1_SA1_LocationCode,RP1_RgDt,
	                                    RP2_Number*PO2_OCurrencyPrice OCurrencyAmount,--入库金额
	                                    (PO2_OCurrencyAmount-PB2_PaymentTotalAmount-PaymentTotalAmount) HasNoPay,--未付金额
	                                    PB2_PayBillCode,PB2_PaymentTotalAmount,
	                                    PR2_RequestCode,PR2_PayMoney,PR2_PoolMoney,PR2_State,
	                                    (PB2_PaymentDeductionAmount+PaymentDeductionAmount) PaymentDeductionAmountSUM, --资金池抵扣金额
	                                    PayBillCode,PaymentTotalAmount,
	                                    (PB2_PaymentTotalAmount+PaymentTotalAmount-RP2_Number*PO2_OCurrencyPrice) CarryMoney, --结转金额
	                                    RT1_RetreatCode,RT2_Number,RT2_RgDt,
	                                    (RT2_Number*PO2_OCurrencyPrice) RT2_OCurrencyAmount  --定金金额
                                FROM B02_BILL.PO2_PODetail 
	                                JOIN B02_BILL.PO1_POHead ON PO1_POCode=PO2_POCode AND PO1_CONO=PO2_CONO AND PO1_DIVI=PO2_DIVI
	                                LEFT JOIN #TEMP_AP ON PO2_POCode=AP1_PO1_PurchaseCode AND PO2_PD1_ProductCode=AP2_PD1_ProductCode AND PO2_CONO=AP2_CONO AND PO2_DIVI=AP2_DIVI
	                                LEFT JOIN #TEMP_PB1 ON PO2_POCode=PR1_PO1_POCode AND PO2_PD1_ProductCode=PB2_PR2_ProductCode AND PO2_CONO=PB2_CONO AND PO2_DIVI=PB2_DIVI
	                                LEFT JOIN #TEMP_PB2 ON PO2_POCode=POCode AND PO2_PD1_ProductCode=ProductCode AND PO2_CONO=CONO AND PO2_DIVI=DIVI
	                                LEFT JOIN #TEMP_PR ON PO2_POCode=#TEMP_PR.PR1_PO1_POCode AND PO2_PD1_ProductCode=PR2_PO2_ProductCode AND PO2_CONO=PR1_CONO AND PO2_DIVI=PR2_DIVI
	                                LEFT JOIN #TEMP_RP ON PO2_POCode=RP1_PO1_POCode AND PO2_PD1_ProductCode=RP2_PD1_ProductCode AND PO2_CONO=RP2_CONO AND PO2_DIVI=RP2_DIVI
	                                LEFT JOIN #TEMP_RT ON PO2_POCode=RT1_PO1_POCode AND PO2_PD1_ProductCode=RT2_PD1_ProductCode AND PO2_CONO=RT2_CONO AND PO2_DIVI=RT2_DIVI
	                                LEFT JOIN B01_MDM.SP1_Supplier ON PO1_SupplierCode=SP1_SupplierCode AND PO2_CONO=SP1_CONO AND PO2_DIVI=SP1_DIVI
	                                LEFT JOIN B01_MDM.BR1_Brand ON PO1_BR1_BrandCode=BR1_BrandCode AND PO2_CONO=BR1_CONO AND PO2_DIVI=BR1_DIVI
                                WHERE PO2_State='35' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL);
        }

        #endregion
        */





        #endregion
    }
}

