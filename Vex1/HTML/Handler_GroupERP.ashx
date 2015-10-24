<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Collections;
using System.Diagnostics;
using HZY.COM.WEB;

public class Handler : IHttpHandler, IRequiresSessionState
{

    //private string m_WSID = "";
    //private string m_SessionID = "";
    //private string m_RequestType = "";
    //private string m_App = "HZY_WSRR";
    //private string m_LoginApp = "SSO";
    string strComp = "";

    //private HandlerCfg m_HzyCfg;
    private HandlerCfg m_HzyCfg = new HandlerCfg("", "SSO");

    public void ProcessRequest(HttpContext context)
    {
        //免登录设置，发布时需要删除
        //context.Session["SessionID" + m_HzyCfg.m_App] = "adddb009-8ed7-40f4-8f3d-52f29ac6a1d2"; //测试库
        //context.Session["UserName" + m_HzyCfg.m_App] = "刘洪";
        //context.Session["SessionID"] = "7699c81e-d7c0-4d29-8612-eebbc611f242";//正式库
        //context.Session["SessionID"] = null; //测试库

        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";


        if (context.Request["compName"] != null){
                strComp = context.Request["compName"];
        }
        else if (context.Request.Form.AllKeys.Length != 0) {
            strComp = context.Request["Company"]; 
        };
        m_HzyCfg.m_App = strComp;
        m_HzyCfg.m_LoginApp = "SSO";
        //= new HandlerCfg(strComp, "SSO");
        CallByJSON(context);
        
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    #region "CallByJSON"
    public void CallByJSON(HttpContext context)
    {

        try
        {
            if (context.Request["WSID"].ToString() == "LoginName")
            {
                if (context.Session["UserName" + m_HzyCfg.m_App] == null)
                {
                    context.Session["UserName" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"UserName\":\"" + context.Session["UserName" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else
            {

                DataSet ds_Request = WebHandler.GetRequestData(context, m_HzyCfg);

                string strXML = WebHandler.GetXMLFromDS(ds_Request, m_HzyCfg);
                strXML = strXML.Replace("&gt;", ">").Replace("&lt;", "<").Replace("&amp;", "&");
                WSRR.WSRR wsrr = new WSRR.WSRR();
                wsrr.Timeout = 1000 * 60 * 60; //超时时间：60分钟
                string strResult = wsrr.CallByXML(strXML);//F11进后台

                 strResult = strResult.Replace("&", "&amp;");

                context.Response.Write(WebHandler.GetJSONFromXML(strResult, context, m_HzyCfg));
            }
        }
        catch (Exception ex)
        {
            string strMessage = ex.Message;
            if (ex.Message == "")
            {
                strMessage = ex.ToString().Replace("\"", "").Replace("'", "");
            }
            if (strMessage == "")
            {
                strMessage = "未知错误";
            }
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"","").Replace("'","") + "\"}");

            //throw;
        }
        finally
        {
            context.Response.End();
        }

    }
    #endregion 
     

}