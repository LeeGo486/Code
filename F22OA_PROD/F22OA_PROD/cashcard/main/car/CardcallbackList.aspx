<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_CardcallbackList, App_Web_cardcallbacklist.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<script  type="text/javascript">
function GoUrlVipShop() 
{ 

    var url="SDBuildVipShop.aspx";	    
    var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
	if (result!="" && result!=undefined)
     {     
         var arvalues=result.split(",");
         window.document.getElementById("ctl00_ctplhder_txtdepotid").value=arvalues[0];
         window.document.getElementById("ctl00_ctplhder_TextBox1").value=arvalues[1];       
     }

}

</script>
<table>
<tr>
<td  style="width: 748px">
<TABLE style="WIDTH: 738px" height=300 cellSpacing=0 cellPadding=0 align=left><TBODY>
<TR>
<TD vAlign=top>
<TABLE ><TBODY>
<TR width=100%>
    <TD >
    <fieldset>
        <legend>查询条件</legend>
        <table width=100%  cellpadding=0 cellspacing=0 >
            <tr>
                <td style="width: 260px" >
                    <asp:Label id="Label1" runat="server" Text="卡号起始："></asp:Label>
                    <asp:TextBox id="txtstar" runat="server" Width="101px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>
                </td>  
                <td style="width: 260px">
                    <asp:Label id="Label2" runat="server" Text="卡号结束：" Width="62px"></asp:Label>&nbsp;
                    <asp:TextBox id="txtcardend" runat="server" Width="118px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>
                </td>              
                <td align=Left rowspan=2>
                    &nbsp;
                    <asp:TextBox ID="TextBox1" runat="server" BackColor="#ECF3F6" BorderStyle="None" Font-Names="宋体" Font-Size="9pt" Width="104px" Font-Underline="False"></asp:TextBox>
                 </td>
                   <td rowspan=2 style="width: 260px">
                        <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="70px" Text="查询" Height="23px" Font-Names="宋体" Font-Size="9pt"></asp:Button>
                       &nbsp; &nbsp;<asp:Button ID="btnCallBack" runat="server" Text="收回选中充值卡" Width=100px OnClick="btnCallBack_Click" Enabled="False" Font-Names="宋体" Font-Size="9pt" Height="24px" />
                   </td>
                   
            </tr>
            <TR>
                <td style="width: 260px">
                    <asp:Label ID="lbldepot" runat="server" Text="选择店铺："></asp:Label>
                    <asp:TextBox ID="txtdepotid" runat="server" BorderStyle="None" Width="101px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>&nbsp;&nbsp;                    
                </td>
                <td style="width: 260px">
                    <asp:Button ID="btnSelectDepot" runat="server" OnClientClick="GoUrlVipShop()" Text="选择店铺" Width="61px" BorderStyle="Dotted" />&nbsp;&nbsp;
                   是否收回：<asp:DropDownList id="ddlcallback" runat="server" OnSelectedIndexChanged="ddlcallback_SelectedIndexChanged" AutoPostBack=true Font-Names="宋体" Font-Size="9pt">
                    <asp:ListItem Text="不限" Value="-"></asp:ListItem>
                    <asp:ListItem Text="已收回" Value="1"></asp:ListItem>
                    <asp:ListItem Text="未收回" Value="0" Selected=True></asp:ListItem>
                    </asp:DropDownList></td>
                <td >
                    
                </td>
            </TR>
        </table> 
        </fieldset>
    </TD>
</TR></TBODY>
</TABLE>

<asp:GridView id="GridView1" runat="server" Width="830px" Height="100%" DataSourceID="ObjectDataSource1"
 GridLines="None" ForeColor="#333333" CellPadding="4" AutoGenerateColumns="False" PageSize="15" OnRowDataBound="GridView1_RowDataBound"
 AllowPaging="True" AllowSorting="True" DataKeyNames="cardid">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="序号">
<ItemTemplate>
    <%# (Container.DataItemIndex + 1).ToString() %>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="选择">
<ItemTemplate>
    <asp:CheckBox ID="ckbSelect" runat="server"  />    
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="cardid" SortExpression="cardid" HeaderText="卡号"></asp:BoundField>
<asp:BoundField DataField="cardname" SortExpression="cardname" HeaderText="卡名称"></asp:BoundField>
<asp:BoundField DataField="sums" SortExpression="sums" HeaderText="卡金额"></asp:BoundField>
<asp:CheckBoxField DataField="start" SortExpression="start" HeaderText="卡状态" Visible="False"></asp:CheckBoxField>
<asp:BoundField DataField="statename" SortExpression="statename" HeaderText="卡状态"></asp:BoundField>
<%--<asp:TemplateField HeaderText="是否生效" Visible=false>
<ItemTemplate>
        <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"start").ToString()=="True"?"生效":"无效" %>'></asp:Label>                
</ItemTemplate>
</asp:TemplateField>--%>
<asp:BoundField DataField="proposerid" SortExpression="proposerid" HeaderText="客户编号" Visible="False"></asp:BoundField>
<asp:BoundField DataField="names" SortExpression="names" HeaderText="客户姓名" Visible="false"></asp:BoundField>

<asp:BoundField DataField="crname" SortExpression="crname" HeaderText="建立人" Visible="false"></asp:BoundField>
<asp:BoundField DataField="username" SortExpression="username" HeaderText="建立人"></asp:BoundField>
<asp:BoundField DataField="depotid" SortExpression="depotid" HeaderText="店铺号"></asp:BoundField>
<asp:BoundField DataField="d_name" SortExpression="d_name" HeaderText="发卡店铺"></asp:BoundField>
<asp:BoundField DataField="crdate" SortExpression="crdate" HeaderText="建立日期" DataFormatString={0:d} HtmlEncode=false></asp:BoundField>
<asp:BoundField DataField="lastdate" SortExpression="lastdate" HeaderText="最后访问日期" DataFormatString={0:d} HtmlEncode=false></asp:BoundField>
<asp:BoundField DataField="comment" SortExpression="comment" HeaderText="备注"></asp:BoundField>
<%--<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment").ToString(), 12)%>
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
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="jcard" SelectMethod="selectFillCard">
<SelectParameters>
<asp:Parameter Type="String" Name="cardidBeg"></asp:Parameter>
<asp:Parameter Name="cardidEnd" Type="String"></asp:Parameter>
<asp:Parameter Name="callback" Type="String"></asp:Parameter>
<asp:Parameter Name="depotid" Type="String" DefaultValue="--"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> </TD></TR></TBODY></TABLE>
</td>
</tr>

</table>
</asp:Content>

