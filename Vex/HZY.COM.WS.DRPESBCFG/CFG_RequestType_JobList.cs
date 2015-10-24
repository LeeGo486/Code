using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：CFG_RequestType_JobList
/// 类说明：对CFG_RequestType_JobList的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-11-01
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRPESBCFG
{

    public class CFG_RequestType_JobList : LogicBase, ILogicGetData
    {
        public CFG_RequestType_JobList()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("DRP_ESB");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;
        /// <summary>
        /// 对CFG_RequestType_JobList的CRUD,为Easyui专用
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
                        string strRequestType_ID = "";

                        strRequestType_ID = ds.Tables["list"].Rows[0]["RequestType_ID"].ToString();

                        string strSQL = "SELECT  * FROM dbo.CFG_RequestType_JobList WHERE 1=1 AND RequestType_ID=" + strRequestType_ID;


                        ds_Return = conn.GetDataSet(strSQL);
                        
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("CFG_RequestType_JobList");
                        conn.BeginTransaction();
                        string strRequestType_job_ID = ds.Tables["list"].Rows[0]["RequestType_job_ID"].ToString();

                        ds.Tables["list"].Columns.Remove("RequestType_job_ID");

                        //检查数据
                        string strRequestType_ID = ds.Tables["list"].Rows[0]["RequestType_ID"].ToString();

                        if (strRequestType_ID == "" ||
                            conn.GetDataTableFirstValue("SELECT COUNT(1) as a FROM CFG_RequestType WHERE RequestType_ID=" + strRequestType_ID).ToString() == "0")
                        {
                            throw new Exception("RequestType_ID信息错误！");
                        }


                        //添加数据
                        if (strRequestType_job_ID == "")
                        {
                            bResult = conn.Insert("CFG_RequestType_JobList", ds.Tables["List"]);
                        }
                        else
                        {
                            bResult = conn.Update("CFG_RequestType_JobList", ds.Tables["List"], "RequestType_job_ID=" + strRequestType_job_ID);
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
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("CFG_RequestType_JobList");
                        conn.LockTableList.Add("CFG_RequestType_JobList_Ref");
                        conn.BeginTransaction();
                        string strRequestType_job_ID = ds.Tables["list"].Rows[0]["RequestType_job_ID"].ToString();



                        if (strRequestType_job_ID.Trim() == "")
                        {
                            throw new Exception("JobListID不空，不知道怎么删除");
                        }

                        bResult = conn.Delete("CFG_RequestType_JobList", "RequestType_job_ID=" + strRequestType_job_ID);
                        bResult = conn.Delete("CFG_RequestType_JobList_Ref", "RequestType_JobList_ID=" + strRequestType_job_ID);

                        conn.CommitTransaction();
                         
                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "删除失败" });

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