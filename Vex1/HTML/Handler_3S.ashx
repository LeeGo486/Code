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

    private HandlerCfg m_HzyCfg = new HandlerCfg("3S_VEX", "SSO");

    public void ProcessRequest(HttpContext context)
    {
        //免登录设置，发布时需要删除
        //context.Session["SessionID" + m_HzyCfg.m_App] = "e3f43515-fada-4a2e-95c3-b2ed1bc9afcf"; //测试库
        //context.Session["UserName" + m_HzyCfg.m_App] = "郭琦琦";
        //context.Session["SessionID"] = "7699c81e-d7c0-4d29-8612-eebbc611f242";//正式库
        //context.Session["SessionID"] = null; //测试库

        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";

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
            bool bExcelImport = false;
            DataSet dsExcel = null;
            if (context.Request.Files.Count > 0)
            {
                UploadFile clsUp = new UploadFile(context);
                clsUp.Upload();
                dsExcel = clsUp.dsExcelData;

                if (context.Request["ExcelImport"] != null && context.Request["ExcelImport"].ToString().ToUpper()=="true".ToUpper())
                {
                    bExcelImport = true;
                }
            }

            if (context.Request["WSID"] == null)
            {
                return;
            }
            
            if (context.Request["WSID"].ToString() == "LoginName")
            {
                if (context.Session["UserName"  + m_HzyCfg.m_App] == null)
                {
                    context.Session["UserName" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"UserName\":\"" + context.Session["UserName" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else if (context.Request["WSID"].ToString() == "DepotID")
            {
                if (context.Session["DepotID" + m_HzyCfg.m_App] == null)
                {
                    context.Session["DepotID" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"DepotID\":\"" + context.Session["DepotID" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else if (context.Request["WSID"].ToString() == "DepotName")
            {
                if (context.Session["DepotName" + m_HzyCfg.m_App] == null)
                {
                    context.Session["DepotName" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"DepotName\":\"" + context.Session["DepotName" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else
            {

                DataSet ds_Request = WebHandler.GetRequestData(context, m_HzyCfg);
                 
                
                string strXML = WebHandler.GetXMLFromDS(ds_Request, m_HzyCfg);

                WSRR.WSRR wsrr = new WSRR.WSRR();
                wsrr.Timeout = 1000 * 60 * 60; //超时时间：60分钟
                

                string strResult = "";
                if (bExcelImport)
                {
                    strResult = wsrr.CallByXMLContainBigData(strXML,dsExcel);//F11进后台
                }
                else
                {
                    strResult = wsrr.CallByXML(strXML);//F11进后台
                }

                //strResult = strResult.Replace("&", "&amp;");

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
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"", "").Replace("'", "") + "\"}");

        }
        finally
        {
            context.Response.End();
        }

    }
    #endregion 
     

}