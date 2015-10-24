using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;


using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

//WSID:ab830f30-75d8-44f8-a272-f96a5bb5001a
namespace HZY.COM.WS.GroupERP
{
    public class POReceipt : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public POReceipt()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量
        Dbconn conn = new Dbconn(),
            lx_conn = new Dbconn("F22LX"), //斓绣
            rs_conn = new Dbconn("F22RS"),//斓居
            gl_conn = new Dbconn("F22GL");//雅斓

        DataTable dtEditResult = new dsCommon.dtResultDataTable(),
                  dt_EditResult = new dsCommon.dtResultDataTable();

        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet(),
                dsReturn = new DataSet(),
                dsDetail = new DataSet();
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
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                string strOPTYPE = dt_OPTYPE.Rows[0][0].ToString();
                strComp = m_hzyMessage.Env_SN;
                conn = new Dbconn(strComp);

                switch (strOPTYPE)
                {
                    case "cmbGetSupplier": cmbGetSupplier(); break;
                    case "cmbGetPo": cmbGetPo(); break;
                    case "cmbGetFailure": cmbGetFailure(); break;
                    case "cmbGetAP": cmbGetAP(); break;
                    case "onExpandRow": onExpandRow(); break;
                    case "Search": Search(); break;
                    case "winGetDetailOld": winGetDetailOld(); break;
                    case "winGetDetailNew": winGetDetailNew(); break;
                    case "Insert": Insert(); break;
                    case "GetWH": GetWH(); break;
                    case "GetDataForRP": GetDataForRP(); break;
                };
                return dsReturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 下拉框初始化
        /// <summary>
        /// 取下拉框的值
        /// </summary>
        private void cmbGetSupplier()
        {
            string strFilter = m_request.Tables[0].Rows[0]["q"].ToString();
            string strSQL = @"
                        SELECT
                        [SP1_SupplierCode],
                        [SP1_Name]
                        FROM [B01_MDM].[SP1_Supplier]
                        WHERE  1=1 AND [SP1_DIVI] = '" + strComp + @"' AND  
                        [SP1_Name] LIKE '%" + strFilter + "%'";
            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region  下拉框获取PO
        private void cmbGetPo()
        {
            string strSupplier = ds.Tables["list"].Rows[0]["where"].ToString();
            string strSQL = @"
                            SELECT
                            [PO1_POCode],
                            [PO1_POCode] [PO1_POCodeN],
                            [PO1_SPPOCode],
                            [PO1_RgUser]
                            FROM [B02_BILL].[PO1_POHead] [a] WITH(NOLOCK)
                            WHERE  1=1 AND [a].PO1_DIVI = '" + strComp + @"'
                            EXISTS(
                                SELECT 1 FROM [B02_BILL].[PO1_POHead] [b] WITH(NOLOCK)
                                WHERE [b].PO1_DIVI = '" + strComp + @"' 
                                AND [a].[PO1_POCode]=[b].[PO1_POCode]
                                AND [b].[PO1_SupplierCode] ='" + strSupplier + @"'
                            )";
            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 下拉框获取不合格原因码
        private void cmbGetFailure()
        {
            string strSQL = @"
                            SELECT 
                            [CT1_OptionsValues],
                            [CT1_Options]
                            FROM [M01_CONF].[CT0_CSYTAB]
                            WHERE [CT1_CONO] = 'HYFG' AND [CT1_DIVI] = '" + strComp + @"' 
                                  AND [CT1_Code] = 'UQCD'
                            ORDER BY [CT1_OptionsValues]";
            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 下拉框获取AP
        private void cmbGetAP()
        {
            string strPo = ds.Tables["list"].Rows[0]["where"].ToString();
            string strSQL = @"
                            SELECT
                            [AP1_APCode]
                            FROM [B02_BILL].[AP1_APOHead] [a]
                            WHERE  1=1 AND [a].[AP1_DIVI] = '" + strComp + @"'
                            EXISTS(
                                SELECT 1 FROM [B02_BILL].[PO1_POHead] [b] 
                                WHERE [b].[AP1_DIVI] = '" + strComp + @"' AND
                                [a].[AP1_PO1_PurchaseCode] = [b].[PO1_POCode]
                                AND [a].[AP1_PO1_PurchaseCode] ='" + strPo + @"'
                            )";

            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取收货的具体数据数据。到货计划下展开的数据
        private void onExpandRow()
        {
            string strPo = ds.Tables["list"].Rows[0]["Po"].ToString();
            string strAP = ds.Tables["list"].Rows[0]["AP"].ToString();
            string strWhere = "WHERE t1.RP1_DIVI='" + strComp + "' ";
            if (strPo != "" && strAP == "")
            {
                strWhere += @" AND RP1_ReceiptCode IN (
                            SELECT RP1_ReceiptCode
                            FROM B02_BILL.RP1_POReceiptHead  WITH(NOLOCK)
                            WHERE RP1_DIVI = '" + strComp + @"' AND RP1_AP1_APCode = ''
                            AND RP1_PO1_POCode = '" + strPo + "')";
            };
            if (strPo != "" && strAP != "")
            {
                strWhere += @" AND EXISTS(
                            SELECT 
                            t2.RP1_PO1_POCode 
                            FROM B02_BILL.RP1_POReceiptHead t2 WITH(NOLOCK)
                            WHERE t2.RP1_DIVI = '" + strComp + @"' 
                            AND t1.RP1_PO1_POCode = t2.RP1_PO1_POCode
                            AND t2.RP1_PO1_POCode = '" + strPo + @"')";
            };
            if (strAP != "" && strAP != "")
            {
                strWhere += @" AND EXISTS (
                                SELECT t3.RP1_AP1_APCode 
                                FROM B02_BILL.RP1_POReceiptHead t3 WITH(NOLOCK)
                                WHERE t3.RP1_DIVI = '" + strComp + @"' 
                                AND t1.RP1_AP1_APCode = t3.RP1_AP1_APCode 
                                AND t3.RP1_AP1_APCode = '" + strAP + "')";
            };
            strWhere += @"
                        GROUP BY t1.RP1_ReceiptCode
                                ,t1.RP1_LState
                                ,t1.RP1_HState
                                ,t4.RP2_UnqualifiedCode
                                ,t1.RP1_AP1_APCode
                                ,t1.RP1_POSNO
                                ,t2.PO1_POCode
                                ,t1.RP1_RgUser
                                ,t2.PO1_SupplierCode
                                ,t2.PO1_RgUser
                                ,t1.RP1_WHSP_WarehousePOS
                                ,t1.RP1_RgDt";
            string strSql = @"
                            SELECT t1.RP1_ReceiptCode
                                ,t2.PO1_POCode
                                ,t1.RP1_AP1_APCode
                                ,t1.RP1_POSNO
                                ,(CASE WHEN t4.RP2_UnqualifiedCode = '' THEN '合格品' 
                                WHEN t4.RP2_UnqualifiedCode <> '' THEN	'不合格品'  END ) RPTYPE
                                ,t1.RP1_HState
                                ,t1.RP1_LState
                                ,t1.RP1_WHSP_WarehousePOS
                                ,sum(t4.RP2_Number) RP2_Number
                                ,t1.RP1_RgUser
                                ,t2.PO1_SupplierCode
                                ,t2.PO1_RgUser
                                ,CONVERT(varchar(100), t1.RP1_RgDt, 20) RP1_RgDt
                            FROM B02_BILL.RP1_POReceiptHead t1 WITH(NOLOCK)
                            LEFT JOIN B02_BILL.RP2_POReceiptDetail t4 WITH(NOLOCK) ON t1.RP1_ReceiptCode = t4.RP2_ReceiptCode AND t1.RP1_CONO=t4.RP2_CONO AND t1.RP1_DIVI=t4.RP2_DIVI
                            LEFT JOIN B02_BILL.PO1_POHead t2 WITH(NOLOCK) ON t1.RP1_PO1_POCode = t2.PO1_POCode AND t1.RP1_CONO=t2.PO1_CONO AND t1.RP1_DIVI=t2.PO1_DIVI
                            " + strWhere;
            dsReturn = conn.GetDataSet(strSql);
        }
        #endregion

        #region 查询的方法
        private void Search()
        {
            string strWhere = " WHERE 1=1";
            string strSupplierCode = ds.Tables["list"].Rows[0]["SupplierCode"].ToString();
            string strPoCode = ds.Tables["list"].Rows[0]["POCode"].ToString();
            string strSPPOCode = ds.Tables["list"].Rows[0]["SPPOCode"].ToString();
            string strRguser = ds.Tables["list"].Rows[0]["RgUser"].ToString();
            string strAPCode = ds.Tables["list"].Rows[0]["APCode"].ToString();
            if (strSupplierCode != "")
            {
                strWhere += @" AND EXISTS (
                        SELECT 1 FROM [#DATA] [c] WITH(NOLOCK) WHERE [t1].[PO1_POCode] = [c].[PO1_POCode]
                        AND [c].[PO1_suppliercode] = '" + strSupplierCode + "') ";
            };
            if (strPoCode != "")
            {
                strWhere += @" AND EXISTS (
                        SELECT 1 FROM [#DATA] [c] WITH(NOLOCK) WHERE [t1].[PO1_POCode] = [c].[PO1_POCode]
                        AND [c].[PO1_POCode] = '" + strPoCode + "') ";
            };
            if (strSPPOCode != "")
            {
                strWhere += " AND [t1].[PO1_SPPOCode] = '" + strSPPOCode + "' ";
            };
            if (strRguser != "")
            {
                strWhere += @" AND EXISTS (
                        SELECT 1 FROM [#DATA] [c] WITH(NOLOCK) WHERE [t1].[PO1_POCode] = [c].[PO1_POCode]
                        AND [c].[PO1_LmUser] = '" + strRguser + "') ";
            };
            if (strAPCode != "")
            {
                strWhere += @" AND EXISTS (
                        SELECT 1 FROM [#DATA] [c] WITH(NOLOCK) WHERE [t1].[AP1_APCode] = [c].[AP1_APCode]
                        AND [c].[AP1_APCode] = '" + strAPCode + "')";
            };
            conn.BeginTransaction();
            string strSQL = @"

                        --获取PO数量
                        SELECT [T1].[PO1_POCode]
                            ,[T1].[PO1_RgUser]
                            ,ISNULL([T1].[PO1_PZNumber],0) AS [PO1_PZNumber]
                            ,SUM(ISNULL([T3].[RP2_Number],0)) AS [POSum] 
                            INTO #PONum
                        FROM [B02_BILL].[PO1_POHead] T1 WITH (NOLOCK)
                        LEFT JOIN B02_BILL.RP1_POReceiptHead T2 WITH(NOLOCK) ON [T1].[PO1_POCode] = [T2].[RP1_PO1_POCode] AND [T1].[PO1_DIVI]=[T2].[RP1_DIVI]
                        LEFT JOIN B02_BILL.RP2_POReceiptDetail T3 WITH(NOLOCK) ON T2.RP1_ReceiptCode = T3.RP2_ReceiptCode AND T3.RP2_State = '90' AND [T2].[RP1_DIVI]=[T3].[RP2_DIVI]
                        WHERE T1.PO1_DIVI = '" + strComp + @"'  
                        GROUP BY [T1].[PO1_POCode]
                                ,[T1].[PO1_PZNumber]
                                ,[T1].[PO1_RgUser]

                        --求PO的数量差
                        SELECT PO1_POCode
	                            ,PO1_PZNumber
	                            ,POSum
                                ,PO1_RgUser
	                            ,ABS((PO1_PZNumber-POSum)) AS PODiff
	                            INTO #PODATA
                        FROM #PONum WITH (NOLOCK)

                        --获取AP数量
                        SELECT [T1].[AP1_PO1_PurchaseCode]
                               ,[T1].[AP1_APCode]
                               ,[T1].[AP1_APlanNumber]
                               ,SUM(ISNULL([T3].[RP2_Number],0)) AS APSum
                        INTO #APNum
                        FROM [B02_BILL].[AP1_APOHead] [T1] WITH (NOLOCK)
                        LEFT JOIN [B02_BILL].[RP1_POReceiptHead] [T2] ON T1.AP1_APCode = T2.RP1_AP1_APCode AND T1.AP1_DIVI=T2.RP1_DIVI
                        LEFT JOIN [B02_BILL].[RP2_POReceiptDetail] [T3] ON T3.RP2_ReceiptCode = T2.RP1_ReceiptCode AND [T3].[RP2_State]= '90' AND T3.RP2_DIVI=T2.RP1_DIVI
                        WHERE T1.AP1_DIVI = '" + strComp + @"'
                        GROUP BY [T1].[AP1_PO1_PurchaseCode]
                        ,[T1].[AP1_APCode]
                        ,[T1].[AP1_APlanNumber]
                        ORDER BY AP1_PO1_PurchaseCode

                        --求AP的数量差
                        SELECT AP1_PO1_PurchaseCode
	                            ,AP1_APCode
	                            ,AP1_APlanNumber
	                            ,APSum
	                            ,ABS(AP1_APlanNumber-APSum) AS APDiff 
	                            INTO #APDATA
                        FROM #APNum WITH (NOLOCK)

                        --合并POAP数据
                        SELECT 
                        [T1].[PO1_POCode]
                        ,[T1].[PO1_PZNumber]
                        ,[T1].[POSum]
                        ,[T1].[PODiff]
                        ,[T2].[AP1_APCode]
                        ,[T2].[AP1_APlanNumber]
                        ,[T1].[PO1_RgUser]
                        ,ISNULL([T2].[APSum],0) AS [APSum]
                        ,ISNULL([T2].[APDiff],0) AS [APDiff]
                        INTO #POAPDATA
                        FROM #PODATA T1 WITH (NOLOCK)
                        LEFT JOIN #APDATA T2 WITH (NOLOCK) ON [T1].[PO1_POCode] = [T2].[AP1_PO1_PurchaseCode] 

                        --所有数据
                        SELECT T1.[PO1_SupplierCode]
                        ,T1.[PO1_POCode]
                        ,T1.[PO1_Company]
                        ,T2.[PO1_PZNumber]
                        ,T2.[POSum]
                        ,T2.[PODiff]
                        ,T2.[AP1_APCode]
                        ,ISNULL(T2.[AP1_APlanNumber],0) AP1_APlanNumber
                        ,T2.[APSum]
                        ,T2.[APDiff] 
                        ,T1.[PO1_LmUser]
                        ,T1.[PO1_LmDt]
                        ,T2.[PO1_RgUser]
                        INTO #ALLDATA
                        FROM B02_BILL.PO1_POHead T1 WITH (NOLOCK)
                        LEFT JOIN #POAPDATA T2 WITH (NOLOCK) ON T1.PO1_POCode = T2.PO1_POCode
                        WHERE T1.PO1_DIVI = '" + strComp + @"'  

                        --成品数据
                        SELECT  PO1_SupplierCode
	                            ,PO1_POCode
                                ,PO1_Company
                                ,PO1_PZNumber
	                            ,POSum
	                            ,PODiff
	                            ,AP1_APCode
	                            ,AP1_APlanNumber
	                            ,APSum
	                            ,APDiff
                                ,PO1_RgUser
	                            ,PO1_LmUser
	                            ,PO1_LmDt
	                            INTO #DATA
                            FROM #ALLDATA WITH(NOLOCK) WHERE AP1_APCode IS NOT NULL
                            UNION ALL
                            SELECT DISTINCT PO1_SupplierCode
	                            ,PO1_POCode
                                ,PO1_Company
                                ,PO1_PZNumber
	                            ,POSum
	                            ,PODiff
	                            ,NULL AS AP1_APCode
	                            ,0 AS AP1_APlanNumber
	                            ,0 AS APSumm
	                            ,0 AS APDiff
                                ,PO1_RgUser
	                            ,PO1_LmUser
	                            ,PO1_LmDt
                            FROM #ALLDATA WITH(NOLOCK)";
            conn.ExcuteQuerryByTran(strSQL, new string[] { });

            strSQL = @"
                        SELECT
                        [t1].[PO1_SupplierCode], 
                        [t1].[PO1_POCode],
                        [t1].[PO1_Company],
                        [t1].[AP1_APCode],
                        [t1].[PO1_PZNumber],
                        [t1].[POSum],
                        [t1].[PODiff],
                        [t1].[AP1_APlanNumber],
                        [t1].[APSum],
                        [t1].[APDiff],
                        [t1].[PO1_LmDt],
                        [t1].[PO1_RgUser],
                        [t1].[PO1_LmUser]
                        FROM [#DATA] t1"
                + strWhere + m_hzyPageInfo.Where;
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            conn.CommitTransaction();
        }
        #endregion

        #region 扫描窗口弹出时抽取数据的方法。(有收货单)
        private void winGetDetailOld()
        {
            string strRPCode = ds.Tables["list"].Rows[0]["rpcode"].ToString();
            string strWhere = " WHERE 1=1";
            strWhere += " AND RP2_ReceiptCode = '" + strRPCode + "'";

            string strSQLTemp = @"
                          --采购单入库数量
                          SELECT PO2_POCode
                          ,PO2_DIVI
                          ,PO2_LISeq
                          ,PO2_LSSeq
                          ,PO2_PD1_ProductCode
                          ,PO2_Number
                          ,SUM(T2.RP2_Number) AS SumPO
                          INTO #RPSum
                          FROM B02_BILL.PO2_PODetail T1 WITH (NOLOCK)
                          LEFT JOIN B02_BILL.RP2_POReceiptDetail T2 WITH (NOLOCK) ON T1.PO2_LISeq = T2.RP2_LINumber AND T1.PO2_DIVI=T2.RP2_DIVI 
                          AND T1.PO2_LSSeq = T2.RP2_LSNumber AND T2.RP2_State = '90' AND T2.RP2_DIVI = '" + strComp + @"'
                          WHERE T1.PO2_DIVI = '" + strComp + @"'
                          GROUP BY PO2_POCode,PO2_DIVI,PO2_LISeq,PO2_LSSeq,PO2_PD1_ProductCode,PO2_Number
                          
                          --到货计划入库数量
                          SELECT DISTINCT t1.AP2_APCode
		                        ,t1.AP2_LINumber
		                        ,t1.AP2_LSNumber
		                        ,t1.AP2_PD1_ProductCode
		                        ,t1.AP2_APlanDt
                                ,t2.AP1_DIVI
		                        ,sum(isnull(t1.AP2_APlanNumber,0)) AP2_APlanNumber
		                        ,sum(isnull(t4.[RP2_Number],0)) SUMAP
		                        INTO #APSum
	                        FROM B02_BILL.AP2_APODetail t1 WITH (NOLOCK)
	                        JOIN B02_BILL.AP1_APOHEAD t2 WITH (NOLOCK) ON t1.AP2_APCode = t2.AP1_APCode AND t1.AP2_DIVI=t2.AP1_DIVI
	                        LEFT JOIN [B02_BILL].[RP1_POReceiptHead] t3 WITH (NOLOCK) ON t1.AP2_APCode = t3.RP1_AP1_APCode AND t3.RP1_DIVI=t2.AP1_DIVI
	                        LEFT JOIN [B02_BILL].[RP2_POReceiptDetail] t4 WITH (NOLOCK) ON t3.RP1_ReceiptCode = t4.RP2_ReceiptCode AND t4.RP2_DIVI=t3.RP1_DIVI
		                        AND t4.RP2_LINumber=t1.AP2_LINumber AND t4.RP2_LSNumber=T1.AP2_LSNumber AND T1.AP2_PD1_ProductCode=t1.AP2_PD1_ProductCode AND t4.[RP2_State] = '90'
                            WHERE t1.AP2_DIVI = '" + strComp + @"'
	                        GROUP BY t1.AP2_APCode ,t1.AP2_LINumber,t1.AP2_LSNumber,t1.AP2_PD1_ProductCode,t1.AP2_APlanDt,t2.AP1_DIVI

                        --综合数据
                        SELECT [RP2_ReceiptCode]
                              ,[Code]
                              ,[LISeq]
                              ,[LSSeq]
                              ,[SKUCode]
                              ,[PlanDate]
                              ,[PlanNumber]
                              ,[RP2_Number]
                              ,CASE WHEN T2.SumPO IS NULL THEN T3.SumAP ELSE T2.SumPO END AS SumNumber
                              ,[RP2_UnqualifiedCode]
                              ,[RP2_UnqualifiedDesp]
                              ,[RP2_State]
                            INTO #DATA
                          FROM [dbo].[View_ReceiptDataOld] T1 WITH (NOLOCK)
                          LEFT JOIN #RPSum T2 WITH (NOLOCK) ON T1.Code = T2.PO2_POCode 
                          AND T2.PO2_LISeq = T1.[LISeq] AND T1.[LSSeq] = T2.PO2_LSSeq AND T2.PO2_DIVI=T1.RP2_DIVI 
                          LEFT JOIN #APSum T3 WITH (NOLOCK) ON T1.Code = T3.AP2_APCode
                          AND T3.AP2_LINumber = T1.[LISeq] AND T1.[LSSeq] = T3.AP2_LSNumber";
            conn.BeginTransaction();
            conn.ExcuteQuerryByTran(strSQLTemp, new string[] { });

            string strSQL = @"
                            SELECT [RP2_ReceiptCode]
                                  ,[Code]
                                  ,[LISeq]
                                  ,[LSSeq]
                                  ,[SKUCode]
                                  ,[PlanDate]
                                  ,[PlanNumber]
                                  ,[RP2_Number] AS [SumNumber]
                                  ,[RP2_Number] AS [Number]
                                  ,[RP2_Number]
                                  ,ABS([PlanNumber]-[RP2_Number]) AS [Diff]
                                  ,[RP2_UnqualifiedCode]
                                  ,[RP2_UnqualifiedDesp]
                                  ,[RP2_State]
                            FROM #DATA" + strWhere + m_hzyPageInfo.Where;
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            conn.CommitTransaction();
        }
        #endregion

        #region 扫描窗口弹出时抽取数据的方法。(无收货单)
        private void winGetDetailNew()
        {

            string strPOCode = ds.Tables["list"].Rows[0]["pocode"].ToString();
            string strAPCode = ds.Tables["list"].Rows[0]["apcode"].ToString();
            // string strWhere = " 1=1 AND PO2_DIVI = '" + strComp + "' ";
            string strSQL = "";
            if (strAPCode == "")
            {
                //strWhere =strWhere+ " AND POCode = '" + strPOCode + "' AND SeqSum NOT IN (SELECT SeqSum FROM [dbo].[View_ReceiptData] WITH (NOLOCK) WHERE POCode = '"
                //+ strPOCode + "' AND APCode IS NOT NULL AND PO2_DIVI=')" + strComp + "'";

                strSQL = @" SELECT [POCode] AS [Code]
                              ,[LISeq]
                              ,[LSSeq]
                              ,[SKUCode]
                              ,[PLANNumber]
                              ,[PLANDate]
                              ,[SumNumber] AS Number
                              ,[Diff]
                            FROM [dbo].[View_ReceiptData] WITH (NOLOCK) WHERE PO2_DIVI='" + strComp + "' AND POCode='" + strPOCode + "' AND (APCode IS NULL OR APCode='')";

            }
            else
            {
                //strWhere = strWhere + " AND APCode = '" + strAPCode + "'";

                strSQL = @" SELECT [APCode] AS [Code]
                              ,[LISeq]
                              ,[LSSeq]
                              ,[SKUCode]
                              ,[PLANNumber]
                              ,[PLANDate]
                              ,[SumNumber] AS Number
                              ,[Diff]
                            FROM [dbo].[View_ReceiptData] WITH (NOLOCK) WHERE PO2_DIVI='" + strComp + "' AND POCode='" + strPOCode + "' AND APCode='" + strAPCode + "'";
            };
            conn.BeginTransaction();

            //strSQL += strWhere + m_hzyPageInfo.Where;
            dsReturn = conn.GetDataSet(strSQL);
            conn.CommitTransaction();
        }

        #endregion

        #region 保存按钮的方法.会调用SaveReceipt方法
        private void Insert()
        {
            string strReceiptCode = ds.Tables["list"].Rows[0]["RP1_ReceiptCode"].ToString();

            DataTable dtRn = SaveReceipt(ds, strReceiptCode);     //调用保存方法

            dsReturn.Tables.Add(dtRn);
        }
        #endregion

        #region SaveReceipt方法
        /// <summary>
        /// 按照传过来的Dataset插入到收货单的主子表中
        /// </summary>
        /// <param name="pdsData">需要保存的数据集</param>
        /// <param name="pstrReCode">收货单号(如果是空,则为新建,如果不为空则为修改)</param>
        /// <returns>return 收货单号</returns>

        private DataTable SaveReceipt(DataSet pdsData, String pstrReCode)
        {
            try
            {
                string strReceiptCode = "";
                string strRP2_UnqualifiedDesp = "";
                string strPoCode = pdsData.Tables["list"].Rows[0]["RP1_PO1_POCode"].ToString();
                string strDIVI = pdsData.Tables["list"].Rows[0]["RP1_DIVI"].ToString();
                //查询收货数量 2015-07-02 yjw
                string strSQL = @"
                                    SELECT RP2_CONO,RP2_DIVI,RP1_PO1_POCode,RP2_PD1_ProductCode
	                                    ,RP2_LINumber,RP2_LSNumber,SUM(RP2_Number) TOTAL
                                    FROM B02_BILL.RP1_POReceiptHead WITH(NOLOCK) 
                                    LEFT JOIN B02_BILL.RP2_POReceiptDetail WITH(NOLOCK) 
	                                    ON RP1_ReceiptCode=RP2_ReceiptCode AND RP1_DIVI=RP2_DIVI
                                    WHERE RP1_PO1_POCode='" + strPoCode + @"' AND RP2_DIVI='" + strDIVI + @"' 
                                    GROUP BY RP2_CONO,RP2_DIVI,RP1_PO1_POCode,RP2_PD1_ProductCode,RP2_LINumber,RP2_LSNumber ";
                DataTable RP_Table = conn.GetDataTable(strSQL);

                if (pstrReCode == "")
                {
                    string strRgur = this.hzyMessage.User_Name;
                    string strXMLDetail = pdsData.Tables["list"].Rows[0]["Detail"].ToString();

                    //仓库编号
                    string strWareHouseCode = pdsData.Tables["LIST"].Rows[0]["RP1_WHSP_WarehousePOS"].ToString();

                    DataSet dsDetail = Common.Common.GetDSByExcelXML(strXMLDetail);

                    strRP2_UnqualifiedDesp = dsDetail.Tables["list"].Rows[0]["RP2_UnqualifiedDesp"].ToString();

                    //pdsData.Tables["list"].Rows[0]["RP1_FACI"] = strIndentify;
                    pdsData.Tables["list"].Rows[0]["RP1_RgUser"] = strRgur;
                    pdsData.Tables["list"].Rows[0]["RP1_RgDt"] = timeNow;
                    pdsData.Tables["list"].Columns.Remove("Detail");
                    System.Guid guid = System.Guid.NewGuid(); //Guid 类型
                    string strGUID = System.Guid.NewGuid().ToString(); //直接返回字符串类型
                    strReceiptCode = AutoKeyCode.GetMaxKeyCode("新增收货单编号", strPoCode, m_hzyMessage.Env_SN, "", conn);
                    pdsData.Tables["list"].Rows[0]["RP1_ID"] = strGUID;
                    pdsData.Tables["list"].Rows[0]["RP1_ReceiptCode"] = strReceiptCode;
                    for (int j = 0; j < dsDetail.Tables["list"].Rows.Count; j++)
                    {
                        //yjw 2015-07-09 控制超收
                        //string where = "RP2_LINumber='" + dsDetail.Tables["list"].Rows[j]["RP2_LINumber"].ToString()
                        //    + "' AND RP2_LSNumber='" + dsDetail.Tables["list"].Rows[j]["RP2_LSNumber"].ToString()
                        //    + "' AND RP1_PO1_POCode='" + strPoCode
                        //    + "' AND RP2_PD1_ProductCode='" + dsDetail.Tables["list"].Rows[j]["RP2_PD1_ProductCode"].ToString() + "'";
                        //DataRow[] dr = RP_Table.Select(where);
                        //if (dr.Length > 0)
                        //{
                        //    decimal rp = Convert.ToDecimal(dr[0]["TOTAL"].ToString()) + Convert.ToDecimal(dsDetail.Tables["list"].Rows[j]["RP2_Number"].ToString());
                        //}
                        string strDetailGUID = System.Guid.NewGuid().ToString();
                        dsDetail.Tables["list"].Rows[j]["RP2_ID"] = strDetailGUID;
                        dsDetail.Tables["list"].Rows[j]["RP2_ReceiptCode"] = strReceiptCode;
                        dsDetail.Tables["list"].Rows[j]["RP2_RgDt"] = timeNow;
                        dsDetail.Tables["list"].Rows[j]["RP2_Rguser"] = strRgur;
                        dsDetail.Tables["list"].Rows[j]["RP2_LmDt"] = timeNow;
                        dsDetail.Tables["list"].Rows[j]["RP2_LmUser"] = strRgur;
                    }
                    bool bResult = false;

                    conn.BeginTransaction(); // 开启事务

                    bResult = conn.Insert("B02_BILL.RP1_POReceiptHead", pdsData.Tables["List"]);
                    if (bResult)
                    {
                        bResult = conn.Insert("B02_BILL.RP2_POReceiptDetail", dsDetail.Tables["List"]);
                    }

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, strReceiptCode });
                        dt_EditResult.Rows.Add(new object[] { true, strRP2_UnqualifiedDesp });
                        conn.CommitTransaction();
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                        conn.RollbackTransaction();
                    }
                }
                else
                {
                    string strRgur = this.hzyMessage.User_Name;
                    string strXMLDetail = pdsData.Tables["list"].Rows[0]["Detail"].ToString();
                    DataSet dsDetail = Common.Common.GetDSByExcelXML(strXMLDetail);
                    strRP2_UnqualifiedDesp = dsDetail.Tables["list"].Rows[0]["RP2_UnqualifiedDesp"].ToString();
                    for (int j = 0; j <= dsDetail.Tables["list"].Rows.Count - 1; j++)
                    {
                        dsDetail.Tables["list"].Rows[j]["RP2_ReceiptCode"] = pstrReCode;
                        dsDetail.Tables["list"].Rows[j]["RP2_LmDt"] = timeNow;
                        dsDetail.Tables["list"].Rows[j]["RP2_LmUser"] = strRgur;
                    }
                    dsDetail.Tables["list"].Columns.Remove("RP2_ID");
                    dsDetail.Tables["list"].Columns.Remove("RP2_CONO");
                    dsDetail.Tables["list"].Columns.Remove("RP2_DIVI");
                    dsDetail.Tables["list"].Columns.Remove("RP2_MaterielState");
                    dsDetail.Tables["list"].Columns.Remove("RP2_RgDt");
                    dsDetail.Tables["list"].Columns.Remove("RP2_RgUser");

                    bool bResult = false;
                    ArrayList listKey = new ArrayList();
                    listKey.Add("RP2_ReceiptCode");
                    listKey.Add("RP2_LINumber");
                    listKey.Add("RP2_LSNumber");

                    conn.BeginTransaction(); // 开启事务

                    bResult = conn.Update("B02_BILL.RP2_POReceiptDetail", dsDetail.Tables["List"], listKey);
                    if (bResult)
                    {
                        bResult = UpLoadReceipt(pstrReCode); //更新主表数据
                    }

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, pstrReCode });
                        dt_EditResult.Rows.Add(new object[] { true, strRP2_UnqualifiedDesp });
                        conn.CommitTransaction();
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                        conn.RollbackTransaction();
                    }
                }
                return dt_EditResult;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region UpLoadReceipt方法 用于更新收货的方法
        /// <summary>
        /// 当子表更新成功时，调用这个方法。用于汇总子表的信息来UPDATE收货主表信息。
        /// </summary>
        /// <param name="pstrReCode">收货单号</param>
        /// <returns>return boolen</returns>
        private bool UpLoadReceipt(String pstrReCode)
        {
            try
            {
                bool bResult = false;
                string strSQL = @"
                SELECT 
                t1.RP2_ReceiptCode RP1_ReceiptCode,
                t1.RP2_LmDt RP1_LmDt,
                t3.RP2_Number RP1_Rnumber,
                t3.RP2_State RP1_State
                FROM B02_BILL.RP2_POReceiptDetail t1 WITH (NOLOCK)
                JOIN 
                (
                SELECT RP2_ID,RP2_LmDt FROM B02_BILL.RP2_POReceiptDetail  WITH (NOLOCK)
                WHERE RP2_DIVI = '" + strComp + @"' AND RP2_LmDt = (SELECT max(RP2_LmDt) 
                FROM B02_BILL.RP2_POReceiptDetail WITH (NOLOCK) WHERE
				RP2_DIVI = '" + strComp + @"' AND RP2_ReceiptCode = '" + pstrReCode + @"')
                AND RP2_ReceiptCode = '" + pstrReCode + @"') t2
                ON t1.RP2_ID = t2. RP2_ID
                JOIN 
                (SELECT RP2_ReceiptCode,max(RP2_Number) RP2_Number,RP2_State
                FROM B02_BILL.RP2_POReceiptDetail WITH (NOLOCK)
				WHERE RP2_DIVI = '" + strComp + @"'
                GROUP BY RP2_ReceiptCode,RP2_State) t3
                ON t1.RP2_ReceiptCode = t3.RP2_ReceiptCode";
                DataSet dsReturn = new DataSet();
                dsReturn = conn.GetDataSet(strSQL);
                ArrayList listKey = new ArrayList();
                listKey.Add("RP1_ReceiptCode");

                bResult = conn.Update("B02_BILL.RP1_POReceiptHead", dsReturn.Tables["Table"], listKey);

                return bResult;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region GetWH
        private void GetWH()
        {
            string company = m_hzyMessage.Env_SN;
            Dbconn pos_conn = new Dbconn();

            switch (company)
            {
                case "GL":
                    pos_conn = gl_conn;
                    break;
                case "LX":
                    pos_conn = lx_conn;
                    break;
                case "RS":
                    pos_conn = rs_conn;
                    break;
            }

            string strSQL = @"SELECT DepotID AS WH1_WareHouseCode
                                     ,d_name AS WH1_Name
                              FROM [dbo].[j_depot] WHERE freeze=0 and m_type=0";
            //string strComp = m_hzyMessage.Env_SN;

            DataTable dt = new DataTable();
            dt = pos_conn.GetDataTable(strSQL);

            //if (strComp == "GL")
            //{
            //    DataTable dt_gl = gl_conn.GetDataTable(strSQL);
            //    dt_EditResult = dt_gl;
            //}
            //else
            //{
            //    DataTable dt_lx = lx_conn.GetDataTable(strSQL),
            //              dt_rs = rs_conn.GetDataTable(strSQL);

            //    int RowCount = dt_rs.Rows.Count;

            //    do
            //    {
            //        DataRow dr_lx = dt_lx.NewRow();
            //        dr_lx["WH1_WareHouseCode"] = dt_rs.Rows[RowCount - 1]["WH1_WareHouseCode"];
            //        dr_lx["WH1_Name"] = dt_rs.Rows[RowCount - 1]["WH1_Name"];

            //        dt_lx.Rows.Add(dr_lx);
            //        RowCount--;
            //    } while (RowCount != 0);

            //    dt_EditResult = dt_lx;
            //};

            dsReturn.Tables.Add(dt.Copy());
        }
        #endregion

        #region
        private void GetDataForRP()
        {
            string strRPCode = "";
            string strPOCode = "";
            string strAPCode = "";
            if (ds.Tables["list"].Columns.Contains("rpcode"))
            {
                strRPCode = ds.Tables["list"].Rows[0]["rpcode"].ToString(); //收货单号
            }
            if (ds.Tables["list"].Columns.Contains("pocode"))
            {
                strPOCode = ds.Tables["list"].Rows[0]["pocode"].ToString();
            }
            if (ds.Tables["list"].Columns.Contains("apcode"))
            {
                strAPCode = ds.Tables["list"].Rows[0]["apcode"].ToString();
            }
            //dt_EditResult = conn.GetDataTable("EXEC GetDataForRP '" + strPOCode + "','" + strAPCode + "','','','','" + m_hzyMessage.Env_SN + "','" + strRPCode + "'");


            //dsReturn.Tables.Add(dt_EditResult);
            dsReturn = conn.GetDataSetBySP("GetDataForRP",
                new string[7] { "@POCODE", "@APCODE", "@SKU", "@LINumber", "@LSNumber", "@DIVI", "@RPCODE" },
                new string[7] { strPOCode, strAPCode, "", "", "", m_hzyMessage.Env_SN, strRPCode });
        }
        #endregion

        //        #region 获取Indentify
        //        private string Indentify(string pstrCode)
        //        {
        //            string strRtn = "";
        //            string strSQL = @"SELECT 
        //                                    SA1_Indentify 
        //                                    FROM [B01_MDM].[SA1_Location] 
        //                                    WHERE SA1_WH1_WareHouseCode = '" + pstrCode + "'";
        //            strRtn = conn.GetDataTableFirstValue(strSQL).ToString();
        //            return strRtn;
        //        }
        //        #endregion


        #endregion
    }
}
