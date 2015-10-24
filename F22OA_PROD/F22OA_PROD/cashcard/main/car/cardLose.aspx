<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardLose, App_Web_cardlose.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <table>
        <tr>
            <td >
                <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>--%>
<TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD><FIELDSET><LEGEND>查询条件</LEGEND><TABLE><TBODY><TR><TD><asp:Label id="Label2" runat="server" Text="卡号：" __designer:wfdid="w1"></asp:Label> <asp:TextBox id="txtcardid" runat="server" __designer:wfdid="w2"></asp:TextBox>&nbsp;&nbsp; <asp:Label id="Label1" runat="server" Text="客户名称："></asp:Label> </TD><TD><asp:TextBox id="txtcardidold" runat="server"></asp:TextBox>&nbsp;&nbsp; <asp:Button id="btnnext" onclick="btnnext_Click" runat="server" Width="68px" Text="查询"></asp:Button> </TD></TR></TBODY></TABLE></FIELDSET> </TD></TR></TBODY></TABLE>
<%--</contenttemplate>
                </asp:UpdatePanel>--%>
            </td>
        </tr>
        <tr>
            <td >
                <asp:Panel ID="Panel1" runat="server" >
                <asp:UpdatePanel id="UpdatePanel2" runat="server">
                        <contenttemplate>
<asp:GridView id="GridView1" AllowSorting="True" runat="server" Width="100%" AllowPaging="True" GridLines="None" CellPadding="4" OnRowDataBound="GridView1_RowDataBound" DataSourceID="ObjectDataSource1" AutoGenerateColumns="False" __designer:wfdid="w25" ForeColor="#333333" PageSize="15" OnRowCommand="GridView1_RowCommand" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" > </FooterStyle>
<Columns>
<asp:BoundField DataField="cardid" HeaderText="卡号"  SortExpression="cardid">
<%--<ItemStyle Width="80px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="proposerid" HeaderText="客户编号"  SortExpression="proposerid">
<%--<ItemStyle Width="90px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="names" HeaderText="客户名称"  SortExpression="names">
<%--<ItemStyle Width="120px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="sex" HeaderText="性别"  SortExpression="cardid">
<%--<ItemStyle Width="40px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="identity" Visible="False" HeaderText="证件号"  SortExpression="identity">
<%--<ItemStyle Width="100px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="passwordtel" Visible="False" HeaderText="密码电话">
<%--<ItemStyle Width="100px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="start" HeaderText="卡状态编号" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" FooterStyle-CssClass="hidden">
<%--<ItemStyle Width="100px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="statename" HeaderText="卡状态"  SortExpression="statename">
<%--<ItemStyle Width="100px"></ItemStyle>--%>
</asp:BoundField>
<asp:BoundField DataField="sums" HeaderText="金额"  SortExpression="sums">
<%--<ItemStyle Width="80px"></ItemStyle>--%>
</asp:BoundField>
<asp:TemplateField AccessibleHeaderText="挂失" HeaderText="操作"><ItemTemplate>
<asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Eval("cardid") %>'   runat="server" Text="挂失" __designer:wfdid="w1" CausesValidation="false" CommandName='<%# Eval("proposerid") %>'
     OnClick="LinkBtnChange_Click" ></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
<asp:HyperLinkField Target="_self" HeaderText="补卡" NavigateUrl="~/cashcard/main/car/cardLose1.aspx?aspxid=1130&amp;aspxname=挂失补卡&amp;cardid={0}" Text="补卡" DataNavigateUrlFormatString="cardLose1.aspx?cardid={0}&amp;aspxid=CA1131&amp;aspxname=挂失补卡" DataNavigateUrlFields="cardid">
<%--<ItemStyle Width="60px"></ItemStyle>--%>
</asp:HyperLinkField>
<asp:TemplateField HeaderText="充值">
    <ItemTemplate>
        <%--<asp:HyperLink ID=hylfullvalue runat=server NavigateUrl='cardfullvaluedetail.aspx?cardid=<%# Eval("cardid") %>&aspxid=CA1130&amp;&aspxname=充值明细&amp;' Text="充值明细" ></asp:HyperLink>--%>
        <a href='cardfullvaluedetail.aspx?cardid=<%# Eval("cardid") %>&aspxid=CA1130&aspxname=充值明细'>充值明细</a>
    </ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="消费">
    <ItemTemplate>
        <%--<asp:HyperLink ID=hylconsume runat=server NavigateUrl='cardconsumedetail.aspx?aspxid=CA1130&aspxname=消费明细&cardid=<%# Eval("cardid") %>' Text="消费明细"></asp:HyperLink> --%>       
        <a href='cardconsumedetail.aspx?cardid=<%# Eval("cardid") %>&aspxid=CA1130&aspxname=消费明细'>消费明细</a>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="addcardid" HeaderText="已补卡号">
</asp:BoundField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" VerticalAlign="Middle"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView>&nbsp; <asp:ObjectDataSource id="ObjectDataSource1" runat="server" __designer:wfdid="w26" OnSelecting="ObjectDataSource1_Selecting" SelectMethod="selectLoseUser" TypeName="jcard"><SelectParameters>
<asp:Parameter Type="String" Name="names"></asp:Parameter>
<asp:Parameter Type="String" Name="depotid"></asp:Parameter>
<asp:Parameter Type="String" Name="cardid"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 
</contenttemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
                &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
    </table>
</asp:Content>

