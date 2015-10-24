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

    //private HandlerCfg m_HzyCfg = new HandlerCfg("HZY_WSRR_Mgr", "SSO");

    public void ProcessRequest(HttpContext context)
    {
        //////免登录设置，发布时需要删除
        //context.Session["SessionID" + m_HzyCfg.m_App] = "c49d5f36-6a52-4959-9c83-1204cf9f4275"; //测试库
        //context.Session["UserName" + m_HzyCfg.m_App] = "马卫清";
        ////context.Session["SessionID"] = "7699c81e-d7c0-4d29-8612-eebbc611f242";//正式库
        ////context.Session["SessionID"] = null; //测试库

        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";


        string strType = context.Request["type"].ToString();

        if (strType == "callbyxml")
        {
            CallByXML(context);
        }
        else if (strType == "getnewid")
        {
            context.Response.Write(System.Guid.NewGuid());
        }
        else if (strType == "formatxml")
        {
            FormatXml(context);
        }

    }

    private void FormatXml(HttpContext pcontext)
    {
        string strXML = pcontext.Request["xml"].ToString();
        pcontext.Response.Write(HZY.COM.Common.Common.FormatXml(strXML));
        pcontext.Response.End();
    }

    private void CallByXML(HttpContext pcontext)
    {
        string strDev = pcontext.Request["dev"].ToString();
        string strXML = pcontext.Request["xml"].ToString();
        string strClientID = pcontext.Request["clientid"].ToString();

        string strEnter = "\r\n";
        if (strXML == "")
        {
            pcontext.Response.Write("xml不能为空");
            pcontext.Response.End();
        }
        else
        {

            string strMessage = "";
            DateTime timeStart = DateTime.Now;
            string strResult = "";

            try
            {
            
                if (strDev == "prod")
                {
                    WSRRProd.WSRR wsrr = new WSRRProd.WSRR();
                    WSRRProd.HZYmessage hzy = new WSRRProd.HZYmessage();
                    hzy.Debug = true;
                    hzy.DebugClientID = strClientID;
                    wsrr.HZYmessageValue =hzy;
                    strResult = wsrr.CallByXML(strXML);//F11进后台
                    strResult = HZY.COM.Common.Common.FormatXml(strResult);
                }
                else
                {
                    WSRRTest.WSRR wsrr = new WSRRTest.WSRR();
                    WSRRTest.HZYmessage hzy = new WSRRTest.HZYmessage();
                    hzy.Debug = true;
                    hzy.DebugClientID = strClientID;
                    wsrr.HZYmessageValue = hzy;
                    strResult = wsrr.CallByXML(strXML);//F11进后台
                    strResult = HZY.COM.Common.Common.FormatXml(strResult);
                    
                }

                strMessage = "执行成功" + strEnter;

            }
            catch (Exception ex)
            {
                strMessage = "执行失败" + strEnter;
                strResult = ex.ToString();
            }
            finally
            {

                DateTime timeEnd = DateTime.Now;
                TimeSpan t = timeEnd - timeStart;
                strMessage += "花费时间(毫秒）：" + t.TotalMilliseconds.ToString("#,###") + strEnter;
                strMessage += "执行结果：" + strEnter;
                strMessage += strResult;
            }


            pcontext.Response.Write(strMessage);
            pcontext.Response.End();
        }

    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }




}