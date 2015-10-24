<%@ page language="C#" autoeventwireup="true" inherits="car_cardLoseUnchain1, App_Web_cardloseunchain1.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>挂失解挂</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" type="text/css" rel="stylesheet"/>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding=0  cellspacing=0>
            
            <tr height=40px>
                <td colspan=2 align=center>
                    <asp:Label ID="lblTitle" runat="server" Text="挂失解挂" Font-Bold=true Font-Size=Medium></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="卡号："></asp:Label>
                </td>
                <td align=left style="width: 254px">
                    <asp:TextBox ID="txtCardID" runat="server" Enabled=true BackColor="White" BorderStyle="None"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="请输入证件号码："></asp:Label></td>
                <td align=left><asp:TextBox ID="txtIdentity" runat="server"></asp:TextBox><font  style="color: #ff3333">*</font>
                    <asp:Button ID="btnCheck" runat="server" Text="验证" OnClick="btnCheck_Click" Width="62px" />
                <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="证件号码不能为空！" ControlToValidate="txtIdentity" Display="Dynamic"></asp:RequiredFieldValidator>
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtIdentity"
                        Display="Dynamic" ErrorMessage="只能是数字！" ValidationExpression="^\d*"></asp:RegularExpressionValidator>--%>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtIdentity"
                        Display="Dynamic" ErrorMessage="证件号无效！" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></td>
            </tr>
            <tr>
                <td colspan=2 style="height: 26px"><asp:Button ID="btnLoseUnchain" runat="server" Text="挂失" OnClick="btnLoseUnchain_Click" Width="70px" />
                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:HyperLink ID=hylReturn runat=server NavigateUrl='cardLose.aspx?aspxid=CA1130&aspxname=挂失解挂' Text="返回"></asp:HyperLink>
                    <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>--%>
                </td>
                    
                    
            </tr>
            <tr>
                <td colspan=2>
                    <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Size=medium Visible=false></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
