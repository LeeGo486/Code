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

    private HandlerCfg m_HzyCfg = new HandlerCfg("HZY_WSRR_Mgr", "SSO");

    public void ProcessRequest(HttpContext context)
    {
        ////免登录设置，发布时需要删除
        //context.Session["SessionID" + m_HzyCfg.m_App] = "c49d5f36-6a52-4959-9c83-1204cf9f4275"; //测试库
        //context.Session["UserName" + m_HzyCfg.m_App] = "马卫清";
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

                WSRR.WSRR wsrr = new WSRR.WSRR();
                string strResult = wsrr.CallByXML(strXML);//F11进后台

                //strResult = strResult.Replace("&", "&amp;");
                //strResult = strResult.Replace("&gt;", ">").Replace("&lt;", "<").Replace("&amp;", "&");

                //strResult = HZY.COM.WEB.WebHandler.HighLightKeyWord(strResult, "马卫清");

                if (m_HzyCfg.m_WSID.ToLower() == "81093d5a-0ef6-4c70-9a89-0ec8f3160a9c")
                {
                    if (strResult.StartsWith("Error"))
                    {
                        context.Response.Write("{\"Error\":\"" + strResult + "\"}");
                        return;
                    }

                    DataSet dsSessionID = HZY.COM.Common.Common.GetDSByExcelXML(strResult);
                    //m_SessionID = strXML;
                    context.Session["SessionID" + m_HzyCfg.m_App] = dsSessionID.Tables[1].Rows[0][0].ToString(); ;
                    context.Session["UserName" + m_HzyCfg.m_App] = context.Request["UserName"];
                    context.Response.Write("{\"Result\":\"登录成功\"}");
                }
                else
                {
                    context.Response.Write(WebHandler.GetJSONFromXML(strResult, context, m_HzyCfg));
                }
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"Error\":\"" + ex.Message + "\"}");

            //throw;
        }
        finally
        {
            context.Response.End();
        }

    }
    #endregion


}