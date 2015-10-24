<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_getcardpsw1, App_Web_getcardpsw1.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
        <BR />
 <table  border=1 width=100% align=center cellpadding=0 cellspacing=0 bordercolor="#cccccc"  bordercolordark="#ffffff" >
    <tr height=40><td colspan=2 align=center><font color=red size=3>查询卡密码</font></td></tr>
    <tr>
        <td align=right width=30%>卡号：</td>
        <td><asp:TextBox id="txtcardid" runat="server"></asp:TextBox> </td>
    </tr>
    <tr height=20>
        <td align=right>密码：</td>
        <td><asp:Label id="lbpsw" runat="server" Text=""></asp:Label>&nbsp; </td>
    </tr>
    <tr height=40>
        <td colspan=2 align=center><asp:Button id="Button1" onclick="Button1_Click" runat="server" Width="60px" Text="查询"></asp:Button></td>
    </tr>
</table>
 
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

