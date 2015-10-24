using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;


/// 类名：WS_Applay
/// 类说明：对WS_Applay的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-11-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR
{

    public class WS_Applay : LogicBase, ILogicGetData
    {
        public WS_Applay()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("WSRR");

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

                                  SELECT [WS_Applay_ID]
                                      ,[WS_Name]
                                      ,[Applay_Time]
                                      ,[Appliay_User]
                                      ,[state]
                                      ,[WS_Content]
                                      ,[Input_Format]
                                      ,[Return_Format]
                                      ,[WS_DeployServer]
                                      ,[WS_SPName]
                                      ,[Logic_Content]
                                      ,[Code]
                                  FROM  [dbo].[WS_Applay]
                                  WHERE 1=1 
                        " + strSearchFilter;

                        ds_Return = conn.GetDataSet(strSQL);

                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("WS_Applay");
                        conn.BeginTransaction();
                        string strWS_Applay_ID = ds.Tables["list"].Rows[0]["WS_Applay_ID"].ToString();

                        ds.Tables["list"].Columns.Remove("WS_Applay_ID");


                        //添加数据
                        if (strWS_Applay_ID == "")
                        {
                            bResult = conn.Insert("WS_Applay", ds.Tables["List"]);
                        }
                        else
                        {
                            bResult = conn.Update("WS_Applay", ds.Tables["List"], "WS_Applay_ID=" + strWS_Applay_ID);
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