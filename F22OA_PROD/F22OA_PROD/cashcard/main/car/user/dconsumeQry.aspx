<%@ page language="C#" masterpagefile="~/cashcard/main/car/user/carmaster.master" autoeventwireup="true" inherits="ucar_dconsumeQryDtBegEnd, App_Web_dconsumeqry.aspx.d716d88e" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    &nbsp;
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 436px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="VERTICAL-ALIGN: middle; WIDTH: 54px; HEIGHT: 16px; TEXT-ALIGN: left">&nbsp;<asp:Label id="Label1" runat="server" Width="65px" Text="日期起始："></asp:Label></TD><TD style="WIDTH: 144px"><BR /><igsch:WebDateChooser id="WebDateChooser1" runat="server" AllowNull="False"></igsch:WebDateChooser></TD><TD style="WIDTH: 83px">&nbsp;<asp:Label id="Label2" runat="server" __designer:wfdid="w50" Text="日期结止："></asp:Label></TD><TD style="VERTICAL-ALIGN: middle; WIDTH: 42px; HEIGHT: 16px; TEXT-ALIGN: left">&nbsp; <igsch:WebDateChooser id="WebDateChooser2" runat="server" AllowNull="False"></igsch:WebDateChooser> <asp:CompareValidator id="CompareValidator1" runat="server" ControlToValidate="WebDateChooser2" ErrorMessage="日期范围填写有误" ControlToCompare="WebDateChooser1" Type="Date" Operator="GreaterThanEqual"></asp:CompareValidator></TD></TR></TBODY></TABLE><asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="87px" Text="查询" Height="29px"></asp:Button> <asp:Button id="Button1" runat="server" Width="87px" Text="打印" Height="28px"></asp:Button> 
</contenttemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 476px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="WIDTH: 545px; HEIGHT: 36px" colSpan=6><asp:GridView id="GridView1" runat="server" Width="100%" Height="100%" ForeColor="#333333" GridLines="None" CellPadding="4" AutoGenerateColumns="False" PageSize="20">
<FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField AccessibleHeaderText="*" HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="consumseid" AccessibleHeaderText="流水号" HeaderText="流水号"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="retailid" AccessibleHeaderText="零售单号" HeaderText="零售单号"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="cardsums" AccessibleHeaderText="金额(元)" HeaderText="金额(元)"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sums" AccessibleHeaderText="消费总金额(元)" HeaderText="消费总金额(元)"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sure_date" AccessibleHeaderText="消费日期" HeaderText="消费日期"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" AccessibleHeaderText="消费店铺" HeaderText="消费店铺"></asp:BoundField>
<asp:HyperLinkField HeaderText="明细单" Text="明细单" DataNavigateUrlFormatString="dconsumeQryRtl.aspx?id1={0}&amp;aspxid=CA1130&amp;aspxname=消费查询" DataNavigateUrlFields="consumseid"></asp:HyperLinkField>
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
</asp:GridView>&nbsp;&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

