﻿using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections;
using System.Data;

/// 类名：Hawk_ReturnGoods
/// 类说明：对退货的增删改查)的CRUD,为Easyui专用
/// 创建人：刘洪
/// WSID：3cd07f76-4d49-4493-ac1c-d3ca20c1631e
/// 创建日期：2015-01-12
/// 修改人：
/// 修改日期：
/// 修改内容：
/// 


namespace HZY.COM.WS.Hawk
{
    /// <summary>
    /// 对GL_ERP_sizeGroup(尺码/尺码组的增删改查)的CRUD,为Easyui专用
    /// </summary>
    /// 
    public class ReturnGoods : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public ReturnGoods()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量

        private Dbconn hk_conn = new Dbconn("Hawk");
        private Dbconn gp_conn = new Dbconn("F22GP");
        private Dbconn lx_conn = new Dbconn("F22LX"); //斓绣
        private Dbconn rs_conn = new Dbconn("F22RS");//斓居
        private Dbconn gl_conn = new Dbconn("F22GL");//雅斓

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        private DataTable dt_List = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();

        #endregion

        #region GetData 主入口
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                dt_List = m_RequestXML.Tables["List"];
                string strTag =  dt_OPTYPE.Rows[0][0].ToString().ToUpper();
                if (strTag == "GetWH".ToUpper())//取主界面Datagrid的数据.
                {
                    GetWH();
                }
                else if (strTag == "Get".ToUpper()) {
                    GetMain("");
                }
                else if (strTag == "mainSearch".ToUpper()) {
                    Search("mainSearch");
                }
                else if (strTag == "winGPSearch".ToUpper())
                {
                    Search("winGPSearch");
                }
                else if (strTag == "winHawkSearch".ToUpper())
                {
                    Search("winHawkSearch");
                }
                else if (strTag == "GetWinDg".ToUpper()) {
                    GetWin();
                }
                else if (strTag == "saveNew".ToUpper())
                {
                    Save("saveNew");
                }
                else if (strTag == "saveEdit".ToUpper())
                {
                    Save("saveEdit");
                }
                return m_ReturnData;
            }
            catch
            {
                hk_conn.RollbackTransaction();
                throw;
            };
        }

        #endregion

        #region 内部函数

            #region 加载仓库

            private void GetWH()
            {
                string strSQL = @"
                                SELECT DepotID AS WH1_WareHouseCode
                                             ,d_name AS WH1_Name
                                FROM [dbo].[j_depot] WHERE freeze=0 and m_type=0";
                string strDIVI = m_hzyMessage.Env_SN;
                if (strDIVI == "GL") {
                    DataTable dt_gl = gl_conn.GetDataTable(strSQL);
                    dt_EditResult = dt_gl;
                } 
                else {
                    DataTable dt_lx = lx_conn.GetDataTable(strSQL);
                    DataTable dt_rs = rs_conn.GetDataTable(strSQL);

                    int RowCount = dt_rs.Rows.Count;

                    do
                    {
                        DataRow dr_lx = dt_lx.NewRow();
                        dr_lx["WH1_WareHouseCode"] = dt_rs.Rows[RowCount - 1]["WH1_WareHouseCode"];
                        dr_lx["WH1_Name"] = dt_rs.Rows[RowCount - 1]["WH1_Name"];

                        dt_lx.Rows.Add(dr_lx);
                        RowCount--;
                    } while (RowCount != 0);

                    dt_EditResult = dt_lx;
                };
                
                m_ReturnData.Tables.Add(dt_EditResult.Copy());
            }

            #endregion

            #region mainDg
                private void GetMain(string where) {
                    //获取汇总
                    string strSQLTotal = @"
                                        SELECT SUM([SR1_PurchasePriceTotal]) AS PPTotal
                                                   ,SUM([SR1_NumberTotal]) AS NumTotal
                                                   ,SUM([SR1_SalePriceTotal]) AS SPTotal
                                        INTO #Temp1
                                        FROM .[B02_BILL].[SR1_ShopRetreatHead] WITH(NOLOCK)
                                        WHERE 1=1 " + where + @"

                                        SELECT SR1_ShopRetreatBillCode
                                                   ,PPTotal
                                                   ,NumTotal
                                                   ,SPTotal
                                        INTO #Temp2 
                                        FROM  [B02_BILL].[SR1_ShopRetreatHead] WITH(NOLOCK), #Temp1 WITH(NOLOCK) ";

                    hk_conn.BeginTransaction();
                    hk_conn.ExcuteQuerryByTran(strSQLTotal, new string[] { });
                              //                    ,[PPTotal]     --采购价合计
                              //,[SPTotal]     --吊牌价合计
                              //,[NumTotal] --数量合计
                    string strSQL = @"
                        SELECT [SR1_ID]
                              ,T1.[SR1_ShopRetreatBillCode]
                              ,[SR1_WareHouseBillCode]
                              ,[SR1_WareHouseCode]
                              ,[SR1_WareHouseName]
                              ,[SR2_PO1_Currency]
                              ,[SR1_SP1_SupplierCode]
                              ,[SR1_PurchasePriceTotal]
                              ,[SR1_SalePriceTotal]
                              ,[SR1_NumberTotal]
                              ,[SP1_Name]
                              ,[SR1_State]
                              ,[SR1_LmDt]
                              ,[SR1_LmUser]
                              ,[SR2_ST1_StyleCode]
                              ,[SR2_ProductCode]
                              ,[SR2_PurchasePrice]
                              ,[SR2_SalePrice]
                              ,[SR2_ZNumber]
                              ,[PPTotal]
                              ,[SPTotal]
                              ,[NumTotal] 
                        FROM [B02_BILL].[SR1_ShopRetreatHead] T1 WITH(NOLOCK)
                        LEFT JOIN [B02_BILL].[SR2_ShopRetreatDetail] T2 WITH(NOLOCK) ON T1.SR1_ShopRetreatBillCode = T2.SR2_ShopRetreatBillCode AND T1.SR1_CONO = T2.SR2_CONO AND T1.SR1_DIVI = T2.SR2_DIVI
                        LEFT JOIN [B01_MDM].[SP1_Supplier] T3 WITH(NOLOCK) ON T1.SR1_CONO = SP1_CONO AND T1.SR1_DIVI = SP1_DIVI AND T1.SR1_SP1_SupplierCode = T3.SP1_SupplierCode 
                        LEFT JOIN #Temp2 T4 WITH(NOLOCK) ON T4.SR1_ShopRetreatBillCode = T1.SR1_ShopRetreatBillCode
                        WHERE [SR1_CONO] = 'HYFG'" + where + m_hzyPageInfo.Where;
                    m_ReturnData = hk_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    hk_conn.CommitTransaction();
                }
            #endregion

            #region winDg
                private void WinDg(string where) {
                    string strSQL = @"SELECT [SR2_ShopRetreatBillCode]
                                            ,[SR2_ID]
                                            ,[SR2_DIVI]
	                                        ,[SR1_WareHouseName]
	                                        ,[SR1_WareHouseCode]
	                                        ,[SR1_SP1_SupplierCode]
	                                        ,[SP1_Name]
	                                        ,[SR2_BR1_BrandCode]
	                                        ,[BR1_Name]
                                            ,[SR2_ProductCode]
                                            ,[SR2_ST1_StyleCode]
                                            ,[SR2_PO1_Currency]
                                            ,[SR2_PurchasePrice]
                                            ,[SR2_SalePrice]
                                            ,[SR2_ZNumber]
                                            ,[SR2_Remarks]
                                            ,[SR2_LmDt]
                                            ,[SR2_LmUser]
                                      FROM [B02_BILL].[SR2_ShopRetreatDetail] T1 WITH(NOLOCK) ,[B02_BILL].[SR1_ShopRetreatHead] T2 WITH(NOLOCK)
                                          ,[B01_MDM].[SP1_Supplier] T3 WITH(NOLOCK) ,[B01_MDM].[BR1_Brand] T4 WITH(NOLOCK)
                                      WHERE T1.SR2_ShopRetreatBillCode = T2.SR1_ShopRetreatBillCode AND T1.SR2_CONO = T2.SR1_CONO 
                                            AND T1.SR2_DIVI = T2.SR1_DIVI AND T2.SR1_CONO = T3.SP1_CONO AND T2.SR1_DIVI = T3.SP1_DIVI 
		                                    AND T2.SR1_SP1_SupplierCode = T3.SP1_SupplierCode AND T1.SR2_CONO = T4.BR1_CONO 
		                                    AND T1.SR2_DIVI = T4.BR1_DIVI AND T1.SR2_BR1_BrandCode = T4.BR1_BrandCode
		                                    AND T1.SR2_CONO = 'HYFG' " + where + m_hzyPageInfo.Where;
                    m_ReturnData = hk_conn.GetDataSet(strSQL);
                }
            #endregion

            #region Search
                private void Search(string type) {
                    string where = " ";
                    string strWHCode = dt_List.Rows[0]["warehouse"].ToString();
                    string strSupplier = dt_List.Rows[0]["suppName"].ToString();
                    string strStyle = dt_List.Rows[0]["style"].ToString();
                    if (type == "mainSearch"){
                        if (strWHCode != "")
                        {
                            where += "AND SR1_WareHouseCode = '" + strWHCode + "' ";
                        };
                        if (strSupplier != "")
                        {
                            where += "AND SP1_Name LIKE '%" + strSupplier + "%' ";
                        };
                        if (strStyle != "")
                        {
                            where += "AND SR2_ST1_StyleCode LIKE '%" + strStyle + "%' ";
                        };
                        GetMain(where);
                    }
                    else if (type == "winGPSearch") {
                        //GetWin();
                    }
                    else if (type == "winHawkSearch") {

                        string strSKU = dt_List.Rows[0]["sku"].ToString();
                        string strBillCode = dt_List.Rows[0]["BillCode"].ToString();
                        where += "AND SR2_ShopRetreatBillCode = '" + strBillCode + "' ";
                        where += "AND SR1_WareHouseCode = '" + strWHCode + "' ";
                        where += "AND SP1_Name = '" + strSupplier + "' ";


                        if (strStyle != ""){
                            where += "AND SR2_ST1_StyleCode LIKE '%" + strStyle + "%' ";
                        };
                        if (strSKU != "") {
                            where += "AND SR2_ProductCode LIKE '%" + strSKU + "%' ";
                        };

                        WinDg(where);
                    };
                }
            #endregion

            #region GetWin
                private void GetWin() {
                    string strWHCode = dt_List.Rows[0]["warehouse"].ToString();
                    string strSuppCode = dt_List.Rows[0]["suppCode"].ToString();
                    string strBillCode = dt_List.Rows[0]["SR2_ShopRetreatBillCode"].ToString();

                    string where = " ";
                    where += "AND SR2_ShopRetreatBillCode = '" + strBillCode + "' ";
                    where += "AND SR1_WareHouseCode = '" + strWHCode + "' ";
                    where += "AND SP1_Name = '" + strSuppCode + "' ";

                    WinDg(where);
                }
            #endregion

            #region Save
                private void Save(string Type) {

                    bool bResult = false;
                    string comp = "";
                    if (Type == "saveNew")
                    {
                        comp = m_hzyPageInfo.Where;
                        comp = comp.Substring(5, 2);

                        dt_List.Columns.Add("SR2_ID");
                        dt_List.Columns.Add("SR2_CONO");
                        dt_List.Columns.Add("SR2_DIVI");
                        dt_List.Columns.Add("SR2_ShopRetreatBillCode");
                        dt_List.Columns.Add("SR2_RgDt");
                        dt_List.Columns.Add("SR2_RgUser");
                        dt_List.Columns.Add("SR2_LmDt");
                        dt_List.Columns.Add("SR2_LmUser");
                        dt_List.Columns.Add("SR2_UptNo");
                    }
                    string maxBillCode = "";

                    DataSet dsSumbit = CreateTab();


           
                    string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    if (Type == "saveNew")
                    {
                        maxBillCode = AutoKeyCode.GetMaxKeyCode("新增退仓单号", comp, "", "", hk_conn);
                        

                        float PurchasePriceSum = 0;
                        float SalePriceSum = 0;
                        int Total = 0;

                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_ShopRetreatBillCode"] = maxBillCode;
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_WareHouseCode"] = dt_List.Rows[0]["sr1_warehousecode"].ToString();
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_WareHouseName"] = dt_List.Rows[0]["sr1_warehousename"].ToString();
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_SP1_SupplierCode"] = dt_List.Rows[0]["sr1_sp1_suppliercode"].ToString();

                        dt_List.Columns.Remove("sp1_name");
                        dt_List.Columns.Remove("br1_name");
                        dt_List.Columns.Remove("k_num");
                        //dt_List.Columns.Remove("sr2_st1_stylecode");
                        dt_List.Columns.Remove("sr1_warehousecode");
                        dt_List.Columns.Remove("sr1_warehousename");
                        dt_List.Columns.Remove("sr1_sp1_suppliercode");

                        for (int i = 0; i < dt_List.Rows.Count; i++) {
                            string guid = System.Guid.NewGuid().ToString();
                            //采购价
                            float PurNum = float.Parse(dt_List.Rows[i]["sr2_purchaseprice"].ToString());
                            //吊牌价
                            float SaleNum = float.Parse(dt_List.Rows[i]["sr2_saleprice"].ToString());
                            //数量
                            int Num = int.Parse(dt_List.Rows[i]["sr2_znumber"].ToString());

                            PurchasePriceSum += PurNum * Num;
                            SalePriceSum += SaleNum * Num;
                            Total += Num;

                            dt_List.Rows[i]["SR2_ID"] = guid;
                            dt_List.Rows[i]["SR2_CONO"] = "HYFG";
                            dt_List.Rows[i]["SR2_DIVI"] = comp;
                            dt_List.Rows[i]["SR2_ShopRetreatBillCode"] = maxBillCode;
                            dt_List.Rows[i]["SR2_RgDt"] = timeNow;
                            dt_List.Rows[i]["SR2_RgUser"] = m_hzyMessage.User_Name;
                            dt_List.Rows[i]["SR2_LmDt"] = timeNow;
                            dt_List.Rows[i]["SR2_LmUser"]  = m_hzyMessage.User_Name;
                            dt_List.Rows[i]["SR2_UptNo"] = "0";

                        };
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_DIVI"] = comp;
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_PurchasePriceTotal"] = PurchasePriceSum.ToString();
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_SalePriceTotal"] = SalePriceSum.ToString();
                        dsSumbit.Tables["dtSR1"].Rows[0]["SR1_NumberTotal"] = Total.ToString();
                    }
                    else if (Type == "saveEdit")
                    {
                        int rowIndex = dt_List.Rows.Count;
                        string sr1_id = dt_List.Rows[rowIndex - 1]["sr1_id"].ToString();

                        dt_List.Rows.RemoveAt(rowIndex - 1);
                        maxBillCode = dt_List.Rows[0]["sr2_shopretreatbillcode"].ToString();
                        string sr2_divi = dt_List.Rows[0]["sr2_divi"].ToString();

                        dt_List.Columns.Remove("sr2_shopretreatbillcode");
                        dt_List.Columns.Remove("sr1_warehousename");
                        dt_List.Columns.Remove("SR1_WareHouseCode");
                        dt_List.Columns.Remove("SR1_SP1_SupplierCode");
                        dt_List.Columns.Remove("SP1_Name");
                        dt_List.Columns.Remove("SR2_BR1_BrandCode");
                        dt_List.Columns.Remove("BR1_Name");
                        dt_List.Columns.Remove("SR2_ProductCode");
                        dt_List.Columns.Remove("SR2_ST1_StyleCode");
                        dt_List.Columns.Remove("SR2_PO1_Currency");
                        dt_List.Columns.Remove("SR2_PurchasePrice");
                        dt_List.Columns.Remove("SR2_SalePrice");
                        dt_List.Columns.Remove("sr1_id");
                        dt_List.Columns.Remove("sr2_divi");

                        for (int j = 0; j < rowIndex-1; j++) { //rowindix-1 是删除了divi那一行
                            dt_List.Rows[j]["SR2_LmDt"] = timeNow;
                            dt_List.Rows[j]["SR2_LmUser"] = m_hzyMessage.User_Name;
                        };

                        ArrayList listKey = new ArrayList();
                        listKey.Add("sr2_id");

                        hk_conn.BeginTransaction(); // 开启事务

                        hk_conn.LockTableList.Add("[B02_BILL].[SR2_ShopRetreatDetail]");
                        hk_conn.LockTableList.Add("[B02_BILL].[SR1_ShopRetreatHead]");

                        bResult = hk_conn.Update("B02_BILL.SR2_ShopRetreatDetail", dt_List, listKey);

                        if (bResult) {
                            float PurchasePriceSum = 0;
                            float SalePriceSum = 0;
                            int Total = 0;

                            string strSQL = @"SELECT 
                                                SR2_PurchasePrice
                                               ,SR2_SalePrice
                                               ,SR2_ZNumber 
                                            FROM B02_BILL.SR2_ShopRetreatDetail 
                                            WHERE SR2_DIVI = '"+sr2_divi+"' AND SR2_ShopRetreatBillCode = '"+ maxBillCode + "'";
                            DataTable dt_SRDetail = hk_conn.GetDataTable(strSQL);

                            for (int k = 0; k < dt_SRDetail.Rows.Count; k++) {
                                //采购价
                                float PurNum = float.Parse(dt_SRDetail.Rows[k]["sr2_purchaseprice"].ToString());
                                //吊牌价
                                float SaleNum = float.Parse(dt_SRDetail.Rows[k]["sr2_saleprice"].ToString());
                                //数量
                                string strNum = dt_SRDetail.Rows[k]["sr2_znumber"].ToString();
                                if (strNum.Length == 4) {
                                    strNum = "0" + strNum;
                                }
                                strNum = strNum.Substring(0,2);
                                int Num = Int32.Parse(strNum);


                                PurchasePriceSum += PurNum * Num;
                                SalePriceSum += SaleNum * Num;
                                Total += Num;
                            }

                            DataSet dsMain = CreateTab();
                            DataTable dtMain = dsMain.Tables["dtSR1"];
                            dtMain.Rows[0]["sr1_id"] = sr1_id;
                            dtMain.Rows[0]["sr1_lmdt"] = timeNow;
                            dtMain.Rows[0]["SR1_PurchasePriceTotal"] = PurchasePriceSum;
                            dtMain.Rows[0]["SR1_SalePriceTotal"] = SalePriceSum;
                            dtMain.Rows[0]["SR1_NumberTotal"] = Total;
                            dtMain.Rows[0]["sr1_lmuser"] = m_hzyMessage.User_Name;

                            dtMain.Columns.Remove("SR1_CONO");
                            dtMain.Columns.Remove("SR1_DIVI");
                            dtMain.Columns.Remove("SR1_ShopRetreatBillCode");
                            dtMain.Columns.Remove("SR1_WareHouseBillCode");
                            dtMain.Columns.Remove("SR1_WareHouseCode");
                            dtMain.Columns.Remove("SR1_WareHouseName");
                            dtMain.Columns.Remove("SR1_SP1_SupplierCode");
                            dtMain.Columns.Remove("SR1_State");
                            dtMain.Columns.Remove("SR1_RgDt");
                            dtMain.Columns.Remove("SR1_RgUser");
                            dtMain.Columns.Remove("SR1_UptNo");

                            ArrayList listKey1 = new ArrayList();
                            listKey1.Add("sr1_id");

                            bResult = hk_conn.Update("B02_BILL.SR1_ShopRetreatHead", dtMain, listKey1);

                        }
                    };

                    


                    
                    if (Type == "saveNew")
                    {
                        hk_conn.BeginTransaction(); // 开启事务
                        hk_conn.LockTableList.Add("[B02_BILL].[SR1_ShopRetreatHead]");
                        hk_conn.LockTableList.Add("[B02_BILL].[SR2_ShopRetreatDetail]");

                        bResult = hk_conn.Insert("B02_BILL.SR1_ShopRetreatHead", dsSumbit.Tables["dtSR1"]);
                        bResult = hk_conn.Insert("B02_BILL.SR2_ShopRetreatDetail", dt_List);
                    };

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, maxBillCode });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "退货失败" });
                    }
                    hk_conn.CommitTransaction();
                    m_ReturnData.Tables.Add(dt_EditResult);

                }
            #endregion

            #region CreateTab
                private DataSet CreateTab() {
                    DataSet ds = new DataSet();

                    DataTable dtSR1 = new DataTable();     //返品主表
                    DataTable dtSR2 = new DataTable();     //返品子表

                    DataRow drSR1 = dtSR1.NewRow();

                    dtSR1.Rows.Add(drSR1);

                    string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    dtSR1.Columns.Add("sr1_id");
                    dtSR1.Columns.Add("SR1_CONO");
                    dtSR1.Columns.Add("SR1_DIVI");
                    dtSR1.Columns.Add("SR1_ShopRetreatBillCode"); //退仓单号
                    dtSR1.Columns.Add("SR1_WareHouseBillCode");   //总退仓单号
                    dtSR1.Columns.Add("SR1_WareHouseCode");       //退货仓库编码
                    dtSR1.Columns.Add("SR1_WareHouseName");       //退货仓库名称
                    dtSR1.Columns.Add("SR1_SP1_SupplierCode");    //供应商编码
                    dtSR1.Columns.Add("SR1_PurchasePriceTotal");  //采购总额
                    dtSR1.Columns.Add("SR1_SalePriceTotal");      //吊牌总额
                    dtSR1.Columns.Add("SR1_NumberTotal");         //退货总数
                    dtSR1.Columns.Add("SR1_State");               //状态
                    dtSR1.Columns.Add("SR1_RgDt");
                    dtSR1.Columns.Add("SR1_RgUser");
                    dtSR1.Columns.Add("SR1_LmDt");
                    dtSR1.Columns.Add("SR1_LmUser");
                    dtSR1.Columns.Add("SR1_UptNo");

                    //赋值

                    dtSR1.Rows[0]["SR1_ID"] = strGUID;
                    dtSR1.Rows[0]["SR1_CONO"] = "HYFG";
                    dtSR1.Rows[0]["SR1_State"] = "15";
                    dtSR1.Rows[0]["SR1_RgDt"] = timeNow;
                    dtSR1.Rows[0]["SR1_RgUser"] = m_hzyMessage.User_Name;
                    dtSR1.Rows[0]["SR1_LmDt"] = timeNow;
                    dtSR1.Rows[0]["SR1_LmUser"] = m_hzyMessage.User_Name;
                    dtSR1.Rows[0]["SR1_UptNo"] = "0";

                    dtSR1.TableName = "dtSR1";

                    ds.Tables.Add(dtSR1);
                    return ds; 
                }
            #endregion
        #endregion
    };
}
