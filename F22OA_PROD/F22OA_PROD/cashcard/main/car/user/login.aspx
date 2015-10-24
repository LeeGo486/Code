<%@ page language="C#" autoeventwireup="true" inherits="car_user_login, App_Web_login.aspx.d716d88e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table style="width: 273px; height: 50px">
                    <tr>
                        <td style="width: 1px; text-align: left">
                            <asp:Label ID="Label1" runat="server" Text="卡号：" Width="56px"></asp:Label></td>
                        <td style="width: 100px; text-align: left">
                            &nbsp;<asp:TextBox ID="txtcardid" runat="server" Width="139px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcardid"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 1px; text-align: right">
                            <asp:Label ID="Label2" runat="server" Text="密码：" Width="50px"></asp:Label></td>
                        <td style="width: 100px; text-align: left">
                            &nbsp;<asp:TextBox ID="txtpsw" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpsw"
                                ErrorMessage="*"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td style="width: 1px">
                        </td>
                        <td style="width: 100px; text-align: left">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="登陆" Width="63px" /></td>
                    </tr>
                    <tr>
                        <td style="width: 1px">
                        </td>
                        <td style="width: 100px; text-align: left">
                            <asp:Label ID="lbtip" runat="server"></asp:Label></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
