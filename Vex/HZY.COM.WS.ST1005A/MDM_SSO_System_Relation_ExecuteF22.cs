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
    ///MDM_SSO_System_Relation_ExecuteTFG 从F22中取到用户,并自动关联AM的账户，插入到MDM中
    /// </summary>
    public class MDM_SSO_System_Relation_ExecuteF22 : LogicBase, ILogicExecute
    {
        public MDM_SSO_System_Relation_ExecuteF22()
        {
            this.m_SessionCheck = false;

        }


        public bool Execute()
        {
            string strSystem_Fid = "144";
            string strSystem_id = "ST0301A";
            string strSystem_Name = "F22分销系统 CS总部版";
            string strCompany_id = "235";
            Dbconn conn = new Dbconn("F22");
            Dbconn conn_MDM = new Dbconn("MDM");

            //取到总部的数据
            DataSet ds = conn.GetDataSet(
                @"  SELECT  userid ,
                            username
                    FROM    j_user t1 WITH ( NOLOCK )
                    WHERE   1 = 1
                            AND dptype = 0
                            AND notuse = 0
 	                    ");


            DataTable dt_Add = new DataTable();
            dt_Add.Columns.Add("System_FID");
            dt_Add.Columns.Add("System_ID");
            dt_Add.Columns.Add("System_Name");
            dt_Add.Columns.Add("AM_User_ID");
            dt_Add.Columns.Add("AM_Login");
            dt_Add.Columns.Add("Company_ID");
            dt_Add.Columns.Add("System_User_ID");
            dt_Add.Columns.Add("System_User_Name");
            dt_Add.Columns.Add("Create_AM_User_ID");
            dt_Add.Columns.Add("CreateTime");
            dt_Add.Columns.Add("UpdateTime");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string strName = ds.Tables[0].Rows[i]["username"].ToString();
                string strUserID = ds.Tables[0].Rows[i]["userid"].ToString();

                DataTable dt_AM = conn_MDM.GetDataTable(@"SELECT AM_User_ID,AM_login FROM dbo.AM_User
                                                WHERE AM_LOGIN=@param0", new string[1] { strName });
                if (dt_AM.Rows.Count > 0)
                {
                    DataRow dr_add = dt_Add.NewRow();
                    dr_add["System_FID"] = strSystem_Fid;
                    dr_add["System_ID"] = strSystem_id;
                    dr_add["System_Name"] = strSystem_Name;
                    dr_add["AM_User_ID"] = dt_AM.Rows[0]["AM_User_ID"].ToString();
                    dr_add["AM_Login"] = dt_AM.Rows[0]["AM_Login"].ToString();

                    dr_add["Company_ID"] = strCompany_id;

                    dr_add["System_User_ID"] = strUserID;
                    dr_add["System_User_Name"] = strName;
                    dr_add["Create_AM_User_ID"] = "0"; //默认为系统自动建立
                    dr_add["CreateTime"] = DateTime.Now;
                    dr_add["UpdateTime"] = DateTime.Now;
                    dt_Add.Rows.Add(dr_add);
                }
            }

            if (dt_Add.Rows.Count > 0)
            {
                ArrayList listLockTable = new ArrayList();
                listLockTable.Add("SSO_System_Relation");

                conn_MDM.BeginTransaction();
                try
                {
                    conn_MDM.TableLock(listLockTable);
                    conn_MDM.Excute("DELETE FROM SSO_System_Relation WHERE System_FID='" + strSystem_Fid + "'");
                    conn_MDM.InsertBYSQLBC("SSO_System_Relation", dt_Add);
                    conn_MDM.CommitTransaction();
                }
                catch (Exception)
                {
                    conn_MDM.RollbackTransaction();
                    throw;
                }

            }

            return true;

        }

    }

}