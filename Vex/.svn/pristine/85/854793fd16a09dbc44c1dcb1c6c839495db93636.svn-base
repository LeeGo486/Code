using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_Dict_EditByXML 
/// 类说明：字典增删改查
/// 创建人：钱超
/// 创建日期：2013-07-12
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新品牌
    /// </summary>
    public class GL_ERP_Dict_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_Dict_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新字典
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
                    string strWHERE = "ISNULL(A.DC0_DictStatus,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = strSQL + @" SELECT 
                                       B.DC0_CONO  
                                      ,B.DC0_DIVI
                                      ,B.DC0_DictId
                                      ,B.DC0_FartherDictId  
                                      ,B.DC0_DictName1 
                                      ,B.DC0_DictName2 
                                      ,B.DC0_DictName3
                                      ,B.DC0_DictName4
                                      ,B.DC0_DictName5  
                                      ,B.DC0_DictStatus 
                                      ,B.DC0_RgUser 
                                      ,B.DC0_RgDt
                                      ,B.DC0_LmUser  
                                      ,B.DC0_LmDt 
                                      ,B.DC0_UptNo               
                               FROM   M01_CONF.DC0_Dictionary A,M01_CONF.DC0_Dictionary B  WITH ( NOLOCK )                                 
                               WHERE A.DC0_DictId=B.DC0_FartherDictId AND " + strWHERE;

                  /*  strSQL = @"SELECT  A.DC0_CONO  
                                      ,A.DC0_DIVI
                                      ,A.DC0_DictId
                                      ,A.DC0_FartherDictId  
                                      ,A.DC0_DictName1 
                                      ,A.DC0_DictName2 
                                      ,A.DC0_DictName3
                                      ,A.DC0_DictName4
                                      ,A.DC0_DictName5  
                                      ,A.DC0_DictStatus 
                                      ,A.DC0_RgUser 
                                      ,A.DC0_RgDt
                                      ,A.DC0_LmUser  
                                      ,A.DC0_LmDt 
                                      ,A.DC0_UptNo 
                                FROM   M01_CONF.DC0_Dictionary A WITH ( NOLOCK )                                 
                                WHERE " + strWHERE;
                    strSQL =   strSQL+ @"UNION SELECT 
                                       B.DC0_CONO  
                                      ,B.DC0_DIVI
                                      ,B.DC0_DictId
                                      ,B.DC0_FartherDictId  
                                      ,B.DC0_DictName1 
                                      ,B.DC0_DictName2 
                                      ,B.DC0_DictName3
                                      ,B.DC0_DictName4
                                      ,B.DC0_DictName5  
                                      ,B.DC0_DictStatus 
                                      ,B.DC0_RgUser 
                                      ,B.DC0_RgDt
                                      ,B.DC0_LmUser  
                                      ,B.DC0_LmDt 
                                      ,B.DC0_UptNo               
                               FROM   M01_CONF.DC0_Dictionary A,M01_CONF.DC0_Dictionary B  WITH ( NOLOCK )                                 
                               WHERE A.DC0_DictId=B.DC0_FartherDictId AND " + strWHERE;*/
 
 

                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("M01_CONF.DC0_Dictionary");
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
                                strSQL = @"UPDATE M01_CONF.DC0_Dictionary SET DC0_DictStatus='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE DC0_DictId='" + ds.Tables["LIST"].Rows[i]["DC0_DictId"].ToString() + @"'
                                AND ISNULL(DC0_DictStatus,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM M01_CONF.DC0_Dictionary WHERE  DC0_DictId=@param0
                                AND ISNULL(DC0_DictStatus,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["DC0_DictId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["DC0_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["DC0_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("DC0_LmDt"))
                                        {
                                            dt.Columns.Add("DC0_LmDt");
                                        }
                                      //  if (!dt.Columns.Contains("DC0_DictStatus"))
                                      //  {
                                      //      dt.Columns.Add("DC0_DictStatus");
                                     //   }

                                        if (!dt.Columns.Contains("DC0_UptNo"))
                                        {
                                            dt.Columns.Add("DC0_UptNo");
                                        }

                                       // dt.Rows[0]["DC0_DictStatus"] = '0';
                                        dt.Rows[0]["DC0_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["DC0_UptNo"] = strCode;
                                    }

                                    conn.Update("M01_CONF.DC0_Dictionary", dt, " DC0_DictId='" + ds.Tables["LIST"].Rows[i]["DC0_DictId"].ToString() + @"'");


                                }
                                else  //add
                                {

                                    string DC0_DictId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("DC0_DictId"))
                                    {
                                        dt.Columns.Add("DC0_DictId");
                                    }

                                   // if (!dt.Columns.Contains("DC0_DictStatus"))
                                  //  {
                                  //      dt.Columns.Add("DC0_DictStatus");
                                  //  }

                                    if (!dt.Columns.Contains("DC0_RgDt"))
                                    {
                                        dt.Columns.Add("DC0_RgDt");
                                    }

                                    if (!dt.Columns.Contains("DC0_LmDt"))
                                    {
                                        dt.Columns.Add("DC0_LmDt");
                                    }

                                    if (!dt.Columns.Contains("DC0_UptNo"))
                                    {
                                        dt.Columns.Add("DC0_UptNo");
                                    }


                                    dt.Rows[0]["DC0_DictId"] = DC0_DictId;
                                  //  dt.Rows[0]["DC0_DictStatus"] = '0';
                                    dt.Rows[0]["DC0_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["DC0_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["DC0_UptNo"] = '0';

                                    conn.Insert("M01_CONF.DC0_Dictionary", dt);



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