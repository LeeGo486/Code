using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Data;
using System.Collections;

// 类名：Deposit
// 类说明：集团版ERP
// 创建人： 俞佳伟
// 创建日期：2015-04-29
// 修改人：
// 修改日期： 

namespace HZY.COM.WS.GroupERP
{
    class Deposit : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Deposit()
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditPaymentRequisit".ToUpper())
                {
                    EditPaymentRequisit();//付款申请单(Hawk2集团版)  
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPR1_PaymentRequisit".ToUpper())
                {
                    GetPR1_PaymentRequisit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDeposit".ToUpper())
                {
                    GetDeposit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDepositDetail".ToUpper())
                {
                    GetDepositDetail();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditPaymentRequest".ToUpper())
                {
                    EditPaymentRequest();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditPaymentDetail".ToUpper())
                {
                    EditPaymentDetail();
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

        #region GetPR1_PaymentRequisit获取各种付款单数据(Hawk2集团版)
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

        #region GetDeposit获取定金付款数据
        private void GetDeposit()
        {
            string strSQL = @" 
                                --SELECT [PR2_CONO]
                                        --,[PR2_DIVI]
                                        --,[PR2_RequestCode]
                                        --,SUM(ISNULL([PR2_ShareAmount],0)) ShareAmountSUM
                                        --,SUM(ISNULL([PR2_PayMoney],0)) PayMoneySUM
                                        --,SUM(ISNULL([PR2_PoolMoney],0)) PoolMoneySUM INTO #TB  
                                --FROM [Hawk].[B02_BILL].[PR2_PaymentRequisitDetail] WITH(NOLOCK)
                                --WHERE [PR2_State]<>'99' AND [PR2_Comment]='定金'
                                --GROUP BY [PR2_CONO],[PR2_DIVI],[PR2_RequestCode]
  
                                --UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                --SET PR1_RequestAmount=ShareAmountSUM,
		                            --PR1_PayAmount=PayMoneySUM,
		                            --PR1_PoolAmount=PoolMoneySUM
                                --FROM B02_BILL.PR1_PaymentRequisitHead PR1,#TB 
                                --WHERE PR1.PR1_RequestCode=#TB.PR2_RequestCode 
		                            --AND PR1.PR1_CONO=#TB.PR2_CONO
		                            --AND PR1.PR1_DIVI=#TB.PR2_DIVI

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
                                        ISNULL(PaymentTotalAmount,0) PB1_PaymentTotalAmount,
	                                    (CASE PR1_State 
                                                WHEN '15' THEN '未付款'
                                                WHEN '80' THEN '部分付款'
                                                WHEN '85' THEN '已付款'
                                                WHEN '95' THEN '定金转预付款'
                                                WHEN '99' THEN '取消'
                                         ELSE '' END) PR1_State,
	                                    PO1_RgUser,
                                        PO1_DIVI
                                FROM B02_BILL.PO1_POHead A with(nolock)
	                                LEFT JOIN B02_BILL.PR1_PaymentRequisitHead B with(nolock) ON A.PO1_POCode=B.PR1_PO1_POCode AND A.PO1_DIVI=B.PR1_DIVI AND PR1_Comment='定金'
	                                JOIN B01_MDM.SP1_Supplier C with(nolock) ON A.PO1_SupplierCode=C.SP1_SupplierCode AND A.PO1_DIVI=C.SP1_DIVI
                                    JOIN B01_MDM.BR1_Brand D with(nolock) ON A.PO1_BR1_BrandCode=D.BR1_BrandCode AND A.PO1_DIVI=D.BR1_DIVI
                                    LEFT JOIN 
                                        (SELECT PB2_CONO,PB2_DIVI,SUBSTRING(PB2_PayBillCode,3,7) POCode,SUM(ISNULL(PB2_PaymentTotalAmount,0)) PaymentTotalAmount 
                                            FROM B02_BILL.PB2_PaymentBillDetail WITH(NOLOCK)
                                            WHERE PB2_Comment='定金' 
                                            GROUP BY PB2_CONO,PB2_DIVI,SUBSTRING(PB2_PayBillCode,3,7)) PB ON PB.PB2_CONO=A.PO1_CONO AND PB.PB2_DIVI=A.PO1_DIVI AND PB.POCode=A.PO1_POCode
                                WHERE PO1_HState<99 AND PO1_LState>15" + m_hzyPageInfo.Where;
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
                                      ,[PO2_POCode]
                                      ,[PO2_PD1_SupperierStyle]
                                      ,[PO2_PD1_SupperierColor]
                                      ,[PO2_PD1_SupperierSize]
                                      ,[PO2_OCurrencyAMount]
                                      ,[PO2_Number]
                                      ,ISNULL([PB2_PaymentTotalAmount],0) PB2_PaymentTotalAmount
                                      ,[PR2_ShareAmount]
                                      ,[PR2_PayMoney]
                                      ,[PR2_PoolMoney]
                                      ,(CASE PR2_State 
                                                WHEN '15' THEN '未付款'
                                                WHEN '80' THEN '部分付款'
                                                WHEN '85' THEN '已付款'
                                                WHEN '95' THEN '定金转预付款'
                                                WHEN '99' THEN '取消'
                                         ELSE '' END) PR2_State
                                      ,[PR2_Comment]
                                      ,[PR2_RgDt]
                                      ,[PR2_RgUser]
                                      ,[PR2_LmDt]
                                      ,[PR2_LmUser]
                                      ,[PR2_UptNo]
                                      ,[PO1_SupplierCode]
                                      ,[PO1_Currency]
                                      ,ISNULL(T.usedDepositAmount,0) usedDepositAmount
                                      ,(CASE WHEN PR2_State='95' THEN 0 ELSE ISNULL(PB2_PaymentTotalAmount,0)-ISNULL(T.usedDepositAmount,0) END) remainDeposit
                                  FROM [B02_BILL].[PR2_PaymentRequisitDetail] A with(nolock)
                                        LEFT JOIN [B02_BILL].[PR1_PaymentRequisitHead] WITH(NOLOCK) ON PR2_RequestCode=PR1_RequestCode AND PR2_CONO=PR1_CONO AND PR2_DIVI=PR1_DIVI AND PR2_Comment='定金'
                                        LEFT JOIN [B02_BILL].[PO2_PODetail] B with(nolock) ON PR1_PO1_POCode=PO2_POCode AND A.PR2_PO2_ProductCode=B.PO2_PD1_ProductCode AND A.PR2_DIVI=B.PO2_DIVI AND PR2_PO2_LISeq=PO2_LISeq AND PR2_PO2_LSSeq=PO2_LSSeq
                                        LEFT JOIN [B02_BILL].[PO1_POHead] WITH(NOLOCK) ON PO1_POCode=PO2_POCode AND PO1_CONO=PO2_CONO AND PO1_DIVI=PO2_DIVI
                                        LEFT JOIN B02_BILL.PB2_PaymentBillDetail WITH(NOLOCK) ON PB2_PR1_RequestCode=PR2_RequestCode AND PB2_CONO=PR2_CONO 
                                            AND PB2_DIVI=PR2_DIVI AND PB2_PR2_LISeq=PR2_PO2_LISeq AND PB2_PR2_LSSeq=PR2_PO2_LSSeq AND PB2_PR2_ProductCode=PR2_PO2_ProductCode
                                        LEFT JOIN (SELECT PB2_CONO,PB2_DIVI,SUBSTRING(PB2_PayBillCode,3,7) pocode,PB2_PR2_ProductCode,PB2_PR2_LISeq,PB2_PR2_LSSeq
						                                        ,SUM(ISNULL(PB2_PaymentDepositAmount,0)) usedDepositAmount
					                                        FROM B02_BILL.PB2_PaymentBillDetail WITH(NOLOCK)
					                                        WHERE PB2_Comment='非定金' AND PB2_State='85'
					                                        GROUP BY PB2_CONO,PB2_DIVI,SUBSTRING(PB2_PayBillCode,3,7),PB2_PR2_ProductCode,PB2_PR2_LISeq,PB2_PR2_LSSeq) T 
				                                        ON T.PB2_CONO=B.PO2_CONO AND T.PB2_DIVI=B.PO2_DIVI AND T.pocode=B.PO2_POCode AND T.PB2_PR2_LISeq=B.PO2_LISeq AND T.PB2_PR2_LSSeq=B.PO2_LSSeq
                                  WHERE 1=1 AND PO2_State>=35 AND PO2_State<=75" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL);
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
            double pr1_requestamount = Convert.ToDouble(dtList.Rows[0]["pr1_requestamount"].ToString());  //定金支付总额
            double Deposit_ratio = Convert.ToDouble(dtList.Rows[0]["deposit_ratio"].ToString());  //定金比例
            double ratio = pr1_requestamount / po1_ocurrencysums; //定金比例
            double payMoney = Convert.ToDouble(dtList.Rows[0]["PR1_PayAmount"].ToString());  //申请支付金额

            DataTable dt = CreatTable("PR1_PaymentRequisitHead");
            m_conn.BeginTransaction();
            if (strRequestCode == "") //新增
            {
                string sreMAXPB1_PR1_RequestCode = AutoKeyCode.GetMaxKeyCode("新增付款申请单2", strPR1_PO1_POCode, strDIVI, "", m_conn);
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
                dr["PR1_RequestAmount"] = dtList.Rows[0]["PR1_RequestAmount"].ToString();//定金支付总额
                dr["PR1_PayAmount"] = dtList.Rows[0]["PR1_PayAmount"].ToString();//支付金额
                dr["PR1_PoolAmount"] = dtList.Rows[0]["PR1_PoolAmount"].ToString();//使用资金池金额
                dr["PR1_PaymentRatio"] = Deposit_ratio;//定金比例   2015-7-7   填什么存什么
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
                    bResult = UpdatePaymentRequisitDetail(strPR1_PO1_POCode, sreMAXPB1_PR1_RequestCode, ratio, pr1_poolamount, pr1_requestamount, strDIVI, payMoney);
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
                //dt.Columns.Remove("PR1_State");
                dt.Columns.Remove("PR1_Comment");
                dt.Columns.Remove("PR1_PO1_SPPOCode");
                dt.Columns.Remove("PR1_PO1_Currency");
                dt.Columns.Remove("PR1_PO1_POCode");
                DataRow dr = dt.NewRow();
                dr["PR1_RequestCode"] = strRequestCode;
                dr["PR1_DIVI"] = strDIVI;
                dr["PR1_PaymentRatio"] = Deposit_ratio;//定金比例
                dr["PR1_RequestAmount"] = dtList.Rows[0]["PR1_RequestAmount"].ToString();//申请金额
                dr["PR1_PayAmount"] = dtList.Rows[0]["PR1_PayAmount"].ToString();//支付金额
                dr["PR1_PoolAmount"] = dtList.Rows[0]["PR1_PoolAmount"].ToString();//使用资金池金额
                dr["PR1_LmDt"] = timeNow;
                dr["PR1_LmUser"] = hzyMessage.User_Name;
                dr["PR1_UptNo"] = "1";
                dr["PR1_State"] = "15";
                dt.Rows.Add(dr);
                ArrayList alist = new ArrayList();
                alist.Add("PR1_RequestCode");
                alist.Add("PR1_DIVI");
                bResult = m_conn.Update("[B02_BILL].[PR1_PaymentRequisitHead]", dt, alist);
                if (bResult)
                {
                    bResult = UpdatePaymentRequisitDetail(strPR1_PO1_POCode, strRequestCode, ratio, pr1_poolamount, pr1_requestamount, strDIVI, payMoney);
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

        #region EditPaymentDetail编辑定金付款申请单子表(Hawk2集团版)
        /// <summary>
        /// EditPaymentDetail编辑定金付款申请单子表(Hawk2集团版)
        /// </summary>
        private void EditPaymentDetail()
        {
            string strState = "";
            bool bResult = false;
            double sum = 0;
            double paymentAmount = 0; //付款单支付金额
            double paymentTotalAmount = 0; //付款单总支付金额=支付金额+资金池抵扣金额
            double peymentDeduction = 0; //付款单抵扣金额

            double shareMoneySum = 0;  //分摊金额
            double payMoneySum = 0; //支付金额
            double poolMoneySum = 0; //资金池抵扣金额

            //获取编辑类型(1.取消,2.付款) 最后一行记录更新状态
            string strType = ds.Tables["list"].Rows[ds.Tables["list"].Rows.Count - 1]["type"].ToString();
            string strPOcode = ds.Tables["list"].Rows[ds.Tables["list"].Rows.Count - 1]["pocode"].ToString();
            string strSupplier = ds.Tables["list"].Rows[ds.Tables["list"].Rows.Count - 1]["suppliercode"].ToString(); //供应商编号
            string strComment = ds.Tables["list"].Rows[ds.Tables["list"].Rows.Count - 1]["Comment"].ToString();
            string strRequestCode = "";//获取付款申请单号
            if (ds.Tables["list"].Columns.Contains("PR2_RequestCode"))
            {
                strRequestCode = ds.Tables["list"].Rows[0]["PR2_RequestCode"].ToString();
            }
            if (ds.Tables["list"].Columns.Contains("PRRequestCode_NEW"))
            {
                strRequestCode = ds.Tables["list"].Rows[0]["PRRequestCode_NEW"].ToString();
            }
            string strDIVI = "";//获取DIVI
            if (ds.Tables["list"].Columns.Contains("pr2_divi"))
            {
                strDIVI = ds.Tables["list"].Rows[0]["pr2_divi"].ToString();
            }
            if (ds.Tables["list"].Columns.Contains("divi"))
            {
                strDIVI = ds.Tables["list"].Rows[0]["divi"].ToString();
            }
            string strCurrency = ds.Tables["list"].Rows[ds.Tables["list"].Rows.Count - 1]["currency"].ToString(); //结算币种
            if (strType.ToUpper() == "CANCEL")
            {
                strState = "99";
            }
            else if (strType.ToUpper() == "PAID")
            {
                strState = "85";
            }
            //else if (strType.ToUpper() == "REFUND")
            //{
            //    strState = "90";
            //}
            //else if (strType.ToUpper() == "TRANSFER")
            //{
            //    strState = "95";
            //}
            m_conn.BeginTransaction();
            //1.根据付款单号,环境,sku将付款申请单子表的pr2_state=99
            //创建付款申请单更新表
            DataTable updateTable = new DataTable();
            updateTable.Columns.Add("PR2_RequestCode");
            updateTable.Columns.Add("PR2_PO2_ProductCode");
            updateTable.Columns.Add("PR2_State");
            updateTable.Columns.Add("PR2_DIVI");

            DataTable Table = new DataTable();

            if (strState == "99")  //取消定金付款申请单
            {
                //添加需要更新的字段
                updateTable.Columns.Add("PR2_ShareAmount");
                updateTable.Columns.Add("PR2_PayMoney");
                updateTable.Columns.Add("PR2_PoolMoney");

                for (int i = 0; i < ds.Tables["list"].Rows.Count - 1; i++)
                {
                    DataRow dr = updateTable.NewRow();
                    dr["PR2_RequestCode"] = strRequestCode; //获取付款申请单号
                    dr["PR2_PO2_ProductCode"] = ds.Tables["list"].Rows[i]["pr2_po2_productcode"].ToString(); //获取SKU
                    dr["PR2_ShareAmount"] = 0;
                    dr["PR2_PayMoney"] = 0;
                    dr["PR2_PoolMoney"] = 0;
                    dr["PR2_State"] = strState;
                    dr["PR2_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
                    updateTable.Rows.Add(dr);

                    shareMoneySum += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_shareamount"].ToString()) * (-1); //统计取消的分摊金额
                    payMoneySum += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_paymoney"].ToString()) * (-1);   //统计取消支付的金额
                    poolMoneySum += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_poolmoney"].ToString()) * (-1); //统计取消的资金池金额
                }
            }
            else if (strState == "85") //定金付款
            {
                string strPB1_PayBillCode = AutoKeyCode.GetMaxKeyCode("新增付款单", strPOcode, strDIVI, "", m_conn);
                int code = Convert.ToInt32(strPB1_PayBillCode.Substring(9, 2));

                //创建付款单表子表            
                Table.Columns.Add("PB2_ID");
                Table.Columns.Add("PB2_CONO");
                Table.Columns.Add("PB2_DIVI");
                Table.Columns.Add("PB2_PayBillCode");
                Table.Columns.Add("PB2_PR2_LISeq");
                Table.Columns.Add("PB2_PR2_LSSeq");
                Table.Columns.Add("PB2_PR2_ProductCode");
                Table.Columns.Add("PB2_PR1_RequestCode");
                Table.Columns.Add("PB2_State");
                Table.Columns.Add("PB2_PaymentAmount");
                Table.Columns.Add("PB2_PaymentTotalAmount");
                Table.Columns.Add("PB2_PaymentDeductionAmount");
                Table.Columns.Add("PB2_Comment");
                Table.Columns.Add("PB2_RgDt");
                Table.Columns.Add("PB2_RgUser");
                Table.Columns.Add("PB2_LmDt");
                Table.Columns.Add("PB2_LmUser");
                Table.Columns.Add("PB2_UptNo");

                //付款单主表
                DataTable pbTable = new DataTable();
                pbTable.Columns.Add("PB1_ID");
                pbTable.Columns.Add("PB1_CONO");
                pbTable.Columns.Add("PB1_DIVI");
                pbTable.Columns.Add("PB1_PayBillCode");
                pbTable.Columns.Add("PB1_PR1_RequestCode");
                pbTable.Columns.Add("PB1_State");
                pbTable.Columns.Add("PB1_PaymentAmount");
                pbTable.Columns.Add("PB1_PaymentTotalAmount");
                pbTable.Columns.Add("PB1_PaymentDeductionAmount");
                pbTable.Columns.Add("PB1_Comment");
                pbTable.Columns.Add("PB1_RgDt");
                pbTable.Columns.Add("PB1_RgUser");
                pbTable.Columns.Add("PB1_LmDt");
                pbTable.Columns.Add("PB1_LmUser");
                pbTable.Columns.Add("PB1_UptNo");

                //创建供应商资金池交易表
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


                for (int i = 0; i < ds.Tables["list"].Rows.Count - 1; i++)
                {

                    DataRow dr = updateTable.NewRow();
                    dr["PR2_RequestCode"] = strRequestCode; //获取付款申请单号
                    dr["PR2_PO2_ProductCode"] = ds.Tables["list"].Rows[i]["pr2_po2_productcode"].ToString(); //获取SKU
                    dr["PR2_State"] = strState;
                    dr["PR2_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
                    updateTable.Rows.Add(dr);

                    DataRow dr1 = Table.NewRow();
                    dr1["PB2_ID"] = System.Guid.NewGuid();//strPB1_PayBillCode
                    dr1["PB2_CONO"] = "HYFG";
                    dr1["PB2_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
                    dr1["PB2_PayBillCode"] = strPB1_PayBillCode;//.Substring(0, strPB1_PayBillCode.Length - 2) + code.ToString();
                    dr1["PB2_PR1_RequestCode"] = strRequestCode;
                    dr1["PB2_PR2_LISeq"] = ds.Tables["list"].Rows[i]["pr2_po2_liseq"].ToString();
                    dr1["PB2_PR2_LSSeq"] = ds.Tables["list"].Rows[i]["pr2_po2_lsseq"].ToString();
                    dr1["PB2_PR2_ProductCode"] = ds.Tables["list"].Rows[i]["pr2_po2_productcode"].ToString();
                    dr1["PB2_State"] = "85";
                    dr1["PB2_PaymentAmount"] = ds.Tables["list"].Rows[i]["pr2_paymoney"].ToString();
                    dr1["PB2_PaymentTotalAmount"] = ds.Tables["list"].Rows[i]["pr2_shareamount"].ToString();
                    dr1["PB2_PaymentDeductionAmount"] = ds.Tables["list"].Rows[i]["pr2_poolmoney"].ToString();
                    dr1["PB2_Comment"] = strComment;
                    dr1["PB2_RgDt"] = timeNow;
                    dr1["PB2_RgUser"] = hzyMessage.User_Name;
                    dr1["PB2_LmDt"] = timeNow;
                    dr1["PB2_LmUser"] = hzyMessage.User_Name;
                    dr1["PB2_UptNo"] = "0";
                    Table.Rows.Add(dr1);


                    paymentAmount += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_paymoney"].ToString());
                    paymentTotalAmount += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_shareamount"].ToString());
                    peymentDeduction += Convert.ToDouble(ds.Tables["list"].Rows[i]["pr2_poolmoney"].ToString());  //累计资金池抵扣金额

                }
                //插付款单主表
                DataRow pbDR = pbTable.NewRow();
                pbDR["PB1_ID"] = System.Guid.NewGuid();
                pbDR["PB1_CONO"] = "HYFG";
                pbDR["PB1_DIVI"] = strDIVI;
                pbDR["PB1_PayBillCode"] = strPB1_PayBillCode;//.Substring(0, strPB1_PayBillCode.Length - 2) + code.ToString();
                pbDR["PB1_PR1_RequestCode"] = strRequestCode;
                pbDR["PB1_State"] = "85";
                pbDR["PB1_PaymentAmount"] = paymentAmount;
                pbDR["PB1_PaymentTotalAmount"] = paymentTotalAmount;
                pbDR["PB1_PaymentDeductionAmount"] = peymentDeduction;
                pbDR["PB1_Comment"] = strComment;
                pbDR["PB1_RgDt"] = timeNow;
                pbDR["PB1_RgUser"] = hzyMessage.User_Name;
                pbDR["PB1_LmDt"] = timeNow;
                pbDR["PB1_LmUser"] = hzyMessage.User_Name;
                pbDR["PB1_UptNo"] = "0";

                pbTable.Rows.Add(pbDR);

                bResult = m_conn.Insert("[B02_BILL].[PB1_PaymentBill]", pbTable);
                if (bResult)
                {
                    if (peymentDeduction != 0)
                    {
                        double suppMoney = GetSupplierMoney(m_hzyMessage.Env_SN, strSupplier, strCurrency);

                        //插供应商资金池交易表
                        DataRow drSP3 = dtSP3.NewRow();
                        drSP3["SP3_ID"] = System.Guid.NewGuid();
                        drSP3["SP3_CONO"] = "HYFG";
                        drSP3["SP3_DIVI"] = m_hzyMessage.Env_SN;
                        drSP3["SP3_SP1_SupplierCode"] = strSupplier;
                        drSP3["SP3_Currency"] = strCurrency;
                        drSP3["SP3_RefCODE"] = strPB1_PayBillCode;
                        drSP3["SP3_RefType"] = "定金付款";
                        drSP3["SP3_TransAmount"] = -peymentDeduction;
                        drSP3["SP3_SurplusAmount"] = suppMoney - peymentDeduction;
                        drSP3["SP3_RgDt"] = timeNow;
                        drSP3["SP3_RgUser"] = m_hzyMessage.User_Name;
                        drSP3["SP3_LmDt"] = timeNow;
                        drSP3["SP3_LmUser"] = m_hzyMessage.User_Name;
                        drSP3["SP3_UptNo"] = "0";

                        dtSP3.Rows.Add(drSP3);

                        bResult = m_conn.Insert("B03_TRANS.SP3_SupplierPoolTrans", dtSP3);

                        if (bResult)
                        {
                            bResult = UpdateSP2_SupplierPool(m_hzyMessage.Env_SN, strSupplier, strCurrency, -peymentDeduction);
                        }
                    }
                }
            }
            #region 注释掉定金退款和转预付款
            //else if (strState == "90")  //定金退款
            //{
            //    Table.Columns.Add("SP3_ID");
            //    Table.Columns.Add("SP3_CONO");
            //    Table.Columns.Add("SP3_DIVI");
            //    Table.Columns.Add("SP3_SP1_SupplierCode");
            //    Table.Columns.Add("SP3_Currency");
            //    Table.Columns.Add("SP3_RefCODE");
            //    Table.Columns.Add("SP3_RefType");
            //    Table.Columns.Add("SP3_TransAmount");
            //    Table.Columns.Add("SP3_SurplusAmount");
            //    Table.Columns.Add("SP3_RgDt");
            //    Table.Columns.Add("SP3_RgUser");
            //    Table.Columns.Add("SP3_LmDt");
            //    Table.Columns.Add("SP3_LmUser");
            //    Table.Columns.Add("SP3_UptNo");

            //    for (int i = 0; i < ds.Tables["list"].Rows.Count - 1; i++)
            //    {
            //        DataRow dr = updateTable.NewRow();
            //        dr["PR2_RequestCode"] = strRequestCode; //获取付款申请单号
            //        dr["PR2_PO2_ProductCode"] = ds.Tables["list"].Rows[i]["pr2_po2_productcode"].ToString(); //获取SKU
            //        dr["PR2_State"] = strState;
            //        dr["PR2_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
            //        updateTable.Rows.Add(dr);

            //        DataRow dr1 = Table.NewRow();
            //        dr1["SP3_ID"] = System.Guid.NewGuid();
            //        dr1["SP3_CONO"] = "HYFG";
            //        dr1["SP3_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
            //        dr1["SP3_SP1_SupplierCode"] = strSupplier;
            //        dr1["SP3_Currency"] =strCurrency;
            //        dr1["TS1_TransCurrency"] = strCurrency;
            //        dr1["SP3_RefCODE"] = ds.Tables["list"].Rows[i]["pr2_shareamount"].ToString(); ;
            //        dr1["TS1_RefCODE"] = ds.Tables["list"].Rows[i]["pr2_requestcode"].ToString();
            //        dr1["TS1_RefType"] = "RM";
            //        dr1["TS1_LINumber"] = ds.Tables["list"].Rows[i]["pr2_po2_liseq"].ToString();
            //        dr1["TS1_LSNumber"] = dr1["TS1_LINumber"] = ds.Tables["list"].Rows[i]["pr2_po2_lsseq"].ToString();
            //        dr1["TS1_RgDt"] = timeNow;
            //        dr1["TS1_RgUser"] = hzyMessage.User_Name;
            //        dr1["TS1_LmDt"] = timeNow;
            //        dr1["TS1_LmUser"] = hzyMessage.User_Name;
            //        dr1["TS1_UptNo"] = "0";

            //        Table.Rows.Add(dr1);
            //    }
            //}
            //else if (strState == "95")  //定金转预付款
            //{
            //    //创建供应商资金交易记录
            //    Table.Columns.Add("SP3_ID");
            //    Table.Columns.Add("SP3_CONO");
            //    Table.Columns.Add("SP3_DIVI");
            //    Table.Columns.Add("SP3_SP1_SupplierCode");
            //    Table.Columns.Add("SP3_Currency");
            //    Table.Columns.Add("SP3_RefCODE");
            //    Table.Columns.Add("SP3_RefType");
            //    Table.Columns.Add("SP3_TransAmount");
            //    Table.Columns.Add("SP3_SurplusAmount");
            //    Table.Columns.Add("SP3_RgDt");
            //    Table.Columns.Add("SP3_RgUser");
            //    Table.Columns.Add("SP3_LmDt");
            //    Table.Columns.Add("SP3_LmUser");
            //    Table.Columns.Add("SP3_UptNo");

            //    for (int i = 0; i < ds.Tables["list"].Rows.Count - 1; i++)
            //    {
            //        DataRow dr = updateTable.NewRow();
            //        dr["PR2_RequestCode"] = strRequestCode; //获取付款申请单号
            //        dr["PR2_PO2_ProductCode"] = ds.Tables["list"].Rows[i]["pr2_po2_productcode"].ToString(); //获取SKU
            //        dr["PR2_State"] = strState;
            //        dr["PR2_DIVI"] = ds.Tables["list"].Rows[i]["pr2_divi"].ToString();
            //        updateTable.Rows.Add(dr);

            //        sum += Convert.ToDouble(ds.Tables["list"].Rows[i]["remaindeposit"].ToString()); //交易金额 2015-06-06 改成剩余定金金额
            //    }
            //    //取供应商资金池金额
            //    //string strSQL1 = @"SELECT ISNULL([SP2_PoolAmount],0) SP2_PoolAmount FROM [B01_MDM].[SP2_SupplierPool] WHERE SP2_SP1_SupplierCode='" + strSupplier + "' AND SP2_DIVI='" + strDIVI + "'";

            //    double supplierSum = GetSupplierMoney(m_hzyMessage.Env_SN, strSupplier, strCurrency);
            //    //Convert.ToDouble(m_conn.GetDataTableFirstValue(strSQL1).ToString()); //供应商资金池金额

            //    DataRow dr1 = Table.NewRow();
            //    dr1["SP3_ID"] = System.Guid.NewGuid();
            //    dr1["SP3_CONO"] = "HYFG";
            //    dr1["SP3_DIVI"] = strDIVI;
            //    dr1["SP3_SP1_SupplierCode"] = strSupplier;
            //    dr1["SP3_Currency"] = strCurrency;
            //    dr1["SP3_RefCODE"] = strRequestCode;
            //    dr1["SP3_RefType"] = "定金";
            //    dr1["SP3_TransAmount"] = sum;
            //    dr1["SP3_SurplusAmount"] = supplierSum + sum;
            //    dr1["SP3_RgDt"] = timeNow;
            //    dr1["SP3_RgUser"] = hzyMessage.User_Name;
            //    dr1["SP3_LmDt"] = timeNow;
            //    dr1["SP3_LmUser"] = hzyMessage.User_Name;
            //    dr1["SP3_UptNo"] = "0";
            //    Table.Rows.Add(dr1);
            //}
            #endregion

            ArrayList alist = new ArrayList();
            alist.Add("PR2_RequestCode");
            alist.Add("PR2_PO2_ProductCode");
            alist.Add("PR2_DIVI");

            bResult = m_conn.Update("[B02_BILL].[PR2_PaymentRequisitDetail]", updateTable, alist);
            if (bResult)
            {
                //更新付款申请单主表 数据汇总(申请金额、支付金额、使用资金池金额、定金比例)
                bResult = UpdatePaymentRequisitHead(strRequestCode, strDIVI, shareMoneySum, payMoneySum, poolMoneySum);

                if (bResult)
                {
                    if (strState == "85") //定金付款,在付款单插入相应的数据
                    {
                        bResult = m_conn.Insert("[B02_BILL].[PB2_PaymentBillDetail]", Table);

                    }
                    if (strState == "99") //定金取消
                    {
                        string updateSQL = @"
                                                UPDATE B02_BILL.PR1_PaymentRequisitHead 
                                                SET PR1_RequestAmount=ShareAmount,PR1_PayAmount=PayMoney,PR1_PoolAmount=PoolMoney,PR1_PaymentRatio=(CASE WHEN ShareAmount=0 THEN 0 ELSE PR1_PaymentRatio END)
                                                FROM B02_BILL.PR1_PaymentRequisitHead,
	                                                (SELECT PR2_CONO,PR2_DIVI,PR2_RequestCode,SUM(ISNULL(PR2_ShareAmount,0)) ShareAmount,SUM(ISNULL(PR2_PayMoney,0)) PayMoney,SUM(ISNULL(PR2_PoolMoney,0)) PoolMoney     
	                                                FROM [Hawk].[B02_BILL].[PR2_PaymentRequisitDetail] WITH(NOLOCK)
	                                                GROUP BY PR2_RequestCode,PR2_CONO,PR2_DIVI) tt 
                                                WHERE tt.PR2_RequestCode=PR1_RequestCode AND tt.PR2_DIVI=PR1_DIVI AND tt.PR2_CONO=PR1_CONO";
                        m_conn.Excute(updateSQL);
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
        private bool UpdatePaymentRequisitDetail(string strPOcode, string strPaymentCode, double ratio, double useMoney, double Deposit_payamount, string strDIVI, double payMoney)
        {
            string strSQL = "";

            strSQL = @"
                        DELETE FROM [B02_BILL].[PR2_PaymentRequisitDetail] WHERE PR2_CONO='HYFG' AND PR2_DIVI='" + strDIVI + "' AND PR2_RequestCode='" + strPaymentCode + "'";

            strSQL += @"            
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
                                    ,[PR2_Comment]
                                    ,[PR2_State]
                                    ,[PR2_RgDt]
                                    ,[PR2_RgUser]
                                    ,[PR2_LmDt]
                                    ,[PR2_LmUser]
                                    ,[PR2_UptNo])";
            strSQL += @"SELECT [PO2_CONO],[PO2_DIVI],'" + strPaymentCode + "',[PO2_LISeq],[PO2_LSSeq],[PO2_PD1_ProductCode],[PO2_OCurrencyAmount]*" + ratio + " shareMoney," +
                                        useMoney + "*" + "[PO2_OCurrencyAmount]*" + ratio + "/" + Deposit_payamount + " poolMoney,[PO2_OCurrencyAmount]*" + ratio + "-" + useMoney + "*" + "[PO2_OCurrencyAmount]*" + ratio + "/" + Deposit_payamount +
                                        " payMoney,'定金','15','" + timeNow + "','" + m_hzyMessage.User_Name + "','" +
                                        timeNow + "','" + m_hzyMessage.User_Name + "',0 FROM B02_BILL.PO2_PODetail WITH(NOLOCK) WHERE PO2_State>=35 AND PO2_State<=75 AND [PO2_DIVI]='" + strDIVI + "' AND [PO2_POCode]='" + strPOcode + "'";
            int rCount = m_conn.Excute(strSQL);
            if (rCount > 0)
            {
                string uptSQl = @"
                                   UPDATE B02_BILL.PR2_PaymentRequisitDetail
                                    SET PR2_PoolMoney=A.PR2_PoolMoney+" + useMoney + @"-T.poolAmount,
                                        PR2_ShareAmount=A.PR2_ShareAmount+" + Deposit_payamount + @"-T.shareAmount,
                                        --PR2_PayMoney=A.PR2_ShareAmount+" + Deposit_payamount + @"-T.shareAmount-(A.PR2_PoolMoney+" + useMoney + @"-T.poolAmount)
                                        PR2_PayMoney=A.PR2_PayMoney+" + payMoney + @"-T.payMoney 
                                    FROM B02_BILL.PR2_PaymentRequisitDetail A WITH(NOLOCK),	
	                                    ( SELECT *,
                                            ROW_NUMBER() OVER(PARTITION BY PR2_CONO,PR2_DIVI,PR2_RequestCode ORDER BY PR2_PO2_LISeq DESC) rowNumber ,
                                            SUM(PR2_PayMoney) OVER(PARTITION BY PR2_CONO,PR2_DIVI,PR2_RequestCode) payMoney,
		                                    SUM(PR2_PoolMoney) OVER(PARTITION BY PR2_CONO,PR2_DIVI,PR2_RequestCode) poolAmount,
                                            SUM(PR2_ShareAmount) OVER(PARTITION BY PR2_CONO,PR2_DIVI,PR2_RequestCode) shareAmount                                            
	                                        FROM B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK)
	                                        WHERE PR2_Comment='定金' AND PR2_State<>'99' AND PR2_RequestCode='" + strPaymentCode + @"' AND PR2_DIVI='" + strDIVI + @"') T
                                    WHERE A.PR2_CONO=T.PR2_CONO AND A.PR2_DIVI=T.PR2_DIVI AND A.PR2_RequestCode=T.PR2_RequestCode 
	                                    AND A.PR2_PO2_LISeq=T.PR2_PO2_LISeq AND A.PR2_PO2_LSSeq=T.PR2_PO2_LSSeq AND T.rowNumber=1";
                m_conn.Excute(uptSQl);
                return true;
            }
            else
            {
                return false;
            }


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

        #region GetSupplierMoney获取供应商资金池余额
        /// <summary>
        /// GetSupplierMoney获取供应商资金池余额
        /// </summary>
        /// <param name="divi">环境</param>
        /// <param name="supplier">供应商编号</param>
        /// <param name="currency">币种</param>
        /// <returns>供应商资金池余额</returns>
        private double GetSupplierMoney(string divi, string supplier, string currency)
        {
            string strSQL = @"
                                SELECT SP2_PoolAmount 
                                FROM B01_MDM.SP2_SupplierPool 
                                WHERE SP2_DIVI='" + divi + "' AND SP2_SP1_SupplierCode='" + supplier + "' AND SP2_Currency='" + currency + "'";
            string supplierMoney = m_conn.GetDataTableFirstValue(strSQL).ToString();
            if (supplierMoney != "")
            {
                return Convert.ToDouble(supplierMoney);
            }
            else
            {
                return 0;
            }
        }
        #endregion

        #region UpdateSP2_SupplierPool更新供应商资金池金额
        /// <summary>
        /// 更新供应商资金池金额
        /// </summary>
        /// <param name="divi">环境</param>
        /// <param name="supplier">供应商编号</param>
        /// <param name="poolmoney">交易金额:负数代表扣掉,正数代表增加</param>
        /// <returns>true:更新成功,false:更新失败</returns>
        private bool UpdateSP2_SupplierPool(string divi, string supplier, string currency, double poolmoney)
        {
            string strSQL = @"UPDATE [B01_MDM].[SP2_SupplierPool] SET SP2_PoolAmount=SP2_PoolAmount+" + poolmoney + ",SP2_LmDt='"
                                + timeNow + "',SP2_LmUser='" + hzyMessage.User_Name + "',SP2_UptNo=SP2_UptNo+1 WHERE SP2_SP1_SupplierCode='"
                                + supplier + "' AND SP2_DIVI='" + divi + "' AND SP2_Currency='" + currency + "'";
            int rNum = m_conn.Excute(strSQL);

            if (rNum == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #endregion
    }
}
