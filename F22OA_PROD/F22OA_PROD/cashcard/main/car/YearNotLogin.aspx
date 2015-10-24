<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_YearNotLogin, App_Web_yearnotlogin.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    &nbsp; &nbsp;
  <fieldset>
    <legend>查询条件及收取年费</legend>
    <table style="width: 300px">    
        <tr>
            <td style="width: 39px;">
                <asp:Label ID="Label1" runat="server" Text="结算时间：" Width="62px"></asp:Label></td>
            <td style="width: 60px;">
                <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
                </igsch:WebDateChooser>
            </td>
            <td style="width: 100px;">
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="查询"
                    Width="72px" /></td>
        </tr>
        <tr>
            <td style="width: 39px">
                <asp:Label ID="Label2" runat="server" Text="年费：" Width="55px"></asp:Label></td>
            <td style="width: 60px">
                <asp:TextBox ID="txtsums" runat="server" Width="114px"></asp:TextBox>&nbsp;
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtsums"
                    ErrorMessage="年费范围值不正确" MaximumValue="10000000" MinimumValue="0" Type="Double"
                    Width="112px" Display="Dynamic"></asp:RangeValidator></td>
            <td style="width: 100px">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="收取年费"
                    Width="76px" /></td>
        </tr>
    </table>
    </fieldset>
    <br />
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 514px; HEIGHT: 57px"><TBODY><TR><TD style="WIDTH: 100px">
<asp:GridView id="GridView1" runat="server" Width="800px"  AutoGenerateColumns="False" ForeColor="#333333" CellPadding="4" GridLines="None" DataSourceID="ObjectDataSource1">
<FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="序号">
    <ItemTemplate>
        <%# (Container.DataItemIndex + 1).ToString() %>
    </ItemTemplate>
    
</asp:TemplateField>
<asp:BoundField DataField="consumseid" HeaderText="消费单号" Visible=false >
<ItemStyle Width="50px"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="cardid" HeaderText="卡号"></asp:BoundField>
<asp:BoundField DataField="names" HeaderText="客户名称"></asp:BoundField>
<asp:BoundField DataField="proposerid" HeaderText="客户编号"></asp:BoundField>
<asp:BoundField DataField="sure_date" HeaderText="建立时间" DataFormatString={0:d} HtmlEncode=false Visible="False"></asp:BoundField>
<asp:BoundField DataField="mtel" HeaderText="信息接收号码"></asp:BoundField>
<asp:BoundField DataField="sums" HeaderText="卡金额"></asp:BoundField>
<asp:BoundField DataField="sure_date" HeaderText="建立时间" DataFormatString={0:d} HtmlEncode=false></asp:BoundField>
</Columns>

<RowStyle BackColor="#F7F6F3" ForeColor="#333333"  HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>


<EditRowStyle BackColor="#999999"></EditRowStyle>

<SelectedRowStyle BackColor="#E2DED6" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
<EmptyDataTemplate>
     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
        <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
            <th scope="col">卡号</th>
            <th scope="col">客户名称</th>
            <th scope="col">客户编号</th>
            <th scope="col">信息接收号码</th>
            <th scope="col">消费金额</th>
            <th scope="col">最后消费时间</th>
        </tr>
      </table>
</EmptyDataTemplate>
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" OnSelecting="ObjectDataSource1_Selecting" SelectMethod="selectNotLogin" TypeName="jcard"><SelectParameters>
<asp:Parameter Type="DateTime" Name="stime"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource></TD></TR><TR><TD style="WIDTH: 100px"></TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

