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
    ///MDM_System_Authorization_Edit 编辑系统权限信息
    /// </summary>
    public class MDM_System_Authorization_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Authorization_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取系统环境信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strAuthorization_ID = m_request.Tables[0].Rows[0]["Authorization_ID"].ToString();

                m_request.Tables[0].Columns.Remove("Authorization_ID");

                string strAuthorization_Name = m_request.Tables[0].Rows[0]["Authorization_Name"].ToString();
                string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();
                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Authorization");
                conn.BeginTransaction();
                conn.TableLock(listTable);


                if (strAuthorization_ID == "")
                {
                    DataTable dt = conn.GetDataTable(@"
                    SELECT COUNT(1) AS Cnt 
                    FROM dbo.MDM_System_Authorization 
                    WHERE 
                    Env_ID=@param0 
                    AND Authorization_Name=@param1", new string[2] { strEnv_ID, strAuthorization_Name });


                    if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                    {
                        throw new Exception("权限：" + strAuthorization_Name + "已存在!");
                    }

                    conn.Insert("MDM_System_Authorization", m_request.Tables[0]);
                }
                else
                {
                    DataTable dt = conn.GetDataTable(@"
                    SELECT COUNT(1) AS Cnt 
                    FROM dbo.MDM_System_Authorization 
                    WHERE 
                    Env_ID=@Param0 
                    AND Authorization_Name=@Param1
                    AND Authorization_ID<>@Param2", new string[3] { strEnv_ID, strAuthorization_Name, strAuthorization_ID });


                    if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                    {
                        throw new Exception("权限：" + strAuthorization_Name + "已存在!");
                    }

                    string strWhere = " Authorization_ID=" + strAuthorization_ID;
                    conn.Update("MDM_System_Authorization", m_request.Tables[0], strWhere);
                }
                conn.CommitTransaction();
                return true;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }



        }

    }

}