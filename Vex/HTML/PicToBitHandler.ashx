<%@ WebHandler Language="C#" Class="PicToBitHandler" %>

using System;
using System.Web;
using System.Text.RegularExpressions;
using System.IO;

public class PicToBitHandler : IHttpHandler {

    private string strPicPath = "";//文件路径

    #region 处理上传文件
    /// <summary>
    /// 1:文件格式不正确;
    /// 2:文件大小不正确;
    /// 3:文件名称：上传成功;
    /// </summary>
    /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            strPicPath = context.Server.MapPath("/file/temp");
            try
            {
                string result = "3";
                string picType = context.Request.QueryString["fileType"];
                
                //获取上传文件类型
                if (picType == "file") {
                    result = UploadFile(context);   //文件上传
                }
                else if (picType == "img") {
                    result = UploadImg(context);    //图片上传
                };
                context.Response.Write(result);
                
            }
            catch (Exception)
            {
                context.Response.Write("3");    //文件上传失败
                throw;
            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
    #endregion

    #region UploadFile
        private string UploadFile(HttpContext context) {
            return "3";
        }
    #endregion

    #region UploagImg
        private string UploadImg(HttpContext context) {
            int count = context.Request.Files.Count;

            if (count > 0) {
                HttpPostedFile hpf = context.Request.Files[0];
                if (hpf != null) {
                    string fileExt = Path.GetExtension(hpf.FileName).ToLower();
                    //只能上传图片，过滤不可上传得文件类型
                    string fileFilt = ".gif|.jpg|.png|.jpeg|.bmp";

                    if (fileFilt.IndexOf(fileExt) <= -1) {
                        return "1";
                    };
                    
                    //判断文件类型
                    int length = hpf.ContentLength;
                    if (length > 204800) {
                        return "2";
                    };
                    
                    //转换文件

                    Byte[] picBit = setPhotoByte(hpf.FileName);
                    
                    //bit 转换成 string
                    return System.Text.Encoding.Default.GetString (picBit);
                };
            };
            return "3";
        }
    #endregion

    #region 将传入的图片转换成二进制代码
    /// <summary>
    /// 将传入的图片转换成二进制代码
    /// </summary>
    /// <returns></returns> 
    private Byte[] setPhotoByte(string photoPath)
    {
        FileStream file;
        if (photoPath != null)
        {
            string str = photoPath;//保存传入的路径
            //将传入路径下的图片以文件方式打开
            file = new FileStream(str, FileMode.Open, FileAccess.Read);//以只读方式打开传入路劲下的图片
            Byte[] byteSQLData = new byte[file.Length];
            file.Read(byteSQLData, 0, byteSQLData.Length);//完整的将文件中的数据读入到创建的byte数据中


            file.Close();
            return byteSQLData;
        }
        return null;
    }
    #endregion 
    public bool IsReusable {
        get {
            return false;
        }
    }

}