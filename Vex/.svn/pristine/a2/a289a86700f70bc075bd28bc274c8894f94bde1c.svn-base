using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;


using HZY.COM.Common.DBAccess;
using System.Xml;
using System.Globalization;
using System.Net;
using System.Text;
using System.IO;
using System.Collections;
using System.Configuration;
using HZY.COM.Common.Base;

namespace HZY.COM.Common.WSRRMgr
{

    public class Common
    {

        public static string m_RouteCode = ConfigurationManager.AppSettings["WSRRRouteCode"];

        public Common()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }

        public enum CallByXmlType
        {
            Common,
            Excel,
            HZYXML 
        }


        #region LogType
        public enum LogType
        {
            CallByXML,
            Login,
            Logout,
            CheckUser_Authorization
        }
        #endregion

        #region WirteLog 当出错的时写日志
        /// <summary>
        /// 当出错的时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static void WirteLog(Exception ex, string logID)
        {
            try
            {

                string currentName = new StackTrace(true).GetFrame(0).GetMethod().Name;
                string callName = new StackTrace(true).GetFrame(1).GetMethod().Name;
                Trace.WriteLine("目前行號: " + new StackTrace(true).GetFrame(0).GetFileLineNumber().ToString());
                Trace.WriteLine("呼叫名稱: " + callName);
                Trace.WriteLine("目前方法: " + currentName);

                Dbconn conn = new Dbconn("WSRR_Log");
                DataTable dt = new DataTable();
                dt.Columns.Add("Error_Datetime");
                dt.Columns.Add("Error_Method");
                dt.Columns.Add("Error_Class");
                dt.Columns.Add("Error_Message");
                dt.Columns.Add("Error_stack");
                dt.Columns.Add("HostName");
                dt.Columns.Add("LogID");
                string strHostName = Dns.GetHostName();
                DataRow dr = dt.NewRow();
                dr["Error_Datetime"] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                dr["Error_Method"] = new StackTrace(true).GetFrame(1).GetMethod().Name;
                dr["Error_Class"] = new StackTrace(true).GetFrame(1).GetFileName();
                dr["Error_Message"] = ex.Message;
                dr["Error_stack"] = ex.ToString();
                dr["HostName"] = strHostName;
                if (logID != "")
                {
                    dr["LogID"] = logID;
                }
                dt.Rows.Add(dr);

                try
                {
                    System.Collections.ArrayList list = new System.Collections.ArrayList();

                    list.Add("[M03_GOVERN].[LWEL_LocalWSRunErrorLog]");
                    conn.TableLock(list);
                    conn.BeginTransaction();
                    conn.Insert("[M03_GOVERN].[LWEL_LocalWSRunErrorLog]", dt);

                    conn.CommitTransaction();
                }
                catch (Exception)
                {
                    conn.RollbackTransaction();
                }
            }
            catch
            {

            }
        }
        #endregion

        #region WirteLog_login 当登录时写日志
        /// <summary>
        /// 当登录时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static string WirteLog_login(string pEnv, string pLoginEnv, string pUserName, string pPassword, string pIP, string pComputerName)
        {
            string strLog_ID = "";
            try
            {

                Dbconn conn = new Dbconn("MDM_log");

                DataTable dt = new DataTable();
                dt.Columns.Add("Log_NewID");
                dt.Columns.Add("Env");
                dt.Columns.Add("LoginEnv");
                dt.Columns.Add("UserName");
                dt.Columns.Add("Password");
                dt.Columns.Add("Request_IP");
                dt.Columns.Add("Request_ComputerName");
                dt.Columns.Add("HostName");

                strLog_ID = Guid.NewGuid().ToString();
                string strHostName = Dns.GetHostName();

                dt.Rows.Add(new object[] { strLog_ID, pEnv, pLoginEnv, pUserName, pPassword, pIP, pComputerName, strHostName });

                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add("Log_Login");
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Insert("Log_Login", dt);
                conn.CommitTransaction();

            }
            catch (Exception ex)
            {
                WirteLog(ex, strLog_ID);
                return "";
            }

            return strLog_ID;
        }
        #endregion

        #region WirteLog_CheckUser_Authorization 当CheckUser_Authorization时写日志
        /// <summary>
        /// 当CheckUser_Authorization时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static string WirteLog_CheckUser_Authorization(string pSession_ID, string pMenuID, string pMenuName, string pUrl, string pIP, string pComputerName)
        {
            string strLog_ID = "";
            try
            {

                Dbconn conn = new Dbconn("MDM_log");

                DataTable dt = new DataTable();
                dt.Columns.Add("Log_NewID");
                dt.Columns.Add("Session_ID");
                dt.Columns.Add("MenuID");
                dt.Columns.Add("MenuName");
                dt.Columns.Add("Url");
                dt.Columns.Add("Request_IP");
                dt.Columns.Add("Request_ComputerName");
                dt.Columns.Add("HostName");

                strLog_ID = Guid.NewGuid().ToString();
                string strHostName = Dns.GetHostName();

                dt.Rows.Add(new object[] { strLog_ID, pSession_ID, pMenuID, pMenuName, pUrl, pIP, pComputerName, strHostName });

                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add("Log_CheckUser_Authorization");
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Insert("Log_CheckUser_Authorization", dt);
                conn.CommitTransaction();

            }
            catch (Exception ex)
            {
                WirteLog(ex, strLog_ID);
                return "";
            }
            return strLog_ID;
        }
        #endregion

