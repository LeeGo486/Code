<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_show_one, App_Web_show_one.aspx.4c52363" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>日程提醒</title>
    		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        日程提醒:<asp:Image ID="img" runat="server" /><br />
        开始时间:<asp:Label ID="lbdate" runat="server"></asp:Label>结束日间:
        <asp:Label ID="lbdate2" runat="server"></asp:Label><br />
        日程内容:<asp:Label ID="lbcontent" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btOK" runat="server" Text="知道了" OnClick="Button1_Click" CssClass="btn" /></div>
    </form>
</body>
</html>
