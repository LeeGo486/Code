<%@ page language="C#" autoeventwireup="true" inherits="help_help_show, App_Web_help_show.aspx.87a0902e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>帮助信息</title>
     <link  href="../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <div  style="padding-left:10px">
     <table   width="98%" class="tbsh">
     <tr>
     <td align="center"><h3><strong><asp:Label ID="LblTitle" runat="server" Font-Names="楷体"></asp:Label></strong></h3></td>
     <td width="35px"><a href="#" onclick="window.history.go(-1);" style="color:#014F8A"><img  src="../icon/go3.gif" border="0"/>返回</a></td>
     </tr>
     </table>
        <br />
       <div  style="padding:20px 20px;" >
        <asp:Label ID="LblDetail" runat="server" Text=""></asp:Label>
        </div>
        </div>
    </form>
</body>
</html>
