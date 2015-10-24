<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.index"
    ContentType="text/html" ResponseEncoding="gb2312" %>

<%@ Import Namespace="System.IO" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;   charset=gb2312" />
    <title></title>
</head>
<script language="c#" runat="server">    
    public void Page_Load(Object src, EventArgs e)
    {
        string strCurrentDir;
        //初始化一些数据    
        if (!Page.IsPostBack)
        {
            strCurrentDir = Server.MapPath(".");
            lblCurrentDir.Text = strCurrentDir;
            tbCurrentDir.Text = strCurrentDir;
        }
        else
        {
            strCurrentDir = tbCurrentDir.Text;
            tbCurrentDir.Text = strCurrentDir;
            lblCurrentDir.Text = strCurrentDir;
        }

        FileInfo fi;
        DirectoryInfo di;
        TableCell td;
        TableRow tr;

        //设定Table中的数据，先搞定第一行    
        tr = new TableRow();

        td = new TableCell();
        td.Controls.Add(new LiteralControl("文件名"));
        tr.Cells.Add(td);

        td = new TableCell();
        td.Controls.Add(new LiteralControl("文件大小"));
        tr.Cells.Add(td);

        td = new TableCell();
        td.Controls.Add(new LiteralControl("更新时间"));
        tr.Cells.Add(td);

        tbDirInfo.Rows.Add(tr);

        string FileName;         //文件名称    
        string FileExt;           //文件扩展名
        string FilePic;           //图像文件类型    
        long FileSize;             //文件大小    
        DateTime FileModify;       //最后更新时间    

        DirectoryInfo dir = new DirectoryInfo(strCurrentDir);
        foreach (FileSystemInfo fsi in dir.GetFileSystemInfos())
        {
            FilePic = "";
            FileName = "";
            FileSize = 0;
            FileExt = "";

            if (fsi is FileInfo)
            {
                //表示当前fsi是文件    
                fi = (FileInfo)fsi;
                FileName = fi.Name;
                FileExt = fi.Extension;
                FileSize = fi.Length;
                FileModify = fi.LastWriteTime;

                //通过扩展名来确定显示图片的类型    
                switch (FileExt)
                {
                    case ".jpg":
                        FilePic = "jpg图像";
                        break;
                    case ".gif":
                        FilePic = "gif图像";
                        break;
                    case ".tiff":
                        FilePic = "tiff图像";
                        break;
                    case ".bmp":
                        FilePic = "bmp图像";
                        break;
                    default:
                        FilePic = "文件";
                        break;
                }
            }
            else
            {
                //当前为目录    
                di = (DirectoryInfo)fsi;
                FileName = di.Name;
                FileModify = di.LastWriteTime;
                FilePic = "目录";
            }
            //组建新的行    
            tr = new TableRow();

            td = new TableCell();
            td.Controls.Add(new LiteralControl(FilePic + "&nbsp;" + FileName));
            tr.Cells.Add(td);

            td = new TableCell();
            td.Controls.Add(new LiteralControl(FileSize.ToString()));
            tr.Cells.Add(td);

            td = new TableCell();
            td.Controls.Add(new LiteralControl(FileModify.ToString()));
            tr.Cells.Add(td);

            tbDirInfo.Rows.Add(tr);
        }
    }    
</script>
<body>
    <form id="Form1" runat="server">
    请选择浏览目录：<asp:TextBox ID="tbCurrentDir" runat="server" /><br>
    当前目录为：<asp:Label ID="lblCurrentDir" runat="server" /><br>
    <asp:Table ID="tbDirInfo" Font-Size="9pt" runat="server" />
    <br>
    </form>
</body>
</html>
