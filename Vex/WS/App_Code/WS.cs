using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;
using System.Collections;
using System.ComponentModel;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;
using HZY.COM.WS.SSO;

/// <summary>
///Web Service 外部主入口 
/// </summary>
public class WS : System.Web.Services.WebService
{
    public WS()
    {

    }


    #region 变量定义
    string m_AppName = "";//应用名称
    string m_Envo = "";//环境
    string m_Company = "";//公司名称
    string m_ClassName = "";//类名
    string m_ExeType = "";//执行类型

    public HZYmessage hzyMessage = new HZYmessage();

    #endregion

    #region Login
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_登录")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string Login(string pEnv, string pLoginEnv, string pUserName, string pPassword)
    {
        return Login(pEnv, pLoginEnv, pUserName, pPassword, false);

    }
    #endregion

    #region Login
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_登录")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string LoginByMD5(string pEnv, string pLoginEnv, string pUserName, string pPassword)
    {
        return Login(pEnv, pLoginEnv, pUserName, pPassword, true);

    }
    #endregion

    #region CheckUser_Authorization
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_菜单权限检查")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string CheckUser_Authorization(string pSession_ID, string pMenuID, string pMenuName, string pUrl)
    {
        string strLog_ID = "";
        string strError = "";
        try
        {

            string strIP = "";
            string strComputerName = "";

            try
            {
                strIP = this.Context.Request.UserHostAddress;
                //strComputerName = Dns.GetHostByAddress(strIP).HostName;
            }
            catch (Exception ex)
            {

            }

            strLog_ID = Log.WirteLog_CheckUser_Authorization(pSession_ID, pMenuID, pMenuName, pUrl, strIP, pMenuName);

//            Dbconn conn = new Dbconn("VexSSO");

//            try
//            {
//                conn.GetDataSet(" SELECT CONVERT(UNIQUEIDENTIFIER,'" + pSession_ID + "') as A");
//            }
//            catch (System.Exception ex)
//            {
//                throw new Exception("SessionID格式有误");

//            }

//            int nTemp = 0;
//            if (int.TryParse(pMenuID, out nTemp) == false)
//            {
//                throw new Exception("MenuID有误");
//            }

//            string strSQL = @"
//              SELECT t1.[SSO_Guid]
//                  ,t2.[Env_ID]
//              FROM [dbo].[SSO_Login] t1
//              LEFT JOIN dbo.MDM_System_env t2 ON t1.Env_sn=t2.Env_SN
//              WHERE [Logout_Time] IS NULL 
//              AND SSO_Guid=@Param0
//            ";

//            DataTable dt = conn.GetDataTable(strSQL, new string[] { pSession_ID });
//            if (dt == null || dt.Rows.Count == 0)
//            {
//                throw new Exception("登录超时，请重新登录");
//            }

//            string strEnv_ID = dt.Rows[0]["Env_ID"].ToString();
//            if (strEnv_ID == "")
//            {
//                throw new Exception("登录超时，请重新登录！");
//            }

//            strSQL = @"
//                SELECT  t1.Name ,
//                        t4.Menu_Name ,
//                        t4.Menu_Id
//                FROM    dbo.MDM_Employees t1 WITH ( NOLOCK )
//                        JOIN dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK ) ON t1.Employee_ID = t2.Employee_ID
//                                                                              AND t2.havaFlag = 1
//                        JOIN dbo.MDM_System_Menu_AUZ t3 WITH ( NOLOCK ) ON t2.Authorization_ID = t3.Authorization_ID
//                                                                           AND t3.havaFlag = 1
//                        JOIN dbo.MDM_System_Menu t4 WITH ( NOLOCK ) ON t3.Menu_ID = t4.Menu_Id
//                                                                AND t4.Env_ID = @Param0
//                                                                AND t4.Menu_Id = @Param1
//"
//                ;

//            dt = conn.GetDataTable(strSQL, new string[] { strEnv_ID, pMenuID });
//            if (dt == null || dt.Rows.Count == 0)
//            {
//                throw new Exception("您没有权限操作！");
//            }


            return "OK";
        }
        catch (Exception ex)
        {
            hzyMessage.ErrorMessage = ex.ToString();
            hzyMessage.Message = ex.ToString();
            HZY.COM.Common.Log.WirteLogWS(ex, strLog_ID);
            strError = ex.ToString();
            return "Error:" + ex.Message;
        }
        finally
        {
            if (strLog_ID != "")
            {
                if (strError != "")
                {
                    Log.UpdateLog_All_WS(Log.LogType.CheckUser_Authorization, strLog_ID, strError, "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Log.UpdateLog_All_WS(Log.LogType.CheckUser_Authorization, strLog_ID, "OK", "", hzyMessage.Session_ID, hzyMessage.Env_SN);

                }
            }
        }

    }
    #endregion

    #region View
    //[WebMethod(
    //     CacheDuration = 0,
    //     BufferResponse = false,
    //     Description = "浙江华之毅投资有限公司_访问日志")]
    //[SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    //public string View(string pMenuID, string pMenuName, string pUrl,string pEnv)
    //{

    //    try
    //    {
    //        string strIP = "";
    //        string strComputerName = "";

    //        try
    //        {
    //            strIP = this.Context.Request.UserHostAddress;
    //            //strComputerName = Dns.GetHostByAddress(strIP).HostName;
    //        }
    //        catch (Exception ex)
    //        {

    //        }

    //Common.WirteLog_View( pMenuID, pMenuName, pUrl,pEnv, strIP, pMenuName);

    //        return "OK";
    //    }
    //    catch (Exception ex)
    //    {
    //        hzyMessage.ErrorMessage = ex.ToString();
    //        hzyMessage.Message = ex.ToString();
    //        HZY.COM.Common.Common.WirteLog(ex);
    //        return "ERROR:" + ex.Message;
    //    }

    //}
    #endregion

    #region Logout
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_登出")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public bool Logout(string pSessionID)
    {
        string strLog_ID = "";
        string strError = "";
        try
        {
            string strIP = "";
            string strComputerName = "";

            try
            {
                strIP = this.Context.Request.UserHostAddress;
                //strComputerName = Dns.GetHostByAddress(strIP).HostName;
            }
            catch (Exception ex)
            {

            }

            strLog_ID = Log.WirteLog_Logout(pSessionID, strIP, strComputerName);

            return DoLogout(pSessionID);
        }
        catch (Exception ex)
        {
            HZY.COM.Common.Log.WirteLogWS(ex, strLog_ID);
            hzyMessage.ErrorMessage = ex.ToString();
            hzyMessage.Message = ex.Message;
            strError = ex.ToString();
            return false;
        }
        finally
        {
            if (strLog_ID != "")
            {
                if (strError != "")
                {
                    Log.UpdateLog_All_WS(Log.LogType.Logout, strLog_ID, strError, "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Log.UpdateLog_All_WS(Log.LogType.Logout, strLog_ID, "OK", "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
            }
        }

    }
    #endregion

    #region LogoutByWSRR
    //[WebMethod(
    //     CacheDuration = 0,
    //     BufferResponse = false,
    //     Description = "浙江华之毅投资有限公司_登出")]
    //[SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    //public bool LogoutByWSRR(string pSessionID)
    //{

    //    try
    //    {
    //        string strIP = "";
    //        string strComputerName = "";

    //        try
    //        {
    //            strIP = this.Context.Request.UserHostAddress;
    //            //strComputerName = Dns.GetHostByAddress(strIP).HostName;
    //        }
    //        catch (Exception ex)
    //        {

    //        }

    //        Common.WirteLog_Logout(pSessionID, strIP, strComputerName);

    //        return DoLogout(pSessionID);
    //    }
    //    catch (Exception ex)
    //    {
    //        HZY.COM.Common.Common.WirteLog(ex);
    //        hzyMessage.ErrorMessage = ex.ToString();
    //        hzyMessage.Message = ex.Message;
    //        return false;
    //    }

    //}
    #endregion

    #region CallByXML
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_基础接口")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string CallByXML(string XmlInput)
    {

        return GetCallByXML(XmlInput, Common.CallByXmlType.Common);

    }
    #endregion

    #region CallByExcelXML
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_基础接口,用于EXCEL操作")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string CallByExcelXML(string XmlInput)
    {

        return GetCallByXML(XmlInput, Common.CallByXmlType.Excel);


    }
    #endregion

    #region CallByHZYXML
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_基础接口,用于返回JSON")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string CallByHZYXML(string XmlInput)
    {

        try
        {
            return GetCallByXML(XmlInput, Common.CallByXmlType.HZYXML);
        }
        catch (Exception ex)
        {
            HZY.COM.Common.Log.WirteLogWS(ex, "");
            hzyMessage.Message = ex.Message;
            hzyMessage.ErrorMessage = ex.ToString();
            return Common.GetResponseStringByBool(false, ex.Message, Common.CallByXmlType.HZYXML, m_ClassName, m_AppName, m_Envo, m_Company, m_ExeType);
        }

    }
    #endregion

    #region 内部函数

    private string Login(string pEnv, string pLoginEnv, string pUserName, string pPassword, bool pMD5)
    {
        string str_LogID = "";
        string strReturn = "";
        string strError = "";
        try
        {
            string strIP = "";
            string strComputerName = "";

            try
            {
                strIP = this.Context.Request.UserHostAddress;
                //strComputerName = Dns.GetHostByAddress(strIP).HostName;
            }
            catch (Exception ex)
            {

            }


            str_LogID = Log.WirteLog_login(pEnv, pLoginEnv, pUserName, pPassword, strIP, strComputerName);


            pUserName = pUserName.Trim();
            pPassword = pPassword.Trim();

            if (CheckUserInfo(pLoginEnv, pUserName, pPassword, pEnv, pMD5))
            {
                strReturn = DoLogin(strIP, strComputerName);
            }
            else
            {
                hzyMessage.ClearUserInfo();
                strReturn = "Error:" + hzyMessage.Message; ;
            }
            return strReturn;
        }
        catch (Exception ex)
        {
            hzyMessage.ErrorMessage = ex.ToString();
            strError = ex.ToString();
            HZY.COM.Common.Log.WirteLogWS(ex, str_LogID);
            return ex.ToString();
        }
        finally
        {
            if (str_LogID != "")
            {
                if (strError != "")
                {
                    Log.UpdateLog_All_WS(Log.LogType.Login, str_LogID, strError, "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Log.UpdateLog_All_WS(Log.LogType.Login, str_LogID, strReturn, "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
            }
        }
    }

    #region GetRequestData 将XML转化成为DataSet
    /// <summary>
    /// 将XML转化成为DataSet
    /// </summary>
    /// <param name="pInputXml"></param>
    /// <returns></returns>
    private DataSet GetRequestData(string pInputXml)
    {

        bool bCreateTable = true;//标志是否需要创建表
        string strXML = "";

        strXML = HZY.COM.Common.Common.EscapeXML(pInputXml);

        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(strXML);

        XmlNode xml = xmlDoc.DocumentElement;
        m_AppName = xml.Attributes["AppName"].Value;
        m_Envo = xml.Attributes["Evno"].Value;
        m_Company = xml.Attributes["Company"].Value;
        m_ClassName = xml.Attributes["ClassName"].Value;
        m_ExeType = xml.Attributes["ExeType"].Value;

        if (hzyMessage.Session_ID == null || hzyMessage.Session_ID == "")
        {
            hzyMessage.Session_ID = xml.Attributes["SessionID"].Value;
        }

        DataSet ds = new DataSet("Request");
        foreach (XmlNode xmlTable in xml.ChildNodes)
        {
            DataTable dt = new DataTable(xmlTable.Attributes["TableName"].ToString());
            foreach (XmlNode xmlRow in xmlTable.ChildNodes)
            {
                DataRow dr = dt.NewRow();
                foreach (XmlNode xmlColumn in xmlRow.ChildNodes)
                {
                    string strColumnName = HZY.COM.Common.Common.UescapeXML(xmlColumn.Name);

                    if (bCreateTable)
                    {
                        dt.Columns.Add(strColumnName);
                    }

                    dr[strColumnName] = HZY.COM.Common.Common.UescapeXML(xmlColumn.InnerXml);
                }
                dt.Rows.Add(dr);
                bCreateTable = false;
            }
            ds.Tables.Add(dt);

        }

        if (ds.Tables.Count == 0)
        {
            ds = null;
        }

        return ds;
    }
    #endregion

    #region CheckUserInfo 单点登录用户信息认证
    /// <summary>
    /// 单点登录用户信息认证
    /// </summary>
    /// <param name="pLoginEnv">认证的环境</param>
    /// <param name="pUserName">用户名</param>
    /// <param name="pPassword">密码</param>
    /// <returns></returns>
    private bool CheckUserInfo(string pLoginEnv, string pUserName, string pPassword, string pEnv, bool pMD5)
    {
        bool returnValue = false;
        try
        {
            if (pLoginEnv.ToUpper() == "SSO")
            {
                pLoginEnv = "AM";
            }

            string[] strParam = new string[1];
            strParam[0] = pUserName.Trim();
            Dbconn conn = new Dbconn("VexSSO");

            VexSSOAccreditatio cls = new VexSSOAccreditatio();
            cls.AccreditatioType = pLoginEnv;
            cls.UserName = strParam[0];
            cls.PassWord = pPassword;
            cls.MD5 = pMD5;
            cls.Execute();

            //取到环境信息的相关信息
            DataTable dt_Env = conn.GetDataTable(@"
                    SELECT  t1.Env_ID ,
                            t2.Company_ID ,
                            t2.Company_sn
                    FROM    DBO.MDM_System_Env t1 WITH ( NOLOCK )
                            JOIN dbo.MDM_Company t2 WITH ( NOLOCK ) ON t1.Company_ID = t2.Company_ID
                    WHERE   ENV_SN=@param0", new string[1] { pEnv });

            if (dt_Env.Rows.Count == 1)
            {

                if (pLoginEnv.ToUpper() == "VEXSSO")
                {
                    hzyMessage.VexSSONewID = cls.AccreditatioSystemHZYMessage.VexSSONewID;
                    hzyMessage.LoginEnv_ID = "0";

                }
                else
                {
                    //获取VexSSONewID及LoginEnvID
                    string strSQL = @"
                    SELECT  VexSSONewID ,
                            t2.Env_ID
                    FROM    [dbo].[MDM_System_Env] t2
                            LEFT JOIN [dbo].[MDM_System_User] t1 ON t2.Env_ID = t1.Env_ID
                                                                    AND t1.App_UserName = @param1
                    WHERE   t2.Env_SN = @param0
        
";

                    DataTable dtSSOInfo = conn.GetDataTable(strSQL, new string[] { pLoginEnv, strParam[0] });
                    string strVexSSONEWID = "";
                    string strLoginEnv_ID = "";
                    if (dtSSOInfo.Rows.Count > 0)
                    {
                        strLoginEnv_ID = dtSSOInfo.Rows[0]["Env_ID"].ToString();
                        strVexSSONEWID = dtSSOInfo.Rows[0]["VexSSONewID"].ToString();
                    }

                    hzyMessage.VexSSONewID = strVexSSONEWID;
                    hzyMessage.LoginEnv_ID = strLoginEnv_ID;
                }



                hzyMessage.Env_ID = dt_Env.Rows[0]["Env_ID"].ToString();
                hzyMessage.Env_SN = pEnv;
                hzyMessage.Company_ID = dt_Env.Rows[0]["Company_ID"].ToString();
                hzyMessage.Company_SN = dt_Env.Rows[0]["Company_sn"].ToString();

                hzyMessage.Message = "登录成功！"; 

                hzyMessage.User_ID = cls.AccreditatioSystemHZYMessage.User_ID;
                hzyMessage.User_Name = cls.AccreditatioSystemHZYMessage.User_Name;
                hzyMessage.User_Name_CN = cls.AccreditatioSystemHZYMessage.User_Name_CN;
                hzyMessage.LoginEnv_SN = pLoginEnv;

                returnValue = true;
            }
            else
            {
                hzyMessage.Message = "环境信息错误！";
                returnValue = false;
            }
        }
        catch (Exception ex)
        {

            hzyMessage.Message = ex.Message;
            returnValue = false;
        }

        return returnValue;
    }
    #endregion

    #region DoLogin  进行登录信息写入
    /// <summary>
    /// 进行登录信息写入
    /// </summary>
    /// <returns></returns>
    private string DoLogin(string pIP, string pComputerName)
    {


        string strGUID = "";
        Dbconn conn = new Dbconn("VexSSO");
        DataTable dt_Guid = conn.GetDataTable("SELECT NEWID() AS GUID", new string[0]);
        strGUID = dt_Guid.Rows[0][0].ToString();
        DataTable dt = new System.Data.DataTable();

        DateTime time = DateTime.Now;

        dt.Columns.Add("SSO_Guid");
        dt.Columns.Add("Company_sn");
        dt.Columns.Add("Company_ID");
        dt.Columns.Add("Env_sn");
        dt.Columns.Add("Env_ID");
        dt.Columns.Add("Login_Env_sn");
        dt.Columns.Add("Login_Env_ID");
        
        dt.Columns.Add("VexSSONewID");
        dt.Columns.Add("User_ID");
        dt.Columns.Add("User_Name");
        dt.Columns.Add("User_Name_CN");
        dt.Columns.Add("Request_IP");
        dt.Columns.Add("Request_ComputerName");
        dt.Columns.Add("Login_Time");
        dt.Columns.Add("Last_Request_Time");

        DataRow dr = dt.NewRow();
        dr["SSO_Guid"] = strGUID;
        dr["Company_sn"] = hzyMessage.Company_SN;
        dr["Company_ID"] = hzyMessage.Company_ID;
        dr["Env_sn"] = hzyMessage.Env_SN;
        dr["Env_ID"] = hzyMessage.Env_ID;
        dr["Login_Env_ID"] = hzyMessage.LoginEnv_ID;
        dr["Login_Env_sn"] = hzyMessage.LoginEnv_SN;
        dr["User_ID"] = hzyMessage.User_ID;
        dr["User_Name"] = hzyMessage.User_Name;
        dr["User_Name_CN"] = hzyMessage.User_Name_CN;

        if (hzyMessage.VexSSONewID != "")
        {
            dr["VexSSONewID"] = hzyMessage.VexSSONewID;
        }
        dr["Request_IP"] = pIP;
        dr["Request_ComputerName"] = pComputerName;
        dr["Login_Time"] = time;
        dr["Last_Request_Time"] = time;
        dt.Rows.Add(dr);

        conn.BeginTransaction();
        try
        {
            conn.Insert("SSO_Login", dt);
            conn.CommitTransaction();

        }
        catch (System.Exception ex)
        {
            conn.RollbackTransaction();
            strGUID = "";
        }

        return strGUID;
    }
    #endregion

    #region DoLogout
    /// <summary>
    /// 登出操作
    /// </summary>
    /// <param name="pSessionID"></param>
    /// <returns></returns>
    private bool DoLogout(string pSessionID)
    {
        bool returnValue = false;
        Dbconn conn = new Dbconn("VexSSO");

        DataTable dt = new System.Data.DataTable();
        dt.Columns.Add("Logout_Time");
        dt.Rows.Add(new object[] { DateTime.Now });

        conn.BeginTransaction();

        ArrayList tableList = new ArrayList();
        tableList.Add("SSO_Login");
        conn.TableLock(tableList);
        returnValue = conn.Update("SSO_Login", dt, "SSO_Guid='" + pSessionID + "'");
        conn.CommitTransaction();

        hzyMessage.ClearUserInfo();
        hzyMessage.Message = "登出成功";

        return returnValue;
    }
    #endregion

    #region CallByXML
    private string GetCallByXML(string XmlInput, Common.CallByXmlType callType)
    {
        string strLog_ID = "";
        string strReturn = "";
        string strError = "";
        try
        {

            string strIP = "";
            string strComputerName = "";

            try
            {
                strIP = this.Context.Request.UserHostAddress;
                //strComputerName = Dns.GetHostByAddress(strIP).HostName;
            }
            catch (Exception ex)
            {

            }

            strLog_ID = Log.WirteLog_CallBYXMLBYWS("WS_Log", XmlInput, strIP, strComputerName);

            DataSet ds_Request = GetRequestData(XmlInput);
            ControlBase c = new ControlBase();
            c.hzyMessage = this.hzyMessage;
            DataSet ds_Response;
            if (m_ExeType.ToUpper() == "GET")
            {
                ds_Response = c.GetData(m_ClassName, ds_Request);

                if (callType == Common.CallByXmlType.Common)
                {
                    strReturn = Common.GetResponseStringByDs(ds_Response, m_ClassName, m_AppName, m_Envo, m_Company, m_ExeType);
                }
                else if (callType == Common.CallByXmlType.Excel)
                {
                    strReturn = Common.GetExcelResponseStringByDs(ds_Response, false, true);
                }
                else if (callType == Common.CallByXmlType.HZYXML)
                {
                    strReturn = Common.GetExcelResponseStringByDs(ds_Response, true, false);
                }
            }
            else if (m_ExeType.ToUpper() == "EXECUTE")
            {
                strReturn = Common.GetResponseStringByBool(c.Excute(m_ClassName, ds_Request), "", callType, m_ClassName, m_AppName, m_Envo, m_Company, m_ExeType);
            }
            return strReturn;

        }
        catch (Exception ex)
        {
            HZY.COM.Common.Log.WirteLogWS(ex, strLog_ID);
            hzyMessage.Message = ex.Message;
            hzyMessage.ErrorMessage = ex.ToString();
            strError = Common.GetResponseStringByBool(false, ex.Message, callType, m_ClassName, m_AppName, m_Envo, m_Company, m_ExeType);
            return strError;
        }
        finally
        {
            if (strLog_ID != "")
            {
                if (strError == "")
                {
                    Log.UpdateLog_CallBYXMLByWS("WS_Log", strLog_ID, strReturn.Length.ToString(), "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Log.UpdateLog_CallBYXMLByWS("WS_Log", strLog_ID, strError, "", hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
            }
        }

    }
    #endregion

    #endregion
}