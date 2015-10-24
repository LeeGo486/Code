<%@ page language="C#" autoeventwireup="true" inherits="car_webcar_delall, App_Web_webcar_delall.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body bgcolor=#ebf3f6>
    <form id="form1" runat="server">
    <div>
        <table align=center width=80%>
            <tr><td style="width: 490px">&nbsp;</td></tr>
               <tr>
                <td align=left style="width: 490px">
                    <asp:Label ID="Label1" runat="server" Font-Size="Small" ForeColor="Red" Text="警告：你将删除所有充值卡的数据"></asp:Label>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    </td>
            </tr>
            
            <tr>
                <td align=center style="width: 490px"><asp:Button ID="btnInit" runat="server" Text="开始初始化" OnClick="btnInit_Click" /></td>
            </tr>
            <tr>
                <td style="height: 21px; width: 490px;" align=center>
                    <asp:Label ID="lblmessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
        
    </div>
    </form>
</body>
</html>
