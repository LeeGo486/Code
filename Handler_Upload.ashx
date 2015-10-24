<%@ WebHandler Language="C#" Class="UploadHandler" %>
 
using System;
using System.Data;
using System.Web;
using System.Threading;
using System.IO;
using HZY.COM.Common;

public class UploadHandler : IHttpHandler
{

    DataTable dt = new DataTable();

    public void ProcessRequest(HttpContext context)
    {
        dt.Columns.Add("result");
        dt.Columns.Add("message");

        if (context.Request.Files.Count == 0)
        {
            dt.Rows.Add(new object[] { "False", "文件过大或提交的信息有误!" });
        }
        else
        {

            string strFileName = Path.GetFileName(context.Request.Files[0].FileName);
            string strExtension = Path.GetExtension(context.Request.Files[0].FileName).ToLower();

            string strFilePath = context.Request["filepath"];
            if (string.IsNullOrEmpty(strFilePath))
            {
                dt.Rows.Add(new object[] { "False", "filepath不能为空" });
            }
            else
            {

                int fileSize = 1024 * 1024 * 4;
                HttpPostedFile postedFile = context.Request.Files[0];
                if (postedFile.ContentLength > fileSize)
                {
                    dt.Rows.Add(new object[] { "False", "最大只能上传4M文件" });
                }
                else
                {

                    strFilePath = "/" + strFilePath + "/" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + strFileName;
                    string strLocation = context.Server.MapPath("upload") + strFilePath;
                    context.Request.Files[0].SaveAs(strLocation);

                    if (context.Request["filepath"] == "HZY_mat")
                    {
                        CreateThumbnail(strLocation, 200, 200);
                    }
                    
                    //context.Response.ContentType = "text/plain";

                    dt.Rows.Add(new object[] { "True", "/upload" + strFilePath + "" });
                }
            }
        }
        string strJSON = HZY.COM.Common.JsonHelper.CreateJsonParameters(dt);
        context.Response.Write(strJSON);
        context.Response.End();

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public static string CreateThumbnail(string lcFilename, int lnWidth, int lnHeight)
    {
        string strFileNameNew = lcFilename.Substring(0, lcFilename.Length - 4) + "small" + lcFilename.Substring(lcFilename.Length - 4);

        System.Drawing.Bitmap bmpOut = null;
        try
        {
            System.Drawing.Bitmap loBMP = new System.Drawing.Bitmap(lcFilename);
            System.Drawing.Imaging.ImageFormat loFormat = loBMP.RawFormat;

            decimal lnRatio;
            int lnNewWidth = 0;
            int lnNewHeight = 0;

            //*** If the image is smaller than a thumbnail just return it
            if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)
            {
                loBMP.Save(strFileNameNew);
                return strFileNameNew;
            }
            if (loBMP.Width > loBMP.Height)
            {
                lnRatio = (decimal)lnWidth / loBMP.Width;
                lnNewWidth = lnWidth;
                decimal lnTemp = loBMP.Height * lnRatio;
                lnNewHeight = (int)lnTemp;
            }
            else
            {
                lnRatio = (decimal)lnHeight / loBMP.Height;
                lnNewHeight = lnHeight;
                decimal lnTemp = loBMP.Width * lnRatio;
                lnNewWidth = (int)lnTemp;
            }
            bmpOut = new System.Drawing.Bitmap(lnNewWidth, lnNewHeight);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmpOut);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.FillRectangle(System.Drawing.Brushes.White, 0, 0, lnNewWidth, lnNewHeight);
            g.DrawImage(loBMP, 0, 0, lnNewWidth, lnNewHeight);

            loBMP.Dispose();
        }
        catch(Exception ex)
        {
            throw ex;
        }

        bmpOut.Save(strFileNameNew);
        return strFileNameNew;
    }

}