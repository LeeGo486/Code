using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;


/// 类名：System_Num
/// 类说明：对账号管理系统系统编号设置的CRUD
/// 创建人：郭琦琦  
/// 创建日期：2014-1-24

namespace HZY.COM.WS.System_Num
{

    public class System_Num : LogicBase, ILogicGetData
    {
        public System_Num()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("MDM");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;
        /// <summary>
        /// 对System_Num的CRUD 
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                 for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {

                        string strSearchFilter = "";
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                        if (strSearchFilter.Trim() != "")
                        {
                            strSearchFilter = " AND " + strSearchFilter;
                        }

                        string strSQL = @"

                                  SELECT 
                                    [System_ID]
                                   ,[System_Code]
                                   ,[System_Name]
                                   ,[System_SN]
                                  FROM [MDM_System]
                        " + strSearchFilter;

                        ds_Return = conn.GetDataSet(strSQL);

                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_System");
                        conn.BeginTransaction();
                        string strSystem_ID = ds.Tables["list"].Rows[0]["strSystem_ID"].ToString();

                        ds.Tables["list"].Columns.Remove("strSystem_ID");


                        //添加数据
                        if (strSystem_ID == "")
                        {
                            bResult = conn.Insert("MDM_System", ds.Tables["List"]);
                        }
                        else
                        {
                            bResult = conn.Update("MDM_System", ds.Tables["List"], "strSystem_ID=" + strSystem_ID);
                        }
                        conn.CommitTransaction();

 
                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else
                    {
                    }
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }
    }

}