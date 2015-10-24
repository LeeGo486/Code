<%@ WebHandler Language="C#" Class="UploadHandler" %>
 
using System;
using System.Data;
using System.Web;
using System.Threading;
using System.IO;
using HZY.COM.Common;
using HZY.COM.WEB;
using HZY.COM.Common.Excel;

public class UploadHandler : IHttpHandler
{

    DataTable dt = new DataTable();

    public bool IsReusable
    {
        get
        {
            return false;

        }
    }
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            UploadFile clsUp = new UploadFile(context);
            clsUp.Upload();
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"", "").Replace("'", "") + "\"}");
        }
       
    }



}