using System.Web.UI.HtmlControls;
using System.Web;
using System;
using System.IO;


public class FileUpLoad
{
    public FileUpLoad()
    { 
    
    }
    /**/
    /// <summary>
    /// 上传文件名称
    /// </summary>
    public string FileName
    {
        get
        {
            return fileName;
        }
        set
        {
            fileName = value;
        }
    }
    private string fileName;

    /**/
    /// <summary>
    /// 上传文件路径
    /// </summary>
    public string FilePath
    {
        get
        {
            return filepath;
        }
        set
        {
            filepath = value;
        }
    }
    private string filepath;

    /**/
    /// <summary>
    /// 文件扩展名
    /// </summary>
    public string FileExtension
    {
        get
        {
            return fileExtension;
        }
        set
        {
            fileExtension = value;
        }
    }
    private string fileExtension;


    public FileUpLoad UpLoadFile(HtmlInputFile InputFile, string filePath, string myfileName, bool isRandom)
    {
        FileUpLoad fp = new FileUpLoad();
        string fileName, fileExtension;
        string saveName;

        //
        //建立上传对象
        //
        HttpPostedFile postedFile = InputFile.PostedFile;

        fileName = System.IO.Path.GetFileName(postedFile.FileName);
        fileExtension = System.IO.Path.GetExtension(fileName);

        //
        //根据类型确定文件格式
        //
        string format = "xlsx";

        //
        //如果格式都不符合则返回
        //
        if (format.IndexOf(fileExtension) == -1)
        {
            throw new ApplicationException("上传数据格式不合法");
        }

        //
        //根据日期和随机数生成随机的文件名
        //
        if (myfileName != string.Empty)
        {
            fileName = myfileName;
        }

        if (isRandom)
        {
            Random objRand = new Random();
            System.DateTime date = DateTime.Now;
            //生成随机文件名
            saveName = date.Year.ToString() + date.Month.ToString() + date.Day.ToString() + date.Hour.ToString() + date.Minute.ToString() + date.Second.ToString() + Convert.ToString(objRand.Next(99) * 97 + 100);
            fileName = saveName + fileExtension;
        }

        string phyPath = HttpContext.Current.Request.MapPath(filePath);

        //判断路径是否存在,若不存在则创建路径
        DirectoryInfo upDir = new DirectoryInfo(phyPath);
        if (!upDir.Exists)
        {
            upDir.Create();
        }

        //
        //保存文件
        //
        try
        {
            postedFile.SaveAs(phyPath + fileName);

            fp.FilePath = filePath + fileName;
            fp.FileExtension = fileExtension;
            fp.FileName = fileName;
        }
        catch
        {
            throw new ApplicationException("上传失败!");
        }

        //返回上传文件的信息
        return fp;
    }
}
