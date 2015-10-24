using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：System_Env
/// 类说明：对System_Env(系统环境)前台传来数据做出响应,为Easyui专用（学习用）。
/// 创建人：刘洪
/// 创建日期：2014-2-12  15：00
/// 修改人：刘洪
/// 修改日期：2014-02-21 16: 00
/// 
namespace HZY.COM.WS.EPAcount
{
    public class System_Env : LogicBase, ILogicGetData
    {
        public System_Env()
        {
            this.m_SessionCheck = true;
        }
        int m_npage = 1, m_Rows = 20;
        string EnvID, CheckEnvName;
        DateTime timeNow;

        private Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataTable dt_OPTYPE = new DataTable();
                DataTable TempTab = new DataTable();

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); //赋值
                ds = Common.Common.GetDSByExcelXML(strXML);

                dt_OPTYPE = ds.Tables["OPTYPE"];
                string dtOPTYPEval = dt_OPTYPE.Rows[0][0].ToString().ToUpper();

                if (dtOPTYPEval != "GET")
                {
                    EnvID = ds.Tables["list"].Rows[0]["Env_id"].ToString();
                    CheckEnvName = ds.Tables["list"].Rows[0]["Env_Name"].ToString();
                    timeNow = DateTime.Now;
                }
                else {
                    
                }

                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {
                    if (dtOPTYPEval == "GET")
                    {
                        string strOrder = " desc  ";
                        string strSort = " Env_ID ";
                        string strWhere = "1=1";
                        string searchFilter = "";

                        m_npage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        m_Rows = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"] != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                        searchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : searchFilter;

                        if (searchFilter.Trim() != "")
                        {
                            strWhere += " AND " + searchFilter;
                        }

                        string strSQL = @"
                                SELECT 
                                         t1.[Env_ID]
                                        ,t1.[Env_Name]
                                        ,t1.[Company_ID]
                                        ,t2.Company_Name
                                        ,t1.[System_ID]
                                        ,t3.[System_Name]
                                        ,t3.[System_SN]
                                        ,t1.[Env_SN]
                                        ,t1.[SSO_Login_URL]
                                        ,t1.[Login_URL]
                                        ,t1.[Createtime]
                                        ,t1.[Updatetime]
                                 ,Convert(bigint,t1.[Timestamps]) Timestamps
                                FROM [dbo].[MDM_System_Env] t1 WITH(NOLOCK)
                                LEFT JOIN dbo.MDM_Company t2 WITH(NOLOCK) ON t1.company_id=t2.Company_ID
                                LEFT JOIN dbo.MDM_System t3 WITH(NOLOCK) ON t1.System_ID=t3.System_ID
                                
                                where " + strWhere;

                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_npage, m_Rows, strSort + " " + strOrder);
                    }
                    else if (dtOPTYPEval == "UPDATE") 
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("MDM_System_Env");// 锁表
                        conn.BeginTransaction(); // 开启事务

                        //检查实体表中该ID是否存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Env WHERE Env_ID = '" + EnvID + "'");

                        if (nCodeCount == 0)
                        {
                            throw new Exception("该环境不存在，请检查！");
                        }

                        if (conn.GetDataTableRowCount("SELECT * FROM MDM_System_Env WHERE Env_ID != '" + EnvID + "'AND Env_Name='" + CheckEnvName + "'") > 0)
                        {
                            throw new Exception("修改的系统环境：" + CheckEnvName + "已存在！");
                        }
                        ds.Tables["list"].Columns.Remove("Env_ID"); //删除无需更新的列
                        ds.Tables["list"].Rows[0]["Updatetime"] = timeNow;

                        //开始更新
                        bResult = conn.Update("MDM_System_Env", ds.Tables["List"], "Env_ID=" + EnvID);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "更新成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (dtOPTYPEval == "INSERT")
                    {
                        bool bResult = false;

                        ds.Tables["list"].Columns.Remove("Env_id");
                        ds.Tables["list"].Rows[0]["Createtime"] = timeNow;
                        ds.Tables["list"].Rows[0]["Updatetime"] = timeNow;

                        conn.LockTableList.Add("MDM_System_Env");
                        conn.BeginTransaction();

                        //检查数据是否已经有了

                        if (conn.GetDataTableRowCount("SELECT * FROM MDM_System_Env WHERE Env_Name='" + CheckEnvName + "'") > 0)
                        {
                            throw new Exception("新增的系统环境：" + CheckEnvName + "已存在！");
                        }


                        //添加数据
                        if ( EnvID == "系统生成")
                        {
                            bResult = conn.Insert("MDM_System_Env", ds.Tables["List"]);
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
                    else if (dtOPTYPEval == "DELETE")
                    {
                        bool bResult = false;
                        //检查实体表中该ID是否存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Env WHERE Env_ID = '" + EnvID + "'");

                        if (nCodeCount == 0)
                        {
                            throw new Exception("环境不存在，无法删除！");
                        }

                        int CheckSMenu = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Menu WHERE Env_ID = '" + EnvID + "'");
                        int CheckSAuthorization = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Authorization WHERE Env_ID = '" + EnvID + "'");

                        if (CheckSMenu != 0 || CheckSAuthorization != 0) 
                        {
                            throw new Exception("菜单或权限存在数据,无法删除！   请联系超级管理员。");
                        }
                        conn.LockTableList.Add("MDM_System_Env");

                        conn.BeginTransaction();
                        bResult = conn.Delete("MDM_System_Env", "Env_ID=" + EnvID);
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
                    else if (dtOPTYPEval == "ALLDELETE") {
                        bool bResult = false;
                        string UserID = hzyMessage.User_ID;

                        //判断是否拥有足够权限
                        if (UserID != "4366")
                        {
                            throw new Exception("您无权限删除该环境！请联系超级管理员。");
                        }
                        //检查实体表中该ID是否存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM MDM_System_Env WHERE Env_ID = '" + EnvID + "'");

                        if (nCodeCount == 0)
                        {
                            throw new Exception("环境不存在，无法删除！");
                        }
                        //锁表
                        conn.LockTableList.Add("MDM_System_Authorization");
                        conn.LockTableList.Add("MDM_System_Menu");
                        conn.LockTableList.Add("MDM_System_Env");
                        conn.LockTableList.Add("MDM_System_User_Authorization");
                        //开启事务
                        conn.BeginTransaction();
                        //删除权限
                        bResult = conn.Delete("MDM_System_Authorization", "Env_ID=" + EnvID);
                        //删除菜单
                        bResult = conn.Delete("MDM_System_Menu", "Env_ID=" + EnvID);
                        //删除用户权限
                        bResult = conn.Delete("MDM_System_User_Authorization",@"Authorization_ID IN (SELECT Authorization_ID FROM MDM_System_Authorization WHERE Env_ID = "+EnvID+")");
                        //删除环境
                        bResult = conn.Delete("MDM_System_Env", "Env_ID=" + EnvID);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "销毁成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "销毁失败" });
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