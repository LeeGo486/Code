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
    public class System_Menu : LogicBase, ILogicGetData
    {

        public System_Menu()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("VexSSO");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;

        /// 系统菜单信息
        public DataSet GetData()
        {
            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
            string strXML = "";
            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
            for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
            {
                //获取菜单树
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                {
                    DataTable dt_list = ds.Tables["LIST"];
                    string env_id = dt_list.Rows[i][0].ToString();
                    string type = dt_list.Rows[i][1].ToString();
                    
                    if (type == "env_right")
                    {
                        string strAuthorization_ID = dt_list.Rows[i][2].ToString();
                        string strSQL = @"
                            SELECT  t1.Menu_Id ,
                                    t1.Menu_Code +' ' + t1.Menu_Name Menu_Name,
                                    t1.Menu_Father_ID ,
                                    ISNULL(t2.HavaFlag, 0) HavaFlag
                            FROM    MDM_System_Menu t1 WITH ( NOLOCK )
                                    LEFT JOIN dbo.MDM_System_Menu_AUZ t2 WITH ( NOLOCK ) ON t1.Menu_Id = t2.Menu_ID
                                    AND Authorization_ID=@param0
                            WHERE   t1.env_id = @param1
                        ";
                        ds_Return = conn.GetDataSet(strSQL, new string[2] { strAuthorization_ID, env_id });
                        //没有菜单树,添加根目录行
                        if (ds_Return.Tables[0].Rows.Count == 0)
                        {
                            ds_Return.Tables[0].Rows.Add(new object[] { "-1", "根目录", "0", "0" });
                        }
                    }
                    else
                    {
                        //DataTable dt = new DataTable();
                        //dt.Columns.Add("Env_ID");
                        //DataRow dr = dt.NewRow();
                        //dr[0] = env_id;
                        //dt.Rows.Add(dr);
                        //m_request.Tables.Add(dt);
                        string strSQL = @"
                            SELECT Menu_Id,Menu_Code+ ''+Menu_Name AS Menu_NameShow,Menu_Father_ID as  Menu_Father_ID_ForTree,
                            Menu_Father_ID,ActionURL,ISNULL(MenuType,1) MenuType,Menu_Code, Menu_Name FROM MDM_System_Menu
                            WHERE Env_ID = @param0 order by Menu_Code
                        ";
                        ds_Return = conn.GetDataSet(strSQL, new string[1] { env_id });
                        //没有菜单树,添加根目录行
                        ds_Return.Tables[0].Rows.Add(new object[] { "0", "00_根目录", "-1", "-1", "", "1", "00", "根目录" });
                        //if (ds_Return.Tables[0].Rows.Count == 0)
                        //{
                        //    ds_Return.Tables[0].Rows.Add(new object[] { "-1", "00_根目录", "0", "-1", "", "1", "00", "根目录" });
                        //}
                        //else
                        //{
                        //    ds_Return.Tables[0].Rows.Add(new object[] { "-1", "00_根目录", "0", "-1", "", "1", "00", "根目录" });
                        //}
                    }
                }
                //更新
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                {
                    DataTable dt_list = ds.Tables["LIST"];
                    string strMenu_ID = dt_list.Rows[0]["Menu_ID"].ToString();
                    bool bResult = false;
                    conn.LockTableList.Add("MDM_System_Menu");//锁定表
                    conn.BeginTransaction();//开始事务
                    //查询
                    //DataSet System_Menu_DataSet = conn.GetDataSet("SELECT * FROM MDM_System_Menu WHERE Menu_ID = " + strMenu_ID);
                    dt_list.Columns.Remove("Menu_ID");//移除属性，标识符列（ID）不能更新
                    bResult = conn.Update("MDM_System_Menu", dt_list, "Menu_ID=" + strMenu_ID);//update语句
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
                    DataTable dt_list = ds.Tables["LIST"];
                    bool bResult = false;
                    conn.LockTableList.Add("MDM_System_Menu");
                    conn.BeginTransaction();
                    string strMenu_ID = dt_list.Rows[0]["Menu_ID"].ToString();
                    string strMenu_Name = dt_list.Rows[0]["Menu_Name"].ToString();
                    if (strMenu_ID == "")
                    {
                        dt_list.Columns.Remove("Menu_ID");//移除属性，标识符列（ID）不能更新
                        if (dt_list.Rows[0]["Menu_Father_ID"].ToString()=="-1")//根目录0
                        {
                            dt_list.Rows[0]["Menu_Father_ID"] = "0";
                        }
                        bResult = conn.Insert("MDM_System_Menu", dt_list);
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
                    //System.Diagnostics.Debug.WriteLine(dt_OPTYPE.Rows[i][0].ToString());
                    //System.Diagnostics.Debugger.Log(1, "TEST", "Message");
                    bool bResult = false;
                    conn.LockTableList.Add("MDM_System_Menu");
                    string strMenu_ID = ds.Tables["list"].Rows[0]["Menu_ID"].ToString();
                    conn.BeginTransaction();
                    bResult = conn.Delete("MDM_System_Menu", "Menu_ID=" + strMenu_ID);
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
    }
}
