<%@ WebHandler Language="C#" Class="Handler_Image_Upload" %>

using System;
using System.IO;
using System.Web;

public class Handler_Image_Upload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            HttpPostedFile postedFile = context.Request.Files[0];
            string filePath = context.Request["filePath"];
            string fileName = context.Request["fileName"];
            ImageUpload clsUp = new ImageUpload();
            string result=clsUp.UpLoadFile(postedFile, filePath, fileName);

            context.Response.Write("{\"Success\":\"" + result + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"", "").Replace("'", "") + "\"}");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}