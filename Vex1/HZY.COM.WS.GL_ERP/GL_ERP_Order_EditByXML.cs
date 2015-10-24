using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：GL_ERP_Order_EditByXML 
/// 类说明：采购单增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新采购单
    /// </summary>
    public class GL_ERP_Order_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_Order_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新采购单
        /// </summary>
        /// <returns></returns>
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
                DateTime PR1_LmDt = DateTime.Now;
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT 
                                [PR1_CONO]
                               ,[PR1_DIVI]
                               ,[PR1_OrderId]
                               ,[PR1_OrderCode]
                               ,[PR1_OrderTypeId]
                               ,[PR1_PR0_ContractId]
                               ,[PR1_SU0_SupplierId]
                               ,[PR1_BD0_BrandId]
                               ,CAST([PR1_PurchaseTotal] AS DECIMAL(20,0)) as PR1_PurchaseTotal
                               ,CAST([PR1_POriginalAmount] AS  DECIMAL(20,2)) as PR1_POriginalAmount
                               ,CAST([PR1_PurchaseAmount]  AS  DECIMAL(20,2)) as PR1_PurchaseAmount
                               ,CAST([PR1_Discount] AS  DECIMAL(20,2)) as PR1_Discount
                               ,CAST([PR1_ExchangeRate] AS  DECIMAL(20,2)) as  PR1_ExchangeRate
                               ,CAST([PR1_Tariff] AS  DECIMAL(20,2)) as  PR1_Tariff
                               ,CAST([PR1_VAT] AS  DECIMAL(20,2)) as  PR1_VAT
                               ,CAST([PR1_Freight] AS  DECIMAL(20,2)) as PR1_Freight
                               ,CAST([PR1_Times] AS  DECIMAL(20,2)) as PR1_Times
                               ,[PR1_Status]
                               ,[PR1_RgUser]
                               ,[PR1_RgDt]
                               ,[PR1_LmUser]
                               ,[PR1_LmDt]
                               ,[PR1_UptNo]
                               ,[PR1_CurrencyTypeId]
                               ,A.[SU0_SupplierCode]  AS  SU0_SupplierCode
                               ,A.[SU0_SupplierType]  AS  SU0_SupplierType
                               ,B.[BD0_BrandName]   AS BD0_BrandName
                               ,C.PR0_ContractCode  AS PR0_ContractCode  
                               ,D.[DC0_DictName1] AS OrderTypeDictName
                               ,F.[DC0_DictName1] AS StatusDictName
                               ,G.[DC0_DictName1] AS CurrencyTypeDictName
                               ,H.[DC0_DictName1] AS PR1_SupplierType 
                               FROM GL_ERP.B02_Bill.PR1_Order WITH ( NOLOCK ) 
                               LEFT JOIN  B01_MDM.SU0_Supplier        A ON  PR1_SU0_SupplierId=A.SU0_SupplierId
                               LEFT JOIN  B01_MDM.BD0_Brand           B ON  PR1_BD0_BrandId=B.BD0_BrandId 
                               LEFT JOIN  B02_Bill.PR0_Contract       C ON  PR1_PR0_ContractId=C.PR0_ContractId   
                               LEFT JOIN  M01_CONF.DC0_Dictionary     D ON  PR1_OrderTypeId=D.DC0_DictId   
                               LEFT JOIN  M01_CONF.DC0_Dictionary     F ON  PR1_Status=F.DC0_DictId   
                               LEFT JOIN  M01_CONF.DC0_Dictionary     G ON  PR1_CurrencyTypeId=G.DC0_DictId  
                               LEFT JOIN  M01_CONF.DC0_Dictionary     H ON  A.SU0_SupplierType=H.DC0_DictId   
                                WHERE " + strWHERE
                                        + @"ORDER BY [PR1_LmDt] DESC "; 

                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("GL_ERP.B02_Bill.PR1_Order");
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
                                strSQL = @"UPDATE GL_ERP.B02_Bill.PR1_Order SET PR1_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'
                               AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               ";
                                conn.ExcuteQuerryByTran(strSQL);

                                strSQL = @"UPDATE B02_Bill.PR1D_OrderDetail SET PR1D_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'
                               AND isnull(PR1D_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               ";
                                conn.ExcuteQuerryByTran(strSQL);


                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM GL_ERP.B02_Bill.PR1_Order WHERE  PR1_OrderId=@param0
                                AND ISNULL(PR1_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["PR1_LmUser"].ToString() != "")

                                    {
                                        string strCode = dt_SR.Rows[0]["PR1_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("PR1_LmDt"))
                                        {
                                            dt.Columns.Add("PR1_LmDt");
                                        }


                                        if (!dt.Columns.Contains("PR1_UptNo"))
                                        {
                                            dt.Columns.Add("PR1_UptNo");
                                        }


                                        dt.Rows[0]["PR1_LmDt"] = DateTime.Now;
                                        
                                        dt.Rows[0]["PR1_UptNo"] = strCode;
                                    }
                                    dt.Columns.Remove("PR1_SupplierType"); 
                                    conn.Update("GL_ERP.B02_Bill.PR1_Order", dt, "PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'");



                                    if (ds.Tables["LIST"].Rows[i]["PR1_ExchangeRate"].ToString() != ""
                                     || ds.Tables["LIST"].Rows[i]["PR1_Tariff"].ToString() != "" 
                                     || ds.Tables["LIST"].Rows[i]["PR1_VAT"].ToString() != ""
                                     || ds.Tables["LIST"].Rows[i]["PR1_Freight"].ToString() != ""
                                      )

                                    { 
                                        strSQL = @" UPDATE DD SET DD.PR1D_CurrencyAmount=EE.PR1D_CurrencyAmount,
                                                DD.PR1D_EstimateCost=EE.PR1D_EstimateCost,
                                                DD.PR1D_PCurrencyPrice=EE.PR1D_PCurrencyPrice
                                                FROM   B02_Bill.PR1D_OrderDetail DD,                                
                                                (SELECT CC.PR1D_OrderDetailId,CC.PR1D_CurrencyAmount,CC.PR1D_EstimateCost,
                                                CC.PR1D_PCurrencyPrice, case when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)<30 and '" + ds.Tables["LIST"].Rows[i]["PR1_SupplierType"].ToString() + @"'='国外'
                                                then CAST(SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',CC.PR1D_SCurrencyPrice)-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)-1 AS VARCHAR(20))+'99'
                                                when cast(right(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),2)as int)>=30 and '" + ds.Tables["LIST"].Rows[i]["PR1_SupplierType"].ToString() + @"'='国外'
                                                then SUBSTRING(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1),1,len(SUBSTRING(cast(CC.PR1D_SCurrencyPrice as varchar(20)),1,charindex('.',cast(CC.PR1D_SCurrencyPrice as varchar(20)))-1))-2)+'99'
                                                when '" + ds.Tables["LIST"].Rows[i]["PR1_SupplierType"].ToString() + @"'='国内' then '0'
                                                END  AS PR1D_SCurrencyPrice FROM
                                                (SELECT AA.PR1D_OrderDetailId,AA.PR1D_CurrencyAmount as PR1D_CurrencyAmount,
                                                AA.PR1D_EstimateCost as PR1D_EstimateCost,
                                                CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1_SupplierType"].ToString() + @"'='国内' THEN '0'
                                                ELSE AA.PR1D_EstimateCost/AA.PR1D_Discount END AS PR1D_SCurrencyPrice,AA.PR1D_PCurrencyPrice as PR1D_PCurrencyPrice
                                                FROM 
                                               (select PR1D_OrderDetailId,PR1D_Discount,PR1D_PR1_OrderId,PR1D_POriginalPrice*PR1_ExchangeRate AS PR1D_PCurrencyPrice,
                                                CASE WHEN '" + ds.Tables["LIST"].Rows[i]["PR1_SupplierType"].ToString() + @"'='国内' THEN PR1D_POriginalPrice*PR1_ExchangeRate 
                                                ELSE PR1D_POriginalPrice*PR1_ExchangeRate*(1+PR1_Tariff)*(1+PR1_VAT)*(1+PR1_Freight)
                                                END AS PR1D_EstimateCost,
                                                PR1D_POriginalPrice*PR1_ExchangeRate*PR1D_Total AS PR1D_CurrencyAmount
                                                FROM B02_Bill.PR1_Order,B02_Bill.PR1D_OrderDetail
                                                WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'
                                                AND PR1_OrderId=PR1D_PR1_OrderId
                                                )AA,
                                                B02_Bill.PR1_Order BB WHERE AA.PR1D_PR1_OrderId=BB.PR1_OrderId) CC)EE
                                                WHERE DD.PR1D_OrderDetailId=EE.PR1D_OrderDetailId";
                                                conn.ExcuteQuerryByTran(strSQL);

                                               strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt='" + PR1_LmDt + @"',
                                               AA.PR1_UptNo=AA.PR1_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA,
                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_PurchaseAmount,
                                                SUM(PR1D_CurrencyAmount) AS PR1_POriginalAmount,PR1D_PR1_OrderId
                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'
                                                GROUP BY PR1D_PR1_OrderId)BB
                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";
                                               conn.ExcuteQuerryByTran(strSQL);


                                               strSQL = @"UPDATE  A  SET A.PR0_Amount=B.PR1_POriginalAmount
                                                FROM B02_Bill.PR0_Contract A,
                                                    (select SUM(PR1_POriginalAmount) as   PR1_POriginalAmount,PR1_PR0_ContractId 
                                                     from B02_Bill.PR1_Order   
                                                     WHERE  PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1_OrderId"].ToString() + @"'
                                                     GROUP BY PR1_PR0_ContractId)B
                                                     WHERE A.PR0_ContractId=B.PR1_PR0_ContractId "
                                                            ;
                                               conn.ExcuteQuerryByTran(strSQL);


                                      }
                                     



                                }

                                else  //add
                                {

                                    string PR1_OrderId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("PR1_OrderId"))
                                    {
                                        dt.Columns.Add("PR1_OrderId");
                                    }



                                    if (!dt.Columns.Contains("PR1_RgDt"))
                                    {
                                        dt.Columns.Add("PR1_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PR1_LmDt"))
                                    {
                                        dt.Columns.Add("PR1_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PR1_UptNo"))
                                    {
                                        dt.Columns.Add("PR1_UptNo");
                                    }


                                    dt.Rows[0]["PR1_OrderId"] = PR1_OrderId;

                                    dt.Rows[0]["PR1_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PR1_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PR1_UptNo"] = '0';

                                    dt.Columns.Remove("PR1_SupplierType"); 

                                    conn.Insert("GL_ERP.B02_Bill.PR1_Order", dt);


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