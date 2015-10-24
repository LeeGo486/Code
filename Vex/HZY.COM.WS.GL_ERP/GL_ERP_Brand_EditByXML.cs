using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：GL_ERP_Brand_EditByXML 
/// 类说明：品牌增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新品牌
    /// </summary>
    public class GL_ERP_Brand_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_Brand_EditByXML()
        {
            this.m_SessionCheck = false;

        }
         
        /// <summary>
        /// 根据XML内容更新品牌
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
                    string strWHERE = "ISNULL(BD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT 
                                    [BD0_CONO]
                                   ,[BD0_DIVI]
                                   ,[BD0_BrandId]
                                   ,[BD0_BrandCode]
                                   ,[BD0_SU0_SupplierId]
                                   ,[BD0_BrandName]
                                   ,[BD0_CountryId]
                                   ,[BD0_StyleId]
                                   ,[BD0_CusGrpId]
                                   ,[BD0_Status]
                                   ,[BD0_RgUser]
                                   ,[BD0_RgDt]
                                   ,[BD0_LmUser]
                                   ,[BD0_LmDt]
                                   ,[BD0_UptNo]
                                   ,A.[SU0_SupplierCode] 
                                   ,B.[DC0_DictName1] AS CountryDictName
                                   ,C.[DC0_DictName1] AS StyleDictName
                                   ,D.[DC0_DictName1] AS CusGrpDictName
                                FROM   B01_MDM.BD0_Brand WITH ( NOLOCK )    
                                LEFT JOIN  B01_MDM.SU0_Supplier A ON  BD0_SU0_SupplierId=A.SU0_SupplierId   
                                LEFT JOIN  M01_CONF.DC0_Dictionary B ON  BD0_CountryId=B.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary C ON  BD0_StyleId=C.DC0_DictId 
                                LEFT JOIN  M01_CONF.DC0_Dictionary D ON  BD0_CusGrpId=D.DC0_DictId                                   
                                WHERE " + strWHERE
                                + @"ORDER BY [BD0_LmDt] DESC ";
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B01_MDM.BD0_Brand");
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
                                strSQL = @"UPDATE B01_MDM.BD0_Brand SET BD0_Status=1 
                               WHERE BD0_BrandId='" + ds.Tables["LIST"].Rows[i]["BD0_BrandId"].ToString() + @"'
                                AND ISNULL(BD0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B01_MDM.BD0_Brand WHERE  BD0_BrandId=@param0
                                AND ISNULL(BD0_Status,'') <>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["BD0_BrandId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["BD0_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["BD0_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("BD0_LmDt"))
                                        {
                                            dt.Columns.Add("BD0_LmDt");
                                        }
                                     //   if (!dt.Columns.Contains("BD0_Status"))
                                      //  {
                                      //      dt.Columns.Add("BD0_Status");
                                      //  }

                                        if (!dt.Columns.Contains("BD0_UptNo"))
                                        {
                                            dt.Columns.Add("BD0_UptNo");
                                        }

                                      //  dt.Rows[0]["BD0_Status"] = '0';
                                        dt.Rows[0]["BD0_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["BD0_UptNo"] = strCode;
                                    }

                                    conn.Update("B01_MDM.BD0_Brand", dt, "BD0_BrandId='" + ds.Tables["LIST"].Rows[i]["BD0_BrandId"].ToString() + @"'");


                                }
 
                                else  //add
                                {

                                    strSQL = @"SELECT BD0_BrandCode FROM  B01_MDM.BD0_Brand  WHERE  BD0_BrandCode=@param0
                                                ";
                                    DataTable dt_SU = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["BD0_BrandCode"].ToString()});

                                    if (dt_SU.Rows.Count > 0)
                                    {
                                        string BD0_BrandCode = dt_SU.Rows[0]["BD0_BrandCode"].ToString();


                                     //   ITSM_Common.SendAMMessage("你输入的品牌编号已存在，最近添加的品牌编号是" + BD0_BrandCode);
                                        ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "你输入的品牌编号已存在，最近添加的品牌编号是" + BD0_BrandCode });
                                        conn.RollbackTransaction();
                                        return ds_Return;

                                        
                                    }
                                    else
                                    {
                                         string BD0_BrandId = Guid.NewGuid().ToString();


                                        if (!dt.Columns.Contains("BD0_BrandId"))
                                        {
                                            dt.Columns.Add("BD0_BrandId");
                                        }

                                 //   if (!dt.Columns.Contains("BD0_Status"))
                                 //   {
                                 //       dt.Columns.Add("BD0_Status");
                                 //   }

                                        if (!dt.Columns.Contains("BD0_RgDt"))
                                        {
                                            dt.Columns.Add("BD0_RgDt");
                                        }

                                        if (!dt.Columns.Contains("BD0_LmDt"))
                                        {
                                         dt.Columns.Add("BD0_LmDt");
                                        }

                                         if (!dt.Columns.Contains("BD0_UptNo"))
                                        {
                                         dt.Columns.Add("BD0_UptNo");
                                        }


                                        dt.Rows[0]["BD0_BrandId"] = BD0_BrandId;
                                //    dt.Rows[0]["BD0_Status"] = '0';
                                        dt.Rows[0]["BD0_RgDt"] = DateTime.Now;
                                        dt.Rows[0]["BD0_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["BD0_UptNo"] = '0';

                                 

                                        conn.Insert("B01_MDM.BD0_Brand", dt);
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