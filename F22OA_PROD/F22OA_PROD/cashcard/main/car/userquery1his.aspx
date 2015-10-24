<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_userquery1his, App_Web_userquery1his.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<table>
    <tr>
        <td>
        <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
   <contenttemplate>--%>
<BR />
<TABLE cellSpacing=0 cellPadding=0 width=738px align=left border=0><TBODY>
<TR>
    <TD style="TEXT-ALIGN: left" colSpan=2>
        <fieldset>
        <legend>查询条件</legend>
        姓名：<asp:TextBox id="txtid" runat="server" Width="139px"></asp:TextBox>&nbsp; 
        <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="70px" Text="查询"></asp:Button> 
        <asp:Button id="Button1" runat="server" Width="68px" Text="打印" Visible="False"></asp:Button>
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
        <asp:UpdatePanel id="UpdatePanel2" runat="server">
   <contenttemplate>
<TABLE style="WIDTH: 890px" height=200 cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR vAlign=top><TD style="WIDTH: 830px; HEIGHT: 129px"><BR />
<asp:GridView id="GridView1" runat="server" Width="100%" PageSize="15"  DataKeyNames="proposerid" AllowSorting="True" AllowPaging="True" GridLines="None" ForeColor="#333333" CellPadding="4" AutoGenerateColumns="False"  OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="proposerid" HeaderText="编号" SortExpression="proposerid" ></asp:BoundField>
<asp:BoundField DataField="names" HeaderText="姓名" SortExpression="names" ></asp:BoundField>
<asp:BoundField DataField="sex" HeaderText="性别" SortExpression="sex" ></asp:BoundField>
<asp:BoundField DataField="identity" HeaderText="证件号" SortExpression="identity" ></asp:BoundField>
<asp:BoundField DataField="tel" HeaderText="固定电话" SortExpression="tel" ></asp:BoundField>
<asp:BoundField DataField="add" HeaderText="联系地址" SortExpression="add" ></asp:BoundField>
<asp:BoundField DataField="mtel" HeaderText="移动电话" SortExpression="mtel" ></asp:BoundField>
<asp:BoundField DataField="passwordtel" HeaderText="密码电话" Visible="False"></asp:BoundField>
<asp:BoundField DataField="presenter" HeaderText="推荐人" SortExpression="presenter" ></asp:BoundField>
<asp:BoundField DataField="depotid" HeaderText="店铺号" SortExpression="depotid" ></asp:BoundField>
<asp:BoundField DataField="d_name" HeaderText="建立店铺" SortExpression="d_name" ></asp:BoundField>
<%--<asp:BoundField DataField="comment" HeaderText="备注" SortExpression="comment" ></asp:BoundField>--%>
<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment1").ToString(),12)%>
    </ItemTemplate>
</asp:TemplateField>
<asp:CommandField SelectText="详细" ShowSelectButton="True" HeaderText="查看"></asp:CommandField>
<%--<asp:BoundField DataField="cardnum" HeaderText="拥有卡数量"></asp:BoundField>
<asp:TemplateField HeaderText="卡明细">
    <ItemTemplate>
        <asp:HyperLink  runat="server" Text='卡明细' NavigateUrl='<%# "userQuery1Detailhis.aspx?ProposerID=" + DataBinder.Eval(Container, "DataItem.proposerid") %> ' ID="Hyperlink2">
    </asp:HyperLink>
    </ItemTemplate>
</asp:TemplateField>--%>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> </TD></TR><TR><TD style="WIDTH: 602px" colSpan=1>&nbsp;
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="jproposer" SelectMethod="queryselecthis"><SelectParameters>
<asp:Parameter Type="String" Name="username" DefaultValue="-"></asp:Parameter>
<asp:Parameter Type="String" Name="userid" DefaultValue="-"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource id="ObjectDataSource2" runat="server"  TypeName="jproposer" SelectMethod="queryselecthiscommon"><SelectParameters>
<asp:Parameter Type="String" Name="username" DefaultValue="-"></asp:Parameter>
<asp:Parameter Type="String" Name="userid" DefaultValue="-"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource>
</TD></TR></TBODY></TABLE>
</contenttemplate>    
</asp:UpdatePanel>
        </td>
    </tr>
</table>
</asp:Content>

