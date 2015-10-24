using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using System.Web;
using System.Web.Services;
using HZY.COM.Common.Base;


/// 类名：System_System_Company
/// 类说明：对System_System_Company的CRUD,为Easyui专用
/// 创建人：郭琦琦 
/// 创建日期：2014-02-13  
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.EPAcount
{
    class System_Company : LogicBase, ILogicGetData
    {
        public System_Company()
        {
            this.m_SessionCheck = false;
        }
        private Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

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
                        int nPage = 1;
                        int nPageRowCount = 20;
                        string strOrder = " desc  ";
                        string strSort = " company_Name ";
                        string strWhere = "";
                        string strSearchFilter = " ";

                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;

                        if (strWhere.Trim() != "")
                        {
                            strWhere = " AND " + strWhere;
                        }

                        if (strSearchFilter.Trim() != "")
                        {
                            strWhere += " AND " + strSearchFilter;
                        }

                        string strSQL = @"
                                SELECT 
                                       [Company_ID],
                                       [Company_Name],
                                       [Company_sn],
                                       [Createtime],
                                       [Updatetime] 
                                FROM   [dbo].[MDM_Company]
                                WHERE 1=1 " + strWhere;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], nPage, nPageRowCount, strSort + " " + strOrder);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_Company");
                        conn.BeginTransaction();
                        DataTable dt_list = ds.Tables["List"];
                         
                        DataTable dt_Data = new DataTable();
                        dt_Data.Columns.Add("Company_ID");
                        dt_Data.Columns.Add("Company_Name");
                        dt_Data.Columns.Add("Company_sn");
                        dt_Data.Columns.Add("Createtime");
                        dt_Data.Columns.Add("Updatetime");
                        DateTime timeNow = DateTime.Now;


                        for (int j = 0; j < dt_list.Rows.Count; j++)
                        {
                            string strCompany_ID = dt_list.Rows[j]["Company_ID"].ToString();
                            string strCompany_Name = dt_list.Rows[j]["Company_Name"].ToString();
                            string strCompany_sn = dt_list.Rows[j]["Company_sn"].ToString();
                            string strCreatetime = dt_list.Rows[j]["Createtime"].ToString();
                            dt_Data.Rows.Add(new object[] { strCompany_ID, strCompany_Name, strCompany_sn, strCreatetime, timeNow });
                        }

                        //检查数据是否已经有了
                        string strCompany_Name_Update = dt_Data.Rows[0]["Company_Name"].ToString();
                        string strCompany_ID_Update = dt_Data.Rows[0]["Company_ID"].ToString();

                        int nCompany_NameCount = conn.GetDataTableRowCount("SELECT * FROM MDM_Company WHERE Company_ID != " + strCompany_ID_Update + " and Company_Name=" + "'" + strCompany_Name_Update + "'");

                        if (nCompany_NameCount != 0)

                        {
                            throw new Exception("新修改的行，公司：" + strCompany_Name_Update + "已经存在，信息错误！");
                        }
                

                        ArrayList listKey = new ArrayList();
                        listKey.Add("Company_ID");
                        bResult = conn.Update("MDM_Company", dt_Data, listKey);
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
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_Company");
                        conn.BeginTransaction();

                        string strCompany_ID = ds.Tables["list"].Rows[0]["company_id"].ToString();


                        if (strCompany_ID == "系统自动生成")
                        {
                            strCompany_ID = "";
                        }

                        ds.Tables["list"].Columns.Remove("company_id");//

                        //检查数据是否已经有了
                        string strCompany_Name = ds.Tables["list"].Rows[0]["company_name"].ToString();

                        if (conn.GetDataTableRowCount("SELECT * FROM MDM_Company WHERE Company_Name=" + "'" + strCompany_Name + "'") > 0)
                        {
                            throw new Exception("新增加的行，公司：" + strCompany_Name + "已经存在，信息错误！");
                        }
                        if (strCompany_ID == "")
                        {
                            bResult = conn.Insert("MDM_Company", ds.Tables["List"]);
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
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_Company");

                        string strCompany_ID = ds.Tables["list"].Rows[0]["company_id"].ToString();

                        conn.BeginTransaction();
                        bResult = conn.Delete("MDM_Company", "Company_ID=" + strCompany_ID);
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
