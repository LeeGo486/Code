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
        //��ʼ��һЩ����    
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

        //�趨Table�е����ݣ��ȸ㶨��һ��    
        tr = new TableRow();

        td = new TableCell();
        td.Controls.Add(new LiteralControl("�ļ���"));
        tr.Cells.Add(td);

        td = new TableCell();
        td.Controls.Add(new LiteralControl("�ļ���С"));
        tr.Cells.Add(td);

        td = new TableCell();
        td.Controls.Add(new LiteralControl("����ʱ��"));
        tr.Cells.Add(td);

        tbDirInfo.Rows.Add(tr);

        string FileName;         //�ļ�����    
        string FileExt;           //�ļ���չ��
        string FilePic;           //ͼ���ļ�����    
        long FileSize;             //�ļ���С    
        DateTime FileModify;       //������ʱ��    

        DirectoryInfo dir = new DirectoryInfo(strCurrentDir);
        foreach (FileSystemInfo fsi in dir.GetFileSystemInfos())
        {
            FilePic = "";
            FileName = "";
            FileSize = 0;
            FileExt = "";

            if (fsi is FileInfo)
            {
                //��ʾ��ǰfsi���ļ�    
                fi = (FileInfo)fsi;
                FileName = fi.Name;
                FileExt = fi.Extension;
                FileSize = fi.Length;
                FileModify = fi.LastWriteTime;

                //ͨ����չ����ȷ����ʾͼƬ������    
                switch (FileExt)
                {
                    case ".jpg":
                        FilePic = "jpgͼ��";
                        break;
                    case ".gif":
                        FilePic = "gifͼ��";
                        break;
                    case ".tiff":
                        FilePic = "tiffͼ��";
                        break;
                    case ".bmp":
                        FilePic = "bmpͼ��";
                        break;
                    default:
                        FilePic = "�ļ�";
                        break;
                }
            }
            else
            {
                //��ǰΪĿ¼    
                di = (DirectoryInfo)fsi;
                FileName = di.Name;
                FileModify = di.LastWriteTime;
                FilePic = "Ŀ¼";
            }
            //�齨�µ���    
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
    ��ѡ�����Ŀ¼��<asp:TextBox ID="tbCurrentDir" runat="server" /><br>
    ��ǰĿ¼Ϊ��<asp:Label ID="lblCurrentDir" runat="server" /><br>
    <asp:Table ID="tbDirInfo" Font-Size="9pt" runat="server" />
    <br>
    </form>
</body>
</html>
