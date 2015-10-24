<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_dloggingQryDtBegEnd, App_Web_dloggingqrydtbegend.aspx.f3086b61" title="Untitled Page" %>

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
<table width="100%">
    <tr>
        <td>
      <%--  <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD style="WIDTH: 800px"><FIELDSET>
<LEGEND>查询条件</LEGEND><TABLE><TBODY><TR><TD style="WIDTH: 27px; TEXT-ALIGN: left">&nbsp; 
<asp:Label id="Label1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="50px" Text="时间起始"></asp:Label> </TD>
<TD style="TEXT-ALIGN: left">
<%--<igsch:WebDateChooser id="WebDateChooser1" runat="server" Font-Size="9pt" Font-Names="宋体" AllowNull="False" Value="2007-08-07" NullDateLabel Height="11px"></igsch:WebDateChooser> --%>
<igsch:WebDateChooser id="WebDateChooser1" runat="server" Width="101px" Height="10px" AllowNull="False"></igsch:WebDateChooser>
</TD>
<TD style="WIDTH: 20px">&nbsp; <asp:Label id="Label2" runat="server" Font-Size="9pt" Font-Names="宋体" Width="49px" Text="时间结止"></asp:Label> </TD><TD style="TEXT-ALIGN: left">
<igsch:WebDateChooser id="WebDateChooser2" runat="server" Width="101px" Height="9px" AllowNull="False"></igsch:WebDateChooser>
<asp:CompareValidator id="CompareValidator1" runat="server" Font-Size="9pt" Font-Names="宋体" Display="Dynamic" Operator="GreaterThanEqual" Type="Date" ControlToCompare="WebDateChooser1" SetFocusOnError="True" ErrorMessage="日期填写不正确" ControlToValidate="WebDateChooser2"></asp:CompareValidator></TD><TD style="WIDTH: 405px">&nbsp;<asp:Label id="lbldepot" runat="server" Font-Size="9pt" Font-Names="宋体" Width="36px" Text="店铺："></asp:Label> <asp:TextBox id="txtdepotid" runat="server" Font-Size="9pt" Font-Names="宋体" Width="58px" BorderStyle="None"></asp:TextBox>&nbsp;&nbsp;<asp:Button id="btnSelectDepot" runat="server" Font-Size="9pt" Font-Names="宋体" Width="64px" Text="选择店铺" Height="20px" OnClientClick="GoUrlVipShop()"></asp:Button> <asp:TextBox id="TextBox1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="79px" BorderStyle="None" BackColor="#ECF3F6"></asp:TextBox>&nbsp;<asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Font-Size="9pt" Font-Names="宋体" Width="60px" Text="查询" Height="24px"></asp:Button> <asp:Button id="Button1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="60px" Text="打印" Height="24px"></asp:Button> </TD></TR></TBODY></TABLE></FIELDSET> </TD></TR></TBODY></TABLE>　　　　　　　 
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
        </td>
    </tr>
    <tr>
        <td>
  
    <asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>
<TABLE style="WIDTH: 850px" cellSpacing=0 cellPadding=0 align="left" border=0><TBODY><TR><TD style="HEIGHT: 36px" colSpan=6>
<asp:GridView id="GridView1" runat="server" Width="100%" GridLines="None" CellPadding="4" AutoGenerateColumns="False" 
      ForeColor="#333333"  AllowSorting="True" AllowPaging=True  PageSize=15 DataSourceID="ObjectDataSource1" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
                            *
                        
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="loggingid" AccessibleHeaderText="流水号" HeaderText="流水号"  SortExpression="loggingid"></asp:BoundField>
<asp:BoundField DataField="cardid" HeaderText="卡号"  SortExpression="cardid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="insums" AccessibleHeaderText="实充金额" HeaderText="实充金额(元)"  SortExpression="insums"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="rate" AccessibleHeaderText="奖励比例(%)" HeaderText="奖励比例(%)"  SortExpression="rate"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="bounty" AccessibleHeaderText="奖励金额(元)" HeaderText="奖励金额(元)"  SortExpression="bounty"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sure_date" AccessibleHeaderText="充值日期" HeaderText="充值日期" DataFormatString={0:d} HtmlEncode=False  SortExpression="sure_date"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" AccessibleHeaderText="店铺号" HeaderText="店铺号"  SortExpression="depotid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="d_name" AccessibleHeaderText="办理店铺" HeaderText="办理店铺"  SortExpression="d_name"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="crdate" AccessibleHeaderText="建立日期" HeaderText="建立日期" DataFormatString={0:d} HtmlEncode=False  SortExpression="crdate"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="comment" AccessibleHeaderText="备注" HeaderText="备注"  SortExpression="comment"></asp:BoundField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
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
</asp:GridView>&nbsp; &nbsp;&nbsp;
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="dlogging" SelectMethod="selectDateBegEnd">
            <SelectParameters>
                <asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
                <asp:Parameter Name="datebeg" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
                <asp:Parameter Name="dateend" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
                <asp:Parameter Name="strdepotid" Type="String" DefaultValue="--"></asp:Parameter>
            </SelectParameters>
        </asp:ObjectDataSource> 
        
        <asp:ObjectDataSource id="ObjectDataSource2" runat="server" TypeName="dlogging" SelectMethod="selectDateBegEndCommon">
            <SelectParameters>
                <asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
                <asp:Parameter Name="datebeg" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
                <asp:Parameter Name="dateend" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
            </SelectParameters>
        </asp:ObjectDataSource> 

</TD></TR></TBODY>

</TABLE>
</contenttemplate>
    </asp:UpdatePanel>
        </td>
    </tr>
</table>
    
    
</asp:Content>

