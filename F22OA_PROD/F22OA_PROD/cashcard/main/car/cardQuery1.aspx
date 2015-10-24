<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="cardQuery1, App_Web_cardquery1.aspx.f3086b61" title="Untitled Page" %>
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
<td style="width: 748px">

<TABLE style="WIDTH: 738px" height=280 cellSpacing=0 cellPadding=0 align=left>
<TBODY>
<TR>
<TD vAlign=top>
    <fieldset>
        <legend>查询条件</legend>
<TABLE width=100%  cellpadding=0 cellspacing=0 ><TBODY>
    <TR>
        <TD>
            <asp:CheckBox id="chkbxcard" runat="server" Checked="True" Text="" Visible="False"></asp:CheckBox> 
            <asp:Label id="Label1" runat="server" Text="卡号起始："></asp:Label><asp:TextBox id="txtstar" runat="server" Width="101px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>
            &nbsp; &nbsp; &nbsp;<asp:Label id="Label2" runat="server" Text="卡号结束：" Width="66px"></asp:Label><asp:TextBox id="txtcardend" runat="server" Width="101px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox> 
            <asp:CompareValidator id="CompareValidator1" runat="server" Operator="GreaterThanEqual" ControlToCompare="txtstar" ErrorMessage="卡号范围不正确" ControlToValidate="txtcardend" Display="Dynamic"></asp:CompareValidator>
        </TD>
        <td align=left rowspan=2>
            <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="65px" Text="查询"></asp:Button>
            &nbsp; &nbsp;<asp:Button id="btnprint" runat="server" Width="65px" Text="打印" Visible=true OnClick="btnprint_Click" Enabled="False"></asp:Button>
        </td>
    </TR>
    <TR>
        <TD>
            <asp:CheckBox id="chkbxdepot" runat="server" Checked="True" Text="" Visible="False"></asp:CheckBox><asp:Label ID="Label3" runat="server" Text="指定店铺："></asp:Label><asp:TextBox id="txtdepotid" runat="server" Width="101px" OnTextChanged="txtdepotid_TextChanged" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;
            
             <asp:Button id="btnSelectDepot" runat="server" Text="选择店铺" OnClientClick="GoUrlVipShop()" Width="63px"></asp:Button> 
             <asp:TextBox id="TextBox1" runat="server" BackColor="#ECF3F6" BorderStyle="None" Font-Underline="True"></asp:TextBox>            
        </TD>
        
    </TR>
   
    </TBODY>
</TABLE>
</fieldset>
<br />
<asp:GridView id="GridView1" runat="server" Width="830px" Height="100%" DataKeyNames="cardid" AllowSorting="True" AllowPaging="True" PageSize="15" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="ObjectDataSource1">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
                            *                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="cardid" SortExpression="cardid" HeaderText="卡号"></asp:BoundField>
<asp:BoundField DataField="cardname" SortExpression="cardname" HeaderText="卡名称"></asp:BoundField>
<asp:BoundField DataField="sums" SortExpression="sums" HeaderText="卡金额"></asp:BoundField>
<%--<asp:CheckBoxField DataField="start" SortExpression="start" HeaderText="卡状态" ></asp:CheckBoxField>--%>
<asp:BoundField DataField="statename" SortExpression="statename" HeaderText="卡状态"></asp:BoundField>
<%--<asp:TemplateField HeaderText="卡状态">
<ItemTemplate>
        <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"start").ToString()=="True"?"生效":"未生效" %>'></asp:Label>                
</ItemTemplate>
</asp:TemplateField>--%>
<asp:BoundField DataField="proposerid" SortExpression="proposerid" HeaderText="客户编号" Visible="False"></asp:BoundField>
<asp:BoundField DataField="names" SortExpression="names" HeaderText="客户姓名"></asp:BoundField>

<asp:BoundField DataField="crname" SortExpression="crname" HeaderText="建立人" Visible=false></asp:BoundField>
<asp:BoundField DataField="username" SortExpression="username" HeaderText="建立人"></asp:BoundField>
<asp:BoundField DataField="depotid" SortExpression="depotid" HeaderText="店铺号"></asp:BoundField>
<asp:BoundField DataField="d_name" SortExpression="d_name" HeaderText="发卡店铺"></asp:BoundField>
<asp:BoundField DataField="crdate" SortExpression="crdate" HeaderText="建立日期" DataFormatString={0:d} HtmlEncode=false></asp:BoundField>
<asp:BoundField DataField="lastdate" SortExpression="lastdate" HeaderText="最后访问日期"  DataFormatString={0:d} HtmlEncode=false></asp:BoundField>
<%--<asp:BoundField DataField="comment" SortExpression="comment" HeaderText="备注"></asp:BoundField>--%>
<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment1").ToString(), 12)%>
    </ItemTemplate>
</asp:TemplateField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView>
<asp:SqlDataSource id="SqlDataSource2" runat="server" SelectCommand="select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,&#13;&#10;&#9;a.depotid,a.crdate,a.lastdate,b.names from  j_card a ,j_proposer b ,view_sys_depotpower18ql c&#13;&#10;where a.proposerid*=b.proposerid &#13;&#10;&#13;&#10;and c.userid='1001' and a.depotid*=c.depotid and c.access=1" ConnectionString="<%$ ConnectionStrings:carcn %>"></asp:SqlDataSource> <asp:SqlDataSource id="SqlDataSource1" runat="server"></asp:SqlDataSource> 
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" OnSelecting="ObjectDataSource1_Selecting" SelectMethod="queryBegEnd" TypeName="jcard"><SelectParameters>
<asp:Parameter Type="String" Name="cardidBeg"></asp:Parameter>
<asp:Parameter Name="cardidEnd" Type="String"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> <asp:ObjectDataSource id="ObjectDataSource2" runat="server" SelectMethod="selectDepotBegEndAll" TypeName="jcard"><SelectParameters>
<asp:Parameter Type="String" Name="cardidBeg"></asp:Parameter>
<asp:Parameter Name="cardidEnd" Type="String"></asp:Parameter>
<asp:Parameter Name="depotid" Type="String"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> <asp:ObjectDataSource id="ObjectDataSource3" runat="server" SelectMethod="queryDepot" TypeName="jcard"><SelectParameters>
<asp:Parameter Name="depotid" Type="String"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> </TD></TR></TBODY>
</TABLE>
</td>
</tr>
</table>
    

</asp:Content>

