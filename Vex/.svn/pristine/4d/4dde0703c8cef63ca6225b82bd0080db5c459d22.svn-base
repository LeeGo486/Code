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
    public class MenuManage : HZYLogicBase, ILogicGetData
    {
        public MenuManage()
        {
            this.m_SessionCheck = true;
        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("WSRR");
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataTable dt_EditResult = new dsCommon.dtResultDataTable();
            DataSet dsRequest = new DataSet();
            DataSet ds_Return = new DataSet();
            dsRequest = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = dsRequest.Tables["OPTYPE"];
            DataTable dt_LIST = dsRequest.Tables["LIST"];

            for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
            {
                //获取用户权限信息
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                {
                    string strSQL = @"
                            SELECT 
                                   [MenuID]
                                  ,[MenuName]
                                  ,[MenuFatherID]
                                  ,[ActionURL]
                              FROM [WSRR_Manage].[F01_CERT].[Menu]
                        ";
                    ds_Return = conn.GetDataSet(strSQL);
                    //ds_Return.Tables[0].Rows.Add(new object[] { "0", "00_根目录", "-1", "-1" });
                }     
                //更新
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                {
                    string strMenuID = dt_LIST.Rows[0]["MenuID"].ToString();
                    bool bResult = false;
                    conn.LockTableList.Add("[WSRR_Manage].[F01_CERT].[Menu]");//锁定表
                    conn.BeginTransaction();//开始事务
                    dt_LIST.Columns.Remove("MenuID");//移除属性，标识符列（ID）不能更新
                    bResult = conn.Update("[WSRR_Manage].[F01_CERT].[Menu]", dt_LIST, "MenuID=" + strMenuID);//update语句
                    conn.CommitTransaction();
                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    string strMenuID = dt_LIST.Rows[0]["MenuID"].ToString();
                    bool bResult = false;
                    conn.LockTableList.Add("[WSRR_Manage].[F01_CERT].[Menu]");//锁定表
                    conn.BeginTransaction();//开始事务
                    dt_LIST.Columns.Remove("MenuID");//移除属性，标识符列（ID）不能更新
                    bResult = conn.Insert("[WSRR_Manage].[F01_CERT].[Menu]", dt_LIST);//update语句
                    conn.CommitTransaction();
                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    string strMenuID = dt_LIST.Rows[0]["MenuID"].ToString();
                    bool bResult = false;
                    conn.LockTableList.Add("[WSRR_Manage].[F01_CERT].[Menu]");//锁定表
                    conn.BeginTransaction();//开始事务
                    dt_LIST.Columns.Remove("MenuID");//移除属性，标识符列（ID）不能更新
                    bResult = conn.Delete("[WSRR_Manage].[F01_CERT].[Menu]" , "MenuID=" + strMenuID);//update语句
                    conn.CommitTransaction();
                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
            }

            return ds_Return;
        }
    }
}
