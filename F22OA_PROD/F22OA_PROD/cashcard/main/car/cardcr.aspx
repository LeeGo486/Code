<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="cardcr, App_Web_cardcr.aspx.f3086b61" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">

    <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<TABLE style="WIDTH: 687px; HEIGHT: 179px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="WIDTH: 207px; HEIGHT: 24px; TEXT-ALIGN: left"></TD><TD style="WIDTH: 827px; HEIGHT: 24px; TEXT-ALIGN: left"></TD><TD style="WIDTH: 323px; HEIGHT: 24px; TEXT-ALIGN: left"></TD></TR><TR><TD style="WIDTH: 207px; HEIGHT: 24px; TEXT-ALIGN: left">卡名称：</TD><TD style="WIDTH: 827px; HEIGHT: 24px; TEXT-ALIGN: left">&nbsp;<asp:TextBox id="txtname" runat="server" MaxLength="50"></asp:TextBox> <asp:RequiredFieldValidator id="RFVname" runat="server" ControlToValidate="txtname" ErrorMessage="请输入卡名称" SetFocusOnError="True">*</asp:RequiredFieldValidator>（如：贵宾卡）</TD><TD style="WIDTH: 323px; HEIGHT: 24px; TEXT-ALIGN: left"><asp:Button id="btnreg" onclick="btnreg_Click" runat="server" Width="81px" UseSubmitBehavior="False" Text="建立卡档案" Height="30px" __designer:wfdid="w6"></asp:Button> <asp:Button id="btnPrint" runat="server" Width="83px" UseSubmitBehavior="False" Text="打印" Height="28px" __designer:wfdid="w7" OnClick="btnPrint_Click"></asp:Button></TD></TR><TR><TD style="WIDTH: 207px; TEXT-ALIGN: left">卡号前缀：</TD><TD style="WIDTH: 827px; TEXT-ALIGN: left">&nbsp;<asp:TextBox id="txtform" runat="server" MaxLength="50"></asp:TextBox> <asp:RequiredFieldValidator id="RFVform" runat="server" ControlToValidate="txtform" ErrorMessage="请输入卡号前缀" SetFocusOnError="True">*</asp:RequiredFieldValidator>（如：ABC）<asp:CustomValidator id="CustomValidator1" runat="server" ControlToValidate="txtform" ErrorMessage="卡号长度超长" __designer:wfdid="w11" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></TD><TD style="WIDTH: 323px; TEXT-ALIGN: left"></TD></TR><TR><TD style="WIDTH: 207px; TEXT-ALIGN: left">起始号：</TD><TD style="WIDTH: 827px; TEXT-ALIGN: left">&nbsp;<asp:TextBox id="txtstart" runat="server" MaxLength="50"></asp:TextBox> <asp:RequiredFieldValidator id="RFVtxtstart" runat="server" Width="6px" ControlToValidate="txtstart" ErrorMessage="请输入起始号" SetFocusOnError="True">*</asp:RequiredFieldValidator>（如：00001）</TD><TD style="WIDTH: 323px; TEXT-ALIGN: left"></TD></TR><TR><TD style="WIDTH: 207px; HEIGHT: 31px; TEXT-ALIGN: left">生成数量：</TD><TD style="WIDTH: 827px; HEIGHT: 31px; TEXT-ALIGN: left">&nbsp;<asp:TextBox id="txtnum" runat="server" MaxLength="50">1</asp:TextBox>&nbsp; （如：30）<asp:CompareValidator id="CompareValidator1" runat="server" ControlToValidate="txtnum" ErrorMessage="数量为正整数" Type="Integer" ValueToCompare="1" Operator="GreaterThanEqual"></asp:CompareValidator></TD><TD style="WIDTH: 323px; HEIGHT: 31px; TEXT-ALIGN: left"></TD></TR><TR><TD style="HEIGHT: 47px; TEXT-ALIGN: center" colSpan=2></TD><TD style="HEIGHT: 47px; TEXT-ALIGN: center" colSpan=1></TD></TR></TBODY></TABLE>
<%--</contenttemplate>
    
    </asp:UpdatePanel>--%>
        
    <%--<asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>--%>
<TABLE height=95 cellSpacing=0 cellPadding=0 width=378 align=center border=0><TBODY><TR><TD style="WIDTH: 400px"><asp:Label id="Label1" runat="server" Width="84px" Text="完成情况：" __designer:wfdid="w2"></asp:Label><BR /><asp:ListBox id="lbxinfo" runat="server" Width="683px" Height="167px" __designer:wfdid="w3"></asp:ListBox></TD></TR></TBODY></TABLE>
<%--</contenttemplate>
    
    </asp:UpdatePanel>--%>
 
</asp:Content>

