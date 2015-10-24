<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardLoseUnchain, App_Web_cardloseunchain.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <table cellpadding=6  cellspacing=10>
            
            <tr height=40px>
                <td colspan=2 align=center>
                    <asp:Label ID="lblTitle" runat="server" Text="挂失解挂" Font-Bold=true Font-Size=Medium></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td align=right style=" height: 28px;">
                    <asp:Label ID="Label2" runat="server" Text="卡号："></asp:Label>
                </td>
                <td align=left style=" height: 28px;">
                    <asp:TextBox ID="txtCardID" runat="server" Enabled=False BorderStyle="Dotted"></asp:TextBox>
                </td>
            </tr>
            
            <tr>
                <td  align=right style="height: 29px">
                    <asp:RadioButton ID="RadioButton1" runat="server" Checked="True" GroupName="grpidepw"
                        Text="证件号码" AutoPostBack="True" OnCheckedChanged="RadioButton1_CheckedChanged" />
                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="grpidepw" Text="密码" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged" /></td>
                <td style="height: 29px">
                     <asp:TextBox ID="txtIdentity" runat="server"></asp:TextBox><font  style="color: #ff3333">*</font>
                        <asp:Button ID="btnCheck" runat="server" Text="验证" OnClick="btnCheck_Click" Width="62px" />
                        <asp:Label ID="lblappearmsg" runat="server" ForeColor="Red"></asp:Label>&nbsp;
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtIdentity"
                            Display="Dynamic" ErrorMessage="只能是数字！" ValidationExpression="^\d*"></asp:RegularExpressionValidator>--%>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtIdentity"
                            Display="Dynamic" ErrorMessage="证件号或密码无效！" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan=2 align=center style="height: 28px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp;
                    <asp:Button ID="btnLoseUnchain" runat="server" Text="挂失" OnClick="btnLoseUnchain_Click" Width="70px" />
                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:HyperLink ID=hylReturn runat=server NavigateUrl='cardLose.aspx?aspxid=CA1130&aspxname=挂失解挂' Text="返回"></asp:HyperLink>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <asp:TextBox ID="TextBox1" runat="server" BackColor="#ECF3F6" BorderStyle="None"
                        ForeColor="#ECF3F6" TextMode="Password" Width="43px"></asp:TextBox>
                    <asp:TextBox ID="TextBox2" runat="server" BackColor="#ECF3F6" BorderStyle="None"
                        ForeColor="#ECF3F6" Width="58px"></asp:TextBox><%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>--%></td>
                    
                    
            </tr>
            <tr>
                <td colspan=2 style="height: 23px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <asp:Label ID="lblMessage" runat="server" Font-Size=9pt Visible=False ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
</asp:Content>

