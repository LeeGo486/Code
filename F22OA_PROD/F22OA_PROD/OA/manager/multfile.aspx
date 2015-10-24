<%@ page language="C#" autoeventwireup="true" inherits="manager_multfile, App_Web_multfile.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>多文件上传</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
			<script language="JavaScript" type="text/javascript">
    function addFile()
    {
    	var str = '<INPUT type="file" size="50" NAME="File"  runat="server" >'
    	document.getElementById('MyFile').insertAdjacentHTML("beforeEnd",str)
    }
			</script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div> 
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <div align="center">
       
				<asp:Label Runat="server" ID="MyTitle"></asp:Label>
				<P id="MyFile"><INPUT type="file" size="50" NAME="File" runat="server"></P>
				<P>
					<input type="button" value="增加(Add)" onclick="addFile()" class="btn">
					<asp:Button Runat="server" Text="上传" ID="Upload" OnClick="Upload_Click" CssClass="btn"></asp:Button>
					<input onclick="this.form.reset()" type="button" value="重置(ReSet)" class="btn">
				</P>
				<CENTER></CENTER>
				<P align="center">
					<asp:Label id="strStatus" runat="server" Font-Names="宋体" Font-Bold="True" Font-Size="9pt" Width="500px"
						BorderStyle="None" BorderColor="White"></asp:Label>
				</P>
				<p align="center">
					<a href="showfile.aspx" target="_self">查看我所上传的文件</a>
				</p>
				<P align="center"><A  href="javascript:history.go(-1)">返回</A></P>
			</div>
    </div>
    </form>
</body>
</html>
