<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="F23Web.Public.Upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>上传</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <script type="text/javascript" src="/Public/lib/jquery-1.4.2.min.js"></script>

    <style type="text/css">
        *
        {
            margin: 0;
            padding: 0;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            $("#<%=file1.ClientID %>").bind('change', function() {
                $(this).fadeOut("show");
                parent.uploading(document.getElementById("<%=file1.ClientID %>").value);
                $("#<%=frmUpload.ClientID %>").submit();
            });
        })
        
    </script>

</head>
<body>
    <form runat="server" id="frmUpload" method="post" enctype="multipart/form-data">
    <input type="file" runat="server" id="file1" style="width: 100%" />
    </form>
</body>
</html>
