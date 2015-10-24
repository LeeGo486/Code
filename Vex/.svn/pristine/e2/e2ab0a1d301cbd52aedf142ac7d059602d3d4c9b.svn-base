using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HZY.COM.WS.WSRR2
{
    public class Authority: HZYLogicBase, ILogicGetData
    {
        public Authority()
        {
            this.m_SessionCheck = true;
        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("WSRR");
            string strWhere = string.Empty;
            string strXML  = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataTable dt_EditResult = new dsCommon.dtResultDataTable();
            DataSet dsRequest = new DataSet();
            DataSet ds_Return = new DataSet();
            dsRequest = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = dsRequest.Tables["OPTYPE"];
            DataTable dt_LIST = dsRequest.Tables["LIST"];

            for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
            {
                //获取权限信息
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                {
                    string strSQL = @"
                    SELECT 
                           [AUZID]
                          ,[AUZName]
                      FROM [WSRR_Manage].[F01_CERT].[AUZ]";
                    ds_Return = conn.GetDataSetForPageList(strSQL,m_hzyPageInfo);
                }
                //新增环境的权限名称
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    //String Env_ID = dt_LIST.Rows[0]["Env_ID"].ToString();
                    String strAuzName = dt_LIST.Rows[0]["AuzName"].ToString();
                    string strsql = @"
                        SELECT COUNT(1) AS Cnt 
                        FROM  [WSRR_Manage].[F01_CERT].[AUZ] 
                        WHERE  Authorization_Name='" + strAuzName + "'";
                    DataTable dt = conn.GetDataTable(strsql);
                    if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "权限：" + strAuzName + "已存在!" });
                    }
                    else
                    {
                        //dt_LIST.Rows[0]["AuzID"] = Guid.NewGuid().ToString();
                        conn.BeginTransaction();
                        bool flag = conn.Insert(" [WSRR_Manage].[F01_CERT].[AUZ]", dt_LIST);
                        conn.CommitTransaction();
                        if (flag)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "权限：" + strAuzName + "添加成功!" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "权限：" + strAuzName + "添加失败!" });
                        }
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                //修改权限的菜单树
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                {
                    String strAuZID = dt_LIST.Rows[0]["AuzID"].ToString();
                    strWhere = " AuzID=" + strAuZID;
                    dt_LIST.Columns.Remove("AuzID");//移除属性，标识符列（ID）不能更新
                    conn.LockTableList.Add("[WSRR_Manage].[F01_CERT].[AUZ]");
                    conn.BeginTransaction();
                    bool flag = conn.Update("[WSRR_Manage].[F01_CERT].[AUZ]", dt_LIST, strWhere);
                    conn.CommitTransaction();
                    if (flag)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "权限修改成功!" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "权限修改失败!" });
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                //删除权限
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    String strAuZID = dt_LIST.Rows[0]["AuzID"].ToString();
                    strWhere = " AuzID=" + strAuZID;
                    conn.BeginTransaction();
                    bool flag = conn.Delete("[WSRR_Manage].[F01_CERT].[AUZ]", strWhere);
                    conn.CommitTransaction();
                    if (flag)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "权限删除成功!" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "权限删除失败!" });
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
            }

            return ds_Return;
        }
    }
}
