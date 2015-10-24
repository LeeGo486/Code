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
    public class User_Authority : HZYLogicBase, ILogicGetData
    {
        public User_Authority()
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
                    string strUserName = dt_LIST.Rows[0]["UserName"].ToString();
                    string strSQL = @"
                                SELECT DISTINCT
	                                   T1.[AUZID]
                                      ,T1.[AUZName]
                                      ,0 AS Authorization_ID_F
                                      , CASE WHEN T2.USERNAME IS NULL THEN '0'
                                       ELSE  '1' END  HavaFlag
                                  FROM [WSRR_Manage].[F01_CERT].[AUZ] T1 WITH ( NOLOCK )
                                  LEFT JOIN [WSRR_Manage].[F01_CERT].[UserAUZ] T2 WITH ( NOLOCK ) ON T1.AUZID=T2.AUZID
			                                AND T2.USERNAME=@param0";
                    ds_Return = conn.GetDataSet(strSQL, new string[] { strUserName });
                }
                //更新用户权限
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    string strUserName = dt_LIST.Rows[0]["UserName"].ToString();
                    conn.LockTableList.Add("[WSRR_Manage].[F01_CERT].[UserAUZ]");//锁定表
                    conn.BeginTransaction();
                    //1.删除该用户的所有权限
                    string strWhere = " UserName=" + strUserName;
                    bool deleteFlag = conn.Delete("[WSRR_Manage].[F01_CERT].[UserAUZ]", strWhere);
                    //2.新增勾选的权限
                    bool insertFlag = conn.Insert("[WSRR_Manage].[F01_CERT].[UserAUZ]", dt_LIST);
                    conn.CommitTransaction();
                    //删除操作和插入操作都正确的情况下
                    if (deleteFlag && insertFlag)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, strUserName + "权限更新成功!" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { true, strUserName + "权限更新失败!" });
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
            }
            return ds_Return;
        }
    }
}
