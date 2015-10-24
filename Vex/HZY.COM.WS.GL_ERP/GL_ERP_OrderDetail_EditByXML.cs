using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：GL_ERP_Order_EditByXML 
/// 类说明：采购单明细增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新采购单明细
    /// </summary>
    public class GL_ERP_OrderDetail_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_OrderDetail_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新采购单明细
        /// </summary>
        /// <returns></returns>
        /// 
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                ArrayList listAMSendList = new ArrayList();

                Dbconn conn = new Dbconn("GL_ERP");

                string strXML = "";
                string strSQL = "";
                string strSQL1 = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @"  
                                      SELECT 
                                      [PR1D_CONO]
                                     ,[PR1D_DIVI]
                                     ,[PR1D_OrderDetailId]
                                     ,[PR1D_PR1_OrderId]
                                     ,[PR1D_PD0_ProductId]
                                     ,CAST([PR1D_Total] AS DECIMAL(20,0)) AS PR1D_Total
                                     ,[PR1D_UnitID]
                                     ,CAST([PR1D_POriginalPrice] AS DECIMAL(20,2)) as PR1D_POriginalPrice
                                     ,CAST([PR1D_PCurrencyPrice] AS DECIMAL(20,2)) as PR1D_PCurrencyPrice
                                     ,CAST([PR1D_SCurrencyPrice] AS DECIMAL(20,2)) as PR1D_SCurrencyPrice
                                     ,CAST([PR1D_Discount] AS DECIMAL(20,2)) as PR1D_Discount
                                     ,CAST([PR1D_EstimateCost] AS DECIMAL(20,2)) as PR1D_EstimateCost
                                     ,CAST([PR1D_OriginalAmount] AS DECIMAL(20,2)) as PR1D_OriginalAmount
                                     ,CAST([PR1D_CurrencyAmount] AS DECIMAL(20,2)) as  PR1D_CurrencyAmount
                                     ,[PR1D_Status]
                                     ,[PR1D_SendDate]
                                     ,[PR1D_Seq]
                                     ,[PR1D_RgUser]
                                     ,[PR1D_RgDt]
                                     ,[PR1D_LmUser]
                                     ,[PR1D_LmDt]
                                     ,[PR1D_UptNo]
                                     ,PR1D_CurrencyTypeId
                                     ,PD0_ColorId
                                     ,PD0_ColorSUId
                                     ,PD0_ColorBSUId
                                     ,PD0_SizeSUId
                                     ,A.PR1_OrderCode
                                     ,B.PD0_ProductCodeSU
                                     ,B.PD0_SKUSU as PR1D_PD0_SKUSU
                                     ,B.PD0_SKU as PR1D_PD0_SKU
                                     ,C.SU0_SupplierCode
                                     ,C.SU0_SupplierType
                                     ,D.DC0_DictName1 AS UnitDictName
                                     ,E.DC0_DictName1 AS StatusDictName
                                     ,H.DC0_DictName1 AS CurrencyTypeDictName
                                     ,I.DC0_DictName1 AS  ColorTypeDictName

                                     FROM B02_Bill.PR1D_OrderDetail
                                     LEFT JOIN B02_Bill.PR1_Order A        ON  A.PR1_OrderId=PR1D_PR1_OrderId
                                     LEFT JOIN B01_MDM.PD0_Product B       ON  B.PD0_ProductId=PR1D_PD0_ProductId
                                     LEFT JOIN  B01_MDM.SU0_Supplier C     ON  PR1_SU0_SupplierId=C.SU0_SupplierId
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  D ON  PR1D_UnitID=D.DC0_DictId  
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  E ON  PR1D_Status=E.DC0_DictId  
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  F ON  B.PD0_SKUSU=F.DC0_DictId  
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  G ON  B.PD0_Code=G.DC0_DictId  
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  H ON  PR1D_CurrencyTypeId=H.DC0_DictId 
                                     LEFT JOIN  M01_CONF.DC0_Dictionary  I ON  B.PD0_ColorId=H.DC0_DictId 
                                WHERE " + strWHERE
                                        + @"ORDER BY [PR1D_LmDt] DESC "; 
                            // ,PD0_SizeSUId
                          // ,I.DC0_DictName2 AS ColorBSUIdDictName
                          //   ,I.DC0_DictName1 AS ColorSUIdDictName
                         //   ,K.DC0_DictName1 AS SizeSUIdTypeDictName

                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B02_Bill.PR1D_OrderDetail");
                    conn.BeginTransaction();
                    //开启事物
                    conn.TableLock(tableList);
                    //锁表
                    try
                    {
                        if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "DELETE")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                strSQL = @"UPDATE B02_Bill.PR1D_OrderDetail SET PR1D_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE PR1D_OrderDetailId='" + ds.Tables["LIST"].Rows[i]["PR1D_OrderDetailId"].ToString() + @"'
                               AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               ";                           
                                conn.ExcuteQuerryByTran(strSQL);

                                strSQL = @"SELECT * FROM B02_Bill.PR1D_OrderDetail  WHERE  PR1D_PR1_OrderId=@param0
                                AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                ";
                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               AA.PR1_UptNo=AA.PR1_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA,
                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_POriginalAmount,
                                                SUM(PR1D_EstimateCost) AS PR1D_EstimateCost,SUM(PR1D_CurrencyAmount) AS PR1_PurchaseAmount,PR1D_PR1_OrderId
                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                 AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                                GROUP BY PR1D_PR1_OrderId)BB
                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";
                                    conn.ExcuteQuerryByTran(strSQL);

                                }
                                else
                                {
                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal='0',
                                               AA.PR1_PurchaseAmount='0',AA.PR1_POriginalAmount='0',
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               AA.PR1_UptNo=AA.PR1_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA
                                                WHERE AA.PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'";
                                    conn.ExcuteQuerryByTran(strSQL);
                                }
 

                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B02_Bill.PR1D_OrderDetail  WHERE  PR1D_OrderDetailId=@param0
                                AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PR1D_OrderDetailId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {


                                    strSQL = @"SELECT * FROM B01_MDM.PD0_Product  WHERE  PD0_ProductId=@param0
                                            AND  PD0_SKUSU=@param1   AND isnull(PD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                             ";

                                 DataTable dt_SU = conn.GetDataTable(strSQL, new string[2] { ds.Tables["LIST"].Rows[i]["PR1D_PD0_ProductId"].ToString(), ds.Tables["LIST"].Rows[i]["PR1D_PD0_SKUSU"].ToString() });
                                //update
                                if (dt_SU.Rows.Count > 0)
                                {

                                    //处理结果
                                  //  if (ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() != "")
                                  //  {

                                        DataTable dtTemp = conn.GetDataTableInTrans(
                                         @" SELECT CC.PR1D_CurrencyAmount,CC.PR1D_POriginalPrice,CC.PR1D_OriginalAmount,CC.PR1D_EstimateCost,CC.PR1D_PCurrencyPrice,
                                       case when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)<30 and '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国外'
                                        then CAST(SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',CC.PR1D_SCurrencyPrice)-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)-1 AS VARCHAR(20))+'99'
                                        when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)>=30 and '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国外'
                                        then SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)+'99'
                                        when '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' then '0'
                                        END  AS PR1D_SCurrencyPrice  FROM
                                       (SELECT AA.PR1D_CurrencyAmount as PR1D_CurrencyAmount,AA.PR1D_POriginalPrice,AA.PR1D_OriginalAmount as PR1D_OriginalAmount,AA.PR1D_EstimateCost as PR1D_EstimateCost,
                                       CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' THEN '0'
                                       ELSE AA.PR1D_EstimateCost/" + ds.Tables["LIST"].Rows[i]["PR1D_Discount"].ToString() + @" END AS PR1D_SCurrencyPrice,AA.PR1D_PCurrencyPrice as PR1D_PCurrencyPrice
                                       FROM 
                                      (select PR1_OrderId," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @" as PR1D_POriginalPrice  ," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate AS PR1D_PCurrencyPrice,
                                       CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' THEN " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate 
                                       ELSE " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate*(1+PR1_Tariff)*(1+PR1_VAT)*(1+PR1_Freight)
                                       END AS PR1D_EstimateCost," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*" + ds.Tables["LIST"].Rows[i]["PR1D_Total"].ToString() + @" AS PR1D_OriginalAmount,
                                       " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate*" + ds.Tables["LIST"].Rows[i]["PR1D_Total"].ToString() + @" AS PR1D_CurrencyAmount
                                       FROM B02_Bill.PR1_Order
                                       WHERE PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                        AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1')AA,
                                        B02_Bill.PR1_Order BB WHERE AA.PR1_OrderId=BB.PR1_OrderId)CC
                                      ");


                                        string PR1D_CurrencyAmount = dtTemp.Rows[0]["PR1D_CurrencyAmount"].ToString();
                                        string PR1D_PCurrencyPrice = dtTemp.Rows[0]["PR1D_PCurrencyPrice"].ToString();
                                        string PR1D_OriginalAmount = dtTemp.Rows[0]["PR1D_OriginalAmount"].ToString();
                                        string PR1D_EstimateCost = dtTemp.Rows[0]["PR1D_EstimateCost"].ToString();
                                        string PR1D_SCurrencyPrice = dtTemp.Rows[0]["PR1D_SCurrencyPrice"].ToString();
                                        string PR1D_POriginalPrice = dtTemp.Rows[0]["PR1D_POriginalPrice"].ToString();

                                        if (PR1D_SCurrencyPrice == "0")
                                        {
                                            PR1D_SCurrencyPrice = ds.Tables["LIST"].Rows[i]["PR1D_SCurrencyPrice"].ToString();
                                        }

                                        string strCode = dt_SR.Rows[0]["PR1D_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }


                            


                                        if (!dt.Columns.Contains("PR1D_LmDt"))
                                        {
                                            dt.Columns.Add("PR1D_LmDt");
                                        }

                                        if (!dt.Columns.Contains("PR1D_CurrencyAmount"))
                                        {
                                            dt.Columns.Add("PR1D_CurrencyAmount");
                                        }

                                        if (!dt.Columns.Contains("PR1D_PCurrencyPrice"))
                                        {
                                            dt.Columns.Add("PR1D_PCurrencyPrice");
                                        }

                                        if (!dt.Columns.Contains("PR1D_OriginalAmount"))
                                        {
                                            dt.Columns.Add("PR1D_OriginalAmount");
                                        }

                                        if (!dt.Columns.Contains("PR1D_EstimateCost"))
                                        {
                                            dt.Columns.Add("PR1D_EstimateCost");
                                        }

                                        if (!dt.Columns.Contains("PR1D_POriginalPrice"))
                                        {
                                            dt.Columns.Add("PR1D_POriginalPrice");
                                        }

                                        if (!dt.Columns.Contains("PR1D_SCurrencyPrice"))
                                        {
                                            dt.Columns.Add("PR1D_SCurrencyPrice");
                                        }


                                        if (!dt.Columns.Contains("PR1D_UptNo"))
                                        {
                                            dt.Columns.Add("PR1D_UptNo");
                                        }

                                        dt.Rows[0]["PR1D_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["PR1D_CurrencyAmount"] = PR1D_CurrencyAmount;
                                        dt.Rows[0]["PR1D_PCurrencyPrice"] = PR1D_PCurrencyPrice;
                                        dt.Rows[0]["PR1D_OriginalAmount"] = PR1D_OriginalAmount;
                                        dt.Rows[0]["PR1D_EstimateCost"] = PR1D_EstimateCost;
                                        dt.Rows[0]["PR1D_SCurrencyPrice"] = PR1D_SCurrencyPrice;
                                        dt.Rows[0]["PR1D_POriginalPrice"] = PR1D_POriginalPrice;
                                        dt.Rows[0]["PR1D_UptNo"] = strCode;

 

                                    
                                    dt.Columns.Remove("PR1D_SupplierType");
                                    dt.Columns.Remove("PR1D_PD0_SKUSU");
                                    conn.Update("B02_Bill.PR1D_OrderDetail", dt, "PR1D_OrderDetailId='" + ds.Tables["LIST"].Rows[i]["PR1D_OrderDetailId"].ToString() + @"'");

                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               AA.PR1_UptNo=AA.PR1_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA,
                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_POriginalAmount,
                                                SUM(PR1D_EstimateCost) AS PR1D_EstimateCost,SUM(PR1D_CurrencyAmount) AS PR1_PurchaseAmount,PR1D_PR1_OrderId
                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                 AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                                GROUP BY PR1D_PR1_OrderId)BB
                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";
                                    conn.ExcuteQuerryByTran(strSQL);

                                    strSQL = @"UPDATE B01_MDM.PD0_Product SET PD0_PurchasePrice='" + PR1D_CurrencyAmount + @"',
                                               PD0_SalePrice='" + PR1D_SCurrencyPrice + @"'，
                                               PD0_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               PD0_UptNo=PD0_UptNo+1
                                               WHERE PD0_ProductId='" + ds.Tables["LIST"].Rows[i]["PR1D_PD0_ProductId"].ToString() + @"'                "
                                               ;
                                    strSQL1 = @"UPDATE  A  SET A.PR0_Amount=B.PR1_POriginalAmount,A.PR0_Total=PR1_PurchaseTotal
                                                FROM B02_Bill.PR0_Contract A,
                                                    (select SUM(PR1_POriginalAmount) as   PR1_POriginalAmount,PR1_PR0_ContractId,SUM(PR1_PurchaseTotal) as   PR1_PurchaseTotal 
                                                     from B02_Bill.PR1_Order   
                                                     WHERE  PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                    AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                                                     GROUP BY PR1_PR0_ContractId)B
                                                     WHERE A.PR0_ContractId=B.PR1_PR0_ContractId "
                                                    ;
                                    conn.ExcuteQuerryByTran(strSQL1);


                                   }
                                }
                                     
                                else  //add
                                {
                                    strSQL = @"SELECT * FROM B01_MDM.PD0_Product  WHERE  PD0_ProductId=@param0
                                               AND  PD0_SKUSU=@param1
                                             ";

                                    DataTable dt_SU = conn.GetDataTable(strSQL, new string[2] { ds.Tables["LIST"].Rows[i]["PR1D_PD0_ProductId"].ToString(), ds.Tables["LIST"].Rows[i]["PR1D_PD0_SKUSU"].ToString() });
                                //update
                                if (dt_SU.Rows.Count > 0)
                                {


                                    DataTable dtTemp = conn.GetDataTableInTrans(
                                    @"
                                        SELECT CC.PR1D_CurrencyAmount,CC.PR1D_POriginalPrice,CC.PR1D_OriginalAmount,CC.PR1D_EstimateCost,CC.PR1D_PCurrencyPrice,
                                        case when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)<30 and '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国外'
                                        then CAST(SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',CC.PR1D_SCurrencyPrice)-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)-1 AS VARCHAR(20))+'99'
                                        when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)>=30 and '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国外'
                                        then SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)+'99'
                                        when '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' then '0'
                                        END  AS PR1D_SCurrencyPrice  FROM
                                       (SELECT AA.PR1D_CurrencyAmount as PR1D_CurrencyAmount,AA.PR1D_POriginalPrice,AA.PR1D_OriginalAmount as PR1D_OriginalAmount,AA.PR1D_EstimateCost as PR1D_EstimateCost,
                                       CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' THEN '0'
                                       ELSE AA.PR1D_EstimateCost/" + ds.Tables["LIST"].Rows[i]["PR1D_Discount"].ToString() + @" END AS PR1D_SCurrencyPrice,AA.PR1D_PCurrencyPrice as PR1D_PCurrencyPrice
                                       FROM 
                                      (select PR1_OrderId," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @" as PR1D_POriginalPrice  ," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate AS PR1D_PCurrencyPrice,
                                       CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1D_SupplierType"].ToString() + @"'='国内' THEN " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate 
                                       ELSE " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate*(1+PR1_Tariff)*(1+PR1_VAT)*(1+PR1_Freight)
                                       END AS PR1D_EstimateCost," + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*" + ds.Tables["LIST"].Rows[i]["PR1D_Total"].ToString() + @" AS PR1D_OriginalAmount,
                                       " + ds.Tables["LIST"].Rows[i]["PR1D_POriginalPrice"].ToString() + @"*PR1_ExchangeRate*" + ds.Tables["LIST"].Rows[i]["PR1D_Total"].ToString() + @" AS PR1D_CurrencyAmount
                                       FROM B02_Bill.PR1_Order
                                       WHERE PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                        AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1')AA,
                                        B02_Bill.PR1_Order BB WHERE AA.PR1_OrderId=BB.PR1_OrderId)CC
                                      ");


                                    string PR1D_CurrencyAmount = dtTemp.Rows[0]["PR1D_CurrencyAmount"].ToString();
                                    string PR1D_PCurrencyPrice = dtTemp.Rows[0]["PR1D_PCurrencyPrice"].ToString();
                                    string PR1D_OriginalAmount = dtTemp.Rows[0]["PR1D_OriginalAmount"].ToString();
                                    string PR1D_EstimateCost = dtTemp.Rows[0]["PR1D_EstimateCost"].ToString();
                                    string PR1D_SCurrencyPrice = dtTemp.Rows[0]["PR1D_SCurrencyPrice"].ToString();
                                    string PR1D_POriginalPrice = dtTemp.Rows[0]["PR1D_POriginalPrice"].ToString();

                                    if (PR1D_SCurrencyPrice == "0")
                                    {
                                        PR1D_SCurrencyPrice = ds.Tables["LIST"].Rows[i]["PR1D_SCurrencyPrice"].ToString();
                                    }

                                    string PR1D_OrderDetailId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("PR1D_OrderDetailId"))
                                    {
                                        dt.Columns.Add("PR1D_OrderDetailId");
                                    }

                                    if (!dt.Columns.Contains("PR1D_RgDt"))
                                    {
                                        dt.Columns.Add("PR1D_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PR1D_LmDt"))
                                    {
                                        dt.Columns.Add("PR1D_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PR1D_UptNo"))
                                    {
                                        dt.Columns.Add("PR1D_UptNo");
                                    }

                                    if (!dt.Columns.Contains("PR1D_CurrencyAmount"))
                                    {
                                        dt.Columns.Add("PR1D_CurrencyAmount");
                                    }

                                    if (!dt.Columns.Contains("PR1D_PCurrencyPrice"))
                                    {
                                        dt.Columns.Add("PR1D_PCurrencyPrice");
                                    }

                                    if (!dt.Columns.Contains("PR1D_OriginalAmount"))
                                    {
                                        dt.Columns.Add("PR1D_OriginalAmount");
                                    }

                                    if (!dt.Columns.Contains("PR1D_EstimateCost"))
                                    {
                                        dt.Columns.Add("PR1D_EstimateCost");
                                    }

                                    if (!dt.Columns.Contains("PR1D_SCurrencyPrice"))
                                    {
                                        dt.Columns.Add("PR1D_SCurrencyPrice");
                                    }





                                    dt.Rows[0]["PR1D_OrderDetailId"] = PR1D_OrderDetailId;
                                    dt.Rows[0]["PR1D_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PR1D_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PR1D_UptNo"] = '0';
                                    dt.Rows[0]["PR1D_CurrencyAmount"] = PR1D_CurrencyAmount;
                                    dt.Rows[0]["PR1D_PCurrencyPrice"] = PR1D_PCurrencyPrice;
                                    dt.Rows[0]["PR1D_OriginalAmount"] = PR1D_OriginalAmount;
                                    dt.Rows[0]["PR1D_EstimateCost"] = PR1D_EstimateCost;
                                    dt.Rows[0]["PR1D_SCurrencyPrice"] = PR1D_SCurrencyPrice;
                                    dt.Rows[0]["PR1D_POriginalPrice"] = PR1D_POriginalPrice;

                                    dt.Columns.Remove("PR1D_SupplierType");
                                    dt.Columns.Remove("PR1D_PD0_SKUSU");
                                    conn.Insert("B02_Bill.PR1D_OrderDetail", dt);



                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               AA.PR1_UptNo=AA.PR1_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA, 
                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_POriginalAmount,
                                                SUM(PR1D_EstimateCost) AS PR1D_EstimateCost,SUM(PR1D_CurrencyAmount) AS PR1_PurchaseAmount,PR1D_PR1_OrderId
                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'                                         
                                                GROUP BY PR1D_PR1_OrderId)BB
                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";

                                    conn.ExcuteQuerryByTran(strSQL);

                                    strSQL1 = @"UPDATE B01_MDM.PD0_Product SET PD0_PurchasePrice='" + PR1D_CurrencyAmount + @"',
                                               PD0_SalePrice='" + PR1D_SCurrencyPrice + @"',
                                               PD0_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                               PD0_UptNo=PD0_UptNo+1
                                               WHERE PD0_ProductId='" + ds.Tables["LIST"].Rows[i]["PR1D_PD0_ProductId"].ToString() + @"'                "
                                               ;
                                    conn.ExcuteQuerryByTran(strSQL1);


                                    strSQL1 = @"UPDATE  A  SET A.PR0_Amount=B.PR1_POriginalAmount,A.PR0_Total=PR1_PurchaseTotal
                                                FROM B02_Bill.PR0_Contract A,
                                                    (select SUM(PR1_POriginalAmount) as   PR1_POriginalAmount,PR1_PR0_ContractId,SUM(PR1_PurchaseTotal) as   PR1_PurchaseTotal 
                                                     from B02_Bill.PR1_Order   
                                                     WHERE  PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                        AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'                                            
                                                        GROUP BY PR1_PR0_ContractId)B
                                                     WHERE A.PR0_ContractId=B.PR1_PR0_ContractId "
                                                    ;
                                     conn.ExcuteQuerryByTran(strSQL1) ;
                                     
                                     

                                    }

                                }

                            }
                        }
                        conn.CommitTransaction();



                        ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "true" });
                    }
                    catch
                    {
                        conn.RollbackTransaction();
                        //事物结束
                        throw;
                    }
                }
                return ds_Return;
            }
            catch
            {
                throw;
            }

        }





    }

}