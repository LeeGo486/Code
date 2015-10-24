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
using HZY.COM.Common.Base;
using HZY.COM.Common.Base;

/// 类名：Mat_Org
/// 类说明：对Mat_Org(施工单位)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-02-27 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.StoreBusinessSystem
{

    public class Mat_Org : LogicBase, ILogicGetData
    {
        public Mat_Org()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("HZY_Mat");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

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
                        string strSort = " orgid ";
                        string strWhere = "1=1";
                        string strSearchFilter = " ";

                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;

                        if (strSearchFilter.Trim() != "")
                        {
                            strWhere += " AND " + strSearchFilter;
                        }

                        string strSQL = @"
                             SELECT 
                                   [orgid],
                                   [assitenid],
                                   [name],
                                   [linkman],
                                   [tel],
                                   [chk_sure],
                                   case when chk_sure='1' then '是' else '否' end as chk_sureName,
                                   [chk_date],
                                   [chk_name],
                                   CONVERT(varchar(100), [createtime], 23) as [createtime],
                                   [crname],
                                   CONVERT(varchar(100), [updatetime], 23) as [updatetime],
                                   [comment],
                                   [vericode]
                            FROM   [mat].[mat_org]    
                            WHERE  " + strWhere;

                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], nPage, nPageRowCount, strSort + " " + strOrder);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        bool bResult = false;
                        string strUsername = this.hzyMessage.User_Name_CN;
                        string strName = ds.Tables["list"].Rows[0]["name"].ToString();

                        ds.Tables["list"].Rows[0]["crname"] = strUsername;
                        ds.Tables["list"].Rows[0]["createtime"] = timeNow;

                        conn.LockTableList.Add("mat.mat_org");// 锁表
                        conn.BeginTransaction(); // 开启事务

                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_org WHERE name = '" + strName + "'");

                        if (nCodeCount != 0)
                        {
                            throw new Exception("该单位档案已存在，请刷新重试！");
                        }
                        bResult = conn.Insert("mat.mat_org", ds.Tables["List"]);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "新增失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        // 获取前台传来的UPDATE信号，data（更新编辑的数据）、sune(审核)、nsure(反审核)
                        string strUpdateTag = ds.Tables["list"].Rows[0]["updatetag"].ToString();

                        if (strUpdateTag == "data") {
                            string strChk_sure = ds.Tables["list"].Rows[0]["chk_sure"].ToString();
                            string strOrgid = ds.Tables["list"].Rows[0]["orgid"].ToString();

                            ds.Tables["list"].Rows[0]["updatetime"] = timeNow;
                            ds.Tables["list"].Columns.Remove("updatetag");
                            ds.Tables["list"].Columns.Remove("orgid");
                            ds.Tables["list"].Columns.Remove("chk_sure");

                            conn.LockTableList.Add("mat.mat_org");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_org WHERE orgid = '" + strOrgid + "'");

                            if (nCodeCount == 0)
                            {
                                throw new Exception("该单位不存在，请刷新重试！");
                            }
                            string strChk_sureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_org WHERE orgid = '" + strOrgid + "'").ToString();

                            if (strChk_sureOld == "0")
                            {
                                if (strChk_sureOld != strChk_sure)
                                {
                                    throw new Exception("状态异常，请刷新重试！");
                                }
                            }
                            else {
                                throw new Exception("状态异常，请刷新重试！");
                            }

                            bResult = conn.Update("mat.mat_org", ds.Tables["List"], "orgid=" + strOrgid);
                            conn.CommitTransaction();
                        }
                        else if (strUpdateTag == "sure") {
                            string strChk_sure = ds.Tables["list"].Rows[0]["chk_sure"].ToString();
                            string strOrgid = ds.Tables["list"].Rows[0]["orgid"].ToString();

                            ds.Tables["list"].Columns.Remove("updatetag");
                            ds.Tables["list"].Columns.Remove("orgid");
                            ds.Tables["list"].Rows[0]["chk_sure"] = 1;

                            conn.LockTableList.Add("mat.mat_org");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_org WHERE orgid = '" + strOrgid + "'");

                            if (nCodeCount == 0)
                            {
                                throw new Exception("该单位不存在，请刷新重试！");
                            }
                            string strChk_sureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_org WHERE orgid = '" + strOrgid + "'").ToString();

                            if (strChk_sureOld == "0")
                            {
                                if (strChk_sureOld != strChk_sure)
                                {
                                    throw new Exception("状态异常，请刷新重试！");
                                }
                            }
                            else
                            {
                                throw new Exception("状态异常，请刷新重试！");
                            }

                            bResult = conn.Update("mat.mat_org", ds.Tables["List"], "orgid=" + strOrgid);
                            conn.CommitTransaction();
                        }
                        else if (strUpdateTag == "nsure") {
                            string strChk_sure = ds.Tables["list"].Rows[0]["chk_sure"].ToString();
                            string strOrgid = ds.Tables["list"].Rows[0]["orgid"].ToString();

                            ds.Tables["list"].Columns.Remove("updatetag");
                            ds.Tables["list"].Columns.Remove("orgid");
                            ds.Tables["list"].Rows[0]["chk_sure"] = 0;

                            conn.LockTableList.Add("mat.mat_org");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_org WHERE orgid = '" + strOrgid + "'");

                            if (nCodeCount == 0)
                            {
                                throw new Exception("该单位不存在，请刷新重试！");
                            }
                            string strChk_sureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_org WHERE orgid = '" + strOrgid + "'").ToString();

                            if (strChk_sureOld == "0")
                            {
                                throw new Exception("状态异常，请刷新重试！");
                            }

                            bResult = conn.Update("mat.mat_org", ds.Tables["List"], "orgid=" + strOrgid);
                            conn.CommitTransaction();
                        }

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        bool bResult = false;
                        string strOrgid = ds.Tables["list"].Rows[0]["orgid"].ToString();

                        conn.LockTableList.Add("mat.mat_org");// 锁表
                        conn.BeginTransaction(); // 开启事务

                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_org WHERE orgid = '" + strOrgid + "'");

                        if (nCodeCount != 0)
                        {
                            int strChk_orgid = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_bill WHERE orgid = " + strOrgid );
                            if (strChk_orgid == 0)
                            {
                                string strChk_sureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_org WHERE orgid = '" + strOrgid + "'").ToString();

                                if (strChk_sureOld == "1")
                                {
                                    throw new Exception("状态异常，请刷新重试！");
                                }
                            }
                            else {
                                throw new Exception("该档案已存在业务数据，无法删除！");
                            }
                        };


                        bResult = conn.Delete("mat.mat_org", "orgid=" + strOrgid);
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
