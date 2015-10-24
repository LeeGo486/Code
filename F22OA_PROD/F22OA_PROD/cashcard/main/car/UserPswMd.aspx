<%@ page language="C#" autoeventwireup="true" inherits="UserPswRecover, App_Web_userpswmd.aspx.f3086b61" %>

<%@ Register Src="usercontrol/bottom.ascx" TagName="bottom" TagPrefix="uc2" %>

<%@ Register Src="usercontrol/header.ascx" TagName="header" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>修改密码</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="780" height="142" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;<uc1:header ID="Header1" runat="server" />
    </td>
  </tr>
  <tr>
    <td height="116" bgcolor="#cccc99">
    <table border="0" align="center" cellpadding="0" cellspacing="0" width ="492px"; height="7px">
      <tr>
        <td colspan="3"  bgcolor="#99cccc" style="height: 41px">&nbsp;<span style="color: #ff0000; font-size: 14pt;">购物卡密码修改</span></td>
        </tr>
      <tr>
        <td style="text-align: left; height: 26px; width: 86px;" bgcolor="#ccffcc">&nbsp;旧密码：</td>
        <td bgcolor="#ccffcc" style="height: 26px">&nbsp;<asp:TextBox ID="txtoldpsw" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtoldpsw"
                ErrorMessage="卡号不能为空">*</asp:RequiredFieldValidator></td>
      </tr>
      <tr>
        <td style="text-align: left; height: 26px; width: 86px;" bgcolor="#ccffcc">&nbsp;新密码：</td>
        <td  bgcolor="#ccffcc" style="height: 26px">&nbsp;<asp:TextBox ID="txtnewpsw" runat="server" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RFVpsw" runat="server" ControlToValidate="txtnewpsw"
                ErrorMessage="请输入新密码" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
      </tr>
        <tr>
            <td style="text-align: left; width: 86px;" bgcolor="#ccffcc">
                确认密码：</td>
            <td bgcolor="#ccffcc">
                &nbsp;<asp:TextBox ID="txtnewpsw2" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewpsw2"
                    ErrorMessage="新密码不能为空">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CVpsw" runat="server" ControlToCompare="txtnewpsw" ControlToValidate="txtnewpsw2"
                    ErrorMessage="两次密码输入不一致" SetFocusOnError="True"></asp:CompareValidator></td>
        </tr>
      <tr>
        <td colspan="3" style="text-align: center; width: 378px; height: 47px;" align="left">
            &nbsp;<asp:Button ID="btnmd" runat="server" OnClick="btnmd_Click" Text="修改密码" Width="135px" Height="47px" /></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;<uc2:bottom ID="Bottom1" runat="server" />
    </td>
  </tr>
</table>
    
    </div>
    </form>
</body>
</html>
