<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="EPReper.Web.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312" />
    <title></title>
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <table border="0" cellpadding="0" cellspacing="0" style="background-image: url('/Images/login.jpg');
            width: 900px; height: 550px;">
            <tr style="width: 900px; height: 285px">
                <td colspan="3" width="100%">
                </td>
            </tr>
            <tr style="height: 20px">
                <td width="45%">
                </td>
                <td valign="middle" align="left" colspan="2" style="height: 20px">
                    <asp:TextBox ID="TxtName" runat="server" Width="129px"></asp:TextBox>
                    <script type="text/javascript">
                        document.getElementById('TxtName').focus();
                    </script>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 10px">
                </td>
            </tr>
            <tr style="height: 20px">
                <td width="45%">
                </td>
                <td align="left" valign="middle" width="15%">
                    <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password" Width="129px" MaxLength="18"></asp:TextBox>
                </td>
                <td width="40%" align="left" valign="middle">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../Images/signin.jpg"
                        OnClick="login_Click" Style="margin-left: 15px" />
                </td>
            </tr>
            <tr style="height: 200px">
                <td align="left" colspan="3" style="width: 100%">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label><br />
                    <asp:HiddenField ID="HidUrl" runat="server" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%--<label>
								<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="../Images/reset.gif" OnClientClick="javascript:window.close();" /></label>--%>
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>
