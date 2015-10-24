<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_dloggingQueryAm, App_Web_dloggingqueryam.aspx.f3086b61" title="Untitled Page" %>
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
     <%--  <asp:UpdatePanel id="UpdatePanel1" runat="server">
       <contenttemplate>--%>
<BR /><TABLE style="WIDTH: 716px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD style="HEIGHT: 20px; TEXT-ALIGN: left"><FIELDSET><LEGEND>查询条件</LEGEND><asp:Label id="Label1" runat="server" Font-Size="9pt" Font-Names="宋体" Text="卡号："></asp:Label> <asp:TextBox id="txtcardid" runat="server" Font-Size="9pt" Font-Names="宋体" Width="94px"></asp:TextBox>&nbsp; <asp:CustomValidator id="CustomValidator1" runat="server" ControlToValidate="txtcardid" ErrorMessage="卡号无效" OnServerValidate="CustomValidator1_ServerValidate" Display="Dynamic"></asp:CustomValidator>&nbsp;<asp:Label id="lbldepot" runat="server" Font-Size="9pt" Font-Names="宋体" Width="40px" Text="店铺："></asp:Label><asp:TextBox id="txtdepotid" runat="server" Font-Size="9pt" Font-Names="宋体" Width="94px" BorderStyle="None"></asp:TextBox>&nbsp;&nbsp; <asp:Button id="btnSelectDepot" runat="server" Width="64px" Text="选择店铺" Height="20px" OnClientClick="GoUrlVipShop()"></asp:Button><asp:TextBox id="TextBox1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="86px" BorderStyle="None" BackColor="#ECF3F6"></asp:TextBox>&nbsp;&nbsp;&nbsp; <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="72px" Text="查询"></asp:Button>&nbsp; <asp:Button id="Button1" runat="server" Width="72px" Text="打印"></asp:Button> </FIELDSET> </TD></TR></TBODY></TABLE>　　　　　　　 
<%--</contenttemplate>    
        </asp:UpdatePanel>--%>
    </td>
</tr>
<tr>
    <td>
    <asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>
<TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=center border=0><TBODY><TR><TD style="HEIGHT: 36px" colSpan=6>
<asp:GridView id="GridView1" runat="server"  DataKeyNames="loggingid" Width="100%" PageSize="15" AllowSorting="True" AllowPaging="True" GridLines="None" CellPadding="4" AutoGenerateColumns="False" ForeColor="#333333" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="loggingid" AccessibleHeaderText="流水号" HeaderText="流水号" SortExpression="loggingid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="cardid" AccessibleHeaderText="卡号" HeaderText="卡号" SortExpression="cardid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="insums" AccessibleHeaderText="实充金额" HeaderText="实充金额(元)" SortExpression="insums"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="rate" AccessibleHeaderText="奖励比例(%)" HeaderText="奖励比例(%)" SortExpression="rate"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="bounty" AccessibleHeaderText="奖励金额(元)" HeaderText="奖励金额(元)" SortExpression="bounty"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sure_date" AccessibleHeaderText="充值日期" HeaderText="充值日期" DataFormatString={0:d} HtmlEncode=False SortExpression="sure_date"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" AccessibleHeaderText="店铺号" HeaderText="店铺号" SortExpression="depotid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="d_name" AccessibleHeaderText="办理店铺" HeaderText="办理店铺" SortExpression="d_name"></asp:BoundField>

<asp:BoundField ReadOnly="True" DataField="crdate" AccessibleHeaderText="建立日期" HeaderText="建立日期" DataFormatString={0:d} HtmlEncode=False SortExpression="crdate"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="comment" AccessibleHeaderText="备注" HeaderText="备注" SortExpression="comment"></asp:BoundField>
<asp:CommandField SelectText="打印" ShowSelectButton="True" HeaderText="打印"></asp:CommandField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
<PagerSettings Mode=NextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<EmptyDataTemplate>
     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
        <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
            <th scope="col">流水号</th>
            <th scope="col">卡号</th>
            <th scope="col">实充金额</th>
            <th scope="col">奖励比例(%)</th>
            <th scope="col">奖励金额(元)</th>
            <th scope="col">充值日期</th>
            <th scope="col">店铺号</th>
            <th scope="col">办理店铺</th>
            <th scope="col">建立日期</th>
        </tr>
      </table>
</EmptyDataTemplate>
</asp:GridView> <asp:SqlDataSource id="SqlDataSource1" runat="server" SelectCommand="SELECT * FROM [d_consume]" ConnectionString="<%$ ConnectionStrings:carcn %>"></asp:SqlDataSource> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" SelectMethod="select" TypeName="dlogging">
            <SelectParameters>
                <asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
                <asp:Parameter Name="cardid" Type="String" DefaultValue="--"></asp:Parameter>
                <asp:Parameter Name="depotid" Type="String" DefaultValue="--"></asp:Parameter>
            </SelectParameters>
        </asp:ObjectDataSource> <asp:ObjectDataSource id="ObjectDataSource2" runat="server" SelectMethod="selectcommon" TypeName="dlogging">
            <SelectParameters>
                <asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
                <asp:Parameter Name="cardid" Type="String" DefaultValue="--"></asp:Parameter>
            </SelectParameters>
        </asp:ObjectDataSource> &nbsp;&nbsp;&nbsp;&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>    
</asp:UpdatePanel>
    </td>
</tr>
</table>


    <br />
</asp:Content>

