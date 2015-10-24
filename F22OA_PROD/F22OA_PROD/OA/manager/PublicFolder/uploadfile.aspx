<%@ page language="C#" autoeventwireup="true" inherits="manager_PublicFolder_uploadfile, App_Web_uploadfile.aspx.f55e7b9c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>多文件上传</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
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
    <DIV  class=content><h2><strong>
				<asp:Label Runat="server" ID="MyTitle"></asp:Label></strong></h2></DIV>
			<DIV align="center"><FONT face="宋体">请选择文件归类:</FONT>
				<asp:DropDownList id="ddlfolder" runat="server" Width="136px"></asp:DropDownList></DIV>
			<P id="MyFile" align="center"><INPUT type="file" size="50" NAME="File" runat="server"></P>
			<P align="center">
				<input type="button" value="增加(Add)" onclick="addFile()">
				<asp:Button Runat="server" Text="上传" ID="Upload" Width="74px" OnClick="Upload_Click"></asp:Button>
				<input onclick="this.form.reset()" type="button" value="重置(R)">
			</P>
			<CENTER></CENTER>
			<P align="center">
				<asp:Label id="strStatus" runat="server" Font-Names="宋体" Font-Bold="True" Font-Size="9pt" Width="500px"
					BorderStyle="None" BorderColor="White"></asp:Label>
			</P>
			<P align="center"><A  href="javascript:history.go(-1)">返回</A></P>
    </div>
    </form>
</body>
</html>
