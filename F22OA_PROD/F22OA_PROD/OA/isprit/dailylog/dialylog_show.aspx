<%@ page language="C#" autoeventwireup="true" inherits="isprit_dailylog_dialylog_show, App_Web_dialylog_show.aspx.d55211a1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>dialylog_show</title>
    <LINK href="../../css/project.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class=content><h2><strong><img src="../../icon/project/3.gif" >最近日志[<asp:Label ID="lbdate" runat="server" ForeColor="#FF8000"></asp:Label>]             <asp:Label id="lbclass" runat="server"></asp:Label></strong></h2></div>
				<p>
						<asp:Label id="lbcontent" runat="server"></asp:Label>
						
						</p>		<hr color=#ffffff size=1 noshade />
						<p>
						<a href="javascript:history.go(-1)">返回</a>
			</p>
    </div>
    </form>
</body>
</html>