        #region WirteLog_View 当View_Log时写日志
        ///// <summary>
        ///// 当WirteLog_View_时写日志
        ///// </summary>
        ///// <param name="ex"></param>
        //public static void WirteLog_View(string pMenuID, string pMenuName, string pUrl, string pEnv, string pIP, string pComputerName)
        //{
        //    try
        //    {

        //        Dbconn conn = new Dbconn("MDM_log");

        //        DataTable dt = new DataTable();
        //        dt.Columns.Add("MenuID");
        //        dt.Columns.Add("MenuName");
        //        dt.Columns.Add("Url");
        //        dt.Columns.Add("Env");
        //        dt.Columns.Add("Request_IP");
        //        dt.Columns.Add("Request_ComputerName");

        //        dt.Rows.Add(new object[] { pMenuID, pMenuName, pUrl, pEnv, pIP, pComputerName });

        //        System.Collections.ArrayList list = new System.Collections.ArrayList();
        //        list.Add("Log_View");
        //        conn.TableLock(list);
        //        conn.BeginTransaction();
        //        conn.Insert("Log_View", dt);
        //        conn.CommitTransaction();

        //    }
        //    catch (Exception ex)
        //    {
        //        WirteLog(ex);
        //    }
        //}
        #endregion

        #region WirteLog_Logout 当登出时写日志
        /// <summary>
        /// 当登出时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static string WirteLog_Logout(string pSession_ID, string pIP, string pComputerName)
        {
            string strLog_id = "";
            try
            {

                Dbconn conn = new Dbconn("MDM_log");

                DataTable dt = new DataTable();
                dt.Columns.Add("Log_NewID");
                dt.Columns.Add("SessionID");
                dt.Columns.Add("Request_IP");
                dt.Columns.Add("Request_ComputerName");
                dt.Columns.Add("HostName");

                strLog_id = Guid.NewGuid().ToString();
                string strHostName = Dns.GetHostName();

                dt.Rows.Add(new object[] { strLog_id, pSession_ID, pIP, pComputerName, strHostName });


                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add("log_Logout");
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Insert("log_Logout", dt);
                conn.CommitTransaction();

            }
            catch (Exception ex)
            {
                WirteLog(ex, "");
                return "";
            }
            return strLog_id;
        }
        #endregion

