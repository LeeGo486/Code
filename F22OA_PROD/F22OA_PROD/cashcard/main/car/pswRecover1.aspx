<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="pswRecover1, App_Web_pswrecover1.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<asp:UpdatePanel id="UpdatePanel1" runat="server">
   <contenttemplate>
<TABLE height="100%" cellSpacing=0 cellPadding=0 width=500 align=center border=0><TBODY><TR><TD style="HEIGHT: 36px; TEXT-ALIGN: left" bgColor=#99cccc colSpan=2><SPAN style="FONT-SIZE: 14pt; COLOR: #ff0000">购物卡密码重置</SPAN></TD></TR><TR><TD style="HEIGHT: 36px; TEXT-ALIGN: left" bgColor=#ccffcc colSpan=2>卡号：<asp:TextBox id="txtcardid" runat="server" Width="107px"></asp:TextBox>&nbsp; <asp:CustomValidator id="CustomValidator1" runat="server" OnServerValidate="CustomValidator1_ServerValidate" ControlToValidate="txtcardid" SetFocusOnError="True" ErrorMessage="卡号无效"></asp:CustomValidator> <asp:Button id="btnnext" onclick="btnnext_Click" runat="server" Width="66px" Height="24px" Text="检索"></asp:Button></TD></TR></TBODY></TABLE>
</contenttemplate>    
</asp:UpdatePanel>

<asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>
<TABLE height=200 cellSpacing=0 cellPadding=0 width=500 align=center border=0><TBODY><TR><TD style="HEIGHT: 37px; TEXT-ALIGN: left" bgColor=#99cccc colSpan=2><SPAN style="FONT-SIZE: 14pt; COLOR: #ff0000">购物卡密码重置 <SPAN style="FONT-SIZE: 12pt; COLOR: #330099">密码随机生成八位数</SPAN></SPAN></TD></TR><TR><TD style="WIDTH: 88px; HEIGHT: 17px; TEXT-ALIGN: left" bgColor=#ccffcc>卡号：</TD><TD style="WIDTH: 295px; HEIGHT: 17px; TEXT-ALIGN: left" bgColor=#ccffcc><asp:Label id="lbcardid" runat="server"></asp:Label>&nbsp;</TD></TR><TR><TD style="WIDTH: 88px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;用户名：</TD><TD style="WIDTH: 295px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;<asp:Label id="lbname" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 88px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;接收号码：</TD><TD style="WIDTH: 295px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;<asp:Label id="lbmtelpsw" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 88px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;证件号：</TD><TD style="WIDTH: 295px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc><asp:Label id="lbidentity" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 88px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;地址：</TD><TD style="WIDTH: 295px; HEIGHT: 19px; TEXT-ALIGN: left" bgColor=#ccffcc>&nbsp;<asp:Label id="lbaddr" runat="server"></asp:Label></TD></TR><TR><TD style="HEIGHT: 24px; TEXT-ALIGN: center" colSpan=2>&nbsp; &nbsp; &nbsp;<asp:Button id="btnpsw" onclick="btnpsw_Click" runat="server" Width="127px" Text="确认密码重置" Height="39px"></asp:Button></TD></TR></TBODY></TABLE>
</contenttemplate>    
</asp:UpdatePanel>
</asp:Content>

