<%@ page language="C#" autoeventwireup="true" inherits="info, App_Web_info.aspx.f3086b61" %>

<%@ Register Src="usercontrol/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="usercontrol/bottom.ascx" TagName="bottom" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>信息提示</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
     <table width="780" height="142" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
        <uc1:header ID="Header1" runat="server" />
        &nbsp;</td>
  </tr>
  <tr>
    <td height="116"><table width="100%" height="95" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="3">
            <asp:Label ID="lbinfo" runat="server" Font-Bold="True" Font-Names="宋体" Font-Size="16pt"
                ForeColor="Red" Height="46px" Width="100%"></asp:Label>&nbsp;</td>
        </tr>
      <tr>
        <td width="124">&nbsp;</td>
        <td width="271">&nbsp;</td>
        <td style="width: 105px">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td style="width: 105px">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td style="width: 105px">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td>
        <uc2:bottom ID="Bottom1" runat="server" />
        &nbsp;</td>
  </tr>
</table>
     </div>
    </form>
</body>
</html>
