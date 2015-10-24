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
    ///ServerMDM_AccountQuery_GetByValues 获取数据库服务器的账户与密码
    /// </summary>
    public class ServerMDM_AccountQuery_GetByValues : LogicBase, ILogicGetData
    {
        
        public ServerMDM_AccountQuery_GetByValues()
        {
            m_SessionCheck = false;
        }
       

        /// <summary>
        /// 获取数据库服务器的账户与密码
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                Dbconn conn = new Dbconn("ServerMDM");
                string[] strPram = new string[4];
                strPram[0] = m_request.Tables[0].Rows[0]["SystemName"].ToString();
                strPram[1] = m_request.Tables[0].Rows[0]["Envo"].ToString();
                strPram[2] = m_request.Tables[0].Rows[0]["USERNAME"].ToString();
                if (m_request.Tables[0].Columns.Contains("DBPASSWORD"))
                {
                    strPram[3] = m_request.Tables[0].Rows[0]["DBPASSWORD"].ToString();
                }

                if (m_request.Tables[0].Columns.Contains("PASSWORD"))
                {
                    strPram[3] = m_request.Tables[0].Rows[0]["PASSWORD"].ToString();
                }
                

                DataSet ds = conn.GetDataSet(@"
                    SELECT  IPAddress IP ,
                            AccessDatabaseList DBNAME ,
                            USERNAME DB_USERID ,
                            DBO.F_decrypt(EncrPassword, @param3) DB_PASSWORD,
                            PORT,
                            CONO,DBDriver
                    FROM    AccountQuery WITH(NOLOCK)
                    WHERE   SystemName = @param0
                            AND Envo = @param1
                            AND USERNAME = @param2

        ", strPram);               
                return ds;
            }
            catch  
            {
                throw;

            }



        }


        public String GetConnectionStr(string strSystemName, string strEnvo, string strUSERNAME,string strPassword)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("SystemName");
            dt.Columns.Add("Envo");
            dt.Columns.Add("USERNAME");
            dt.Columns.Add("DBPASSWORD");

            dt.Rows.Add(new object[] { strSystemName ,strEnvo,strUSERNAME,strPassword});
            ds.Tables.Add(dt);

            this.m_request = ds;


            DataSet dsReturn =  GetData();
            if (dsReturn.Tables[0].Rows.Count == 0)
            {
                return "";
            }

            string strConn = "";
            string strDBDriver = dsReturn.Tables[0].Rows[0]["DBDriver"].ToString();
            
            //SQL
            if (strDBDriver.Substring(0, 3).ToUpper() == "SQL" || strDBDriver.Substring(0, 5).ToUpper() == "MSSQL")
            {
                string strDBServer = dsReturn.Tables[0].Rows[0]["IP"].ToString();
                string strDBName = dsReturn.Tables[0].Rows[0]["DBNAME"].ToString();
                string strDBUser = dsReturn.Tables[0].Rows[0]["DB_USERID"].ToString();
                string strDBPass = dsReturn.Tables[0].Rows[0]["DB_PASSWORD"].ToString();
                strConn = "Data Source=" + strDBServer + ";User ID=" + strDBUser + ";Password=" + strDBPass + ";DataBase=" + strDBName + ";";
                 
            }

            return strConn;
        }

    }

}