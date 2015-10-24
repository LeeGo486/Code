using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

namespace HZY.COM.WS.EPAcount
{
    class System_Right : HZYLogicBase, ILogicGetData
    {
        public System_Right()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 10;

        /// 系统权限信息 59f31018-58d8-429b-90bd-e8ad0a91da94
        public DataSet GetData()
        {
            string strWhere = "", strSort = "";
            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
        
            ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
            DataTable dt_list = ds.Tables["LIST"];
            for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
            {
                //获取环境的权限信息
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                {
                    string strSQL = @"
                        SELECT 
		                        t1.[Authorization_ID] ,
                                t1.[Env_ID] ,
                                t3.[Env_SN] ,
                                t3.[Env_Name] ,
                                t1.[Authorization_Name] ,
                                t1.[Createtime] ,
                                t1.[Updatetime] ,
                                CONVERT(BIGINT, t1.[Timestamps]) Timestamps
                        FROM    [dbo].MDM_System_Authorization t1 WITH ( NOLOCK )
                                LEFT JOIN  dbo.MDM_System_Env  t3 WITH ( NOLOCK ) ON t3.Env_ID=t1.Env_ID
                                WHERE 1=1 
                       
                    ";
                    ds_Return = conn.GetDataSetForPageList(strSQL,m_hzyPageInfo);
               
                }
                //修改权限的菜单树
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    string strAuthorization_ID = dt_list.Rows[0]["form_AuthorizationSubmit_Auz_ID"].ToString();
                    ArrayList listTable = new ArrayList();
                    listTable.Add("MDM_System_Menu_AUZ");
                    conn.BeginTransaction();
                    conn.TableLock(listTable);
                    strWhere = " Authorization_ID=" + strAuthorization_ID;
                    bool flag1 = conn.Delete("MDM_System_Menu_AUZ", strWhere);
                    ArrayList listMenu = new ArrayList();
                    string strMenuId = dt_list.Rows[0]["form_AuthorizationSubmit_Menulist"].ToString();
                    string[] ssMenuId = strMenuId.Split(',');
                    bool flag = false;
                    foreach (string MenuId in ssMenuId)
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("Menu_ID");
                        dt.Columns.Add("Authorization_ID");
                        dt.Columns.Add("HavaFlag");
                        DataRow dr = dt.NewRow();
                        dr["Menu_ID"] = MenuId;
                        dr["Authorization_ID"] = strAuthorization_ID;
                        dr["HavaFlag"] = 1;
                        dt.Rows.Add(dr);
                        flag = conn.Insert("MDM_System_Menu_AUZ", dt);
                    }
                    if (flag)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "菜单分配成功!" });
                        conn.CommitTransaction();
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "菜单分配失败!" });
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                //新增环境的权限名称
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    String Env_ID = dt_list.Rows[0]["Env_ID"].ToString();
                    String Authorization_Name = dt_list.Rows[0]["Authorization_Name"].ToString();
                    string strsql = @"
                        SELECT COUNT(1) AS Cnt 
                        FROM dbo.MDM_System_Authorization 
                        WHERE 
                        Env_ID="+Env_ID+" AND Authorization_Name='"+Authorization_Name+"'";
                    DataTable dt = conn.GetDataTable(strsql);
                    if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "权限：" + Authorization_Name + "已存在!" });
                    }
                    else
                    {
                        dt_list.Columns.Remove("Authorization_ID");//移除属性，标识符列（ID）不能更新
                        conn.BeginTransaction();
                        bool flag = conn.Insert("MDM_System_Authorization", dt_list);
                        conn.CommitTransaction();
                        if (flag)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "权限：" + Authorization_Name + "添加成功!" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "权限：" + Authorization_Name + "添加失败!" });
                        }
                    }
                    ds_Return.Tables.Add(dt_EditResult);
                }
                //修改环境的权限名称
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                {
                    String Authorization_ID = dt_list.Rows[0]["Authorization_ID"].ToString();
                    strWhere = " Authorization_ID=" + Authorization_ID;
                    dt_list.Columns.Remove("Authorization_ID");//移除属性，标识符列（ID）不能更新
                    conn.LockTableList.Add("MDM_System_Authorization");
                    conn.BeginTransaction();
                    bool flag = conn.Update("MDM_System_Authorization", dt_list, strWhere);
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
                //删除环境的权限名称
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    String Authorization_ID = dt_list.Rows[0]["Authorization_ID"].ToString();
                    strWhere = " Authorization_ID=" + Authorization_ID;
                    conn.BeginTransaction();
                    bool flag = conn.Delete("MDM_System_Authorization", strWhere);
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
