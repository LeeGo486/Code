<%@ page language="C#" autoeventwireup="true" inherits="car_webcar_initmenu, App_Web_webcar_initmenu.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>充值卡菜单维护</title>
    <link href="../car/car_default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <br />
        <br />
        <br />
        <br />
        <table>
            <caption>
                初始化充值卡菜单</caption>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    密码：</td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Width="128px"></asp:Label></td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
        <br />
        <table style="width: 208px">
            <tr>
               
                <td style="width: 100px">
                    &nbsp;<asp:Button ID="Button1" runat="server" CssClass="btSubmit" OnClick="Button1_Click"
                        Text="确定" Width="95px" /></td>
                         <td style="width: 100px">
                    <asp:Button ID="Button2" runat="server" CssClass="btSubmit" Text="取消" UseSubmitBehavior="False"
                        Width="107px" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
