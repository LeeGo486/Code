<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardDistribut, App_Web_carddistribut.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<table>
<tr>
    <td>
    <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
   <contenttemplate>--%>
<BR />
<TABLE   height="100%" cellSpacing=0 cellPadding=0 width=738px align=left border=0><TBODY>
<TR>
    <TD style=" HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2>
        <fieldset>
            <legend>查询条件</legend>
            姓名：<asp:TextBox id="txtname" runat="server" Width="139px"></asp:TextBox> 
            <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="txtname" ErrorMessage="卡号不能为空" SetFocusOnError="True" Enabled="False">*</asp:RequiredFieldValidator> 
            <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="83px" Text="查询" Height="25px"></asp:Button>
        </fieldset>
    </TD>
</TR></TBODY>
</TABLE>
<%--</contenttemplate>    
</asp:UpdatePanel>--%>

    </td>
</tr>
<tr>
    <td>
    <asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>
<TABLE style="WIDTH: 800px" height=80 cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR valign=top><TD style="WIDTH: 850px; HEIGHT: 129px"><BR /><asp:GridView id="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="ObjectDataSource1" AllowPaging="True" AllowSorting="True" PageSize="15" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:BoundField DataField="proposerid" HeaderText="编号"  SortExpression="proposerid"></asp:BoundField>
<asp:BoundField DataField="names" HeaderText="姓名" SortExpression="names"></asp:BoundField>
<asp:BoundField DataField="sex" HeaderText="性别" SortExpression="sex"></asp:BoundField>
<asp:BoundField DataField="identity" HeaderText="证件号" SortExpression="identity"></asp:BoundField>
<asp:BoundField DataField="tel" HeaderText="固定电话" SortExpression="tel"></asp:BoundField>
<asp:BoundField DataField="add" HeaderText="联系地址" SortExpression="add"></asp:BoundField>
<asp:BoundField DataField="mtel" HeaderText="移动电话" SortExpression="mtel"></asp:BoundField>
<asp:BoundField DataField="passwordtel" HeaderText="密码电话" Visible="False"></asp:BoundField>
<%--<asp:BoundField DataField="comment" HeaderText="备注" SortExpression="comment"></asp:BoundField>--%>
<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment1").ToString(),12)%>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="presenter" HeaderText="推荐人" SortExpression="presenter"></asp:BoundField>
<asp:BoundField DataField="depotid" HeaderText="店铺编号" SortExpression="depotid"></asp:BoundField>
<asp:BoundField DataField="d_name" HeaderText="建立店铺" SortExpression="d_name"></asp:BoundField>
<asp:HyperLinkField HeaderText="开卡" Text="开卡" DataNavigateUrlFormatString="cardDistributSub.aspx?proid={0}&amp;aspxid=CA1110&amp;aspxname=发充值卡" DataNavigateUrlFields="proposerid"></asp:HyperLinkField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> &nbsp; 
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" SelectMethod="select" TypeName="jproposer" OldValuesParameterFormatString="original_{0}" ><SelectParameters>
<asp:Parameter Type="String" Name="username"></asp:Parameter>
<asp:Parameter Type="String" Name="userid"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 

<asp:ObjectDataSource id="ObjectDataSource2" runat="server" SelectMethod="selectcommon" TypeName="jproposer" OldValuesParameterFormatString="original_{0}" >
<SelectParameters>
<asp:Parameter Type="String" Name="username"></asp:Parameter>
<asp:Parameter Type="String" Name="userid"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 
</TD></TR></TBODY></TABLE>
</contenttemplate>
</asp:UpdatePanel>
    </td>
</tr>
</table>


    &nbsp;

<br />


          
</asp:Content>

