<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teset.aspx.cs" Inherits="EPReper.Web.teset" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <meta charset="utf-8" content="" />
    <link href="kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
        <link href="kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="kindediter/themes/default/default.css" />
        <link rel="stylesheet" href="kindediter/plugins/code/prettify.css" />
        <script charset="utf-8" src="kindediter/kindeditor.js" type="text/javascript"></script>
        <script charset="utf-8" src="kindediter/lang/zh_CN.js" type="text/javascript"></script>
        <script charset="utf-8" src="kindediter/plugins/code/prettify.js" type="text/javascript"></script>
        <script type="text/javascript">
            KindEditor.ready(function (K) {
                var editor1 = K.create('#content1', {
                    cssPath: 'kindediter/plugins/code/prettify.css',
                    uploadJson: 'kindediter/asp.net/upload_json.ashx',
                    fileManagerJson: 'kindediter/asp.net/file_manager_json.ashx',
                    allowFileManager: true,
                    afterCreate: function () {
                        var self = this;
                        K.ctrl(document, 13, function () {
                            self.sync();
                        });
                        K.ctrl(self.edit.doc, 13, function () {
                            self.sync();
                        });
                    }
                });
                prettyPrint();
            });
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <label style="font-size: x-large;">
            文章标题</label><input type="text" title="文章标题" style="width: 700px; height: 30px;" />
        <hr style="width: 700px; border-left: 0;" />
        <textarea id="content1" cols="100" rows="8" style="width: 700px; height: 200px; visibility: hidden;" runat="server"></textarea>
        <br />
        <asp:Button ID="Button1" runat="server" Text="提交内容" OnClick="GetValue"/>
    </div>
    </form>
</body>
</html>
