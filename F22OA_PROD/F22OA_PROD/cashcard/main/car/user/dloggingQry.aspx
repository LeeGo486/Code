<%@ page language="C#" masterpagefile="~/cashcard/main/car/user/carmaster.master" autoeventwireup="true" inherits="ucar_dloggingQryDtBegEnd, App_Web_dloggingqry.aspx.d716d88e" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 302px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="WIDTH: 57px; HEIGHT: 1px; TEXT-ALIGN: left">&nbsp;<asp:Label id="Label1" runat="server" Width="70px" Text="时间起始："></asp:Label></TD><TD style="WIDTH: 110px; HEIGHT: 1px; TEXT-ALIGN: left">&nbsp; &nbsp; <igsch:WebDateChooser id="WebDateChooser1" runat="server" AllowNull="False"></igsch:WebDateChooser></TD><TD style="WIDTH: 66px; HEIGHT: 1px">&nbsp;<asp:Label id="Label2" runat="server" Width="72px" Text="时间结止："></asp:Label></TD><TD style="WIDTH: 182px; HEIGHT: 1px; TEXT-ALIGN: left"><BR /><igsch:WebDateChooser id="WebDateChooser2" runat="server" AllowNull="False" Value></igsch:WebDateChooser> <asp:CompareValidator id="CompareValidator1" runat="server" Operator="GreaterThanEqual" Type="Date" ControlToCompare="WebDateChooser1" SetFocusOnError="True" ErrorMessage="日期填写不正确" ControlToValidate="WebDateChooser2"></asp:CompareValidator></TD></TR><TR><TD style="WIDTH: 57px; HEIGHT: 1px; TEXT-ALIGN: left"></TD><TD style="WIDTH: 110px; HEIGHT: 1px; TEXT-ALIGN: right">&nbsp;</TD><TD style="WIDTH: 66px; HEIGHT: 1px; TEXT-ALIGN: left"><asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="77px" Text="查询" Height="29px"></asp:Button></TD><TD style="WIDTH: 182px; HEIGHT: 1px; TEXT-ALIGN: left">&nbsp;<asp:Button id="Button1" runat="server" Width="81px" Text="打印" Height="29px"></asp:Button></TD></TR></TBODY></TABLE>　　　　　　　 
</contenttemplate>
    </asp:UpdatePanel>
    <br />
    <asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 544px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="HEIGHT: 36px" colSpan=6><asp:GridView id="GridView1" runat="server" Width="100%" Height="100%" ForeColor="#333333" AutoGenerateColumns="False" CellPadding="4" GridLines="None">
<FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="loggingid" AccessibleHeaderText="流水号" HeaderText="流水号"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="insums" AccessibleHeaderText="实充金额" HeaderText="实充金额(元)"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="rate" AccessibleHeaderText="奖励比例(%)" HeaderText="奖励比例(%)"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="bounty" AccessibleHeaderText="奖励金额(元)" HeaderText="奖励金额(元)"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sure_date" AccessibleHeaderText="充值日期" HeaderText="充值日期"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" AccessibleHeaderText="办理店铺" HeaderText="办理店铺"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="crdate" AccessibleHeaderText="建立日期" HeaderText="建立日期"></asp:BoundField>
</Columns>

<RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>
<EmptyDataTemplate>
                    *
                
</EmptyDataTemplate>

<EditRowStyle BackColor="#999999"></EditRowStyle>

<SelectedRowStyle BackColor="#E2DED6" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
</asp:GridView>&nbsp; &nbsp;&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

