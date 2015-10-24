﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common.WSRRMgr;
using HZY.COM.Common.DBAccess;
using System.Text;
using System.Web.Script.Services;
using System.Configuration;
using HZY.COM.Common.Base;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class WSRR : System.Web.Services.WebService
{
    public WSRR()
    {

    }

    #region 变量定义
    string m_AppName = "";//应用名称
    string m_WSID = "";//WEB Service编号
    string m_SessionID = "";//WEB Service编号
    string m_JsonpName = "";

    public HZYmessage hzyMessage = new HZYmessage();

    #endregion

    #region CallByXML
    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司_基础接口")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string CallByXML(string XmlInput)
    {
        string strLogID = "";
        string strReturn = "";
        string strError = "";
        try
        {
            string strIP = "";
            string strComputerName = "";

            strIP = GetIP();

            strLogID = Common.WirteLog_CallBYXML("WSRR_Log", XmlInput, strIP, strComputerName);

            DataSet dsRequest = GetRequestData(XmlInput);

            //取到WS的基础信息
            DataSet dsWSID = GetWSIDInfo();

            //验证用户信息
            CheckUserLogin(dsWSID);

            strReturn = CallWebService(dsWSID, dsRequest);

            //strReturn = ReplaceLowOrderASCIICharacters(strReturn);
            return strReturn;
        }
        catch (Exception ex)
        {
            HZY.COM.Common.Log.WirteLog(ex, strLogID);
            hzyMessage.Message = ex.Message;
            hzyMessage.ErrorMessage = ex.ToString();
            strError = "Error:" + ex.Message;
            return strError;
        }
        finally
        {
            if (strLogID != "")
            {
                if (strError == "")
                {
                    Common.UpdateLog_CallBYXML("WSRR_Log", strLogID, strReturn.Length.ToString(), this.m_WSID, hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Common.UpdateLog_CallBYXML("WSRR_Log", strLogID, strError, this.m_WSID, hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
            }
        }

    }
    #endregion

    #region CallByJSON
    public string CallByJSON(HttpRequest pRequest)
    {
        string strLogID = "";
        string strReturn = "";
        string strError = "";
        try
        {

            string strIP = "";
            string strComputerName = "";

            try
            {
                strIP = this.Context.Request.UserHostAddress;
            }
            catch (Exception ex)
            {

            }
             
            DataSet dsRequest = GetRequestData(pRequest);

            //取到WS的基础信息
            DataSet dsWSID = GetWSIDInfo();

            //验证用户信息
            CheckUserLogin(dsWSID);
            strReturn = m_JsonpName + "(" + CallWebService(dsWSID, dsRequest) + ")";
            return strReturn;
        }
        catch (Exception ex)
        {
            HZY.COM.Common.Log.WirteLog(ex, strLogID);
            hzyMessage.Message = ex.Message;
            hzyMessage.ErrorMessage = ex.ToString();
            strError = "Error:" + ex.Message;
            return strError;
        }
        finally
        {
            if (strLogID != "")
            {
                if (strError == "")
                {
                    Common.UpdateLog_CallBYXML("WSRR_Log", strLogID, strReturn.Length.ToString(), this.m_WSID, hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
                else
                {
                    Common.UpdateLog_CallBYXML("WSRR_Log", strLogID, strError, this.m_WSID, hzyMessage.Session_ID, hzyMessage.Env_SN);
                }
            }
        }

    }
    #endregion

    #region 内部函数

    #region GetIP
    private string GetIP()
    {
        string strIP = "";
        try
        {
            strIP = this.Context.Request.UserHostAddress;
        }
        catch (Exception ex)
        {

        }

        return strIP;
    }
    #endregion

    #region GetWSIDInfo
    private DataSet GetWSIDInfo()
    {
        Dbconn conn = new Dbconn("WSRR");

        //取到关系表
        DataSet ds = conn.GetDataSet(@"
                    SELECT  t1.WSID ,
                            t1.WSMethod ,
                            t1.WSState ,
                            t1.WSType ,
                            t1.WSHost,
                            t1.WSURL ,
                            NeedLogin,
                            t2.ParamName ,
                            WSUnicode,
                            ParamIndex,
                            ParamMustFlag ,
                            ParamName ,
                            ParamType,
                            DefaultValue
                    FROM    [M01_CONF].[LW1_LocalWSHead]  t1 WITH ( NOLOCK )
                            LEFT JOIN [M01_CONF].[LW2_LocalWSDetail]  t2 WITH ( NOLOCK ) ON t1.WSSrcID = t2.WSSrcID
                    WHERE   t1.WSID = @Param0
                            AND t1.WSState = '运行中'
                    ORDER BY ParamIndex ASC ", new string[1] { m_WSID });

        if (ds == null || ds.Tables.Count == 0
            || ds.Tables[0].Rows.Count == 0)
        {
            throw new Exception("WSID的信息不正确");
        }

        return ds;
    }
    #endregion

    #region CallWebService
    private string CallWebService(DataSet pdsWSID, DataSet pdsRequest)
    {
        string strReturnValue = "";
        if (pdsWSID.Tables.Count > 0 && pdsWSID.Tables[0].Rows.Count > 0)
        {
            if (pdsWSID.Tables[0].Rows[0]["WSType"].ToString().ToLower() == "wsdl")
            {
                strReturnValue = ExecuteWSDL(pdsWSID, pdsRequest).ToString();
            }
            else if (pdsWSID.Tables[0].Rows[0]["WSType"].ToString().ToLower() == "restful")
            {

                strReturnValue = ExecuteRestful(pdsWSID, pdsRequest);
            }
            else if (pdsWSID.Tables[0].Rows[0]["WSType"].ToString().ToLower() == "wsdlnet")
            {
                strReturnValue = ExecuteWSDLNet(pdsWSID, pdsRequest).ToString();
            }
            else if (pdsWSID.Tables[0].Rows[0]["WSType"].ToString().ToLower() == "wsdlwsrr")
            {
                strReturnValue = ExecuteWSDLWSRR(pdsWSID, pdsRequest).ToString();
            }
        }

        //strReturnValue = ReplaceLowOrderASCIICharacters(strReturnValue);
        return strReturnValue;
    }
    #endregion

    //public static string ReplaceLowOrderASCIICharacters(string tmp)
    //{
    //    StringBuilder info = new StringBuilder();
    //    foreach (char cc in tmp)
    //    {
    //        int ss = (int)cc;
    //        if (((ss >= 0) && (ss <= 8)) || ((ss >= 11) && (ss <= 12)) || ((ss >= 14) && (ss <= 32)))
    //            info.AppendFormat(" ", ss);//&#x{0:X};
    //        else info.Append(cc);
    //    }
    //    return info.ToString();
    //}

    #region CheckUserLogin
    public void CheckUserLogin(DataSet dsWSID)
    {
        if (dsWSID.Tables[0].Rows[0]["NeedLogin"].ToString() == "1")
        {
            string SessionID = hzyMessage.Session_ID;
            CheckUser(SessionID,true);
        }
    }
    #endregion

    #region CheckUser
    public static HZYmessage CheckUser(string SessionID,bool pUpdateLastReustTime)
    {
        HZYmessage message = new HZYmessage();
        if (SessionID == null || SessionID == "")
        {
            throw new Exception("身份验证错误");
        }
        Dbconn conn = new Dbconn("WSRR");
        string strSQL = @"
              SELECT 
                    [LoginSessionID]
                  ,[LoginUser]
                  ,[LoginTime]
              FROM F01_Cert.Login
              where LoginSessionID=@param0
              and LogoutTime is null
        ";

        DataTable dt = conn.GetDataTable(strSQL, new string[] { SessionID });
        if (dt.Rows.Count == 1)
        {
            message.Session_ID = dt.Rows[0]["LoginSessionID"].ToString();
            //message.Employee_ID = dt.Rows[0]["LoginUser"].ToString();
            message.User_ID = dt.Rows[0]["LoginUser"].ToString();
            message.User_Name = dt.Rows[0]["LoginUser"].ToString();
            message.User_Name_CN = dt.Rows[0]["LoginUser"].ToString();

            if (pUpdateLastReustTime)
            {
                //需要更新用户的最后访问日期
                conn.BeginTransaction();
                conn.ExcuteQuerryByTran("update F01_Cert.Login set LastVisitTime=getdate() where LoginSessionID=@param0", new string[] { message.Session_ID });
                conn.CommitTransaction();
            }

            return message;
        }
        else
        {
            throw new Exception("身份验证错误");
        }
    }

    #endregion

    #region GetRequestData 将XML转化成为DataSet
    /// <summary>
    /// 将XML转化成为DataSet
    /// </summary>
    /// <param name="pInputXml"></param>
    /// <returns></returns>
    private DataSet GetRequestData(string pInputXml)
    {


        string strXML = "";

        DataSet ds = new DataSet("Request");


        try
        {
            strXML = HZY.COM.Common.Common.EscapeXML(pInputXml);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(strXML);

            XmlNode xml = xmlDoc.DocumentElement;
            m_AppName = xml.Attributes["App"].Value;
            m_WSID = xml.Attributes["WSID"].Value;


            if (hzyMessage.Session_ID == null || hzyMessage.Session_ID == "")
            {
                hzyMessage.Session_ID = xml.Attributes["SessionID"].Value;
            }

            hzyMessage.Env_SN = m_AppName;

            DataTable dt = new DataTable("RequestTable");

            dt.Columns.Add("ParamName");
            dt.Columns.Add("ParamValue");
            foreach (XmlNode xmlColumn in xml.ChildNodes)
            {
                DataRow dr = dt.NewRow();
                dr["ParamName"] = HZY.COM.Common.Common.UescapeXML(xmlColumn.Name);
                dr["ParamValue"] = HZY.COM.Common.Common.UescapeXML(xmlColumn.InnerXml);
                dt.Rows.Add(dr);
            }

            ds.Tables.Add(dt);
        }
        catch (Exception ex)
        {
            throw new Exception("InputXml的格式有误，请检查");
        }


        return ds;
    }
    #endregion

    #region GetRequestData 将HttpRequest转化成为DataSet
    /// <summary>
    /// 将HttpRequest转化成为DataSet
    /// </summary>
    /// <param name="pInputXml"></param>
    /// <returns></returns>
    private DataSet GetRequestData(HttpRequest pRequest)
    {
        DataSet ds = new DataSet("Request");

        try
        {
            DataTable dt = new DataTable("RequestTable");

            this.m_WSID = pRequest.QueryString["WSID"].ToString();
            hzyMessage.Session_ID = pRequest.QueryString["SessionID"].ToString();
            m_JsonpName = pRequest.QueryString["jsoncallback"].ToString();

            dt.Columns.Add("ParamName");
            dt.Columns.Add("ParamValue");

            for (int i = 0; i < pRequest.QueryString.Count; i++)
            {
                if (pRequest.QueryString.AllKeys[i] != "SessionID"
                    && pRequest.QueryString.AllKeys[i] != "WSID"
                    )
                {
                    DataRow dr = dt.NewRow();
                    dr["ParamName"] = pRequest.QueryString.AllKeys[i];
                    dr["ParamValue"] = pRequest.QueryString[i];
                    dt.Rows.Add(dr);
                }
            }

            ds.Tables.Add(dt);
        }
        catch (Exception ex)
        {
            throw new Exception("JSON的格式有误，请检查");
        }


        return ds;
    }
    #endregion

    #region ExecuteWSDL
    private object ExecuteWSDL(DataSet pdsWSID, DataSet pdsRequest)
    {
        string strMethod = pdsWSID.Tables[0].Rows[0]["WSMethod"].ToString();
        object[] args = new object[pdsWSID.Tables[0].Rows.Count];

        for (int j = 0; j < pdsWSID.Tables[0].Rows.Count; j++)
        {
            if (pdsWSID.Tables[0].Rows[j]["ParamName"] == DBNull.Value)
            {
                if (pdsWSID.Tables[0].Rows.Count == 1)
                {
                    args = new object[0];
                }

                continue;
            }

            string strParamName = pdsWSID.Tables[0].Rows[j]["ParamName"].ToString();
            DataRow[] drList = pdsRequest.Tables[0].Select("ParamName='" + strParamName + "'");
            if (drList.Length > 0)
            {
                if (pdsWSID.Tables[0].Rows[j]["ParamType"].ToString().ToLower() == "int")
                {
                    args[j] = Convert.ToInt32(drList[0]["ParamValue"]);
                }
                else if (pdsWSID.Tables[0].Rows[j]["ParamType"].ToString().ToLower() == "datetime")
                {
                    args[j] = Convert.ToDateTime(drList[0]["ParamValue"]);
                }
                else
                {
                    args[j] = drList[0]["ParamValue"].ToString();
                }
            }
            else
            {
                if (pdsWSID.Tables[0].Rows[j]["DefaultValue"] != DBNull.Value)
                {
                    if (pdsWSID.Tables[0].Rows[j]["ParamType"].ToString().ToLower() == "int")
                    {
                        args[j] = Convert.ToInt32(pdsWSID.Tables[0].Rows[j]["DefaultValue"].ToString());
                    }
                    else if (pdsWSID.Tables[0].Rows[j]["ParamType"].ToString().ToLower() == "datetime")
                    {
                        args[j] = Convert.ToDateTime(pdsWSID.Tables[0].Rows[j]["DefaultValue"].ToString());
                    }
                    else
                    {
                        args[j] = pdsWSID.Tables[0].Rows[j]["DefaultValue"].ToString();
                    }
                }
                else
                {
                    throw new Exception(strParamName + "参数没有被赋值！");
                }
            }
        }

        string strURL = GetURL(pdsWSID);

        //指定单点登录的地址
        if (m_WSID.ToUpper() == "550FC164-ADC8-4F88-BC9D-73C4248050BC")
        {
            //strURL = c
            string strCfgSSOURL = ConfigurationManager.AppSettings["SSOURL"];
            if (strCfgSSOURL != null && strCfgSSOURL != "")
            {
                strURL = strCfgSSOURL;
            }

        }
        object result = WebServiceHelper.InvokeWebService(strURL, strMethod, args);
        return result;
    }
    #endregion

    #region ExecuteRestful
    private string ExecuteRestful(DataSet pdsWSID, DataSet pdsRequest)
    {
        string strParam = "";
        string strType = pdsWSID.Tables[0].Rows[0]["WSMethod"].ToString().ToLower();
        string strUnicode = pdsWSID.Tables[0].Rows[0]["WSUnicode"].ToString().ToUpper();

        for (int j = 0; j < pdsWSID.Tables[0].Rows.Count; j++)
        {
            if (pdsWSID.Tables[0].Rows[j]["ParamName"] == DBNull.Value)
            {
                continue;
            }
            string strParamName = pdsWSID.Tables[0].Rows[j]["ParamName"].ToString();
            DataRow[] drList = pdsRequest.Tables[0].Select("ParamName='" + strParamName + "'");

            if (drList.Length > 0)
            {
                if (strType == "get")
                {
                    strParam += drList[0]["ParamName"].ToString() + "=";
                    strParam += drList[0]["ParamValue"].ToString() + "&";

                    //Microsoft.JScript.GlobalObject.escape(
                }
                else if (strType == "post")
                {
                    strParam = drList[0]["ParamValue"].ToString();
                }
            }
            else
            {

                if (pdsWSID.Tables[0].Rows[j]["DefaultValue"] != DBNull.Value)
                {
                    if (strType == "get")
                    {
                        strParam += strParamName + "=";
                        strParam += pdsWSID.Tables[0].Rows[j]["DefaultValue"].ToString() + "&";
                    }
                    else if (strType == "post")
                    {
                        strParam = drList[0]["ParamValue"].ToString();
                    }
                }
                else
                {
                    if (pdsWSID.Tables[0].Rows[j]["ParamMustFlag"].ToString() == "1")
                    {
                        throw new Exception(strParamName + "参数没有被赋值！");
                    }
                }
            }

        }


        string strResult = "";
        HttpTools http = new HttpTools();
        string strurl = GetURL(pdsWSID);

        if (strType == "get")
        {
            strResult = http.CreateHttpGet(strurl + strParam, false, strUnicode);

        }
        else if (strType == "post")
        {
            strResult = http.CreateHttpPost(strurl, strParam, false, strUnicode);
        }

        return strResult;

    }
    #endregion

    #region ExecuteWSDLNet
    private string ExecuteWSDLNet(DataSet pdsWSID, DataSet pdsRequest)
    {
        string strMethod = pdsWSID.Tables[0].Rows[0]["WSMethod"].ToString();
        string[] args = new string[1];
        pdsRequest.Tables[0].Rows.Add(new object[] { "SessionID", hzyMessage.Session_ID });

        string strClassName = "";
        string strExeType = "";
        DataRow[] drList = pdsWSID.Tables[0].Select("ParamName='ClassName'");
        if (drList.Length > 0)
        {
            strClassName = drList[0]["DefaultValue"].ToString();
        }

        if (strClassName == "")
        {
            throw new Exception("配置错误，请核对。ClassName");
        }

        drList = pdsWSID.Tables[0].Select("ParamName='ExeType'");
        if (drList.Length > 0)
        {
            strExeType = drList[0]["DefaultValue"].ToString();
        }

        if (strExeType == "")
        {
            throw new Exception("配置错误，请核对。ExeType");
        }

        string strXML = "";
        strXML += "<Interface AppName=\"\" Company=\"\" ClassName=\"" + strClassName + "\" Evno=\"" + hzyMessage.Env_SN + "\" ExeType=\"" + strExeType.ToUpper() + "\" SessionID=\"" + hzyMessage.Session_ID + "\">";
        strXML += "<Table TableName=\"Request\">";
        strXML += "<Row>";

        for (int j = 0; j < pdsWSID.Tables[0].Rows.Count; j++)
        {

            if (pdsWSID.Tables[0].Rows[j]["ParamName"] == DBNull.Value)
            {
                continue;
            }

            if (pdsWSID.Tables[0].Rows[j]["ParamName"].ToString().ToUpper() == "ClassName".ToUpper()
                || pdsWSID.Tables[0].Rows[j]["ParamName"].ToString().ToUpper() == "ExeType".ToUpper())
            {
                continue;
            }

            string strParamName = pdsWSID.Tables[0].Rows[j]["ParamName"].ToString();
            drList = pdsRequest.Tables[0].Select("ParamName='" + strParamName + "'");
            if (drList.Length > 0)
            {
                strXML += "<" + strParamName + ">" + drList[0]["ParamValue"].ToString() + "</" + strParamName + ">";
            }
            else
            {
                if (pdsWSID.Tables[0].Rows[j]["DefaultValue"] != DBNull.Value)
                {
                    strXML += "<" + strParamName + ">" + pdsWSID.Tables[0].Rows[j]["DefaultValue"].ToString() + "</" + strParamName + ">";
                }
                else
                {
                    throw new Exception(strParamName + "参数没有被赋值！");
                }
            }
        }

        strXML += "</Row>";
        strXML += "</Table>";
        strXML += "</Interface>";

        args[0] = strXML;
        object strResult = WebServiceHelper.InvokeWebService(GetURL(pdsWSID), strMethod, args);
        return strResult.ToString();
    }
    #endregion

    #region ExecuteWSDLWSRR
    private string ExecuteWSDLWSRR(DataSet pdsWSID, DataSet pdsRequest)
    {
        string strMethod = pdsWSID.Tables[0].Rows[0]["WSMethod"].ToString();
        string[] args = new string[1];
        pdsRequest.Tables[0].Rows.Add(new object[] { "SessionID", hzyMessage.Session_ID });

        DataSet dsToRequest = new DataSet();
        DataTable dtRequest = new DataTable();

        dtRequest.Columns.Add("ClassName");
        dtRequest.Rows.Add(new object[] { "" });

        string strClassName = "";
        string strExeType = "";
        DataRow[] drList = pdsWSID.Tables[0].Select("ParamName='ClassName'");

        if (drList.Length > 0)
        {
            strClassName = drList[0]["DefaultValue"].ToString();
        }

        if (strClassName == "")
        {
            throw new Exception("配置错误，请核对。ClassName");
        }

        drList = pdsWSID.Tables[0].Select("ParamName='ExeType'");
        if (drList.Length > 0)
        {
            strExeType = drList[0]["DefaultValue"].ToString();
        }

        if (strExeType == "")
        {
            throw new Exception("配置错误，请核对。ExeType");
        }

        for (int j = 0; j < pdsWSID.Tables[0].Rows.Count; j++)
        {

            if (pdsWSID.Tables[0].Rows[j]["ParamName"] == DBNull.Value)
            {
                continue;
            }

            if (pdsWSID.Tables[0].Rows[j]["ParamName"].ToString() == "ClassName"
                || pdsWSID.Tables[0].Rows[j]["ParamName"].ToString() == "ExeType")
            {
                continue;
            }

            string strParamName = pdsWSID.Tables[0].Rows[j]["ParamName"].ToString();
            drList = pdsRequest.Tables[0].Select("ParamName='" + strParamName + "'");
            if (drList.Length > 0)
            {
                dtRequest.Columns.Add(strParamName);
                dtRequest.Rows[0][strParamName] = drList[0]["ParamValue"];
            }
            else
            {
                if (pdsWSID.Tables[0].Rows[j]["DefaultValue"] != DBNull.Value)
                {
                    dtRequest.Columns.Add(strParamName);
                    dtRequest.Rows[0][strParamName] = pdsWSID.Tables[0].Rows[j]["DefaultValue"];
                }
                else
                {
                    throw new Exception(strParamName + "参数没有被赋值！");
                }
            }
        }

        string strReturn = "";
        dsToRequest.Tables.Add(dtRequest);
        HZY.COM.Common.WSRRMgr.ControlBase c = new HZY.COM.Common.WSRRMgr.ControlBase();
        c.hzyMessage = this.hzyMessage;
        DataSet dsResponse;
        Common.CallByXmlType calltype = Common.CallByXmlType.Common;
        if (strExeType.ToUpper() == "GET")
        {
            dsResponse = c.GetData(strClassName, dsToRequest);

            if (strMethod == "CallByXML")
            {
                strReturn = Common.GetResponseStringByDs(dsResponse, strClassName, "", hzyMessage.Env_SN, hzyMessage.Company_SN, strExeType);
            }
            else if (strMethod == "CallByExcelXML")
            {
                strReturn = Common.GetExcelResponseStringByDs(dsResponse, false, true);
                calltype = Common.CallByXmlType.Excel;
            }
            else if (strMethod == "CallByHZYXML")
            {
                strReturn = Common.GetExcelResponseStringByDs(dsResponse, true, true);
                calltype = Common.CallByXmlType.HZYXML;
            }
        }
        else if (strExeType.ToUpper() == "EXECUTE")
        {
            strReturn = Common.GetResponseStringByBool(c.Excute(strClassName, pdsRequest), "", calltype, strClassName, "", hzyMessage.Env_SN, hzyMessage.Company_SN, strExeType);
        }
        return strReturn;


    }
    #endregion

    #region GetURL
    private string GetURL(DataSet dsWSID)
    {
        string strUrl = dsWSID.Tables[0].Rows[0]["WSURL"].ToString().Replace("\\", "/");
        string strHost = dsWSID.Tables[0].Rows[0]["WSHost"].ToString().Replace("\\", "/");

        if (strHost.Substring(strHost.Length - 1, 1) != "/")
        {
            strHost = strHost + "/";
        }

        if (strUrl.Substring(0, 1) == "/")
        {
            strUrl = strUrl.Substring(1);
        }
        strUrl = strHost + strUrl;
        return strUrl;
    }
    #endregion

    #endregion
}