using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：System_Code
/// 类说明：对System_Code(系统编号设置)的CRUD,为Easyui专用
/// 创建人：郭琦琦 
/// 创建日期：2014-01-26 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.EPAcount
{

    public class System_Code : LogicBase, ILogicGetData
    {
        public System_Code()
        {
            this.m_SessionCheck = true;
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
                        string strSort = " System_ID ";
                        string strWhere = "";
                        string strSearchFilter = " ";

                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        //strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strSort = strSort;
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
                                   [System_ID],
                                   [System_Name],
                                   [System_Code],
                                   [System_SN]
                            FROM   [MDM_System]
                            WHERE  1 = 1 " + strWhere;
                         
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], nPage, nPageRowCount, strSort + " " + strOrder);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_System");
                        conn.BeginTransaction();
                        string strSystem_ID = ds.Tables["list"].Rows[0]["System_ID"].ToString();
                        string strrowindex = ds.Tables["list"].Rows[0]["rowindex"].ToString();


                        ds.Tables["list"].Columns.Remove("System_ID");//
                        ds.Tables["list"].Columns.Remove("rowindex");

                        //检查数据是否已经有了
                        string strSystem_Code = ds.Tables["list"].Rows[0]["System_Code"].ToString();
                        string strSystem_Name = ds.Tables["list"].Rows[0]["System_Name"].ToString();

                        int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System WHERE System_ID != " + strSystem_ID + " and System_Code=" + "'" + strSystem_Code + "'");
                        int nSystemNameCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System WHERE System_ID != " + strSystem_ID + " and System_Name=" + "'" + strSystem_Name + "'");

                        if (nCodeCount != 0 || nSystemNameCount != 0)
                        {
                            throw new Exception("编号：" + strSystem_Code +"或者名称：" + strSystem_Name + "已经存在！！！信息错误！");
                        }


                        bResult = conn.Update("MDM_System", ds.Tables["List"], "System_ID=" + strSystem_ID);
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
                        conn.LockTableList.Add("MDM_System");
                        conn.BeginTransaction();

                        string strSystem_ID = ds.Tables["list"].Rows[0]["System_ID"].ToString();


                        if (strSystem_ID == "系统自动生成")
                        {
                            strSystem_ID = "";
                        }

                        ds.Tables["list"].Columns.Remove("System_ID");//
 
                        //检查数据是否已经有了
                        string strSystem_Code = ds.Tables["list"].Rows[0]["System_Code"].ToString();
                        string strSystem_Name = ds.Tables["list"].Rows[0]["System_Name"].ToString();

                        if (conn.GetDataTableRowCount("SELECT * FROM MDM_System WHERE System_Code=" + "'" + strSystem_Code + "'") > 0)
                        {
                            throw new Exception("新增加的行，编号：" + strSystem_Code + "已经存在信息错误！");
                        }


                        if (conn.GetDataTableRowCount("SELECT * FROM MDM_System WHERE System_Name=" + "'" + strSystem_Name + "'") > 0)
                        {
                            throw new Exception("新增加的行，名称："  + strSystem_Name + "已经存在信息错误！");
                        }


                        //添加数据
                        if (strSystem_ID == "")
                        {
                            bResult = conn.Insert("MDM_System", ds.Tables["List"]);
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
                        conn.LockTableList.Add("MDM_System");

                        string strSystem_ID = ds.Tables["list"].Rows[0]["System_ID"].ToString();
 
                        conn.BeginTransaction();
                        bResult = conn.Delete("MDM_System", "System_ID=" + strSystem_ID);
                        bResult = conn.Delete("MDM_System_Property_Info", "System_ID=" + strSystem_ID);
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
