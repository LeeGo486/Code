<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_webcar_crcard, App_Web_webcar_crcard.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 401px;
                height: 179px">
                <tr>
                    <td bgcolor="#99cccc" colspan="2" style="height: 35px; text-align: left">
                        <span style="font-size: 12pt; color: #ff0000">购物卡注册 <span style="font-size: 9pt;
                            color: #ffff33">填写卡信息</span></span></td>
                </tr>
                <tr>
                    <td bgcolor="#ccffcc" style="width: 79px; text-align: left">
                        卡名称：</td>
                    <td bgcolor="#ccffcc" style="width: 323px; text-align: left">
                        &nbsp;<asp:TextBox ID="txtname" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVname" runat="server" ControlToValidate="txtname"
                            ErrorMessage="请输入卡名称" SetFocusOnError="True">*</asp:RequiredFieldValidator>（如：贵宾卡）</td>
                </tr>
                <tr>
                    <td bgcolor="#ccffcc" style="width: 79px; text-align: left">
                        &nbsp;卡号前缀：</td>
                    <td bgcolor="#ccffcc" style="width: 323px; text-align: left">
                        &nbsp;<asp:TextBox ID="txtform" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVform" runat="server" ControlToValidate="txtform"
                            ErrorMessage="请输入卡号前缀" SetFocusOnError="True">*</asp:RequiredFieldValidator>（如：ABC）</td>
                </tr>
                <tr>
                    <td bgcolor="#ccffcc" style="width: 79px; text-align: left">
                        &nbsp;起始号：</td>
                    <td bgcolor="#ccffcc" style="width: 323px; text-align: left">
                        &nbsp;<asp:TextBox ID="txtstart" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVtxtstart" runat="server" ControlToValidate="txtstart"
                            ErrorMessage="请输入起始号" SetFocusOnError="True" Width="6px">*</asp:RequiredFieldValidator>（如：00001）</td>
                </tr>
                <tr>
                    <td bgcolor="#ccffcc" style="width: 79px; height: 31px; text-align: left">
                        &nbsp;生成数量：</td>
                    <td bgcolor="#ccffcc" style="width: 323px; height: 31px; text-align: left">
                        &nbsp;<asp:TextBox ID="txtnum" runat="server">1</asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtnum"
                            ErrorMessage="数量为正整数" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="1"></asp:CompareValidator>
                        （如：30）</td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 47px">
                        &nbsp;<asp:Button ID="btnreg" runat="server" Height="30px" 
                            Text="完成" Width="81px" />&nbsp; &nbsp;
                        <asp:Button ID="btnclose" runat="server" Height="31px" Text="关闭" Width="82px" /></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

