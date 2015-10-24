<%@ page language="C#" masterpagefile="~/cashcard/main/car/user/carmaster.master" autoeventwireup="true" inherits="ucar_dconsumeQueryAmRtl, App_Web_dconsumeqryrtl.aspx.d716d88e" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <asp:UpdatePanel id="UpdatePanel3" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="WIDTH: 69px; HEIGHT: 689px"><asp:GridView id="GridView1" runat="server" Width="125%" Height="673px" AllowPaging="True" AutoGenerateColumns="False"><Columns>
<asp:BoundField DataField="retailid" HeaderText="单号"></asp:BoundField>
<asp:BoundField DataField="styleid" HeaderText="款式编号"></asp:BoundField>
<asp:BoundField DataField="s_name" HeaderText="款式"></asp:BoundField>
<asp:BoundField DataField="sizeid" HeaderText="尺码"></asp:BoundField>
<asp:BoundField DataField="colorid" HeaderText="颜色"></asp:BoundField>
<asp:BoundField DataField="discount" HeaderText="折扣"></asp:BoundField>
<asp:BoundField DataField="s_price" HeaderText="单价"></asp:BoundField>
<asp:BoundField DataField="nums" HeaderText="数量"></asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:d}" DataField="crdate" HeaderText="日期"></asp:BoundField>
</Columns>
</asp:GridView> </TD></TR><TR><TD style="WIDTH: 69px; HEIGHT: 18px">&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

