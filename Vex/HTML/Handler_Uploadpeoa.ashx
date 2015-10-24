<%@ WebHandler Language="C#" Class="UploadHandler" %>
 
using System;
using System.Data;
using System.Web;
using System.Threading;
using System.IO;
using HZY.COM.Common;
using HZY.COM.WEB;
using HZY.COM.Common.Excel; 
using HZY.COM.FTP;
using System.Collections; 
using System.Configuration; 
using HZY.COM.Common.DBAccess; 

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
        String res = "";
        try
        {
            String filePath = context.Request["filePath"].ToString();
            res = setPhotToSave(filePath);
            context.Response.Write("{\"res\":\"" + res + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"", "").Replace("'", "") + "\"}");
        }
         
    }

    #region 上传图片到服务器
    /// <summary>
    /// 上传图片并到服务器
    /// </summary>
    /// <returns></returns> 
    private String setPhotToSave(String strPhotoPath)
    {
        DataSet ds_Return = new DataSet();
        String remoteHost = "172.16.205.57";
        //String remoteHost = "192.168.0.114";
        String remotePath = "";
        String remoteUser = "peoa";
        String remotePass = "peoa";
        String remoteDir = "";
        int remotePort = 21; 
        try
        {
            //上传文件
            var ftcc = new HZY.COM.FTP.FTPClient(remoteHost, remotePath, remoteUser, remotePass, remotePort);
            ftcc.Connect();
            ftcc.ChDir(remoteDir);   // 切换到ftp对应目录下的文件夹路径
            ftcc.Put(strPhotoPath); 
        }
        catch (Exception ex)
        {
            return "error";
        } 
        return "ok";   
    }
    #endregion


}