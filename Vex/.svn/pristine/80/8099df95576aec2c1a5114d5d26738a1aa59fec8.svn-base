using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_Supplier_EditByXML_ForEasyUI 
/// 类说明：供应商增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新供应商
    /// </summary>
    public class GL_ERP_Supplier_EditByXML_ForEasyUI : LogicBase, ILogicGetData
    {
        public GL_ERP_Supplier_EditByXML_ForEasyUI()
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


                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " desc  ";
                string strSort = " SU0_SupplierCode ";
                string strWhere = " 1=1 ";
                string strSearchFilter = " ";

                if (m_request != null)
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;

                    string strWhereTemp = m_request.Tables[0].Rows[0]["where"].ToString();

                    if (strWhereTemp.Trim() != "")
                    {
                        strWhere += " AND " + strWhereTemp;
                    }

                    if (strSearchFilter.Trim() != "")
                    {
                        strWhere += " AND " + strSearchFilter;
                    }
                }

                
                ArrayList listAMSendList = new ArrayList();

                Dbconn conn = new Dbconn("GL_ERP");

                string strXML = "";
                string strSQL = "";
                string strCode = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    strWhere += " AND ISNULL(SU0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWhere += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @"SELECT  
                                    [SU0_CONO]
                                   ,[SU0_DIVI]
                                   ,[SU0_SupplierId]
                                   ,[SU0_SupplierCode]   
                                   ,[SU0_SupplierType]
                                   ,[SU0_SupplierName]
                                   ,[SU0_Address]
                                   ,[SU0_Contact]
                                   ,[SU0_Phone]
                                   ,[SU0_Bank]
                                   ,[SU0_BankAccount]
                                   ,[SU0_BankAddress]
                                   ,[SU0_BankSwift]
                                   ,[SU0_Status]
                                   ,[SU0_RgUser]
                                   ,[SU0_RgDt]
                                   ,[SU0_LmUser]
                                   ,[SU0_LmDt]
                                   ,[SU0_UptNo]
                                   ,[DC0_DictName1]
                                FROM   B01_MDM.SU0_Supplier  WITH ( NOLOCK )       
                                LEFT JOIN  M01_CONF.DC0_Dictionary  ON  SU0_SupplierType=DC0_DictId                         
                                WHERE " + strWhere + @"  "; 
                    ds_Return = conn.GetDataSetForPageList(strSQL,new string[0]{},nPage,nPageRowCount,strSort+" " + strOrder);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B01_MDM.SU0_Supplier");
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
                                strSQL = @"UPDATE B01_MDM.SU0_Supplier SET SU0_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               WHERE SU0_SupplierId='" + ds.Tables["LIST"].Rows[i]["SU0_SupplierId"].ToString() + @"'
                                AND ISNULL(SU0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "UPDATE"
                            || ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "INSERT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B01_MDM.SU0_Supplier WHERE  SU0_SupplierId=@param0
                                AND ISNULL(SU0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["SU0_SupplierId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["SU0_LmUser"].ToString() != "")
                                    {
                                        string strUptNo = dt_SR.Rows[0]["SU0_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0"; 
                                        }

                                        if (!dt.Columns.Contains("SU0_LmDt"))
                                        {
                                            dt.Columns.Add("SU0_LmDt");
                                        }
                                      //  if (!dt.Columns.Contains("SU0_Status"))
                                      //   {
                                      //      dt.Columns.Add("SU0_Status");
                                      //  }

                                        if (!dt.Columns.Contains("SU0_UptNo"))
                                        {
                                            dt.Columns.Add("SU0_UptNo");
                                        }

                                       //   dt.Rows[0]["SU0_Status"] = '0';
                                          dt.Rows[0]["SU0_LmDt"] = DateTime.Now;
                                          dt.Rows[0]["SU0_UptNo"] = strUptNo;
                                    }

                                    conn.Update("B01_MDM.SU0_Supplier", dt, "SU0_SupplierId='" + ds.Tables["LIST"].Rows[i]["SU0_SupplierId"].ToString() + @"'");


                                }
                                else  //add
                                {


                                    DataTable dtTemp = conn.GetDataTableInTrans(
                                    @"SELECT MAX(SU0_SupplierCode) AS MaxCode ,'A'AS PreCode FROM B01_MDM.SU0_Supplier
                                    WHERE SU0_SupplierCode LIKE 'A'+'%'");
                                    //供应商编号生成
                                     strCode = dtTemp.Rows[0]["MaxCode"].ToString();
                                    if (strCode == "")
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + "0001";
                                    }
                                    else
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + (Convert.ToInt32(strCode.Substring(strCode.Length - 4)) + 1).ToString("0000");
                                    }

 
                                    string SU0_SupplierId = Guid.NewGuid().ToString();
                       

                                    if (!dt.Columns.Contains("SU0_SupplierId"))
                                    {
                                        dt.Columns.Add("SU0_SupplierId");
                                    }

                                  //  if (!dt.Columns.Contains("SU0_Status"))
                                  //  {
                                   //     dt.Columns.Add("SU0_Status");
                                    //}

                                    if (!dt.Columns.Contains("SU0_RgDt"))
                                    {
                                        dt.Columns.Add("SU0_RgDt");
                                    }

                                    if (!dt.Columns.Contains("SU0_LmDt"))
                                    {
                                        dt.Columns.Add("SU0_LmDt");
                                    }

                                    if (!dt.Columns.Contains("SU0_SupplierCode"))
                                    {
                                        dt.Columns.Add("SU0_SupplierCode");
                                    }

                                    if (!dt.Columns.Contains("SU0_UptNo"))
                                    {
                                        dt.Columns.Add("SU0_UptNo");
                                    }


                                    dt.Rows[0]["SU0_SupplierId"] =SU0_SupplierId;
                                  //  dt.Rows[0]["SU0_Status"] = '0';
                                    dt.Rows[0]["SU0_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["SU0_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["SU0_SupplierCode"] = strCode;
                                    dt.Rows[0]["SU0_UptNo"] = '0';
                                    conn.Insert("B01_MDM.SU0_Supplier", dt);
                                  
                                 

                                    //ITSM_Common.SendAMMessage("")
 
                                }

                            }
                        }
                        conn.CommitTransaction();



                        ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result", "SU0_SupplierCode" }, new string[] { "true", strCode });
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