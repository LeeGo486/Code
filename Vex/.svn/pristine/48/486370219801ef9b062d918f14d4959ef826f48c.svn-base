using System;
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
using HZY.COM.Common;
using HZY.COM.Common.Base;

/// <summary>
/// Control .NET程序调用的主入口
/// </summary>
public class Control : System.Web.Services.WebService
{
    public Control()
    {

    }

    public HZYmessage hzyMessage=new HZYmessage();

    private bool m_WS = false;

    [WebMethod(
         Description = "浙江华之毅投资有限公司_用户登录")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public string Login(string pAppName, string pCompany, string pEnv, string pLoginEnv, string pUserName, string pPassword)
    {

        hzyMessage = new HZYmessage();
        try
        {
            WS ws = new WS();
            return ws.Login(pEnv, pLoginEnv, pUserName, pPassword);
        }
        catch (Exception ex)
        {
            hzyMessage.ErrorMessage = ex.Message;
            HZY.COM.Common.Log.WirteLogWS(ex,"");
            return "";
        }
    }

    [WebMethod(
     Description = "浙江华之毅投资有限公司_用户登录")]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public bool Logout(string pSession)
    {

        try
        {
            WS ws = new WS();
            return ws.Logout(pSession);
        }
        catch (Exception ex)
        {
            hzyMessage.ErrorMessage = ex.Message;
            HZY.COM.Common.Log.WirteLogWS(ex, "");
            return false;
        }
    }

    [WebMethod(
         Description = "浙江华之毅投资有限公司", EnableSession = true)]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public bool Excute(string logicName, System.Data.DataSet request)
    {

        try
        {
            //if (!CheckIP())
            //{
            //    hzyMessage.ErrorMessage = "IP限制";
            //    return false;
            //}

            ControlBase cb = new ControlBase();
            cb.hzyMessage = this.hzyMessage;
            return cb.Excute(logicName, request);
        }
        catch (Exception ex)
        {

            hzyMessage.ErrorMessage = ex.ToString();
            hzyMessage.Message = ex.Message;
            HZY.COM.Common.Log.WirteLogWS(ex, "");
            return false;
        }
    }




    [WebMethod(
         CacheDuration = 0,
         BufferResponse = false,
         Description = "浙江华之毅投资有限公司", EnableSession = true)]
    [SoapHeader("hzyMessage", Direction = SoapHeaderDirection.InOut)]
    public DataSet GetData(string logicName, System.Data.DataSet request)
    {
        try
        {
            
            //if (!CheckIP())
            //{
            //    hzyMessage.ErrorMessage = "IP限制";
            //    return null;
            //}

            ControlBase cb = new ControlBase();
            cb.hzyMessage = this.hzyMessage;
            return cb.GetData(logicName, request);
        }
        catch (Exception ex)
        {

            hzyMessage.ErrorMessage = ex.Message;
            //hzyMessage.exception = ex;
            HZY.COM.Common.Log.WirteLogWS(ex, "");
            return null;
        }
    }


    private bool CheckIP()
    {

        string strRequestIP = this.Context.Request.UserHostAddress;
        string strHostName = Dns.GetHostName();
        IPHostEntry ipEntry = Dns.GetHostEntry(strHostName);

        //HZY.COM.Common.Common.WirteLogWS(new Exception(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));

        if (strRequestIP == "127.0.0.1" || strRequestIP == "::1")
        {
            return true;
        }

        for (int i = 0; i < ipEntry.AddressList.Length; i++)
        {
            if (ipEntry.AddressList[i].ToString() == strRequestIP)
            {
                return true;
            }
        }

        if (strRequestIP == "192.168.0.35" || strRequestIP == "172.16.59.210" || strRequestIP == "172.16.34.91")
        {
            return true;
        }
        return false;
    }
}

