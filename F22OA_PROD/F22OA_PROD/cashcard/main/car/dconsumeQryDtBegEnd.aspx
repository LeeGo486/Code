<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_dconsumeQryDtBegEnd, App_Web_dconsumeqrydtbegend.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
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
    <td>
        <fieldset>
            <legend>查询条件</legend>
        <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<BR /><TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY>
<TR>
<TD style="VERTICAL-ALIGN: middle; WIDTH: 48px; HEIGHT: 16px; TEXT-ALIGN: left">
    <asp:Label id="Label1" runat="server" Width="48px" Text="日期起始"></asp:Label>
</TD>
<TD style="WIDTH: 101px">
    <igsch:WebDateChooser id="WebDateChooser1" runat="server" Width="101px" Height="10px" AllowNull="False"></igsch:WebDateChooser>
</TD>
<TD style="WIDTH: 49px">
    <asp:Label id="Label2" runat="server" Text="日期结止"></asp:Label>
</TD>
<TD style="WIDTH: 126px">
    <igsch:WebDateChooser id="WebDateChooser2" runat="server" Width="101px" Height="9px" AllowNull="False"></igsch:WebDateChooser> 
    <asp:CompareValidator id="CompareValidator1" runat="server" Display="Dynamic" Operator="GreaterThanEqual" Type="Date" ControlToCompare="WebDateChooser1" ErrorMessage="日期范围填写有误" ControlToValidate="WebDateChooser2"></asp:CompareValidator> 
 </TD>
 <TD style="WIDTH: 397px">
 <asp:Label id="lbldepot" runat="server" Font-Size="9pt" Font-Names="宋体" Width="40px" Text="店铺："></asp:Label>
 <asp:TextBox id="txtdepotid" runat="server" Font-Size="9pt" Font-Names="宋体" Width="68px" BorderStyle="None"></asp:TextBox><asp:Button id="btnSelectDepot" runat="server" Width="64px" Text="选择店铺" Height="20px" OnClientClick="GoUrlVipShop()"></asp:Button><asp:TextBox id="TextBox1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="75px" BorderStyle="None" BackColor="#ECF3F6"></asp:TextBox>&nbsp;&nbsp;<asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="60px" Text="查询"></asp:Button> <asp:Button id="Button1" runat="server" Width="60px" Text="打印"></asp:Button></TD></TR></TBODY></TABLE>&nbsp; 
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
    </fieldset>
    </td>
</tr>
<tr>
    <td>
  <asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 830px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD style="WIDTH: 830px; HEIGHT: 36px" colSpan=6>
<asp:GridView id="GridView1" runat="server" Width="100%" AllowSorting="True" AllowPaging="true" PageSize="15" 
AutoGenerateColumns="False" CellPadding="4" GridLines="None" ForeColor="#333333"
 DataSourceID="ObjectDataSource1" DataKeyNames="consumseid">
 
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField AccessibleHeaderText="*" HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="consumseid" AccessibleHeaderText="流水号" HeaderText="流水号" SortExpression="consumseid"></asp:BoundField>
<asp:BoundField DataField="cardid" HeaderText="卡号" SortExpression="cardid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="retailid" AccessibleHeaderText="零售单号" HeaderText="零售单号" SortExpression="retailid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="cardsums" AccessibleHeaderText="上期余额(元)" HeaderText="上期余额(元)" SortExpression="cardsums"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sums" AccessibleHeaderText="消费总金额(元)" HeaderText="消费总金额(元)" SortExpression="sums"></asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:d}" ReadOnly="True" DataField="sure_date" AccessibleHeaderText="消费日期" HeaderText="消费日期" SortExpression="sure_date"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" AccessibleHeaderText="消费店铺" HeaderText="消费店铺" SortExpression="depotid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="d_name" AccessibleHeaderText="店铺名称" HeaderText="店铺名称" SortExpression="d_name"></asp:BoundField>
<asp:HyperLinkField HeaderText="明细单" Text="明细单" DataNavigateUrlFormatString="dconsumeQueryAmRtl.aspx?id1={0}&amp;aspxid=CA1130&amp;aspxname=消费查询" DataNavigateUrlFields="consumseid"></asp:HyperLinkField>
<asp:BoundField ReadOnly="True" DataField="comment" AccessibleHeaderText="备注" HeaderText="备注" SortExpression="comment"></asp:BoundField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>
<EmptyDataTemplate>
     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
        <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
            <th scope="col">流水号</th>
            <th scope="col">卡号</th>
            <th scope="col">零售单号</th>
            <th scope="col">上期余额(元)</th>
            <th scope="col">消费总金额(元)</th>
            <th scope="col">消费日期</th>
            <th scope="col">店铺编号</th>
            <th scope="col">消费店铺</th>
            <th scope="col">明细单</th>
        </tr>
      </table>
</EmptyDataTemplate>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView>&nbsp;&nbsp; 
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="dconsume" SelectMethod="selectDtBegEnd">
<SelectParameters>
<asp:Parameter Type="String" Name="userid" DefaultValue="-"></asp:Parameter>
<asp:Parameter Type="String" Name="datebeg" DefaultValue="1900-01-01"></asp:Parameter>
<asp:Parameter Type="String" Name="dateend" DefaultValue="1900-01-01"></asp:Parameter>
<asp:Parameter Type="String" Name="strdepotid" DefaultValue="-"></asp:Parameter>

</SelectParameters>
</asp:ObjectDataSource> 

<asp:ObjectDataSource id="ObjectDataSource2" runat="server" TypeName="dconsume" SelectMethod="selectDtBegEndCommon">
<SelectParameters>
<asp:Parameter Type="String" Name="userid" DefaultValue="-"></asp:Parameter>
<asp:Parameter Type="String" Name="datebeg" DefaultValue="1900-01-01"></asp:Parameter>
<asp:Parameter Type="String" Name="dateend" DefaultValue="1900-01-01"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource>
</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    </td>
</tr>
</table>
    &nbsp;

  
    
</asp:Content>

