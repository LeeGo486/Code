using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Market_User_For_HZY_F22_Edit 编辑用户信息
    /// </summary>
    public class MDM_Market_User_For_HZY_F22_Edit : LogicBase, ILogicExecute
    {
        public MDM_Market_User_For_HZY_F22_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑用户信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM_Master");
            Dbconn conn_Market = new Dbconn("MDM_Market");

            try
            {
                string strexpression_id = m_request.Tables[0].Rows[0]["expression_id"].ToString();
                string strbody_id = m_request.Tables[0].Rows[0]["body_id"].ToString();
                string struser_login_name = m_request.Tables[0].Rows[0]["user_login_name"].ToString();
                string struser_name = m_request.Tables[0].Rows[0]["user_name"].ToString();
                string struser_notuse = m_request.Tables[0].Rows[0]["user_notuse"].ToString();
                string strAction = m_request.Tables[0].Rows[0]["Action"].ToString();
               
                DataSet ds = conn_Market.GetDataSet(@"SELECT [Body_ID]  FROM [MKT_User_CN_For_HZY_F22] WHERE 
                User_Login_Name=@Param0",new string[1]{struser_login_name});


                //如果是添加，先核对用户ID对不对
                if (strAction == "Add" && ds.Tables[0].Rows.Count>0)
                {
                    throw new Exception("要添加的用户登录名已经存在，请核对");
                }

                if (strAction == "Add")
                {
                    strbody_id = conn.GetDataTable("SELECT NEWID() as ID", new string[0]).Rows[0][0].ToString();

                    conn.GetDataSetBySP("SP_CreateMasterData", new string[2] { "@MDMName", "@bodyID" }, new string[2] { "User", strbody_id });

                    AddNewRow(conn, strbody_id, struser_name, struser_login_name, struser_notuse);
                }
                else
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        strbody_id = ds.Tables[0].Rows[i]["Body_ID"].ToString();
                        AddNewRow(conn, strbody_id, struser_name, struser_login_name, struser_notuse);
                    }
                }
                return true;
            }
            catch
            {
                
                throw;
            }



        }

        private void AddNewRow(Dbconn conn, string strbody_id, string struser_name, string struser_login_name, string struser_notuse)
        {
            string[] strParam = new string[5];
            strParam[0] = "@MDMName";
            strParam[1] = "@PropertyName";
            strParam[2] = "@ExpressionName";
            strParam[3] = "@BodyID";
            strParam[4] = "@Values";

            string[] strValues = new string[5];
            strValues[0] = "User";
            strValues[1] = "用户姓名";
            strValues[2] = "CN";
            strValues[3] = strbody_id;
            strValues[4] = struser_name;

            conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);
            strValues[0] = "User";
            strValues[1] = "用户所属App";
            strValues[2] = "CN";
            strValues[3] = strbody_id;
            strValues[4] = "F22";
            conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);

            strValues[0] = "User";
            strValues[1] = "登录用户名";
            strValues[2] = "CN";
            strValues[3] = strbody_id;
            strValues[4] = struser_login_name;
            conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);

            strValues[0] = "User";
            strValues[1] = "是否停用";
            strValues[2] = "CN";
            strValues[3] = strbody_id;
            strValues[4] = struser_notuse;
            conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);

            if (struser_notuse == "1")
            {
                strValues[0] = "User";
                strValues[1] = "停用日期";
                strValues[2] = "CN";
                strValues[3] = strbody_id;
                strValues[4] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);
            }
            else
            {
                strValues[0] = "User";
                strValues[1] = "停用日期";
                strValues[2] = "CN";
                strValues[3] = strbody_id;
                strValues[4] = "";
                conn.GetDataSetBySP("SP_InsertValue", strParam, strValues);
            }
        }

    }

}