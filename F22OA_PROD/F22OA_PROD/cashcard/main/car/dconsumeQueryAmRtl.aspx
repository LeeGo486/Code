<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_dconsumeQueryAmRtl, App_Web_dconsumequeryamrtl.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <asp:UpdatePanel id="UpdatePanel3" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 1038px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="WIDTH: 69px; HEIGHT: 51px"><asp:GridView id="GridView1" runat="server" Width="780px" AutoGenerateColumns="False" AllowPaging="True" ForeColor="#333333" CellPadding="4" GridLines="None">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
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

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> </TD></TR><TR><TD style="WIDTH: 69px; HEIGHT: 18px">&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

