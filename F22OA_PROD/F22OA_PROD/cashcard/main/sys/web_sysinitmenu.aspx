<%@ page language="C#" masterpagefile="~/cashcard/main/sys/SysMaster.master" autoeventwireup="true" inherits="web_sysinitmenu, App_Web_web_sysinitmenu.aspx.9597e00c" title="系统初始化" %>

<%@ Register Assembly="Infragistics2.WebUI.Misc.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<div style="text-align: center"> 
    <igmisc:webgroupbox id="WebGroupBox1" runat="server" height="264px" text="请选择要初始化的项目：" ><Template>
<BR /><igmisc:WebPanel style="TEXT-ALIGN: left" id="WebPanel1" runat="server" Height="34px">
<Header Text="警告"></Header>
<Template>
此功能的作用是为了自动增加系统菜单而设置的。所以只能在系统首次使用系统时使用！
</Template>
</igmisc:WebPanel><BR /><BR />
<TABLE >
<TBODY>
<TR>
<TD style="WIDTH: 100px"></TD>
<TD style="WIDTH: 100px" align=left>
    <asp:CheckBox id="CheckBox_Card" runat="server" Width="108px" Text="充值卡系统"></asp:CheckBox></TD>
<TD style="WIDTH: 100px"></TD>
</TR>
<TR>
<TD style="WIDTH: 100px"></TD>
<TD style="WIDTH: 100px" align=left>
<asp:CheckBox id="CheckBox_sys" runat="server" Width="108px" Text="主系统"></asp:CheckBox>
</TD><TD style="WIDTH: 100px"></TD>
</TR>

<TR>
<TD style="WIDTH: 100px"></TD>
<TD style="WIDTH: 100px" align=left></TD>
<TD style="WIDTH: 100px"></TD>
</TR></TBODY></TABLE><BR />
<asp:Label id="Label1" runat="server" Width="148px" ForeColor="Red"></asp:Label> 
</Template>
</igmisc:webgroupbox>
    <br />
    <asp:Button ID="bt_ok" runat="server" CssClass="btSubmit" OnClick="bt_ok_Click" Text="确定" />
    <!--<asp:Button ID="bt_close" runat="server" CssClass="btSubmit" Text="取消" />-->
</div>
</asp:Content>

