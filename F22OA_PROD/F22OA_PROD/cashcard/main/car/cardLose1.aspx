<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="cardLose1, App_Web_cardlose1.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<table>
<tr>
<td >
    <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<TABLE style="WIDTH: 100%" cellSpacing=0 cellPadding=0 align=left border=0><TBODY>
<TR >
    <TD width=73px>
        <asp:Label id="Label1" runat="server" Text="挂失卡号："></asp:Label>
    </TD>
    <TD style="WIDTH: 313px; HEIGHT: 25px" align=left>
        <asp:TextBox id="txtcardidold" runat="server" Width="134px"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="请输入卡号" ControlToValidate="txtcardidold">*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CtmVdtoldid" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardidold" OnServerValidate="CtmVdtoldid_ServerValidate"></asp:CustomValidator> 
        <asp:Button id="btnnext" onclick="btnnext_Click" runat="server" Width="68px" Height="24px" Text="查询"></asp:Button>
     </TD>
 <TD style="WIDTH: 87px; HEIGHT: 25px; TEXT-ALIGN: left">&nbsp;&nbsp;&nbsp; </TD>
 </TR>
 </TBODY></TABLE>
<%--</contenttemplate>    
</asp:UpdatePanel>--%>
</td>
</tr>
<tr>
<td >
<asp:Panel ID="Panel1" runat="server" >
<%--<asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>--%>
<TABLE cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD>&nbsp;挂失卡号：</TD><TD>&nbsp;<asp:Label id="lbcardid" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 30px; TEXT-ALIGN: left">&nbsp;用户名：</TD><TD style="WIDTH: 448px; HEIGHT: 30px; TEXT-ALIGN: left">&nbsp;<asp:Label id="lbname" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 29px; TEXT-ALIGN: left">&nbsp;证件号：</TD><TD style="WIDTH: 448px; HEIGHT: 29px; TEXT-ALIGN: left">&nbsp;<asp:Label id="lbidentity" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 36px; TEXT-ALIGN: left">&nbsp;接收号码：</TD><TD style="WIDTH: 448px; HEIGHT: 36px; TEXT-ALIGN: left"><asp:Label id="lbpswtel" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 36px; TEXT-ALIGN: left">&nbsp;说明：</TD><TD style="WIDTH: 448px; HEIGHT: 36px; TEXT-ALIGN: left"><asp:Label id="lbcomment" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 36px; TEXT-ALIGN: left">状态：</TD><TD style="WIDTH: 448px; HEIGHT: 36px; TEXT-ALIGN: left"><asp:Label id="lbstart" runat="server" ForeColor="Red" __designer:wfdid="w23"></asp:Label></TD></TR><TR><TD style="WIDTH: 73px; HEIGHT: 36px; TEXT-ALIGN: left">&nbsp;新 卡 号：</TD><TD style="WIDTH: 448px; HEIGHT: 36px; TEXT-ALIGN: left">&nbsp; <asp:TextBox id="txtcardid" runat="server" Width="137px"></asp:TextBox>&nbsp; <asp:CustomValidator id="CtmVdtid" runat="server" ControlToValidate="txtcardid" ErrorMessage="新卡号无效" OnServerValidate="CtmVdtid_ServerValidate"></asp:CustomValidator></TD></TR><TR><TD style="HEIGHT: 36px" align=left colSpan=2><asp:Button id="btnsubit" onclick="btnsubit_Click" runat="server" Width="98px" Text="新卡补办" Height="30px" Enabled="False"></asp:Button>&nbsp;<asp:Label id="lblmessage" runat="server" ForeColor="Red" __designer:wfdid="w8"></asp:Label> <asp:Label id="lblnewcardid" runat="server" ForeColor="Red" __designer:wfdid="w9"></asp:Label></TD></TR></TBODY></TABLE>
<%--</contenttemplate>
</asp:UpdatePanel>--%>
    &nbsp;
   </asp:Panel>
</td>
</tr>
</table>
    
    
    
 
       <br />
</asp:Content>

