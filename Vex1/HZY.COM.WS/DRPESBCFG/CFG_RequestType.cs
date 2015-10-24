using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;


/// 类名：CFG_RequestType
/// 类说明：对CFG_RequestType的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-11-01
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRPESBCFG
{

    public class CFG_RequestType : LogicBase, ILogicGetData
    {
        public CFG_RequestType()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("DRP_ESB");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;
        /// <summary>
        /// 对CFG_RequestType的CRUD,为Easyui专用
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
                //bool bEdit = false;
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
                                    [RequestType_ID]
                                    ,REPLACE( [Name],CHAR(9),'') Name
                                    ,replace(replace(REPLACE([Content],CHAR(9),' '),char(13),'回车'),char(10),'回车') [Content]
                                    -- ,'' as Content
                                    ,[Table_Name]
                                    --,replace(replace(REPLACE([SQL],CHAR(9),' '),char(13),'<br>'),char(10),'<br>') SQL
                                    ,REPLACE(REPLACE(REPLACE([SQL],CHAR(10),'回车'),CHAR(13),'回车'),CHAR(9),' ') SQL
                                    ,'' sql
                                    ,[Enabled]
                                    ,[Type]
                                    ,[CreateTime]
                                    ,[Timestamps]
                                  FROM [CFG_RequestType]

                                  WHERE 1=1 
                        " + strSearchFilter;

                        ds_Return = conn.GetDataSet(strSQL);

                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("CFG_RequestType");
                        conn.BeginTransaction();
                        string strRequestType_ID = ds.Tables["list"].Rows[0]["RequestType_ID"].ToString();

                        ds.Tables["list"].Columns.Remove("RequestType_ID");


                        //添加数据
                        if (strRequestType_ID == "")
                        {
                            bResult = conn.Insert("CFG_RequestType", ds.Tables["List"]);
                        }
                        else
                        {
                            bResult = conn.Update("CFG_RequestType", ds.Tables["List"], "RequestType_ID=" + strRequestType_ID);
                        }
                        conn.CommitTransaction();

                        //cls.Request = ds1;
                        //bool bResult = cls.Execute();

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
                        //dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        //ds_Return.Tables.Add(dt_EditResult);

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