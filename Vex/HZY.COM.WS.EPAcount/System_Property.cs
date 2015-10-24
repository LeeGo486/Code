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


/// 类名：System_Property
/// 类说明：对System_Property(系统属性设置)的CRUD,为Easyui专用
/// 创建人：郭琦琦 
/// 创建日期：2014-01-26  
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.EPAcount
{
    public class System_Property : LogicBase, ILogicGetData
    {
        public System_Property()
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
                        string strSort = " Property_ID ";
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
                                        [Property_ID],
                                        [Property_Name]
                                FROM [MDM_System_Property]
                                WHERE 1=1 " + strWhere;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], nPage, nPageRowCount, strSort + " " + strOrder);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_System_Property");
                        conn.BeginTransaction();
                        string strProperty_ID = ds.Tables["list"].Rows[0]["Property_ID"].ToString();
                        string strrowindex = ds.Tables["list"].Rows[0]["rowindex"].ToString();

                        ds.Tables["list"].Columns.Remove("Property_ID");//
                        ds.Tables["list"].Columns.Remove("rowindex");

                        //核对数据
                        string strProperty_Name = ds.Tables["list"].Rows[0]["Property_Name"].ToString();
                        int nProperty_NameCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Property WHERE Property_ID != " + strProperty_ID + " and Property_Name=" + "'" + strProperty_Name + "'");


                        if (nProperty_NameCount != 0 )
                        {
                            throw new Exception("修改的行名称：" + strProperty_Name + "已经存在！！！信息错误！");
                        }

                        bResult = conn.Update("MDM_System_Property", ds.Tables["List"], "Property_ID=" + strProperty_ID);
 
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
                        conn.LockTableList.Add("MDM_System_Property");
                        conn.BeginTransaction();
                        string strProperty_ID = ds.Tables["list"].Rows[0]["Property_ID"].ToString();
                        if (strProperty_ID == "系统自动生成")
                        {
                            strProperty_ID = "";
                        }


                        ds.Tables["list"].Columns.Remove("Property_ID");//
                       
                        //核对数据
                        string strProperty_Name = ds.Tables["list"].Rows[0]["Property_Name"].ToString();
                        int nProperty_NameCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Property WHERE  Property_Name=" + "'" + strProperty_Name + "'");

                        if (nProperty_NameCount != 0)
                        {
                            throw new Exception("新增加的行，名称：" + strProperty_Name + "名称已经存在！！！信息错误！");
                        }

                         if (strProperty_ID == "")
                        {
                            bResult = conn.Insert("MDM_System_Property", ds.Tables["List"]);
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
                        conn.LockTableList.Add("MDM_System_Property");

                        string strProperty_ID = ds.Tables["list"].Rows[0]["Property_ID"].ToString();

                        //ds.Tables["list"].Columns.Remove("Property_ID");//

                        conn.BeginTransaction();
                        bResult = conn.Delete("MDM_System_Property", "Property_ID=" + strProperty_ID);
                        bResult = conn.Delete("MDM_System_Property_Info", "Property_ID=" + strProperty_ID);
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
