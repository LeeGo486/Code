using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///TFG_Dept_Term_UpdateFromMDM 更新TFG的人员关系表
    /// </summary>
    public class TFG_Dept_Term_UpdateFromMDM : LogicBase, ILogicExecute
    {
        public TFG_Dept_Term_UpdateFromMDM()
        {
            this.m_SessionCheck = false;

        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("MDM");

            //取到用户信息
            DataTable dt_User = conn.GetDataTable(
                @"  SELECT  t1.AM_User_id ,
                            t1.TfgMachineNo ,
                            t1.ComputerName ,
                            t2.AM_LOGIN
                    FROM    dbo.AM_TFG_Relation t1 WITH ( NOLOCK )
                            LEFT JOIN dbo.AM_User t2 WITH ( NOLOCK ) ON t1.AM_User_id = t2.AM_User_id
             
                     ", new string[0]);

            DbconnMysql connMysqlTFG = new DbconnMysql("TFG_infoguard");

            //取到部门信息,只取到两级目录，并且只会室与部门
            DataTable dt_user_dep = conn.GetDataTable(@" 
                        
                     SELECT DISTINCT
                            t1.AM_User_id ,
                            CASE WHEN t3.AM_Dept1_ID IS NULL THEN t3.AM_Company
                                 ELSE t3.AM_Dept1_ID
                            END AM_S_Dept_ID
                     FROM   dbo.AM_TFG_Relation t1 WITH ( NOLOCK )
                            LEFT JOIN dbo.AM_User_Dept t2 WITH ( NOLOCK ) ON t1.AM_User_id = t2.AM_User_id
                            LEFT JOIN dbo.AM_Dept t3 WITH ( NOLOCK ) ON t2.AM_S_Dept_ID = t3.AM_S_Dept_ID
                            LEFT JOIN dbo.AM_Dept t4 WITH ( NOLOCK ) ON t3.AM_Dept1_ID = t4.AM_S_Dept_ID
                     WHERE  t3.[AM_Dept_NAME_All] LIKE '01%'
                            AND ( t4.AM_Dept_NAME IS NULL
                                  OR t4.AM_Dept_NAME LIKE '%部'
                                  OR t4.AM_Dept_NAME LIKE '%室'
                                )
                        ", new string[0]);
            try
            {

                ArrayList tableList = new ArrayList();
                connMysqlTFG.BeginTransaction();


                tableList.Add("Info_Term");
                connMysqlTFG.TableLock(tableList);

                //更新TFG服务器的用户姓名
                for (int i = 0; i < dt_User.Rows.Count; i++)
                {
                    DataTable dt_Update_Info_Term = new DataTable();
                    dt_Update_Info_Term.Columns.Add("sn");
                    dt_Update_Info_Term.Columns.Add("name");

                    DataRow dr = dt_Update_Info_Term.NewRow();
                    dr["sn"] = dt_User.Rows[i]["TfgMachineNo"];
                    dr["name"] = dt_User.Rows[i]["AM_LOGIN"];
                    dt_Update_Info_Term.Rows.Add(dr);

                    string strWhere = "sn='" + dt_User.Rows[i]["TfgMachineNo"] + "'";

                    connMysqlTFG.Update("Info_Term", dt_Update_Info_Term, strWhere);

                }

                //删除用户与部门数据
                connMysqlTFG.Excute("Delete FROM info_dep_term");

                //插入用户与部门数据
                DataTable dt_trem_dep = new DataTable();
                dt_trem_dep.Columns.Add("term_id");
                dt_trem_dep.Columns.Add("dep_id");

                for (int i = 0; i < dt_User.Rows.Count; i++)
                {

                    string strSN = dt_User.Rows[i]["TfgMachineNo"].ToString();
                    string strcn_id = dt_User.Rows[i]["AM_User_id"].ToString();
                    string[] strParam = new string[1];


                    strParam[0] = dt_User.Rows[i]["TfgMachineNo"].ToString();

                    DataTable dt_info_term = connMysqlTFG.GetDataTable(@"
                                                SELECT id,
                                                    sn 
                                                FROM info_term
                                                WHERE sn=?Param0", strParam);
                    for (int j = 0; j < dt_info_term.Rows.Count; j++)
                    {
                        string strID = dt_info_term.Rows[j]["id"].ToString();

                        DataRow[] drList = dt_user_dep.Select("AM_User_id=" + strcn_id, "AM_S_Dept_ID ASC");
                        foreach (DataRow dr in drList)
                        {
                            DataRow drAdd = dt_trem_dep.NewRow();
                            drAdd["term_id"] = strID;
                            drAdd["dep_id"] = dr["AM_S_Dept_ID"];
                            dt_trem_dep.Rows.Add(drAdd);
                        }

                    }

                }

                if (dt_trem_dep.Rows.Count > 0)
                {
                    connMysqlTFG.Insert("info_dep_term", dt_trem_dep);
                }

                //取到TFG的所有有效用户的没有小翅膀组织架构信息的铁卷用户
                DataTable dt_NO_dept = connMysqlTFG.GetDataTable(@"select name,id from info_term
where enabled<>2
and not exists (select 1 from info_dep_term where info_term.id=info_dep_term.term_id)"
                    , new string[0]);


                for (int i = 0; i < dt_NO_dept.Rows.Count; i++)
                {
                    string strName = dt_NO_dept.Rows[i]["name"].ToString();
                    string strID = dt_NO_dept.Rows[i]["id"].ToString();

                    //找到小翅膀对应的用户的组织架构
                    DataTable dt_User_temp = conn.GetDataTable(@"  
                                    
                                   SELECT  DISTINCT CASE WHEN t3.am_dept1_id IS NULL THEN t3.AM_Company ELSE t3.am_dept1_id END AM_S_Dept_ID
                                    FROM    dbo.AM_User t1 WITH ( NOLOCK )
                                            JOIN dbo.AM_User_Dept t2 WITH ( NOLOCK ) ON t1.AM_User_id = t2.AM_USER_ID
                                            JOIN dbo.AM_Dept t3 WITH ( NOLOCK ) ON t2.AM_S_Dept_ID = t3.AM_S_Dept_ID
                                            LEFT JOIN dbo.AM_Dept t4 WITH(NOLOCK) ON t3.am_dept1_id=t4.AM_S_Dept_ID
                                    WHERE   t1.AM_login ='" + strName + @"'
                                    AND (t4.AM_S_Dept_ID IS NULL --公司 
                                    OR t4.AM_Dept_NAME LIKE '%部'
                                    OR t4.AM_Dept_NAME LIKE '%室'
                                    )
                                    AND t3.AM_Dept_NAME_All like '01%'
", new string[0]);

                    if (dt_User_temp.Rows.Count > 0)
                    {

                        DataTable dtUPdate = new DataTable();
                        dtUPdate.Columns.Add("term_id");
                        dtUPdate.Columns.Add("dep_id");
                        foreach (DataRow dr in dt_User_temp.Rows)
                        {
                            DataRow drNew = dtUPdate.NewRow();
                            drNew["dep_id"] = dr["AM_S_Dept_ID"];
                            drNew["term_id"] = strID;
                            dtUPdate.Rows.Add(drNew);
                        }

                        connMysqlTFG.Insert("info_dep_term", dtUPdate);
                    }
                }

                connMysqlTFG.CommitTransaction();
                return true;

            }
            catch
            {
                connMysqlTFG.RollbackTransaction();
                throw;
                
            }
        }

    }

}