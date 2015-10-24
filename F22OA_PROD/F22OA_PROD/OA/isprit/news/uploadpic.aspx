<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_uploadpic, App_Web_uploadpic.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
    <title>多文件上传</title>
		<script language="JavaScript" type="text/javascript">
    function addFile()
    {
    	var str = '<INPUT type="file" size="50" NAME="File"  runat="server" >'
    	document.getElementById('MyFile').insertAdjacentHTML("beforeEnd",str)
    }
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div align="center">
				<asp:Label Runat="server" ID="MyTitle"></asp:Label>
				<P id="MyFile"><INPUT type="file" size="50" NAME="File" runat="server"></P>
				<P>
					<input type="button" value="增加(Add)" onclick="addFile()">
					<asp:Button Runat="server" Text="上传" ID="Upload" OnClick="Upload_Click"></asp:Button>
					<input onclick="this.form.reset()" type="button" value="重置(ReSet)">
				</P>
				<CENTER></CENTER>
				<P align="center">
					<asp:Label id="strStatus" runat="server" Font-Names="宋体" Font-Bold="True" Font-Size="9pt" Width="500px"
						BorderStyle="None" BorderColor="White"></asp:Label>
				</P>
				<p align="center">
					<a href="allpic.aspx" target="_self">查看所有图片</a>
				</p>
			</div>
    </div>
    </form>
</body>
</html>
