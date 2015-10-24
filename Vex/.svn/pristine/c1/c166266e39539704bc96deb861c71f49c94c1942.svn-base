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
    ///TFG_Dept_ExceuteGetFromMDM 将MDM的组织架构信息插入到TFG中去
    /// </summary>
    public class TFG_Dept_ExceuteGetFromMDM : LogicBase, ILogicExecute
    {
        public TFG_Dept_ExceuteGetFromMDM()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            return null;
        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("MDM");
            DataTable dt = conn.GetDataTable( //只取一级目录，并且名称为部或者室的部门
                @"  

               SELECT 
                    t1.AM_S_Dept_ID AS ID,
                    t1.AM_P_Dept_ID AS superior_dep,
                    t1.AM_Dept_NAME AS name,
                    '1' AS enabled,
                    '1' AS auto_approve
                FROM dbo.AM_Dept t1
                LEFT JOIN dbo.AM_Dept t2 WITH(NOLOCK) ON t1.am_dept1_id=t2.AM_S_Dept_ID
                WHERE t1.am_dept2_id IS NULL
                AND t1.[AM_Dept_NAME_All] LIKE '01%'
                AND (t1.am_dept1_id IS NULL OR
                t2.AM_Dept_NAME LIKE '%室'
                OR t2.AM_Dept_NAME LIKE '%中心'
                OR t2.AM_Dept_NAME LIKE'%部')
                    
                    ", new string[0]);


            //过滤非01开始的公司组织架构


            //将一级公司的父节点改成1
            DataRow[] drList = dt.Select("superior_dep=0");
            foreach (DataRow dr1 in drList)
            {
                dr1["superior_dep"] = "1";
            }


            //添加一行主目录
            DataRow dr = dt.NewRow();
            dr["ID"] = "1";
            dr["superior_dep"] = "0";
            dr["name"] = "华之毅集团";
            dr["enabled"] = "1";
            dr["auto_approve"] = "1";
            dt.Rows.Add(dr);



            DbconnMysql connMysqlTFG = new DbconnMysql("TFG_infoguard");

            try
            {


                ArrayList tableList = new ArrayList();
                connMysqlTFG.BeginTransaction();
 
                tableList.Add("info_dep");
                connMysqlTFG.TableLock(tableList);
                
                connMysqlTFG.ExcuteQuerry("DELETE FROM info_dep;");

                connMysqlTFG.Insert("info_dep", dt);

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