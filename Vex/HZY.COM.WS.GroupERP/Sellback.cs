using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System.Collections;
using System.Data;

//wsid:3ab6728f-7324-4eec-8c07-6ac675672e51
//创建者:俞佳伟
namespace HZY.COM.WS.GroupERP
{
    class Sellback : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Sellback()
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
        DataTable resultTable = new DataTable();

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
                string strXML = "";//初始化XML
                string filter = "";//初始化模糊查询条件
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_conn = new Dbconn(m_hzyMessage.Env_SN);
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetWareHouse".ToUpper())//获取仓库信息
                {
                    GetWareHouse();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSupplier".ToUpper())//获取供应商信息
                {
                    GetSupplier();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetAddList".ToUpper())
                {
                    GetAddList();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEditList".ToUpper())
                {
                    GetEditList();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetShopRetreat".ToUpper()) //获取店铺退货主表
                {
                    GetShopRetreat();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Edit".ToUpper())
                {
                    Edit();
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

        #region 取仓库信息
        /// <summary>
        /// 获取仓库信息
        /// </summary>
        private void GetWareHouse()
        {
            string strSQL = @"
                                SELECT [WH1_ID]
                                      ,[WH1_CONO]
                                      ,[WH1_DIVI]
                                      ,[WH1_WareHouseCode]
                                      ,[WH1_Name]
                                      ,[WH1_Desp]
                                      ,[WH1_State]
                                      ,[WH1_RgDt]
                                      ,[WH1_RgUser]
                                      ,[WH1_LmDt]
                                      ,[WH1_LmUser]
                                      ,[WH1_UptNo]
                                      ,[WH1_Indentify]
                                FROM [Hawk].[B01_MDM].[WH1_WareHouse]
                                WHERE WH1_CONO='HYFG' AND WH1_State='20' AND WH1_DIVI='" + m_hzyMessage.Env_SN + "'";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取供应商
        private void GetSupplier()
        {
            string strSQL = @"
                                SELECT [SP1_ID]
                                      ,[SP1_CONO]
                                      ,[SP1_DIVI]
                                      ,[SP1_SupplierCode]
                                      ,[SP1_Name]
                                      ,[SP1_Desp]
                                      ,[SP1_RegionCode]
                                      ,[SP1_RegionName]
                                      ,[SP1_TypeCode]
                                      ,[SP1_TypeName]
                                      ,[SP1_State]
                                      ,[SP1_SupplyTax]
                                      ,[SP1_Contacts]
                                      ,[SP1_ContactTel]
                                      ,[SP1_Address]
                                      ,[SP1_BankName]
                                      ,[SP1_BankAddress]
                                      ,[SP1_BankAccount]
                                      ,[SP1_BankSWIFTID]
                                      ,[SP1_FeatureName]
                                      ,[SP1_FeatureCode]
                                      ,[SP1_RgDt]
                                      ,[SP1_RgUser]
                                      ,[SP1_LmDt]
                                      ,[SP1_LmUser]
                                      ,[SP1_UptNo]
                                  FROM [Hawk].[B01_MDM].[SP1_Supplier]
                                  WHERE SP1_CONO='HYFG' AND SP1_State='20' AND SP1_DIVI='" + m_hzyMessage.Env_SN + "'";

            ds_Return = m_conn.GetDataSet(strSQL);
        }

        #endregion

        #region 获取店铺退货主表信息
        private void GetShopRetreat()
        {
            string strSQL = @"
                                SELECT [SR1_ID]
                                      ,[SR1_CONO]
                                      ,[SR1_DIVI]
                                      ,[SR1_ShopRetreatBillCode]
                                      ,[SR1_WareHouseBillCode]
                                      ,[SR1_WareHouseCode]
                                      ,[SR1_WareHouseName]
                                      ,[SR1_SP1_SupplierCode]
                                      ,[SP1_Name]
                                      ,[BR1_Name]
                                      ,[SR1_PO1_POCode]
                                      ,[SR1_PurchasePriceTotal]
                                      ,[SR1_NumberTotal]
                                      ,[SR1_Money]
                                      ,[SR1_State]
                                      ,(CASE WHEN [SR1_State]='15' THEN '未审核' ELSE '已审核' END) statename 
                                      ,[SR1_RgDt]
                                      ,[SR1_RgUser]
                                      ,[SR1_LmDt]
                                      ,[SR1_LmUser]
                                      ,[SR1_UptNo]
                                      ,[SR1_SalePriceTotal]
                                      ,[PO1_Currency]
                                  FROM [Hawk].[B02_BILL].[SR1_ShopRetreatHead] WITH(NOLOCK)
                                  JOIN B01_MDM.SP1_Supplier WITH(NOLOCK) ON SR1_SP1_SupplierCode=SP1_SupplierCode AND SR1_CONO=SP1_CONO AND SR1_DIVI=SP1_DIVI
                                  JOIN B02_BILL.PO1_POHead WITH(NOLOCK) ON SR1_CONO=PO1_CONO AND SR1_DIVI=PO1_DIVI AND SR1_PO1_POCode=PO1_POCode
                                  JOIN B01_MDM.BR1_Brand WITH(NOLOCK) ON BR1_CONO=SR1_CONO AND BR1_DIVI=SR1_DIVI AND BR1_BrandCode=PO1_BR1_BrandCode
                                  WHERE SR1_PO1_POCode IS NOT NULL AND SR1_DIVI='" + m_hzyMessage.Env_SN + "' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }

        #endregion

        #region GetAddList 获取交易历史表数据
        /// <summary>
        /// GetList 获取交易历史表数据
        /// </summary>
        private void GetAddList()
        {
            string strSQL = @"
                                --获取入库
                                SELECT * INTO #PPS
                                FROM 
	                                (SELECT [TS1_ID],[TS1_CONO],[TS1_DIVI],[TS1_Seq],[TS1_TransType],[TS1_PO1_POCode],[TS1_AP1_APCode],[TS1_WH1_WareHouseCode],[TS1_SA1_LocationCode]
                                          ,[TS1_PD1_ProductCode],[TS1_TransNumber],[TS1_BNumber],[TS1_ANumber],[TS1_TransCurrency],[TS1_SupplierTax],[TS1_TransDPrice]
                                          ,[TS1_TransDAMount],[TS1_TransDTaxPrice],[TS1_TransDTaxAmount],[TS1_TransOPrice],[TS1_TransOAMount],[TS1_TransOTaxPrice]
                                          ,[TS1_TransOTaxAmount],[TS1_RefCODE],[TS1_RefType],[TS1_LINumber],[TS1_LSNumber],[TS1_RgDt],[TS1_RgUser],[TS1_LmDt]
                                          ,[TS1_LmUser],[TS1_UptNo],'折价入库' POReceipt
	                                FROM(
		                                SELECT *,ROW_NUMBER() OVER(PARTITION BY TS1_CONO,TS1_DIVI,TS1_RefCODE ORDER BY TS1_Seq DESC) rowNumber
		                                FROM [Hawk].[B03_TRANS].[TS1_Transaction] WITH(NOLOCK) 
		                                WHERE TS1_RefCODE IS NOT NULL AND TS1_RefType IS NULL AND TS1_CONO='HYFG' AND TS1_DIVI='GL') T
	                                WHERE T.rowNumber=1
	                                UNION ALL
	                                 SELECT [TS1_ID],[TS1_CONO],[TS1_DIVI],[TS1_Seq],[TS1_TransType],[TS1_PO1_POCode],[TS1_AP1_APCode],[TS1_WH1_WareHouseCode],[TS1_SA1_LocationCode]
                                          ,[TS1_PD1_ProductCode],[TS1_TransNumber],[TS1_BNumber],[TS1_ANumber],[TS1_TransCurrency],[TS1_SupplierTax],[TS1_TransDPrice]
                                          ,[TS1_TransDAMount],[TS1_TransDTaxPrice],[TS1_TransDTaxAmount],[TS1_TransOPrice],[TS1_TransOAMount],[TS1_TransOTaxPrice]
                                          ,[TS1_TransOTaxAmount],[TS1_RefCODE],[TS1_RefType],[TS1_LINumber],[TS1_LSNumber],[TS1_RgDt],[TS1_RgUser],[TS1_LmDt]
                                          ,[TS1_LmUser],[TS1_UptNo] ,'合格入库' POReceipt
	                                 FROM B03_TRANS.TS1_Transaction WITH(NOLOCK) 
	                                 WHERE TS1_TransType='PPS' AND TS1_SA1_LocationCode='E12001' AND TS1_RefType='RP') A
                                
                                --从店铺表中获取退货
                                SELECT SR2_TS1_Seq
	                                    ,SUM(ISNULL(SR2_ZNumber,0)) RTnumber
                                    INTO #SR
                                FROM B02_BILL.SR1_ShopRetreatHead WITH(NOLOCK) 
	                                JOIN B02_BILL.SR2_ShopRetreatDetail WITH(NOLOCK) ON SR1_CONO=SR2_CONO AND SR1_DIVI=SR2_DIVI AND SR1_ShopRetreatBillCode=SR2_ShopRetreatBillCode   
                                GROUP BY SR2_TS1_Seq

                                SELECT PO1_CONO,PO1_DIVI,PO1_POCode,PO2_PD1_ProductCode,PO2_LISeq,PO2_LSSeq,PO2_PD1_SupperierStyle,PO2_PurchaseCurrency,PO2_OCurrencyPrice,PO2_DCurrencyPrice,PO1_SupplierCode,
		                                PO2_PD1_SupperierColor,PO2_PD1_SupperierSize,PO2_Number,AP2_APCode,AP2_APlanNumber,A.TS1_WH1_WareHouseCode,ST2_SalePrice,ST1_StyleCode,ST1_BR1_BrandCode,ST2_Color,ST3_Size,PO1_SupplyTax, A.POReceipt,
		                                A.TS1_TransNumber NUMS,A.TS1_TransDPrice DPRICE,A.TS1_TransOPrice OPRICE,A.TS1_TransOAMount OAMOUT,A.TS1_TransDAMount DAMOUNT,A.TS1_Seq,RTnumber
		                                --SR2_ID,SR1_ShopRetreatBillCode,SR1_WareHouseCode,SR2_ZNumber,SR2_ZNumber rtnum,SR2_Price,rtoamount,SR2_Remarks
                                FROM B02_BILL.PO1_POHead WITH(NOLOCK) 
	                                JOIN B02_BILL.PO2_PODetail WITH(NOLOCK) ON PO1_CONO=PO2_CONO AND PO1_DIVI=PO2_DIVI AND PO1_POCode=PO2_POCode
	                                JOIN #PPS A ON PO1_CONO=A.TS1_CONO AND PO1_DIVI=A.TS1_DIVI AND PO1_POCode=A.TS1_PO1_POCode AND PO2_LISeq=A.TS1_LINumber AND PO2_LSSeq=A.TS1_LSNumber                            
	                                LEFT JOIN B02_BILL.AP2_APODetail WITH(NOLOCK) ON AP2_CONO=A.TS1_CONO AND AP2_DIVI=A.TS1_DIVI AND A.TS1_AP1_APCode=AP2_APCode AND AP2_LINumber=A.TS1_LINumber AND AP2_LSNumber=A.TS1_LSNumber
	                                LEFT JOIN #SR ON SR2_TS1_Seq=A.TS1_Seq
                                    JOIN B01_MDM.ST3_StyleColorSize WITH(NOLOCK) ON PO2_PD1_ProductCode=ST3_SKUCode AND PO1_CONO=ST3_CONO AND PO1_DIVI=ST3_DIVI
	                                JOIN B01_MDM.ST2_StyleColor WITH(NOLOCK) ON ST3_CONO=ST2_CONO AND ST3_DIVI=ST2_DIVI AND ST3_ST2_SKCCode=ST2_SKCCode
                                    JOIN B01_MDM.ST1_Style WITH(NOLOCK) ON ST1_CONO=ST2_CONO AND ST1_DIVI=ST2_DIVI AND ST1_StyleCode=ST2_ST1_StyleCode
                                WHERE PO1_CONO='HYFG' AND PO1_DIVI='" + m_hzyMessage.Env_SN + "' " + m_hzyPageInfo.Where + " ORDER BY PO2_PD1_ProductCode,AP2_APCode";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region GetEditList 获取交易历史表数据
        /// <summary>
        /// GetList 获取交易历史表数据
        /// </summary>
        private void GetEditList()
        {
            string strSQL = @"
                                --获取入库
                                SELECT * INTO #PPS FROM B03_TRANS.TS1_Transaction WITH(NOLOCK) WHERE TS1_TransType IN('PPS','MVL')
                                
                                --从店铺表中获取退货
                                SELECT SR1_CONO,SR1_DIVI,SR1_ShopRetreatBillCode,SR1_PO1_POCode,SR2_ID,SR2_AP1_APCode,SR2_PO2_LISeq,SR2_PO2_LSSeq,SR2_ProductCode
                                    ,SR1_WareHouseCode,SR2_Price,SR2_ZNumber,SR2_Price*SR2_ZNumber rtoamount,SR2_Remarks,SR2_TS1_Seq,SUM(ISNULL(SR2_ZNumber,0)) OVER(PARTITION BY SR2_TS1_Seq) RTNumber
                                INTO #SR
                                FROM B02_BILL.SR1_ShopRetreatHead WITH(NOLOCK) JOIN B02_BILL.SR2_ShopRetreatDetail WITH(NOLOCK) ON SR1_CONO=SR2_CONO AND SR1_DIVI=SR2_DIVI AND SR1_ShopRetreatBillCode=SR2_ShopRetreatBillCode                             

                                SELECT PO1_CONO,PO1_DIVI,PO1_POCode,PO2_PD1_ProductCode,PO2_LISeq,PO2_LSSeq,PO2_PD1_SupperierStyle,PO2_PurchaseCurrency,PO2_OCurrencyPrice,PO2_DCurrencyPrice,PO1_SupplierCode,
		                                PO2_PD1_SupperierColor,PO2_PD1_SupperierSize,PO2_Number,AP2_APCode,AP2_APlanNumber,A.TS1_WH1_WareHouseCode,ST2_SalePrice,ST1_StyleCode,ST1_BR1_BrandCode,ST2_Color,ST3_Size,PO1_SupplyTax,
		                                (CASE WHEN A.TS1_TransType='PPS' AND A.TS1_SA1_LocationCode='E12001' THEN '合格入库' WHEN A.TS1_TransType='MVL' AND A.TS1_SA1_LocationCode='E12001' THEN '折价入库' ELSE '' END ) POReceipt,
		                                A.TS1_TransNumber NUMS,A.TS1_TransDPrice DPRICE,A.TS1_TransOPrice OPRICE,A.TS1_TransOAMount OAMOUT,A.TS1_TransDAMount DAMOUNT,
		                                SR2_ID,SR1_ShopRetreatBillCode,SR1_WareHouseCode,SR2_ZNumber,SR2_ZNumber rtnum,SR2_Price,rtoamount,SR2_Remarks,RTNumber,A.TS1_Seq
                                FROM B02_BILL.PO1_POHead WITH(NOLOCK) 
	                                JOIN B02_BILL.PO2_PODetail WITH(NOLOCK) ON PO1_CONO=PO2_CONO AND PO1_DIVI=PO2_DIVI AND PO1_POCode=PO2_POCode
	                                JOIN #PPS A ON PO1_CONO=A.TS1_CONO AND PO1_DIVI=A.TS1_DIVI AND PO1_POCode=A.TS1_PO1_POCode AND PO2_LISeq=A.TS1_LINumber AND PO2_LSSeq=A.TS1_LSNumber                            
	                                LEFT JOIN B02_BILL.AP2_APODetail WITH(NOLOCK) ON AP2_CONO=A.TS1_CONO AND AP2_DIVI=A.TS1_DIVI AND A.TS1_AP1_APCode=AP2_APCode AND AP2_LINumber=A.TS1_LINumber AND AP2_LSNumber=A.TS1_LSNumber
	                                LEFT JOIN #SR ON SR1_CONO=PO1_CONO AND SR1_DIVI=PO1_DIVI AND SR1_PO1_POCode=PO1_POCode AND SR2_ProductCode=PO2_PD1_ProductCode AND SR2_PO2_LISeq=PO2_LISeq AND SR2_PO2_LSSeq=PO2_LSSeq AND SR2_TS1_Seq=A.TS1_Seq
                                    JOIN B01_MDM.ST3_StyleColorSize WITH(NOLOCK) ON PO2_PD1_ProductCode=ST3_SKUCode AND PO1_CONO=ST3_CONO AND PO1_DIVI=ST3_DIVI
	                                JOIN B01_MDM.ST2_StyleColor WITH(NOLOCK) ON ST3_CONO=ST2_CONO AND ST3_DIVI=ST2_DIVI AND ST3_ST2_SKCCode=ST2_SKCCode
                                    JOIN B01_MDM.ST1_Style WITH(NOLOCK) ON ST1_CONO=ST2_CONO AND ST1_DIVI=ST2_DIVI AND ST1_StyleCode=ST2_ST1_StyleCode
                                WHERE PO1_CONO='HYFG' AND PO1_DIVI='" + m_hzyMessage.Env_SN + "' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 新增、修改代销退厂(店铺退货主子表,交易历史表)
        /// <summary>
        /// Edit 新增、修改代销退厂(店铺退货主子表,交易历史表)
        /// </summary>
        private void Edit()
        {
            bool bResult = true;
            DataTable myTable = ds.Tables["list"];
            double PurchasePriceTotal = 0;  //采购金额
            double SalePriceTotal = 0; //吊牌金额
            int rtNums = 0; //退货总数
            double rtPriceTotal = 0; //退货总额
            string maxBillCode = ""; //退仓单号
            if (myTable.Columns.Contains("SR1_ShopRetreatBillCode"))
            {
                maxBillCode = myTable.Rows[0]["SR1_ShopRetreatBillCode"].ToString();
            }
            m_conn.BeginTransaction();
            //获取已退货数量
            string strGetRT = @"SELECT SR2_TS1_Seq
	                                    ,SUM(ISNULL(SR2_ZNumber,0)) RTnumbers
                                    FROM B02_BILL.SR2_ShopRetreatDetail WITH(NOLOCK)
                                    GROUP BY SR2_TS1_Seq";
            DataTable dtRT = m_conn.GetDataTable(strGetRT);   
            if (maxBillCode == "")  //新增
            {
                maxBillCode = AutoKeyCode.GetMaxKeyCode("新增退仓单号", m_hzyMessage.Env_SN, "", "", m_conn);

                DataTable SR2 = CreatTable("SR2_ShopRetreatDetail");
                
                for (int i = 0; i < myTable.Rows.Count; i++)
                {
                    DataRow[] dr= dtRT.Select("SR2_TS1_Seq='" + myTable.Rows[i]["TS1_Seq"].ToString() + "'");
                    if (dr.Length > 0)
                    {
                        decimal rtTotal = Convert.ToDecimal(dr[0]["RTnumbers"].ToString()) + Convert.ToDecimal(myTable.Rows[i]["rtnum"].ToString());
                        if (rtTotal > Convert.ToDecimal(myTable.Rows[i]["nums"].ToString())) //判断本次退货+已退货数量 是否超过入库数量
                        {
                            bResult = false;
                            dt_EditResult.Rows.Add(new object[] { false, myTable.Rows[i]["po2_pd1_productcode"].ToString() + " 退货数量超过入库数量" });
                            break;
                        }
                    }
                    
                    //创建SR2_ShopRetreatDetail表
                    DataRow drSR2 = SR2.NewRow();
                    drSR2["SR2_CONO"] = "HYFG";
                    drSR2["SR2_DIVI"] = m_hzyMessage.Env_SN;
                    drSR2["SR2_ShopRetreatBillCode"] = maxBillCode;
                    drSR2["SR2_AP1_APCode"] = myTable.Rows[i]["AP2_APCode"].ToString();
                    drSR2["SR2_PO2_LISeq"] = myTable.Rows[i]["PO2_LISeq"].ToString();
                    drSR2["SR2_PO2_LSSeq"] = myTable.Rows[i]["PO2_LSSeq"].ToString();
                    drSR2["SR2_ProductCode"] = myTable.Rows[i]["PO2_PD1_ProductCode"].ToString();
                    drSR2["SR2_ST1_StyleCode"] = myTable.Rows[i]["ST1_StyleCode"].ToString();
                    drSR2["SR2_ST2_Color"] = myTable.Rows[i]["ST2_Color"].ToString();
                    drSR2["SR2_ST3_Size"] = myTable.Rows[i]["ST3_Size"].ToString();
                    drSR2["SR2_PO1_Currency"] = myTable.Rows[i]["PO2_PurchaseCurrency"].ToString();
                    drSR2["SR2_PurchasePrice"] = myTable.Rows[i]["PO2_OCurrencyPrice"].ToString();
                    drSR2["SR2_SalePrice"] = myTable.Rows[i]["ST2_SalePrice"].ToString();
                    drSR2["SR2_Price"] = myTable.Rows[i]["oprice"].ToString();
                    drSR2["SR2_ZNumber"] = myTable.Rows[i]["rtnum"].ToString();
                    drSR2["SR2_Remarks"] = myTable.Rows[i]["sr2_remarks"].ToString();
                    drSR2["SR2_RgDt"] = timeNow;
                    drSR2["SR2_RgUser"] = m_hzyMessage.User_Name;
                    drSR2["SR2_LmDt"] = timeNow;
                    drSR2["SR2_LmUser"] = m_hzyMessage.User_Name;
                    drSR2["SR2_UptNo"] = "0";
                    drSR2["SR2_TS1_Seq"] = myTable.Rows[i]["TS1_Seq"].ToString(); 

                    SR2.Rows.Add(drSR2);

                    PurchasePriceTotal += (Convert.ToDouble(myTable.Rows[i]["PO2_OCurrencyPrice"].ToString())) * (Convert.ToInt32(myTable.Rows[i]["rtnum"].ToString())); //汇总采购金额
                    SalePriceTotal += (Convert.ToDouble(myTable.Rows[i]["ST2_SalePrice"].ToString())) * (Convert.ToInt32(myTable.Rows[i]["rtnum"].ToString())); //汇总吊牌金额
                    rtNums += Convert.ToInt32(myTable.Rows[i]["rtnum"].ToString());  //汇总退货总数
                    rtPriceTotal += (Convert.ToDouble(myTable.Rows[i]["oprice"].ToString())) * (Convert.ToInt32(myTable.Rows[i]["rtnum"].ToString()));  //汇总退货总额

                }
                if (bResult)
                {
                    //创建SR1_ShopRetreatHead
                    DataTable SR1 = CreatTable("SR1_ShopRetreatHead");
                    DataRow drSR1 = SR1.NewRow();
                    drSR1["SR1_CONO"] = "HYFG";
                    drSR1["SR1_DIVI"] = m_hzyMessage.Env_SN;
                    drSR1["SR1_ShopRetreatBillCode"] = maxBillCode;
                    drSR1["SR1_WareHouseCode"] = myTable.Rows[0]["sr1_warehousecode"].ToString();
                    drSR1["SR1_WareHouseName"] = myTable.Rows[0]["sr1_warehousename"].ToString();
                    drSR1["SR1_SP1_SupplierCode"] = myTable.Rows[0]["PO1_SupplierCode"].ToString();
                    drSR1["SR1_PO1_POCode"] = myTable.Rows[0]["PO1_POCode"].ToString();
                    drSR1["SR1_BR1_BrandCode"] = myTable.Rows[0]["ST1_BR1_BrandCode"].ToString();
                    drSR1["SR1_PurchasePriceTotal"] = PurchasePriceTotal;
                    drSR1["SR1_SalePriceTotal"] = SalePriceTotal;
                    drSR1["SR1_NumberTotal"] = rtNums;
                    drSR1["SR1_Money"] = rtPriceTotal;
                    drSR1["SR1_State"] = "15";
                    drSR1["SR1_RgDt"] = timeNow;
                    drSR1["SR1_RgUser"] = m_hzyMessage.User_Name;
                    drSR1["SR1_LmDt"] = timeNow;
                    drSR1["SR1_LmUser"] = m_hzyMessage.User_Name;
                    drSR1["SR1_UptNo"] = "0";

                    SR1.Rows.Add(drSR1);

                    bResult = m_conn.Insert("[B02_BILL].[SR2_ShopRetreatDetail]", SR2);
                    if (bResult)
                    {
                        bResult = m_conn.Insert("[B02_BILL].[SR1_ShopRetreatHead]", SR1);
                    }
                }
            }
            else   //修改
            {
                //创建更新表
                DataTable dtSR2 = new DataTable();
                dtSR2.Columns.Add("SR2_ID");
                dtSR2.Columns.Add("SR2_ZNumber");
                dtSR2.Columns.Add("SR2_Remarks");
                dtSR2.Columns.Add("SR2_LmDt");
                dtSR2.Columns.Add("SR2_LmUser");
                dtSR2.Columns.Add("SR2_UptNo");

                m_conn.BeginTransaction();
                for (int i = 0; i < myTable.Rows.Count; i++)
                {
                    DataRow[] dr = dtRT.Select("SR2_TS1_Seq='" + myTable.Rows[i]["TS1_Seq"].ToString() + "'");
                    if (dr.Length > 0)
                    {
                        decimal rtTotal = Convert.ToDecimal(dr[0]["RTnumbers"].ToString()) + Convert.ToDecimal(myTable.Rows[i]["rtnum"].ToString());
                        if (rtTotal > Convert.ToDecimal(myTable.Rows[i]["nums"].ToString())) //判断本次退货+已退货数量 是否超过入库数量
                        {
                            bResult = false;
                            dt_EditResult.Rows.Add(new object[] { false, myTable.Rows[i]["po2_pd1_productcode"].ToString() + " 退货数量超过入库数量" });
                            break;
                        }
                    }

                    DataRow drSR2 = dtSR2.NewRow();
                    drSR2["SR2_ID"] = myTable.Rows[i]["SR2_ID"].ToString();
                    drSR2["SR2_ZNumber"] = myTable.Rows[i]["rtnum"].ToString();
                    drSR2["SR2_Remarks"] = myTable.Rows[i]["sr2_remarks"].ToString();
                    drSR2["SR2_LmDt"] = timeNow;
                    drSR2["SR2_LmUser"] = m_hzyMessage.User_Name;

                    dtSR2.Rows.Add(drSR2);
                }
                if (bResult)
                {
                    ArrayList aList = new ArrayList();
                    aList.Add("SR2_ID");
                    bResult = m_conn.Update("[B02_BILL].[SR2_ShopRetreatDetail]", dtSR2, aList);
                    if (bResult)
                    {
                        string strUptSQL = @"
                                            UPDATE B02_BILL.SR1_ShopRetreatHead SET SR1_Money=SR_TOTAL FROM B02_BILL.SR1_ShopRetreatHead, 
                                            (SELECT [SR2_CONO],[SR2_DIVI],[SR2_ShopRetreatBillCode],SUM(ISNULL([SR2_ZNumber],0)*ISNULL([SR2_Price],0)) SR_TOTAL
                                            FROM [B02_BILL].[SR2_ShopRetreatDetail] WITH(NOLOCK)
                                            GROUP BY [SR2_CONO],[SR2_DIVI],[SR2_ShopRetreatBillCode]) TT
                                            WHERE SR1_CONO=TT.SR2_CONO AND SR1_DIVI=TT.SR2_DIVI AND SR1_ShopRetreatBillCode=TT.SR2_ShopRetreatBillCode";
                        int count = m_conn.Excute(strUptSQL);
                        if (count < 1)
                        {
                            bResult = false;
                        }
                    }
                }
            }


            //返回结果
            if (!bResult)
            {
                dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                m_conn.RollbackTransaction(); //事务回滚
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                m_conn.CommitTransaction(); //事务提交
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 创建表
        /// <summary>
        /// 创建所需要的表
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <returns>DataTable</returns>
        private DataTable CreatTable(string tableName)
        {
            DataTable dt = new DataTable();
            if (tableName == "SR1_ShopRetreatHead")  //创建店铺退货主表
            {
                dt.Columns.Add("SR1_CONO");
                dt.Columns.Add("SR1_DIVI");
                dt.Columns.Add("SR1_ShopRetreatBillCode");
                dt.Columns.Add("SR1_WareHouseCode");
                dt.Columns.Add("SR1_WareHouseName");
                dt.Columns.Add("SR1_SP1_SupplierCode");
                dt.Columns.Add("SR1_PO1_POCode");
                dt.Columns.Add("SR1_BR1_BrandCode");
                dt.Columns.Add("SR1_PurchasePriceTotal");
                dt.Columns.Add("SR1_SalePriceTotal");
                dt.Columns.Add("SR1_NumberTotal");
                dt.Columns.Add("SR1_Money");
                dt.Columns.Add("SR1_State");
                dt.Columns.Add("SR1_RgDt");
                dt.Columns.Add("SR1_RgUser");
                dt.Columns.Add("SR1_LmDt");
                dt.Columns.Add("SR1_LmUser");
                dt.Columns.Add("SR1_UptNo");

            }
            else if (tableName == "SR2_ShopRetreatDetail") // 创建店铺退货子表
            {
                dt.Columns.Add("SR2_CONO");
                dt.Columns.Add("SR2_DIVI");
                dt.Columns.Add("SR2_ShopRetreatBillCode");
                dt.Columns.Add("SR2_AP1_APCode");
                dt.Columns.Add("SR2_PO2_LISeq");
                dt.Columns.Add("SR2_PO2_LSSeq");
                dt.Columns.Add("SR2_ProductCode");
                dt.Columns.Add("SR2_ST1_StyleCode");
                dt.Columns.Add("SR2_ST2_Color");
                dt.Columns.Add("SR2_ST3_Size");
                dt.Columns.Add("SR2_PO1_Currency");
                dt.Columns.Add("SR2_PurchasePrice");
                dt.Columns.Add("SR2_SalePrice");
                dt.Columns.Add("SR2_Price");
                dt.Columns.Add("SR2_ZNumber");
                dt.Columns.Add("SR2_Remarks");
                dt.Columns.Add("SR2_RgDt");
                dt.Columns.Add("SR2_RgUser");
                dt.Columns.Add("SR2_LmDt");
                dt.Columns.Add("SR2_LmUser");
                dt.Columns.Add("SR2_UptNo");
                dt.Columns.Add("SR2_TS1_Seq");
            }
            else if (tableName == "TS1_Transaction") //创建交易历史表
            {
                dt.Columns.Add("TS1_CONO");
                dt.Columns.Add("TS1_DIVI");
                dt.Columns.Add("TS1_TransType");
                dt.Columns.Add("TS1_WH1_WareHouseCode");
                dt.Columns.Add("TS1_SA1_LocationCode");
                dt.Columns.Add("TS1_PD1_ProductCode");
                dt.Columns.Add("TS1_TransNumber");
                dt.Columns.Add("TS1_BNumber");
                dt.Columns.Add("TS1_ANumber");
                dt.Columns.Add("TS1_TransCurrency");
                dt.Columns.Add("TS1_SupplierTax");
                dt.Columns.Add("TS1_TransDPrice");
                dt.Columns.Add("TS1_TransDAMount");
                dt.Columns.Add("TS1_TransDTaxPrice");
                dt.Columns.Add("TS1_TransDTaxAmount");
                dt.Columns.Add("TS1_TransOPrice");
                dt.Columns.Add("TS1_TransOAMount");
                dt.Columns.Add("TS1_TransOTaxPrice");
                dt.Columns.Add("TS1_TransOTaxAmount");
                dt.Columns.Add("TS1_RefCODE");
                dt.Columns.Add("TS1_RefType");
                dt.Columns.Add("TS1_LINumber");
                dt.Columns.Add("TS1_LSNumber");
                dt.Columns.Add("TS1_RgDt");
                dt.Columns.Add("TS1_RgUser");
                dt.Columns.Add("TS1_LmDt");
                dt.Columns.Add("TS1_LmUser");
                dt.Columns.Add("TS1_UptNo");
            }
            return dt;
        }
        #endregion

        #region 获取库存
        private DataTable GetSK1_Inventory()
        {
            DataTable dt = new DataTable();
            string strSQL = @" 
                                SELECT * FROM B04_WHS.SK1_Inventory 
                                WHERE SK1_State=2 AND SK1_DIVI='" + m_hzyMessage.Env_SN + "'";
            dt = m_conn.GetDataSet(strSQL).Tables[0];
            return dt;
        }

        #endregion


        #endregion
    }
}
