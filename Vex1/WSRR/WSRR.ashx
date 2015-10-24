<%@ WebHandler Language="C#" Class="WSRRForJson" %>

using System;
using System.Web;
using System.Data;

public class WSRRForJson : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
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

    public void CallByJSON(HttpContext context)
    {
        WSRR cls = new WSRR();
        string strJson = cls.CallByJSON(context.Request);
        context.Response.Write(strJson);
    }



}