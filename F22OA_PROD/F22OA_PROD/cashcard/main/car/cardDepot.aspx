<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardDepot, App_Web_carddepot.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<script  type="text/javascript">
    function GoUrlVipShop() 
    { 
    var url="SDBuildVipShop.aspx";	    
    var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
	if (result!="" && result!=undefined)
     {
        var arvalues=result.split(",");
         window.document.getElementById("ctl00_ctplhder_txtdepot").value=arvalues[0];
         window.document.getElementById("ctl00_ctplhder_TextBox1").value=arvalues[1];       
     }
    }
    </script>  
   <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<BR />
<table>
    <TR><TD><FIELDSET><LEGEND>查询条件</LEGEND><TABLE cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="WIDTH: 72px"><asp:Label id="Label6" runat="server" Text="卡号起始："></asp:Label> </TD><TD width="20%"><asp:TextBox id="txtstar" runat="server" Font-Size="9pt" Font-Names="宋体" Width="127px"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" SetFocusOnError="True" ErrorMessage="卡号不能为空" ControlToValidate="txtstar">*</asp:RequiredFieldValidator> </TD><TD style="WIDTH: 81px"><asp:Label id="Label5" runat="server" Text="卡号结束："></asp:Label> </TD><TD style="WIDTH: 244px" colSpan=2><asp:TextBox id="txtcardend" runat="server" Font-Size="9pt" Font-Names="宋体"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="填写卡号" ControlToValidate="txtcardend">*</asp:RequiredFieldValidator> <asp:CompareValidator id="CompareValidator1" runat="server" Display="Dynamic" ErrorMessage="卡号范围不正确" ControlToValidate="txtcardend" Operator="GreaterThanEqual" ControlToCompare="txtstar"></asp:CompareValidator> </TD><TD rowSpan=2><asp:Button id="Button3" onclick="btnNext_Click" runat="server" Width="80px" Text="查询"></asp:Button> &nbsp;&nbsp;&nbsp;&nbsp; <asp:Button id="Button2" onclick="Button2_Click" runat="server" Width="80px" Text="确定领卡"></asp:Button> </TD></TR><TR><TD style="WIDTH: 72px"><asp:Label id="Label7" runat="server" Text="店铺编号："></asp:Label> </TD><TD><asp:TextBox id="txtdepot" runat="server" Font-Size="9pt" Font-Names="宋体" Width="127px"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" Display="Dynamic" SetFocusOnError="True" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtdepot">*</asp:RequiredFieldValidator> </TD><TD style="WIDTH: 81px"><asp:Button id="btnSelectDepot" runat="server" Text="选择店铺" OnClientClick="GoUrlVipShop()"></asp:Button> </TD><TD style="WIDTH: 128px"><asp:TextBox id="TextBox1" runat="server" BorderStyle="None" BackColor="#ECF3F6"></asp:TextBox> </TD><TD style="WIDTH: 244px" colSpan=2></TD><TD></TD></TR><TR><TD style="WIDTH: 72px"><asp:Label id="Label1" runat="server" Text=" " ToolTip="卡号起始："></asp:Label> <asp:Label id="lbstar" runat="server" ForeColor="Red"></asp:Label> <asp:Label id="Label2" runat="server" Text=" " ToolTip="卡号结束："></asp:Label> <asp:Label id="lbend" runat="server" ForeColor="Red"></asp:Label> <asp:Label id="Label4" runat="server" Text=" " ToolTip="店铺编号："></asp:Label> <asp:Label id="lbdepot" runat="server" ForeColor="Red"></asp:Label> <asp:Label id="Label3" runat="server" Text=" " ToolTip="店铺名称："></asp:Label> <asp:Label id="lbdepotname" runat="server" ForeColor="Red"></asp:Label> </TD></TR><TR><TD colSpan=5><asp:Button id="Button6" onclick="Button2_Click" runat="server" Width="83px" ToolTip="确定领卡" Visible="False"></asp:Button> </TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
</table>
<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE cellSpacing=0 cellPadding=0 width="98%" align=left border=0><TBODY>
<TR vAlign=top><TD style="WIDTH: 404px;">
<asp:GridView id="GridView1" runat="server" Width="800px" ForeColor="#333333" AutoGenerateColumns="False" CellPadding="4" GridLines="None">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="序号">
    <ItemTemplate><%#(Container.DataItemIndex + 1).ToString() %></ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="cardid" HeaderText="卡号" SortExpression="cardid"></asp:BoundField>
<asp:BoundField DataField="cardname" HeaderText="卡名称" SortExpression="cardname"></asp:BoundField>
<asp:BoundField DataField="sums" HeaderText="当前金额" SortExpression="sums"></asp:BoundField>
<asp:BoundField DataField="crdate" HeaderText="建卡日期" DataFormatString={0:d} HtmlEncode=false SortExpression="crdate"> </asp:BoundField>
<asp:BoundField DataField="crname" HeaderText="创建人" Visible=false></asp:BoundField>
<asp:BoundField DataField="username" HeaderText="创建人" SortExpression="username"></asp:BoundField>
<asp:BoundField DataField="statename" HeaderText="卡状态" SortExpression="statename"></asp:BoundField>
<%--<asp:TemplateField HeaderText="是否启用">
<ItemTemplate>
        <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"start").ToString()=="True"?"启用":"未启用" %>'></asp:Label>                
</ItemTemplate>
</asp:TemplateField>--%>
<asp:BoundField DataField="proposerid" HeaderText="持卡人编号"></asp:BoundField>
<asp:BoundField DataField="names" HeaderText="持卡人"></asp:BoundField>
<asp:BoundField DataField="depotid" HeaderText="店铺号"></asp:BoundField>
<asp:BoundField DataField="d_name" HeaderText="店铺"></asp:BoundField>
<%--<asp:BoundField DataField="comment" HeaderText="说明"></asp:BoundField>--%>
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

<HeaderStyle BackColor="#507CD1" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" VerticalAlign="Middle"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> </TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    &nbsp;&nbsp;
    <br />
</asp:Content>