        #region WirteLog_CallBYXML 当CallByXML时写日志
        /// <summary>
        /// 当CallByXML时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static string WirteLog_CallBYXML(string strDBconn, string pInputXML, string pIP, string pComputerName)
        {
            try
            {

                Dbconn conn = new Dbconn(strDBconn);

                DataTable dt = new DataTable();
                dt.Columns.Add("Log_NewID");
                dt.Columns.Add("Log_Time");
                dt.Columns.Add("XmlInput");
                dt.Columns.Add("Request_IP");
                dt.Columns.Add("Request_ComputerName");
                dt.Columns.Add("HostName");

                string strLog_ID = System.Guid.NewGuid().ToString();
                string strHostName = Dns.GetHostName();

                dt.Rows.Add(new object[] { strLog_ID, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"), pInputXML, pIP, pComputerName, strHostName });

                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add("[M03_GOVERN].[LWRL_LocalWSRunLog]");
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Insert("[M03_GOVERN].[LWRL_LocalWSRunLog]", dt);
                conn.CommitTransaction();
                return strLog_ID;
            }
            catch (Exception ex)
            {
                WirteLog(ex, "");
                return "";
            }
        }
        #endregion

        #region UpdateLog_CallBYXML 当CallByXML时更新日志
        /// <summary>
        /// 当CallByXML时更新日志
        /// </summary>
        /// <param name="pResult"></param>
        /// <param name="pError_Message"></param>
        /// <returns></returns>
        public static string UpdateLog_CallBYXML(string pDBconn, string pLog_ID, string pResult, string pWS_ID, string pSession_ID, string pAppSN)
        {
            return UpdateLog_All(pDBconn, "[M03_GOVERN].[LWRL_LocalWSRunLog]", pLog_ID, pResult, pWS_ID, pSession_ID, pAppSN);
        }
        #endregion

        #region UpdateLog_All 更新日志的执行结果
        /// <summary>
        /// 更新日志的执行结果
        /// </summary>
        /// <param name="pResult"></param>
        /// <param name="pError_Message"></param>
        /// <returns></returns>
        private static string UpdateLog_All(string pDBconn, string pTableName, string pLog_ID, string pResult
            , string pWS_ID, string pSession_ID, string pAppSN)
        {
            try
            {

                Dbconn conn = new Dbconn(pDBconn);

                DataTable dt = new DataTable();
                dt.Columns.Add("Result");
                dt.Columns.Add("End_Time");

                if (pDBconn == "WSRR_Log")
                {
                    dt.Columns.Add("WS_ID");
                    dt.Columns.Add("Session_ID");
                    dt.Columns.Add("AppSN");
                }

                string strWHERE = " Log_NewID='" + pLog_ID + "'";

                if (pDBconn == "WSRR_Log")
                {
                    dt.Rows.Add(new object[] { pResult, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"), pWS_ID, pSession_ID, pAppSN });
                }
                else
                {
                    dt.Rows.Add(new object[] { pResult, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") });
                }

                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add(pTableName);
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Update(pTableName, dt, strWHERE);
                conn.CommitTransaction();
                return pLog_ID;
            }
            catch (Exception ex)
            {
                WirteLog(ex, "");
                return "";
            }
        }
        #endregion

        #region UpdateLog_All_WS 更新WS日志的执行结果
        /// <summary>
        /// 更新WS日志的执行结果
        /// </summary>
        /// <param name="pResult"></param>
        /// <param name="pError_Message"></param>
        /// <returns></returns>
        public static string UpdateLog_All_WS(LogType pLogType, string pLog_ID, string pResult, string pWS_ID, string pSession_ID, string pAppSN)
        {
            string strTableName = "";
            switch (pLogType)
            {
                case LogType.CallByXML:
                    strTableName = "[M03_GOVERN].[LWRL_LocalWSRunLog]";
                    break;
                case LogType.Login:
                    strTableName = "log_Login";
                    break;

                case LogType.Logout:
                    strTableName = "log_Logout";
                    break;

                case LogType.CheckUser_Authorization:
                    strTableName = "Log_CheckUser_Authorization";
                    break;
            }
            return UpdateLog_All("MDM_Log", strTableName, pLog_ID, pResult, pWS_ID, pSession_ID, pAppSN);
        }
        #endregion

        #region WirteLog_Menu_Click 当菜单被点击时写日志
        /// <summary>
        /// 当菜单被点击时写日志
        /// </summary>
        /// <param name="ex"></param>
        public static void WirteLog_Menu_Click(string pAbsolutePath, string pAbsoluteUri, string pUri, string pRequestIP, string pRequestComputerName, string pBrownserMajorVersion, string pBrownserVersion, string pBrowserPlatform, string pBrowser_Type, string pBrowser_Name)
        {
            try
            {

                Dbconn conn = new Dbconn("MDM_log");

                DataTable dt = new DataTable();
                dt.Columns.Add("Absolute_Path");
                dt.Columns.Add("Absolute_Uri");
                dt.Columns.Add("Uri");
                dt.Columns.Add("Request_IP");
                dt.Columns.Add("Request_ComputerName");
                dt.Columns.Add("Brownser_MajorVersion");
                dt.Columns.Add("Brownser_Version");
                dt.Columns.Add("Browser_Platform");
                dt.Columns.Add("Browser_Type");
                dt.Columns.Add("Browser_Name");
                dt.Columns.Add("HostName");

                string strHostName = Dns.GetHostName();
                dt.Rows.Add(new object[] { pAbsolutePath, pAbsoluteUri, pUri, pRequestIP, pRequestComputerName, pBrownserMajorVersion, pBrownserVersion, pBrowserPlatform, pBrowser_Type, pBrowser_Name, strHostName });

                System.Collections.ArrayList list = new System.Collections.ArrayList();
                list.Add("Log_Menu_Click");
                conn.TableLock(list);
                conn.BeginTransaction();
                conn.Insert("Log_Menu_Click", dt);
                conn.CommitTransaction();

            }
            catch (Exception ex)
            {
                WirteLog(ex, "");
            }
        }
        #endregion

        #region GetMD5  MD5加密字符串
        /// <summary>
        /// MD5加密字符串
        /// </summary>
        /// <param name="myString">待加密字符串</param>
        /// <returns>一次加密后的结果</returns>
        public static string GetMD5(string myString)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = System.Text.Encoding.Default.GetBytes(myString);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;
            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x").PadLeft(2, '0'); ;
            }
            return byte2String;
        }
        #endregion

        #region GetRequestDataSet 建立一行数据的一个数据集
        /// <summary>
        /// 建立一行数据的一个数据集
        /// </summary>
        /// <param name="pStrColumn"></param>
        /// <param name="pValue"></param>
        /// <returns></returns>
        public static DataSet GetRequestDataSet(string[] pStrColumn, string[] pValue)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            for (int i = 0; i < pStrColumn.Length; i++)
            {
                dt.Columns.Add(pStrColumn[i]);
            }

            DataRow dr = dt.NewRow();
            for (int i = 0; i < pValue.Length; i++)
            {
                dr[i] = pValue[i];
            }

            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }
        #endregion

        #region GetDSByExcelXML 根据EXCEL提交的XML，生成一个数据集
        public static DataSet GetDSByExcelXML(string strXML)
        {
            return GetDSByExcelXML(strXML, true);
        }

        public static DataSet GetDSByExcelXML(string strXML, bool pbContainOptypeTable)
        {
            return GetDSByExcelXML(strXML, pbContainOptypeTable, false);
        }

        public static DataSet GetDSByExcelXML(string strXML, bool pbContainOptypeTable, bool bpUnescape)
        {
            DataSet ds = new DataSet();
            //strXML = @"<ROOT><OPTYPE>DELETE</OPTYPE><LIST><ROW><Request_Code>SR20130609001</Request_Code><Requst_UserName>马卫清</Requst_UserName><Request_Type>Windows</Request_Type><Prod>正式</Prod></ROW><ROW><Request_Code>SR20130609002</Request_Code><Requst_UserName>王秀宝</Requst_UserName><Request_Type>DB</Request_Type><Prod>正式</Prod></ROW></LIST></ROOT>";

            DataTable dt_OPTYPE = new DataTable("OPTYPE");
            dt_OPTYPE.Columns.Add("OPTYPE");
            if (pbContainOptypeTable)
            {
                ds.Tables.Add(dt_OPTYPE);
            }
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(EscapeXML(strXML));

            XmlNode xml = xmlDoc.DocumentElement;

            int nListIndex = 0;

            foreach (XmlNode xmlRoot in xml.ChildNodes)
            {
                if (xmlRoot.Name.ToUpper() == "OPTYPE")
                {
                    dt_OPTYPE.Rows.Add(new object[] { UescapeXML(xmlRoot.InnerText) });
                    //nListIndex++;
                }
                else if (xmlRoot.Name.ToUpper() == "LIST")
                {
                    bool bCreateTable = true;
                    DataTable dt_List = new DataTable();



                    if (xmlRoot.Attributes["TBName"] != null
                        && xmlRoot.Attributes["TBName"].Value != "")
                    {
                        dt_List.TableName = xmlRoot.Attributes["TBName"].Value;
                    }
                    else
                    {
                        if (nListIndex == 0)
                        {
                            dt_List.TableName = "LIST";
                        }
                        else
                        {
                            dt_List.TableName = "LIST" + (nListIndex).ToString(); ;
                        }
                        nListIndex++;
                    }

                    foreach (XmlNode xmlRow in xmlRoot.ChildNodes)
                    {
                        DataRow dr = dt_List.NewRow();
                        foreach (XmlNode xmlColumn in xmlRow.ChildNodes)
                        {
                            string strColumnName = UescapeXML(xmlColumn.Name);

                            if (bCreateTable)
                            {
                                dt_List.Columns.Add(strColumnName);
                            }

                            if (bpUnescape)
                            {
                                dr[strColumnName] = Microsoft.JScript.GlobalObject.unescape(UescapeXML(xmlColumn.InnerXml));
                            }
                            else
                            {
                                dr[strColumnName] = UescapeXML(xmlColumn.InnerXml);
                            }
                        }
                        dt_List.Rows.Add(dr);
                        bCreateTable = false;
                    }
                    ds.Tables.Add(dt_List);
                }
            }

            return ds;
        }
        #endregion

        #region GetResponseStringByDs 返回XML格式的字符串
        /// <summary>
        /// 返回XML格式的字符串
        /// </summary>
        /// <param name="pResponseDs"></param>
        /// <returns></returns>
        public static string GetResponseStringByDs(DataSet pResponseDs, string pClassName, string pAppName, string pEnvo, string pCompany, string pExetype)
        {
            string strXML = "<Interface ClassName=\"" + pClassName + "\" AppName=\"" + pAppName + "\" Evno=\"" + pEnvo + "\" Company=\"" + pCompany + "\" ExeType=\"" + pExetype + "\" Result=\"True\">";


            if (pResponseDs != null)
            {
                for (int i = 0; i < pResponseDs.Tables.Count; i++)
                {
                    DataTable dt = pResponseDs.Tables[i];
                    strXML += "<Table TableName=\"" + dt.TableName + "\" RowCount=\"" + dt.Rows.Count.ToString() + "\">";
                    if (dt.Rows.Count == 0)
                    {
                        strXML += "<Rows>";
                        for (int j = 0; j < dt.Columns.Count; j++)
                        {
                            strXML += "<" + dt.Columns[j].ColumnName + ">";
                            strXML += "</" + dt.Columns[j].ColumnName + ">";

                        }
                        strXML += "</Rows>";
                    }
                    else
                    {
                        for (int j = 0; j < dt.Rows.Count; j++)
                        {
                            strXML += "<Rows>";
                            for (int k = 0; k < dt.Columns.Count; k++)
                            {
                                strXML += "<" + dt.Columns[k].ColumnName + ">";
                                strXML += dt.Rows[j][dt.Columns[k].ColumnName].ToString();
                                strXML += "</" + dt.Columns[k].ColumnName + ">";

                            }
                            strXML += "</Rows>";

                        }
                    }
                    strXML += "</Table>";
                }
            }
            strXML += "</Interface>";
            return strXML;
        }
        #endregion

        #region GetExcelResponseStringByDs 返回EXCEL XML格式的字符串
        /// <summary>
        /// 回EXCEL XML格式的字符串
        /// </summary>
        /// <param name="pResponseDs"></param>
        /// <param name="pContnceTableName">false:专门为EXCEL提供，原则上只支持单表<</param>
        /// <param name="pAutoFileColumn">自动填充列，当没有数据的时候，也会返回列信息</param> 
        /// <returns></returns>
        public static string GetExcelResponseStringByDs(DataSet pResponseDs, bool pContnceTableName, bool pAutoFileColumn)
        {
            string strXML = "<ROOT>";

            if (pResponseDs != null)
            {
                for (int i = 0; i < pResponseDs.Tables.Count; i++)
                {
                    DataTable dt = pResponseDs.Tables[i];

                    if (pContnceTableName == false)
                    {
                        if (dt.TableName == "PageRowCount")
                        {
                            continue;
                        }
                    }

                    if (dt.Columns.Count == 1 && dt.Columns[0].ColumnName.StartsWith("XML"))
                    {
                        strXML += "<LIST";

                        if (pContnceTableName == true)
                        {
                            strXML += " TBName=\"" + dt.TableName + "\"";
                        }
                        strXML += ">";

                        for (int j = 0; j < dt.Rows.Count; j++)
                        {
                            strXML += dt.Rows[j][0].ToString();

                        }
                        strXML += "</LIST>";
                        continue;
                    }

                    strXML += "<LIST";

                    if (pContnceTableName == true)
                    {
                        strXML += " TBName=\"" + dt.TableName + "\"";
                    }
                    strXML += ">";

                    if (dt.Rows.Count == 0 && pAutoFileColumn)
                    {
                        strXML += "<Rows>";
                        for (int j = 0; j < dt.Columns.Count; j++)
                        {
                            strXML += "<" + dt.Columns[j].ColumnName + ">";
                            strXML += "</" + dt.Columns[j].ColumnName + ">";

                        }
                        strXML += "</Rows>";
                    }
                    else
                    {

                        ////需要对数据进行unescape,效率比较低
                        //if (pbEscape)
                        //{
                        //    for (int j = 0; j < dt.Rows.Count; j++)
                        //    {
                        //        string strXML_Row = "";
                        //        strXML_Row += "<Rows>";
                        //        for (int k = 0; k < dt.Columns.Count; k++)
                        //        {
                        //            strXML_Row += "<" + dt.Columns[k].ColumnName + ">";
                        //            strXML_Row += Microsoft.JScript.GlobalObject.escape(dt.Rows[j][dt.Columns[k].ColumnName].ToString());
                        //            strXML_Row += "</" + dt.Columns[k].ColumnName + ">";

                        //        }
                        //        strXML_Row += "</Rows>";

                        //        strXML += strXML_Row;
                        //    }
                        //}
                        //else
                        //{

                            //对datatable转XML进行优化，性能提高10倍以上
                            string[] ary = new string[0];

                            string strExpression = "''";

                            string strNewColumnName = "Meq" + Guid.NewGuid().ToString();

                            int nColumnCount = dt.Columns.Count;

                            ArrayList strNewColumnList = new ArrayList();

                            for (int j1 = 0; j1 < nColumnCount; j1++)
                            {
                                string strColumnName = dt.Columns[j1].ColumnName;
                                strExpression += String.Format("+'<{0}>'+isnull(Convert({0},'System.String'),'')+'</{0}>'", strColumnName);

                                if ((j1 + 1) % 10 == 0)
                                {
                                    strNewColumnList.Add(strExpression);
                                    strExpression = "''";
                                }
                            }

                            if (strExpression != "")
                            {
                                strNewColumnList.Add(strExpression);
                            }

                            strExpression = "";
                            for (int i1 = 0; i1 < strNewColumnList.Count; i1++)
                            {
                                string strExpressionTemp = strNewColumnList[i1].ToString();
                                dt.Columns.Add(strNewColumnName + i1.ToString(), typeof(string), strExpressionTemp);

                                if (strExpression != "")
                                {
                                    strExpression += "+";
                                }
                                strExpression += "[" + strNewColumnName + i1.ToString() + "]";
                            }
                            dt.Columns.Add(strNewColumnName, typeof(string), strExpression);

                            ary = Array.ConvertAll<DataRow, string>(dt.Select("1=1"), r => r[strNewColumnName].ToString());

                            string str = string.Join("</Rows><Rows>", ary);

                            strXML += "<Rows>" + str + "</Rows>";
                        }
                    //}
                    strXML += "</LIST>";
                }
            }
            strXML += "</ROOT>";
            return strXML;
        }

        #endregion

        #region GetResponseStringByBool 返回XML格式的字符串
        /// <summary>
        /// 返回XML格式的字符串
        /// </summary>
        /// <param name="pResponseDs"></param>
        /// <returns></returns>
        public static string GetResponseStringByBool(bool pValues, string pErrorMessage, CallByXmlType pType, string pClassName, string pAppName, string pEnvo, string pCompany, string pExetype)
        {
            string strXML = "";
            if (pType == CallByXmlType.Common)
            {
                strXML = "<Interface ClassName=\"" + pClassName + "\" AppName=\"" + pAppName + "\" Evno=\"" + pEnvo + "\" Company=\"" + pCompany + "\" ExeType=\"" + pExetype + "\"";
                strXML += " Result=\"" + pValues.ToString() + "\">";

                strXML += "<Message>" + pErrorMessage + "</Message>";

                strXML += "</Interface>";
            }
            else if (pType == CallByXmlType.Excel || pType == CallByXmlType.HZYXML)
            {
                strXML = "<ROOT><LIST><Rows><Result>" + pValues + "</Result><Message>" + pErrorMessage + "</Message></Rows></LIST></ROOT>";
            }
            //else if (pType == CallByXmlType.HZYXML)
            //{
            //    strXML = "[{\"Result\":\"" + pValues + "\",\"Message\":\"" + pErrorMessage + "\"}]";
            //}
            return strXML;
        }
        #endregion

        #region TimeStamps与字符的转换
        public static string TimeStampsTOString(object value)
        {
            return "0x" + BitConverter.ToString((byte[])value);
        }

        public static byte[] StringTOTimeStamps(string value)
        {
            byte[] buffer2 = null;
            try
            {
                byte[] buffer = null;
                string hexString = value.Replace("0x", "");
                int num = 0;
                int num2 = hexString.Length / 2;
                buffer = new byte[num2];
                for (int i = 0; i < buffer.Length; i++)
                {
                    string s = new string(new char[] { hexString[num], hexString[num + 1] });
                    buffer[i] = byte.Parse(s, NumberStyles.HexNumber);
                    num += 2;
                }
                buffer2 = buffer;
            }
            catch
            {

            }
            return buffer2;

        }
        #endregion

        #region GetDataTableByAML
        /// <summary>
        /// 将AML字符转化为DataTable
        /// </summary>
        /// <param name="pStrAML">输入ＡＭＬ字符</param>
        /// <returns></returns>
        public static DataTable GetDataTableByAML(string pStrAML)
        {
            char strSplitString = ',';
            string strAMLTemp = pStrAML;
            bool bCreateTable = true;

            DataTable dt = new DataTable();

            while (strAMLTemp.Length > 0)
            {
                //找到第一个的"【"
                int nStart = strAMLTemp.IndexOf("【");
                int nEnd = strAMLTemp.IndexOf("】", nStart);
                if (nStart > -1 && nEnd > -1) //找到
                {
                    string strSubAML = strAMLTemp.Substring(nStart + 1, nEnd - nStart - 1);

                    if (strSubAML != "")
                    {
                        string[] strList = strSubAML.Split(strSplitString);

                        DataRow dr = dt.NewRow();
                        for (int i = 0; i < strList.Length; i++)
                        {
                            if (bCreateTable)
                            {
                                dt.Columns.Add("Data" + i.ToString());
                            }

                            if (i > dt.Columns.Count)
                            {
                                break;
                            }

                            dr["Data" + i.ToString()] = strList[i];
                        }
                        dt.Rows.Add(dr);
                        bCreateTable = false;

                    }
                    strAMLTemp = strAMLTemp.Substring(nEnd + 1);
                }
                else
                {
                    strAMLTemp = "";
                }
            }
            return dt;
        }
        #endregion

        #region GetDsByAML
        /// <summary>
        /// 将AML字符转化为DataSet
        /// </summary>
        /// <param name="pStrAML">输入ＡＭＬ字符</param>
        /// <returns></returns>
        public static DataSet GetDsByAML(string pStrAML)
        {
            char strSplitString = ',';
            string strAMLTemp = pStrAML;

            DataTable dt = new DataTable();
            DataRow dr = dt.NewRow();
            while (strAMLTemp.Length > 0)
            {
                //找到第一个的"【"
                int nStart = strAMLTemp.IndexOf("【");
                int nEnd = strAMLTemp.IndexOf("】", nStart);
                if (nStart > -1 && nEnd > -1) //找到
                {
                    string strSubAML = strAMLTemp.Substring(nStart + 1, nEnd - nStart - 1);

                    if (strSubAML != "")
                    {

                        int nStartSub = strSubAML.IndexOf(strSplitString);

                        dt.Columns.Add(strSubAML.Substring(0, nStartSub));
                        if (nStartSub > -1) //存在值
                        {

                            dr[strSubAML.Substring(0, nStartSub)] = strSubAML.Substring(nStartSub + 1);

                        }
                        else
                        {
                            dr[strSubAML.Substring(0, nStartSub)] = "";
                        }

                    }
                    strAMLTemp = strAMLTemp.Substring(nEnd + 1);
                }
                else
                {
                    strAMLTemp = "";
                }
            }
            dt.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            return ds;
        }
        #endregion

        #region GetAMLByDs
        /// <summary>
        /// 将DataSet的第一张表转为AML
        /// </summary>
        /// <param name="ds"></param>
        /// <returns></returns>
        public static string GetAMLByDs(DataSet ds)
        {
            char strSplitString = ',';

            string strReturnAML = "";

            DataTable dt = ds.Tables[0];

            for (int i = 0; i < dt.Columns.Count; i++)
            {
                strReturnAML += "【" + dt.Columns[i].ColumnName.ToString() + strSplitString + dt.Rows[0][i].ToString() + "】";
            }
            return strReturnAML;
        }
        #endregion

        #region GetXMLStringByDs 返回XML格式的字符串
        /// <summary>
        /// 返回XML格式的字符串
        /// </summary>
        /// <param name="pResponseDs"></param>
        /// <returns></returns>
        public static string GetXMLStringByDs(DataSet pResponseDs, string pClassName, string pAppName, string pEnvo, string pCompany, string pExeType)
        {
            string strXML = "<Interface ClassName=\"" + pClassName + "\" AppName=\"" + pAppName + "\" Evno=\"" + pEnvo + "\" Company=\"" + pCompany + "\" ExeType=\"" + pExeType + "\" Result=\"True\">";


            if (pResponseDs != null)
            {
                for (int i = 0; i < pResponseDs.Tables.Count; i++)
                {
                    DataTable dt = pResponseDs.Tables[i];
                    strXML += "<Table TableName=\"" + dt.TableName + "\" RowCount=\"" + dt.Rows.Count.ToString() + "\">";
                    if (dt.Rows.Count == 0)
                    {
                        strXML += "<Rows>";
                        for (int j = 0; j < dt.Columns.Count; j++)
                        {
                            strXML += "<" + dt.Columns[j].ColumnName + ">";
                            strXML += "</" + dt.Columns[j].ColumnName + ">";

                        }
                        strXML += "</Rows>";
                    }
                    else
                    {
                        for (int j = 0; j < dt.Rows.Count; j++)
                        {
                            strXML += "<Rows>";
                            for (int k = 0; k < dt.Columns.Count; k++)
                            {
                                strXML += "<" + dt.Columns[k].ColumnName + ">";
                                strXML += dt.Rows[j][dt.Columns[k].ColumnName].ToString();
                                strXML += "</" + dt.Columns[k].ColumnName + ">";

                            }
                            strXML += "</Rows>";

                        }
                    }
                    strXML += "</Table>";
                }
            }
            strXML += "</Interface>";
            return strXML;
        }
        #endregion

        #region GetExcelXMLStringByDs 返回EXCEL XML格式的字符串
        /// <summary>
        /// 返回EXCEL XML格式的字符串
        /// </summary>
        /// <param name="pResponseDs"></param>
        /// <returns></returns>
        public static string GetExcelXMLStringByDs(DataSet pResponseDs)
        {
            string strXML = "<ROOT>";


            if (pResponseDs != null)
            {
                for (int i = 0; i < pResponseDs.Tables.Count; i++)
                {
                    DataTable dt = pResponseDs.Tables[i];
                    strXML += "<LIST TBName=\"" + dt.TableName + "\">";
                    if (dt.Rows.Count == 0)
                    {
                        strXML += "<Rows>";
                        for (int j = 0; j < dt.Columns.Count; j++)
                        {
                            strXML += "<" + dt.Columns[j].ColumnName + ">";
                            strXML += "</" + dt.Columns[j].ColumnName + ">";

                        }
                        strXML += "</Rows>";
                    }
                    else
                    {

                        for (int j = 0; j < dt.Rows.Count; j++)
                        {
                            string strXML_Row = "";
                            strXML_Row += "<Rows>";
                            for (int k = 0; k < dt.Columns.Count; k++)
                            {
                                strXML_Row += "<" + dt.Columns[k].ColumnName + ">";
                                strXML_Row += dt.Rows[j][dt.Columns[k].ColumnName].ToString();
                                strXML_Row += "</" + dt.Columns[k].ColumnName + ">";

                            }
                            strXML_Row += "</Rows>";

                            strXML += strXML_Row;
                        }
                    }
                    strXML += "</LIST>";
                }
            }
            strXML += "</ROOT>";
            return strXML;
        }
        #endregion

        #region EscapeXML 对XML语句进行转义
        /// <summary>
        /// 对XML语句进行转义
        /// </summary>
        /// <param name="strXML">待反转义的XML</param>
        /// <returns></returns>
        public static string EscapeXML(string strXML)
        {
            strXML = strXML.Replace("《", "_x300A_");
            strXML = strXML.Replace("》", "_x300B_");
            return strXML;
        }
        #endregion

        #region UescapeXML 对XML语句进行反转义
        /// <summary>
        /// 对XML语句进行反转义
        /// </summary>
        /// <param name="strXML">待反转义的XML</param>
        /// <returns></returns>
        public static string UescapeXML(string strXML)
        {
            strXML = strXML.Replace("_x300A_", "《");
            strXML = strXML.Replace("_x300B_", "》");
            return strXML;
        }
        #endregion

        #region CheckUser
        public static HZYmessage CheckUser(string SessionID)
        {
            HZYmessage message = new HZYmessage();
            if (SessionID == null || SessionID == "")
            {
                throw new Exception("身份验证错误");
            }
            Dbconn conn = new Dbconn("MDM");
            string strSQL = @"
              SELECT 
                    [SSO_Guid]
                  ,[Company_sn]
                  ,[Company_ID]
                  ,[Env_sn]
                  ,[Env_ID]
                  ,[Request_IP]
                  ,[Request_ComputerName]
                  ,[Login_Env_sn]
                  ,[Login_Env_ID]
                  ,[Employee_ID]
                  ,[User_ID]
                  ,[User_Name]
                  ,[User_Name_CN]
              FROM [MDM].[dbo].[SSO_Login] with(nolock)
              where [SSO_Guid]=@param0
              and Logout_Time is null
        ";

            DataTable dt = conn.GetDataTable(strSQL, new string[] { SessionID });
            if (dt.Rows.Count == 1)
            {
                message.Session_ID = dt.Rows[0]["SSO_Guid"].ToString();
                message.Company_SN = dt.Rows[0]["Company_sn"].ToString();
                message.Company_ID = dt.Rows[0]["Company_ID"].ToString();
                message.Env_SN = dt.Rows[0]["Env_sn"].ToString();
                message.Env_ID = dt.Rows[0]["Env_ID"].ToString();
                message.LoginEnv_SN = dt.Rows[0]["Login_Env_sn"].ToString();
                message.LoginEnv_ID = dt.Rows[0]["Login_Env_ID"].ToString();
                //message.Employee_ID = dt.Rows[0]["Employee_ID"].ToString();
                message.User_ID = dt.Rows[0]["User_ID"].ToString();
                message.User_Name = dt.Rows[0]["User_Name"].ToString();
                message.User_Name_CN = dt.Rows[0]["User_Name_CN"].ToString();


                //需要更新用户的最后访问日期
                return message;
            }
            else
            {
                throw new Exception("身份验证错误");
            }
        }
        #endregion

        #region FormatXml
        public static string FormatXml(string sUnformattedXml)
        {
            try
            {
                XmlDocument xd = new XmlDocument();
                xd.LoadXml(sUnformattedXml);
                StringBuilder sb = new StringBuilder();
                StringWriter sw = new StringWriter(sb);
                XmlTextWriter xtw = null;
                try
                {
                    xtw = new XmlTextWriter(sw);
                    xtw.Formatting = Formatting.Indented;
                    xtw.Indentation = 1;
                    xtw.IndentChar = '\t';
                    xd.WriteTo(xtw);
                }
                finally
                {
                    if (xtw != null)
                        xtw.Close();
                }
                return sb.ToString().Replace("\t", "    ");
            }
            catch (Exception ex)
            {

                return sUnformattedXml;
            }

        }

        #endregion

        #region GetListTableName
        public static string GetListTableName(int index)
        {

            if (index == 0)
            {
                return "LIST";
            }
            else
            {
                return "LIST" + index.ToString(); ;
            }
        }
        #endregion

        #region GetRequestSaleString
        public static string GetRequestSaleString(string pRequestStr)
        {
            if (pRequestStr == null)
            {
                return "";
            }
            else
            {
                return pRequestStr.Replace("'", "''");
            }

        }
        #endregion
    }

}