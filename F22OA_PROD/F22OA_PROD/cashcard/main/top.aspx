<%@ page language="C#" autoeventwireup="true" inherits="top, App_Web_top.aspx.b10cd3ef" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
<style type="text/css">
body{
padding-bottom:0px;
padding-left:0px;
padding-right:0px;
padding-top:0px;
margin-bottom:0px;
margin-left:0px;
margin-right:0px;
margin-top:0px;
background:url(icon/header_bg.gif) repeat-x;
}
</style>
</head>
<body>
<form id="form1" runat="server">
<div style="background:url(icon/ZhxLogo_vista.gif) no-repeat left top;height:80px;margin-left:20px;">
<div style="text-align: right;margin-right:30px;color:white;font-size:12px;padding-top:10px;">
欢迎您！<asp:Label ID="Label2" runat="server" Text="" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
（编号：<asp:Label ID="Label1" runat="server" Text="" ></asp:Label>）&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="lbexit" runat="server" ForeColor="White" OnClick="lbexit_Click">退出系统</asp:LinkButton>
</div>
</div>
</form>
</body>
</html>