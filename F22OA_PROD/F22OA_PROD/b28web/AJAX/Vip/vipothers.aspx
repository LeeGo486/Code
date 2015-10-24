<%@ page language="C#" autoeventwireup="true" inherits="AJAX_Vip_vipothers, App_Web_vipothers.aspx.3005feca" %>

<form id="form1" runat="server">
<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
    BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="0px" 
    CellPadding="4" Font-Names="arial" Font-Size="12px" ForeColor="Black" 
    GridLines="Vertical" Width="100%">
    <FooterStyle BackColor="#CCCC99" />
    <RowStyle BackColor="#F7F7DE" HorizontalAlign="Left" />
    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
    <Fields>
        <asp:BoundField DataField="vipname" HeaderText="顾客姓名：" />
        <asp:BoundField DataField="vipbirth" DataFormatString="{0:yyyy年MM月dd日}" 
            HeaderText="顾客生日：" />
        <asp:BoundField DataField="vipcardid" HeaderText="VIP卡号：" />
        <asp:BoundField DataField="viptypename" HeaderText="卡类型：" />
        <asp:BoundField DataField="centum" HeaderText="总积分：" />
        <asp:BoundField DataField="pcentum" HeaderText="上季积分：" />
        <asp:BoundField DataField="sums" HeaderText="总储值：" />
        <asp:BoundField DataField="vipemit" DataFormatString="{0:yyyy年MM月dd日}" 
            HeaderText="开卡日期：" />
        <asp:BoundField DataField="enddate" DataFormatString="{0:yyyy年MM月dd日}" 
            HeaderText="有效期至：" />
        <asp:BoundField DataField="mobtel" HeaderText="手机：" />
        <asp:BoundField DataField="viptel" HeaderText="电话：" />
        <asp:BoundField DataField="vipadd" HeaderText="地址：" />
    </Fields>
    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
</asp:DetailsView>
</form>
