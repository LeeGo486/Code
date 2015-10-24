using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_Product_EditByXML 
/// 类说明：商品增删改查
/// 创建人：钱超
/// 创建日期：2013-07-11
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新商品
    /// </summary>
    public class GL_ERP_Product_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_Product_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新供应商
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
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "ISNULL(PD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";

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
                                     [PD0_CONO]
                                    ,[PD0_DIVI]
                                    ,[PD0_ProductId]
                                    ,[PD0_SUO_SupplierId]
                                    ,[PD0_BD0_BrandId]
                                    ,[PD0_ProductCodeSU]
                                    ,[PD0_ColorSUId]
                                    ,[PD0_SizeSUId]
                                    ,[PD0_SKUSU]
                                    ,[PD0_Code]
                                    ,[PD0_ColorId]
                                    ,[PD0_SizeId]
                                    ,[PD0_SKU]
                                    ,[PD0_YearId]
                                    ,[PD0_SeasonId]
                                    ,[PD0_Lvl1]
                                    ,[PD0_Lvl2] 
                                    ,[PD0_Lvl3]
                                    ,[PD0_SourceCountry]
                                    ,[PD0_Composition]
                                    ,[PD0_QulityLevel]
                                    ,[PD0_StandardId]
                                    ,[PD0_SecurityLevelId]
                                    ,cast([PD0_PurchasePrice] as decimal(20,2)) as PD0_PurchasePrice
                                    ,cast([PD0_SalePrice] as decimal(20,2)) as PD0_SalePrice  
                                    ,[PD0_UnitId]
                                    ,[PD0_IsPrinted]
                                    ,[PD0_Status]
                                    ,[PD0_RgUser]
                                    ,[PD0_RgDt]
                                    ,[PD0_LmUser]
                                    ,[PD0_LmDt]
                                    ,[PD0_ColorSUId]
                                    ,[PD0_PicPath]
                                    ,[PD0_Lvl0]
                                    ,A.[SU0_SupplierCode] 
                                    ,B.[BD0_BrandName]  
                                    ,C.[DC0_DictName1] AS YearDictName
                                    ,D.[DC0_DictName1] AS SeasonDictName
                                    ,E.[DC0_DictName1] AS StandardDictName
                                    ,F.[DC0_DictName1] AS SecurityLevelDictName
                                    ,G.[DC0_DictName1] AS ColorSUDictName
                                    ,H.[DC0_DictName1] AS SizeSUDictName
                                    ,I.[DC0_DictName1] AS Lvl1DictName
                                    ,J.[DC0_DictName1] AS Lvl2DictName
                                    ,K.[DC0_DictName1] AS ColorBSUName
  
                                    ,M.[DC0_DictName1] AS ColorDictName
                                    ,N.[DC0_DictName1] AS SizeDictName
                                FROM   B01_MDM.PD0_Product WITH ( NOLOCK )    
                                LEFT JOIN  B01_MDM.SU0_Supplier    A ON  PD0_SUO_SupplierId=A.SU0_SupplierId
                                LEFT JOIN  B01_MDM.BD0_Brand       B ON  PD0_BD0_BrandId=B.BD0_BrandId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary C ON  PD0_YearId=C.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary D ON  PD0_SeasonId=D.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary E ON  PD0_StandardId=E.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary F ON  PD0_SecurityLevelId=F.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary G ON  PD0_ColorSUId=G.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary H ON  PD0_SizeSUId=H.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary I ON  PD0_Lvl1=I.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary J ON  PD0_Lvl2=J.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary K ON  PD0_ColorSUId=K.DC0_DictId
 
                                LEFT JOIN  M01_CONF.DC0_Dictionary M ON  PD0_ColorId=M.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary N ON  PD0_SizeId=N.DC0_DictId

                                WHERE " + strWHERE
                                      + @"ORDER BY [PD0_LmDt] DESC "; 
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B01_MDM.PD0_Product");
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
                                strSQL = @"UPDATE B01_MDM.PD0_Product SET PD0_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE PD0_ProductId='" + ds.Tables["LIST"].Rows[i]["PD0_ProductId"].ToString() + @"'
                                AND ISNULL(PD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B01_MDM.PD0_Product WHERE  PD0_ProductId=@param0
                                AND ISNULL(PD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PD0_ProductId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["PD0_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["PD0_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("PD0_LmDt"))
                                        {
                                            dt.Columns.Add("PD0_LmDt");
                                        }
                                      //  if (!dt.Columns.Contains("PD0_Status"))
                                      //  {
                                      //      dt.Columns.Add("PD0_Status");
                                      //  }

                                        if (!dt.Columns.Contains("PD0_UptNo"))
                                        {
                                            dt.Columns.Add("PD0_UptNo");
                                        }

                                       // dt.Rows[0]["PD0_Status"] = '0';
                                        dt.Rows[0]["PD0_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["PD0_UptNo"] = strCode;
                                    }

                                    conn.Update("B01_MDM.PD0_Product", dt, "PD0_ProductId='" + ds.Tables["LIST"].Rows[i]["PD0_ProductId"].ToString() + @"'");


                                }
                                else  //add
                                {


                                 //   string PD0_ProductId = Guid.NewGuid().ToString();


                               //     if (!dt.Columns.Contains("PD0_ProductId"))
                               //     {
                               //         dt.Columns.Add("PD0_ProductId");
                                //    }

                                   // if (!dt.Columns.Contains("PD0_Status"))
                                   // {
                                  //      dt.Columns.Add("PD0_Status");
                                  //  }

                                    if (!dt.Columns.Contains("PD0_RgDt"))
                                    {
                                        dt.Columns.Add("PD0_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PD0_LmDt"))
                                    {
                                        dt.Columns.Add("PD0_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PD0_UptNo"))
                                    {
                                        dt.Columns.Add("PD0_UptNo");
                                    }


                                //    dt.Rows[0]["PD0_ProductId"] = PD0_ProductId;
                                  //  dt.Rows[0]["PD0_Status"] = '0';
                                    dt.Rows[0]["PD0_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PD0_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PD0_UptNo"] = '0';
                             
                                    conn.Insert("B01_MDM.PD0_Product", dt);

                          


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