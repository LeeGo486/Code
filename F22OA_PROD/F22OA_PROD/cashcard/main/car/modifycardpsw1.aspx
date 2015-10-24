<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_modifycardpsw1, App_Web_modifycardpsw1.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<br />
<table  border=1 width=100% align=center cellpadding=0 cellspacing=0 bordercolor="#cccccc"  bordercolordark="#ffffff" >
     <tr height=40><td colspan=2 align=center><font color=red size=3>修改卡密码</font></td></tr>
    <tr>
        <td  align=right width=20%>卡号：</td>
        <td style="color: #ff3333; width: 372px;">
            <asp:TextBox ID="txtCardid" runat="server" OnTextChanged="txtCardid_TextChanged" Width="350px"></asp:TextBox>
            *<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCardid"
                Display="Dynamic" ErrorMessage="请输入卡号！"></asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtCardid"
                Display="Dynamic" ErrorMessage="卡号无效！" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></td>
        
    </tr>
    <tr>
        <td  align=right>
            旧密码：</td>
        <td style="color: #ff3333; width: 372px;">
            <asp:TextBox ID="txtOldPass" runat="server" TextMode="Password" Width="350px"></asp:TextBox>
            *<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtOldPass"
                Display="Dynamic" ErrorMessage="请输入旧密码！"></asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtOldPass"
                Display="Dynamic" ErrorMessage="旧密码不正确，请重新输入！" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator></td>
               
    </tr>
    <tr>
        <td  align=right>
            新密码：</td>
        <td style="color: #ff3333; width: 372px;">
            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" Width="350px"></asp:TextBox>
            *<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNewPass"
                Display="Dynamic" ErrorMessage="请输入新密码！"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtNewPass"
                ErrorMessage="*请输入数字" ForeColor="Blue" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator></td>
        
    </tr>
    <tr>
        <td  align=right>
            确认新密码：</td>
        <td style="color: #ff3333; width: 372px;">
            <asp:TextBox ID="txtReNewPass" runat="server" TextMode="Password" Width="350px"></asp:TextBox>
            *<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtReNewPass"
                Display="Dynamic" ErrorMessage="两次密码输入不相同，请重新输入！" ControlToCompare="txtNewPass"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtReNewPass"
                ErrorMessage="请再次输入新密码！" Display="Dynamic"></asp:RequiredFieldValidator></td>
        
    </tr>
    <tr>
        <td colspan=2 align=center height=30>
            <asp:Label ID="lblmessage" runat="server" Text="Label" Visible=False  ForeColor="red" Width="238px"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </td>
    </tr>
    <tr>
        <td align=center colspan=2>
            <asp:Button ID="btnOk" runat="server" Text="确定" Width=70px OnClick="btnOk_Click" />
           
        </td>
         
    </tr>
</table>
</asp:Content>

