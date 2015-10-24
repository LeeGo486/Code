using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Helper;
using EPManageWeb.Models;
using System.Text;


namespace EPManageWeb.Controllers
{
    public class UploadController : BaseController
    {
        [CookiesAuthorize]
        public ActionResult Index(string type)
        {
            UploadResult r = new UploadResult() { Success = false };

            FileType fileType = FileType.StylePic;
            if (Enum.TryParse<FileType>(type, out fileType))
            {
                String[] validExts = { ".jpg", ".gif", ".png", ".swf", ".avi", ".mpg", ".rar", ".zip", ".doc", ".docx", ".xls", ".xlsx" };
                if (Request.Files.Count > 0)
                {
                    try
                    {
                        HttpPostedFileBase file = Request.Files[0];
                        String ext = String.Empty;
                        if (file.FileName.LastIndexOf(".") > -1)
                            ext = file.FileName.Substring(file.FileName.LastIndexOf(@"."));
                        //if (!validExts.Contains(ext.ToLower()))
                        //{
                        //    StringBuilder sb = new StringBuilder();
                        //    Array.ForEach(validExts, t => sb.AppendFormat("{0},", t));
                        //    if (sb.Length > 0) sb.Remove(sb.Length - 1, 1);
                        //    throw new Exception("上传文件不合法，仅能上传图片、FLASH与视频文件，后缀名为：" + sb.ToString());
                        //}
                        String filename = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ext;
                        file.SaveAs(Server.MapPath("~/Upload/" + filename));
                        r.FileName = "/Upload/" + filename;

                        r.Success = true;
                    }
                    catch (Exception e)
                    {
                        r.ErrMsg = e.Message;
                        r.Success = false;
                    }
                    return new JsonResult() { Data = r, ContentType = "text/plain" };
                }
            }
            else
            {
                r.ErrMsg = "上传文件类型不合法，参数为" + type;
            }
            return new JsonResult() { Data = r, ContentType = "text/plain" };
        }

    }

    class UploadResult
    {
        public int Id { get; set; }
        public bool Success { get; set; }
        public String FileName { get; set; }
        public String ErrMsg { get; set; }
    }
}
