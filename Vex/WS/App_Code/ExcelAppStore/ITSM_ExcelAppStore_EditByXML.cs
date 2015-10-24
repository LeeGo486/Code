using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：ITSM_ExcelAppStore_EditByXML 
/// 类说明：根据XML内容更新ExcelAppStore
/// 创建人：王秀宝
/// 创建日期：2013-06-23
/// 修改人：
/// 修改日期：
namespace HZY.COM.ExcelAppStore
{
    /// <summary>
    /// 根据XML内容更新服务器申请单
    /// </summary>
    public class ITSM_ExcelAppStore_EditByXML : LogicBase, ILogicGetData
    {
        public ITSM_ExcelAppStore_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新服务器申请单
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds_Return = new DataSet();
                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();

                Dbconn conn = new Dbconn("HZY_ExcelAppStore");

                string strXML = "";
                string strSQL = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                {
                    string strWHERE = " Deleted=0 ";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT *
                                FROM    ExcelAppStore WITH ( NOLOCK )
                                WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("ExcelAppStore");
                    conn.BeginTransaction();
                    conn.TableLock(tableList);
                    try
                    {
                        if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "DELETE")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                strSQL = @"UPDATE ExcelAppStore SET Deleted=1 
                               WHERE AppName='" + ds.Tables["LIST"].Rows[i]["AppName"].ToString() + @"'
                                AND Deleted=0 ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM ExcelAppStore WHERE  AppName=@param0
                                AND Deleted=0 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["AppName"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //运维操作
                                    if (ds.Tables["LIST"].Rows[i]["AppName"].ToString() != "")
                                    {
                                        conn.Update("ExcelAppStore", dt, "AppName='" + ds.Tables["LIST"].Rows[i]["AppName"].ToString() + @"'");
                                    }

                                }
                                else  //add
                                {

                                    conn.Insert("ExcelAppStore", dt);
                                }

                            }
                        }
                        conn.CommitTransaction();

 
                        ds_Return = Common.Common.GetRequestDataSet(new string[]{"Result"},new string[]{"true"});
                    }
                    catch
                    {
                        conn.RollbackTransaction();
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