using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

/// <summary>
/// ImageUpload 的摘要说明
/// </summary>
public class ImageUpload
{
    /**/
    /// <summary>
    /// 上传文件名称
    /// </summary>
    public string FileName { get; set; }

    /**/
    /// <summary>
    /// 上传文件路径
    /// </summary>
    public string FilePath { get; set; }

    /**/
    /// <summary>
    /// 文件扩展名
    /// </summary>
    public string FileExtension { get; set; }

    public string UpLoadFile(HttpPostedFile inputFile, string filePath, string myfileName)
    {
        if (string.IsNullOrEmpty(filePath))
        {
            throw new ApplicationException("路径不能为空");
        }
        if (string.IsNullOrEmpty(myfileName))
        {
            throw new ApplicationException("文件名不能为空");
        }
        FileUpLoad fp = new FileUpLoad();

        //建立上传对象
        HttpPostedFile postedFile = inputFile;

        FileName = System.IO.Path.GetFileName(postedFile.FileName);
        FileExtension = System.IO.Path.GetExtension(FileName).ToUpper();

        //如果格式都不符合则返回
        if (!".JPG".Equals(FileExtension) && !".JPEG".Equals(FileExtension) && !".PNG".Equals(FileExtension) )
        {
            throw new ApplicationException("上传图片格式正确，请选择jpg,png格式的图片");
        }
        if (postedFile.ContentLength > 1024 * 1024 * 20)
        {
            throw new ApplicationException("最大只能上传20M文件");
        }

        if (myfileName != string.Empty)
        {
            FileName = myfileName+FileExtension;
        }

        string phyPath = HttpContext.Current.Server.MapPath("upload");

        //判断路径是否存在,若不存在则创建路径
        DirectoryInfo upDir = new DirectoryInfo(phyPath);
        if (!upDir.Exists)
        {
            upDir.Create();
        }

        try
        {
            string tempPath = Path.Combine(phyPath, filePath);
            string originalImagePath = Path.Combine(tempPath, FileName);
            string thumbnailPath = Path.Combine(tempPath,"thumbnail_" + FileName);
            //保存源文件
            postedFile.SaveAs(originalImagePath);

            ImageHelper.MakeThumbnail(originalImagePath, thumbnailPath,80,80,"W");
        }
        catch
        {
            throw new ApplicationException("上传失败!");
        }
        return "/upload/" + filePath + "/thumbnail_" + FileName;
    }
}