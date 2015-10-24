using System;
using System.Data;
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


///索赔后台类
///WSID:2c77a6d2-5c6b-406e-9010-f49fba7dafbc
///LeeGo
///
namespace HZY.COM.WS.GroupERP
{
    class Claim : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public Claim()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        private DataTable dt_List = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();
        string strComp = "";

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
                string strXML = "",
                       strOPTYPE = "";
                strComp = m_hzyMessage.Env_SN;
                conn = new Dbconn(strComp);

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                strOPTYPE = dt_OPTYPE.Rows[0][0].ToString();

                dt_List = m_RequestXML.Tables["List"];
                switch (strOPTYPE)
                {
                    case "GET": Get(""); break;
                    case "OnExpandRow": GetOnExpandRow(); break;
                    case "GetSearch": GetSearch(); break;
                    case "Return": Return(); break;
                    case "GetWinData": GetWinData(); break;

                }

                return m_ReturnData;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }

        #endregion

        #region 内部函数

        #region GetClaim获取索赔表
        /// <summary>
        /// GetClaim获取索赔表数据
        /// </summary>
        private void GetClaim(string strWhere)
        {
            string strSQL = @"SELECT CD2_CONO,CD2_DIVI,CD2_ClaimCode,CD1_RetreatWareHouse,CD1_ReceiptWareHouse,CD1_PO1_POCode
	                                ,CD1_RP1_ReceiptCode,CD1_ClaimType,CD1_RT1_RetreatCode,CD1_PO1_Currency,CD2_PO2_LISeq
	                                ,CD2_PO2_LSSeq,CD2_PD1_ProductCode,CD2_Number,CD2_PO2_Unit,CD2_PO2_OCurrencyPrice,CD2_PO2_OCurrencyAMount
	                                ,CD2_PO2_DCurrencyPrice,CD2_PO2_DCurrencyAMount,CD2_PO2_OCurrencyRebatePrice,CD2_PO2_OCurrencyRebateAMount
	                                ,CD2_PO2_DCurrencyRebatePrice,CD2_PO2_DCurrencyRebateAMount,CD2_Discount,CD2_State,CD2_RgDt,CD2_RgUser
	                                ,CD2_LmDt,CD2_LmUser,PO1_SupplierCode,SP1_Name,PO2_PD1_SupperierStyle,PO2_PD1_SupperierColor,PO2_PD1_SupperierSize
	                                ,PO1_SupplyTax,RP2_UnqualifiedCode,RP2_UnqualifiedDesp,RP1_AP1_APCode
                              FROM view_Claim
                              WHERE CD2_CONO='HYFG' AND CD2_DIVI='" + m_hzyMessage.Env_SN + "' " + strWhere;
            m_ReturnData = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }

        #endregion

        #region Get
        /// <summary>
        /// 取索赔管理主界面Datagrid的数据
        /// </summary>
        /// 
        private void Get(string pstrWhere)
        {
            string strSQL = @"
                    SELECT DISTINCT [CD1_ID]
                          ,[CD1_ClaimCode]
                          ,[CD1_State]
                          ,[CD1_ClaimType]
                          ,[CD1_PO1_POCode]
                          ,[PO1_SupplierCode]
                          ,[CD1_RgUser]
                          ,[CD1_RgDt]
                          ,[CD1_LmUser]
                          ,[CD1_LmDt]
                          ,[CD1_RP1_ReceiptCode]
                          ,[RP2_UnqualifiedDesp]
                          ,[SP1_Name]
                      FROM [dbo].[View_ClaimHead] WHERE 1=1 AND CD1_DIVI = '" + strComp + "' " + pstrWhere;
            m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            return;
        }

        #endregion

        #region GetOnExpandRow

        /// <summary>
        /// 取索赔主界面的展开数据
        /// </summary>
        /// 
        private void GetOnExpandRow()
        {
            string strClaimCode = dt_List.Rows[0]["ClaimCode"].ToString();    //索赔单号

            string strSQL = @"
                        SELECT [CD2_ID]
                            ,[SK1_WH1_WareHouseCode]
                            ,[SK1_SA1_LocationCode]
                            ,[CD2_PD1_ProductCode]
                            ,[CD2_State]
                            ,[CD2_Number]
                            ,[CD2_PO2_Unit]
                            ,[CD2_PO2_OCurrencyPrice]
                            ,[CD2_PO2_DCurrencyPrice]
                            ,[CD2_PO2_OCurrencyAMount]
                            ,[CD2_PO2_DCurrencyAMount]
                            ,[CD2_PO2_OCurrencyRebatePrice]
                            ,[CD2_PO2_DCurrencyRebatePrice]
                            ,[CD2_PO2_OCurrencyRebateAMount]
                            ,[CD2_PO2_DCurrencyRebateAMount]
                            ,[CD2_Discount]
                            ,[CD1_ClaimType]
                        FROM [dbo].[View_ClaimDetail1]
                        WHERE CD2_DIVI = '" + strComp + "' CD2_ClaimCode = @param0";
            m_ReturnData = conn.GetDataSet(strSQL, new string[] { strClaimCode });
            return;
        }

        #endregion

        #region GetSearch
        /// <summary>
        /// 取索赔主界面的查询数据
        /// </summary>
        private void GetSearch()
        {
            string strPO = dt_List.Rows[0]["PO"].ToString();     //采购单号
            string strRP = dt_List.Rows[0]["RP"].ToString();     //收货单号
            string strSKU = dt_List.Rows[0]["SKU"].ToString();    //SKU
            string strPORgUser = dt_List.Rows[0]["PORgUser"].ToString();//采购人
            string strClaimType = dt_List.Rows[0]["ClaimType"].ToString(); //采购状态
            string strWhere = "";

            if (strPO != "")
            {
                strWhere += " AND CD1_PO1_POCode ='" + strPO + "'";
            }
            if (strRP != "")
            {
                strWhere += " AND CD1_RP1_ReceiptCode = '" + strRP + "'";
            }
            if (strSKU != "")
            {
                strWhere += " AND CD2_PD1_ProductCode = '" + strSKU + "'";
            }
            if (strPORgUser != "")
            {
                strWhere += " AND CD2_RgUser = '" + strPORgUser + "'";
            }
            if (strClaimType != "")
            {
                strWhere += " AND CD2_State LIKE '" + strClaimType + "'";
            }
            GetClaim(strWhere);
        }
        #endregion

        #region Return退货方法
        /// <summary>
        /// 退货方法
        /// </summary>
        private void Return()
        {
            bool bResult = true;
            //先查询veiw
            //            string strCheckSQL = @"
            //                                    SELECT *
            //                                    FROM [dbo].[View_ClaimHandle]
            //                                    WHERE CD1_DIVI = '" + strComp + "'";
            string strCheckSQL = @"
                                    SELECT [SK1_ID]
                                          ,[SK1_CONO]
                                          ,[SK1_DIVI]
                                          ,[SK1_WH1_WareHouseCode]
                                          ,[SK1_SA1_LocationCode]
                                          ,[SK1_BatchCode]
                                          ,[SK1_PD1_ProductCode]
                                          ,[SK1_StockNumber]
                                          ,[SK1_UsableNumber]
                                          ,[SK1_State]
                                          ,[SK1_RgDt]
                                          ,[SK1_RgUser]
                                          ,[SK1_LmDt]
                                          ,[SK1_LmUser]
                                          ,[SK1_UptNo]
                                          ,[SK1_Seq]
                                      FROM [Hawk].[B04_WHS].[SK1_Inventory] WITH(NOLOCK) 
                                      WHERE [SK1_DIVI]='" + strComp + "'";

            DataTable dtSK = conn.GetDataTable(strCheckSQL);

            DataSet dsHandle = CreatDtTable();                          //创建ds
            dsHandle.Tables["dtRT1"].Rows.Add(dsHandle.Tables["dtRT1"].NewRow());//添加行
            conn.BeginTransaction();
            for (int i = 0; i < dt_List.Rows.Count; i++)
            {
                string strClaimCode = dt_List.Rows[i]["CD2_ClaimCode"].ToString();      //索赔单号
                string strPOCode = dt_List.Rows[i]["CD1_PO1_POCode"].ToString();            //采购单号
                string strLISeq = dt_List.Rows[i]["CD2_PO2_LISeq"].ToString();

                DataRow[] dr = dtSK.Select("SK1_BatchCode='" + strClaimCode + "'");

                if (dr.Length == 1)
                {
                    decimal decUserNumber = Convert.ToDecimal(dr[0]["SK1_StockNumber"].ToString());//库存
                    string strRetreatWareHouse = dt_List.Rows[i]["RT1_RetreatWareHouse"].ToString();

                    if (strLISeq.Length == 1)
                    {
                        strPOCode = strPOCode + "0" + strLISeq;
                    }
                    else
                    {
                        strPOCode = strPOCode + strLISeq;
                    }
                    string strRetCode = AutoKeyCode.GetMaxKeyCode("新增退货单编号", strComp, strPOCode, "", conn); //生成退货单号

                    //创建退货主表的数据
                    //string strGuidRT1 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    //dsHandle.Tables["dtRT1"].Rows[i]["RT1_ID"] = strGuidRT1;
                    
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_CONO"] = "HYFG";
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_DIVI"] = strComp;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_RetreatCode"] = strRetCode;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_PO1_POCode"] = dt_List.Rows[i]["CD1_PO1_POCode"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_RP1_ReceiptCode"] = dt_List.Rows[i]["CD1_RP1_ReceiptCode"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_ZNumber"] = dt_List.Rows[i]["CD2_Number"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_OCurrencySums"] = dt_List.Rows[i]["CD2_PO2_OCurrencyAMount"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_DCurrencySums"] = dt_List.Rows[i]["CD2_PO2_DCurrencyAMount"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_PO1_Currency"] = dt_List.Rows[i]["CD1_PO1_Currency"];
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_RetreatWareHouse"] = strRetreatWareHouse;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_State"] = "90";
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_RgDt"] = timeNow;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_RgUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_LmUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_LmDt"] = timeNow;
                    dsHandle.Tables["dtRT1"].Rows[0]["RT1_UptNo"] = "0";

                    //创建退货子表的数据
                    //string strGuidRT2 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    //dsHandle.Tables["dtRT2"].Rows[i]["RT2_ID"] = strGuidRT2;
                    dsHandle.Tables["dtRT2"].Rows.Add(dsHandle.Tables["dtRT2"].NewRow());
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_CONO"] = "HYFG";
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_DIVI"] = strComp;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_RetreatCode"] = strRetCode;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_LISeq"] = dt_List.Rows[i]["CD2_PO2_LISeq"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_LSSeq"] = dt_List.Rows[i]["CD2_PO2_LSSeq"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PD1_ProductCode"] = dt_List.Rows[i]["CD2_PD1_ProductCode"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_Number"] = dt_List.Rows[i]["CD2_Number"]; //退货数量为，库存表的可用库存
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_Unit"] = dt_List.Rows[i]["CD2_PO2_Unit"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_OCurrencyPrice"] = dt_List.Rows[i]["CD2_PO2_OCurrencyPrice"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_DCurrencyPrice"] = dt_List.Rows[i]["CD2_PO2_DCurrencyPrice"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_OCurrencyAMount"] = dt_List.Rows[i]["CD2_PO2_OCurrencyAMount"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_PO2_DCurrencyAMount"] = dt_List.Rows[i]["CD2_PO2_DCurrencyAMount"];
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_State"] = "90";
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_RgDt"] = timeNow;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_RgUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_LmDt"] = timeNow;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_LmUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtRT2"].Rows[i]["RT2_UptNo"] = "0";

                    //创建交易历史表的数据
                    // string strGuidTS1 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    decimal decSuppTax = 1 + Convert.ToDecimal(dt_List.Rows[i]["PO1_SupplyTax"].ToString());         //供应商税率
                    decimal decTransDP = Convert.ToDecimal(dt_List.Rows[i]["CD2_PO2_DCurrencyPrice"].ToString());  //本币交易单价
                    decimal decTransAMO = Convert.ToDecimal(dt_List.Rows[i]["CD2_PO2_DCurrencyAMount"].ToString());  //本币交易金额
                    decimal decTransOP = Convert.ToDecimal(dt_List.Rows[i]["CD2_PO2_OCurrencyPrice"].ToString());   //原币交易单价
                    decimal decTransOA = Convert.ToDecimal(dt_List.Rows[i]["CD2_PO2_OCurrencyAMount"].ToString());   //原币交易金额

                    decimal decTransDTP = decTransDP * decSuppTax;  //本币单价含税
                    decimal decTransDTA = decTransAMO * decSuppTax; //本币金额含税
                    decimal decTransOTP = decTransOP * decSuppTax;  //原币单价含税
                    decimal decTransOTA = decTransOA * decSuppTax;  //原币金额含税
                    
                    string strCDNumber = dt_List.Rows[i]["CD2_Number"].ToString(); //退货数量
                    
                    decimal decCDNumber = Convert.ToDecimal(strCDNumber);
                    decimal decTransANum = decUserNumber - decCDNumber;     //交易后库存


                    //dsHandle.Tables["dtTS1"].Rows[i]["TS1_ID"] = strGuidTS1;
                    dsHandle.Tables["dtTS1"].Rows.Add(dsHandle.Tables["dtTS1"].NewRow());
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_CONO"] = "HYFG";
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_DIVI"] = strComp;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_PO1_POCode"] = dt_List.Rows[i]["CD1_PO1_POCode"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransType"] = "RT";
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_WH1_WareHouseCode"] = "W03";
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_SA1_LocationCode"] = "E13001";
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_PD1_ProductCode"] = dt_List.Rows[i]["CD2_PD1_ProductCode"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransNumber"] = strCDNumber;  //交易数量
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_BNumber"] = decUserNumber;    //交易前库存
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_ANumber"] = decTransANum;     //交易后库存
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransCurrency"] = dt_List.Rows[i]["CD2_PO2_Unit"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_SupplierTax"] = decSuppTax;   //供应商税率
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransDPrice"] = decTransDP;  //本币交易单价
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransDAMount"] = decTransAMO; //本币交易金额
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransDTaxPrice"] = decTransDTP;//本币-含税
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransDTaxAmount"] = decTransDTA;//本币-含税
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransOPrice"] = decTransOP;   //原币单价
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransOAMount"] = decTransOA;  //原币金额
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransOTaxPrice"] = decTransOTP;//原币-含税
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_TransOTaxAmount"] = decTransOTA;//原币-含税
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_RefCODE"] = strRetCode;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_RefType"] = "RT";
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_LINumber"] = dt_List.Rows[i]["CD2_PO2_LISeq"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_LSNumber"] = dt_List.Rows[i]["CD2_PO2_LSSeq"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_AP1_APCode"] = dt_List.Rows[i]["RP1_AP1_APCode"];
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_RgDt"] = timeNow;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_RgUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_LmDt"] = timeNow;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_LmUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtTS1"].Rows[i]["TS1_UptNo"] = "0";

                    //索赔子表
                    dsHandle.Tables["dtCD2"].Rows.Add(dsHandle.Tables["dtCD2"].NewRow());
                    dsHandle.Tables["dtCD2"].Rows[i]["CD2_ClaimCode"] = strRetCode;
                    dsHandle.Tables["dtCD2"].Rows[i]["CD2_DIVI"] = dt_List.Rows[i]["CD2_DIVI"];
                    dsHandle.Tables["dtCD2"].Rows[i]["CD2_State"] = "20";
                    dsHandle.Tables["dtCD2"].Rows[i]["CD2_LmUser"] = m_hzyMessage.User_Name;
                    dsHandle.Tables["dtCD2"].Rows[i]["CD2_LmDt"] = timeNow;

                    //索赔单主表
                    dsHandle.Tables["dtCD1"].Rows.Add(dsHandle.Tables["dtCD1"].NewRow());
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_RetreatWareHouse"] = strRetreatWareHouse;
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_DIVI"] = dt_List.Rows[i]["CD2_DIVI"];
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_RT1_RetreatCode"] = strRetCode;
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_ClaimCode"] = dt_List.Rows[i]["CD2_ClaimCode"];
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_ClaimType"] = "退货";
                    dsHandle.Tables["dtCD1"].Rows[i]["CD1_State"] = "20";

                    //库存表
                    dsHandle.Tables["dtSK1"].Rows.Add(dsHandle.Tables["dtSK1"].NewRow());
                    dsHandle.Tables["dtSK1"].Rows[i]["SK1_DIVI"] = dt_List.Rows[i]["CD2_DIVI"];
                    dsHandle.Tables["dtSK1"].Rows[i]["SK1_BatchCode"] = dt_List.Rows[i]["CD2_ClaimCode"];

                    bResult = conn.Insert("B02_BILL.RT1_RetreatHEAD", dsHandle.Tables["dtRT1"]);
                    if (!bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "操作失败!" });
                        bResult = false;
                        break;
                    }

                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "此次退货无库存数据,请检查!" });
                    bResult = false;
                    break;
                }

            }
            if (bResult)
            {
                bResult = conn.Insert("B02_BILL.RT2_RetreatDetail", dsHandle.Tables["dtRT2"]); //增加退货数据
                if (bResult)
                {
                    bResult = conn.Insert("B03_TRANS.TS1_Transaction", dsHandle.Tables["dtTS1"]);//增加交易表
                    if (bResult)
                    {
                        ArrayList SKList = new ArrayList();
                        SKList.Add("SK1_DIVI");
                        SKList.Add("SK1_BatchCode");

                        bResult = conn.Delete("B04_WHS.SK1_Inventory", dsHandle.Tables["dtSK1"], SKList); //删除库存
                        if (bResult)
                        {
                            ArrayList listCD2 = new ArrayList();
                            listCD2.Add("CD2_ClaimCode");
                            listCD2.Add("CD2_DIVI");
                            bResult = conn.Update("B02_BILL.CD2_ClaimDetail", dsHandle.Tables["dtCD2"], listCD2); //更新索赔子表
                            if (bResult)
                            {
                                ArrayList listCD1 = new ArrayList();
                                listCD1.Add("CD1_ClaimCode");
                                listCD1.Add("CD1_DIVI");
                                bResult = conn.Update("B02_BILL.CD1_ClaimHEAD", dsHandle.Tables["dtCD1"], listCD1); //更新索赔主表
                            }
                        }
                    }

                }


                //结果抛出
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "退货成功" });
                    conn.CommitTransaction();
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "退货失败" });
                    conn.RollbackTransaction();
                }
            }
            m_ReturnData.Tables.Add(dt_EditResult);

            // string strHandleType = dt_List.Rows[0]["HandleType"].ToString();    //索赔的处理类型

            #region 注释
            //if (strRowCount == "0")
            //{
            //    dt_EditResult.Rows.Add(new object[] { false, "此次退货无库存数据,请检查!" });
            //    m_ReturnData.Tables.Add(dt_EditResult);
            //    return;
            //}
            //else
            //{
            //    DataSet dsHandle = CreatDtTable();                          //创建ds
            //    System.Guid guid = System.Guid.NewGuid();                   //Guid 类型
            //    string strRguser = this.hzyMessage.User_Name;               //操作人
            //    DataTable dtNeedData = conn.GetDataTable(strCheckSQL);      //取出需要的数据
            //    string strRetCode = AutoKeyCode.GetMaxKeyCode("新增退货单编号", strComp, strPOCode, "", conn); //生成退货单号
            //    if (strHandleType == "退货")
            //    {
            //        //创建退货表的数据
            //        string strGuidRT1 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_ID"] = strGuidRT1;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_CONO"] = "HYFG";
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_DIVI"] = strComp;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_RetreatCode"] = strRetCode;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_PO1_POCode"] = dtNeedData.Rows[0]["CD1_PO1_POCode"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_RP1_ReceiptCode"] = dtNeedData.Rows[0]["CD1_RP1_ReceiptCode"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_ZNumber"] = dtNeedData.Rows[0]["CD2_Number"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_OCurrencySums"] = dtNeedData.Rows[0]["CD1_OCurrencySums"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_DCurrencySums"] = dtNeedData.Rows[0]["CD1_DCurrencySums"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_PO1_Currency"] = dtNeedData.Rows[0]["CD1_PO1_Currency"];
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_RetreatWareHouse"] = strRetreatWareHouse;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_State"] = "90";
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_RgDt"] = timeNow;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_RgUser"] = strRguser;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_LmUser"] = strRguser;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_LmDt"] = timeNow;
            //        dsHandle.Tables["dtRT1"].Rows[0]["RT1_UptNo"] = "0";

            //        //创建退货子表的数据
            //        for (int j = 0; j <= dtNeedData.Rows.Count - 1; j++)
            //        {
            //            string strGuidRT2 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_ID"] = strGuidRT2;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_CONO"] = "HYFG";
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_DIVI"] = strComp;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_RetreatCode"] = strRetCode;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_LISeq"] = dtNeedData.Rows[j]["CD2_PO2_LISeq"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_LSSeq"] = dtNeedData.Rows[j]["CD2_PO2_LSSeq"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PD1_ProductCode"] = dtNeedData.Rows[j]["CD2_PD1_ProductCode"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_Number"] = dtNeedData.Rows[j]["CD2_Number"]; //退货数量为，库存表的可用库存
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_Unit"] = dtNeedData.Rows[j]["CD2_PO2_Unit"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_OCurrencyPrice"] = dtNeedData.Rows[j]["CD2_PO2_OCurrencyPrice"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_DCurrencyPrice"] = dtNeedData.Rows[j]["CD2_PO2_DCurrencyPrice"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_OCurrencyAMount"] = dtNeedData.Rows[j]["CD2_PO2_OCurrencyAMount"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_PO2_DCurrencyAMount"] = dtNeedData.Rows[j]["CD2_PO2_DCurrencyAMount"];
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_State"] = "90";
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_RgDt"] = timeNow;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_RgUser"] = strRguser;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_LmDt"] = timeNow;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_LmUser"] = strRguser;
            //            dsHandle.Tables["dtRT2"].Rows[j]["RT2_UptNo"] = "0";

            //        };
            //        //创建交易记录表的数据
            //        for (int j = 0; j <= dtNeedData.Rows.Count - 1; j++)
            //        {
            //            string strGuidTS1 = System.Guid.NewGuid().ToString();      //直接返回字符串类型
            //            decimal decSuppTax = 1 + Convert.ToDecimal(dtNeedData.Rows[j]["PO1_SupplyTax"].ToString());         //供应商税率
            //            decimal decTransDP = Convert.ToDecimal(dtNeedData.Rows[j]["CD2_PO2_DCurrencyPrice"].ToString());  //本币交易单价
            //            decimal decTransAMO = Convert.ToDecimal(dtNeedData.Rows[j]["CD2_PO2_DCurrencyAMount"].ToString());  //本币交易金额
            //            decimal decTransOP = Convert.ToDecimal(dtNeedData.Rows[j]["CD2_PO2_OCurrencyPrice"].ToString());   //原币交易单价
            //            decimal decTransOA = Convert.ToDecimal(dtNeedData.Rows[j]["CD2_PO2_OCurrencyAMount"].ToString());   //原币交易金额

            //            decimal decTransDTP = decTransDP * decSuppTax;  //本币单价含税
            //            decimal decTransDTA = decTransAMO * decSuppTax; //本币金额含税
            //            decimal decTransOTP = decTransOP * decSuppTax;  //原币单价含税
            //            decimal decTransOTA = decTransOA * decSuppTax;  //原币金额含税
            //            string strUserNumber = dtNeedData.Rows[j]["SK1_StockNumber"].ToString();  //库存
            //            string strCDNumber = dtNeedData.Rows[j]["CD2_Number"].ToString(); //退货数量
            //            decimal decUserNumber = Convert.ToDecimal(strUserNumber);
            //            decimal decCDNumber = Convert.ToDecimal(strCDNumber);
            //            decimal decTransANum = decUserNumber - decCDNumber;     //交易后库存


            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_ID"] = strGuidTS1;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_CONO"] = "HYFG";
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_DIVI"] = strComp;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_PO1_POCode"] = dtNeedData.Rows[j]["CD1_PO1_POCode"];
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransType"] = "RT";
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_WH1_WareHouseCode"] = "W03";
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_SA1_LocationCode"] = "E13001";
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_PD1_ProductCode"] = dtNeedData.Rows[j]["CD2_PD1_ProductCode"];
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransNumber"] = strCDNumber;  //交易数量
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_BNumber"] = decUserNumber;    //交易前库存
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_ANumber"] = decTransANum;     //交易后库存
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransCurrency"] = dtNeedData.Rows[j]["CD2_PO2_Unit"];
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_SupplierTax"] = decSuppTax;   //供应商税率
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransDPrice"] = decTransDP;  //本币交易单价
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransDAMount"] = decTransAMO; //本币交易金额
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransDTaxPrice"] = decTransDTP;//本币-含税
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransDTaxAmount"] = decTransDTA;//本币-含税
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransOPrice"] = decTransOP;   //原币单价
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransOAMount"] = decTransOA;  //原币金额
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransOTaxPrice"] = decTransOTP;//原币-含税
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_TransOTaxAmount"] = decTransOTA;//原币-含税
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_RefCODE"] = strRetCode;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_RefType"] = "RT";
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_LINumber"] = dtNeedData.Rows[j]["CD2_PO2_LISeq"];
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_LSNumber"] = dtNeedData.Rows[j]["CD2_PO2_LSSeq"];
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_RgDt"] = timeNow;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_RgUser"] = strRguser;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_LmDt"] = timeNow;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_LmUser"] = strRguser;
            //            dsHandle.Tables["dtTS1"].Rows[j]["TS1_UptNo"] = "0";
            //        };

            //        //索赔单子表
            //        for (int j = 0; j <= dtNeedData.Rows.Count - 1; j++)
            //        {
            //            dsHandle.Tables["dtCD2"].Rows[j]["CD2_ClaimCode"] = strRetCode;
            //            dsHandle.Tables["dtCD2"].Rows[j]["CD2_State"] = "20";
            //            dsHandle.Tables["dtCD2"].Rows[j]["CD2_LmUser"] = strRguser;
            //            dsHandle.Tables["dtCD2"].Rows[j]["CD2_LmDt"] = timeNow;
            //        };

            //        //索赔单主表
            //        dsHandle.Tables["dtCD1"].Rows[0]["CD1_RetreatWareHouse"] = strRetreatWareHouse;
            //        dsHandle.Tables["dtCD1"].Rows[0]["CD1_RT1_RetreatCode"] = strRetCode;
            //        dsHandle.Tables["dtCD1"].Rows[0]["CD1_ClaimCode"] = dtNeedData.Rows[0]["CD1_ClaimCode"];

            //        bool bResult;
            //        conn.LockTableList.Add("B04_WHS.SK1_Inventory");// 锁表
            //        conn.LockTableList.Add("B02_BILL.RT2_RetreatDetail");
            //        conn.LockTableList.Add("B02_BILL.RT1_RetreatHEAD");
            //        conn.LockTableList.Add("B03_TRANS.TS1_Transaction");
            //        conn.LockTableList.Add("B02_BILL.CD2_ClaimDetail");
            //        conn.LockTableList.Add("B02_BILL.RP2_POReceiptDetail");
            //        conn.BeginTransaction(); // 开启事务

            //        bResult = conn.Delete("B04_WHS.SK1_Inventory", "SK1_BatchCode=" + "'" + strClaimCode + "'"); //删除库存
            //        bResult = conn.Insert("B02_BILL.RT2_RetreatDetail", dsHandle.Tables["dtRT2"]); //增加退货数据
            //        bResult = conn.Insert("B02_BILL.RT1_RetreatHEAD", dsHandle.Tables["dtRT1"]);
            //        bResult = conn.Insert("B03_TRANS.TS1_Transaction", dsHandle.Tables["dtTS1"]);//增加交易表

            //        ArrayList listKey = new ArrayList();
            //        listKey.Add("CD2_ClaimCode");
            //        bResult = conn.Update("B02_BILL.CD2_ClaimDetail", dsHandle.Tables["dtCD2"], listKey);

            //        listKey.Remove("CD2_ClaimCode");
            //        listKey.Add("CD1_ClaimCode");
            //        bResult = conn.Update("B02_BILL.CD1_ClaimHEAD", dsHandle.Tables["dtCD1"], listKey);

            //        if (bResult)
            //        {
            //            dt_EditResult.Rows.Add(new object[] { true, "退货成功" });
            //        }
            //        else
            //        {
            //            dt_EditResult.Rows.Add(new object[] { false, "退货失败" });
            //        }
            //        conn.CommitTransaction();
            //        m_ReturnData.Tables.Add(dt_EditResult);
            //    }
            //}
            #endregion
        }
        #endregion

        #region CreatDtTable
        /// <summary>
        /// 创建退货主表，子表，交易记录表，库存表，采购单子表，并对主表做一些常用字段的初始化工作。
        /// </summary>
        /// <returns></returns>
        private DataSet CreatDtTable()
        {
            DataSet dsReturn = new DataSet();
            DataTable dtRT2 = new DataTable();     //退货子表
            DataTable dtRT1 = new DataTable();     //退货主表
            DataTable dtTS1 = new DataTable();     //交易记录
            DataTable dtSK1 = new DataTable();     //库存表
            DataTable dtPO2 = new DataTable();     //采购子表
            DataTable dtCD2 = new DataTable();     //索赔子表
            DataTable dtCD1 = new DataTable();     //索赔主表
           
           // System.Guid guid = System.Guid.NewGuid();               //Guid 类型
            //string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

            //退货主表
            //dtRT1.Columns.Add("RT1_ID");
            dtRT1.Columns.Add("RT1_CONO");
            dtRT1.Columns.Add("RT1_DIVI");
            dtRT1.Columns.Add("RT1_RetreatCode");
            dtRT1.Columns.Add("RT1_PO1_POCode");
            dtRT1.Columns.Add("RT1_RP1_ReceiptCode");
            dtRT1.Columns.Add("RT1_ZNumber");
            dtRT1.Columns.Add("RT1_RetreatWareHouse");
            dtRT1.Columns.Add("RT1_OCurrencySums");
            dtRT1.Columns.Add("RT1_DCurrencySums");
            dtRT1.Columns.Add("RT1_PO1_Currency");
            dtRT1.Columns.Add("RT1_State");
            dtRT1.Columns.Add("RT1_RgDt");
            dtRT1.Columns.Add("RT1_RgUser");
            dtRT1.Columns.Add("RT1_LmDt");
            dtRT1.Columns.Add("RT1_LmUser");
            dtRT1.Columns.Add("RT1_UptNo");

            //赋值
            //dtRT1.Rows[0]["RT1_ID"] = strGUID;

            //退货子表
            //dtRT2.Columns.Add("RT2_ID");
            dtRT2.Columns.Add("RT2_CONO");
            dtRT2.Columns.Add("RT2_DIVI");
            dtRT2.Columns.Add("RT2_RetreatCode");
            dtRT2.Columns.Add("RT2_PO2_LISeq");
            dtRT2.Columns.Add("RT2_PO2_LSSeq");
            dtRT2.Columns.Add("RT2_PD1_ProductCode");
            dtRT2.Columns.Add("RT2_Number");
            dtRT2.Columns.Add("RT2_PO2_Unit");
            dtRT2.Columns.Add("RT2_PO2_OCurrencyPrice");
            dtRT2.Columns.Add("RT2_PO2_DCurrencyPrice");
            dtRT2.Columns.Add("RT2_PO2_OCurrencyAMount");
            dtRT2.Columns.Add("RT2_PO2_DCurrencyAMount");
            dtRT2.Columns.Add("RT2_Discount");
            dtRT2.Columns.Add("RT2_State");
            dtRT2.Columns.Add("RT2_RgDt");
            dtRT2.Columns.Add("RT2_RgUser");
            dtRT2.Columns.Add("RT2_LmDt");
            dtRT2.Columns.Add("RT2_LmUser");
            dtRT2.Columns.Add("RT2_UptNo");

            //交易表
            //dtTS1.Columns.Add("TS1_ID");
            dtTS1.Columns.Add("TS1_CONO");
            dtTS1.Columns.Add("TS1_PO1_POCode");
            dtTS1.Columns.Add("TS1_DIVI");
            dtTS1.Columns.Add("TS1_TransType");
            dtTS1.Columns.Add("TS1_WH1_WareHouseCode");
            dtTS1.Columns.Add("TS1_SA1_LocationCode");
            dtTS1.Columns.Add("TS1_PD1_ProductCode");
            dtTS1.Columns.Add("TS1_TransNumber");
            dtTS1.Columns.Add("TS1_BNumber");
            dtTS1.Columns.Add("TS1_ANumber");
            dtTS1.Columns.Add("TS1_TransCurrency");
            dtTS1.Columns.Add("TS1_SupplierTax");
            dtTS1.Columns.Add("TS1_TransDPrice");
            dtTS1.Columns.Add("TS1_TransDAMount");
            dtTS1.Columns.Add("TS1_TransDTaxPrice");
            dtTS1.Columns.Add("TS1_TransDTaxAmount");
            dtTS1.Columns.Add("TS1_TransOPrice");
            dtTS1.Columns.Add("TS1_TransOAMount");
            dtTS1.Columns.Add("TS1_TransOTaxPrice");
            dtTS1.Columns.Add("TS1_TransOTaxAmount");
            dtTS1.Columns.Add("TS1_RefCODE");
            dtTS1.Columns.Add("TS1_RefType");
            dtTS1.Columns.Add("TS1_LINumber");
            dtTS1.Columns.Add("TS1_LSNumber");
            dtTS1.Columns.Add("TS1_AP1_APCode");
            dtTS1.Columns.Add("TS1_RgDt");
            dtTS1.Columns.Add("TS1_RgUser");
            dtTS1.Columns.Add("TS1_LmDt");
            dtTS1.Columns.Add("TS1_LmUser");
            dtTS1.Columns.Add("TS1_UptNo");


            //赋值
            //strGUID = System.Guid.NewGuid().ToString();
            //dtTS1.Rows[0]["TS1_ID"] = strGUID;

            //库存表
            dtSK1.Columns.Add("SK1_ID");
            dtSK1.Columns.Add("SK1_CONO");
            dtSK1.Columns.Add("SK1_DIVI");
            dtSK1.Columns.Add("SK1_WH1_WareHouseCode");
            dtSK1.Columns.Add("SK1_SA1_LocationCode");
            dtSK1.Columns.Add("SK1_BatchCode");
            dtSK1.Columns.Add("SK1_PD1_ProductCode");
            dtSK1.Columns.Add("SK1_StockNumber");
            dtSK1.Columns.Add("SK1_UsableNumber");
            dtSK1.Columns.Add("SK1_State");
            dtSK1.Columns.Add("SK1_RgDt");
            dtSK1.Columns.Add("SK1_RgUser");
            dtSK1.Columns.Add("SK1_LmDt");
            dtSK1.Columns.Add("SK1_LmUser");
            dtSK1.Columns.Add("SK1_UptNo");


            //赋值
            // strGUID = System.Guid.NewGuid().ToString();
            //dtSK1.Rows[0]["SK1_ID"] = strGUID;

            //采购单子表
            dtPO2.Columns.Add("PO2_ID");
            dtPO2.Columns.Add("PO2_CONO");
            dtPO2.Columns.Add("PO2_DIVI");
            dtPO2.Columns.Add("PO2_POCode");
            dtPO2.Columns.Add("PO2_LISeq");
            dtPO2.Columns.Add("PO2_LSSeq");
            dtPO2.Columns.Add("PO2_State");
            dtPO2.Columns.Add("PO2_PD1_SupperierStyle");
            dtPO2.Columns.Add("PO2_PD1_SupperierColor");
            dtPO2.Columns.Add("PO2_PD1_SupperierSize");
            dtPO2.Columns.Add("PO2_PD1_ProductCode");
            dtPO2.Columns.Add("PO2_Number");
            dtPO2.Columns.Add("PO2_Unit");
            dtPO2.Columns.Add("PO2_PurchaseCurrency");
            dtPO2.Columns.Add("PO2_OCurrencyPrice");
            dtPO2.Columns.Add("PO2_DCurrencyPrice");
            dtPO2.Columns.Add("PO2_OCurrencyAMount");
            dtPO2.Columns.Add("PO2_DCurrencyAMount");
            dtPO2.Columns.Add("PO2_PlanDeliveryDate");
            dtPO2.Columns.Add("PO2_RgDt");
            dtPO2.Columns.Add("PO2_RgUser");

            //索赔单子表
            dtCD2.Columns.Add("CD2_ClaimCode");
            dtCD2.Columns.Add("CD2_DIVI");
            dtCD2.Columns.Add("CD2_State");
            dtCD2.Columns.Add("CD2_LmDt");
            dtCD2.Columns.Add("CD2_LmUser");

            //索赔主表
            dtCD1.Columns.Add("CD1_DIVI");
            dtCD1.Columns.Add("CD1_RT1_RetreatCode");
            dtCD1.Columns.Add("CD1_ClaimCode");
            dtCD1.Columns.Add("CD1_RetreatWareHouse");
            dtCD1.Columns.Add("CD1_State");
            dtCD1.Columns.Add("CD1_ClaimType");
            //dtCD1.Rows[0]["CD1_ClaimType"] = "退货";
            //dtCD1.Rows[0]["CD1_State"] = "20";

            //将创建的表添加到DataSet中，并返回给Handle。
            dtPO2.TableName = "dtPO2";
            dtRT1.TableName = "dtRT1";
            dtRT2.TableName = "dtRT2";
            dtSK1.TableName = "dtSK1";
            dtTS1.TableName = "dtTS1";
            dtCD2.TableName = "dtCD2";
            dtCD1.TableName = "dtCD1";

            dsReturn.Tables.Add(dtPO2);
            dsReturn.Tables.Add(dtRT1);
            dsReturn.Tables.Add(dtRT2);
            dsReturn.Tables.Add(dtSK1);
            dsReturn.Tables.Add(dtTS1);
            dsReturn.Tables.Add(dtCD2);
            dsReturn.Tables.Add(dtCD1);


            return dsReturn;
        }
        #endregion

        #region GetWinData
        /// <summary>
        /// 用于取出弹出窗口的数据。
        /// </summary>
        private void GetWinData()
        {
            string strCliamCode = dt_List.Rows[0]["CliamCode"].ToString();
            string strSQL = @"
                            SELECT [CD2_PD1_ProductCode]
                                  ,[CD2_PO2_LISeq]
                                  ,[CD2_PO2_LSSeq]
                                  ,[CD2_Number]
                                  ,[CD2_PO2_Unit]
                                  ,[CD2_PO2_OCurrencyPrice]
                                  ,[CD2_PO2_OCurrencyAMount]
                                  ,[CD2_PO2_OCurrencyRebatePrice]
                                  ,[CD2_PO2_OCurrencyRebateAMount]
                                  ,[CD1_PO1_Currency]
                                  ,[ST1_LargeClass]
                                  ,[ST1_SmallClass]
                            FROM [dbo].[View_ClaimWin]
                            WHERE CD2_DIVI = '" + strComp + "' AND [CD2_ClaimCode] = @param0";
            m_ReturnData = conn.GetDataSet(strSQL, new string[] { strCliamCode });
        }
        #endregion

        #endregion
    }
}
