<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_Card_queryMonth, App_Web_card_querymonth.aspx.f3086b61" %>
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
        <TABLE style="WIDTH: 800px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD style="WIDTH: 800px"><FIELDSET>
        <LEGEND>查询条件</LEGEND><TABLE><TBODY><TR><TD style="WIDTH: 27px; TEXT-ALIGN: left">&nbsp; 
        <asp:Label id="Label1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="50px" Text="时间起始"></asp:Label> </TD>
        <TD style="TEXT-ALIGN: left">
        <igsch:WebDateChooser id="WebDateChooser1" runat="server" Width="101px" Height="10px" AllowNull="False"></igsch:WebDateChooser>
        </TD>
        <TD style="WIDTH: 20px">&nbsp; <asp:Label id="Label2" runat="server" Font-Size="9pt" Font-Names="宋体" Width="49px" Text="时间结止"></asp:Label> </TD><TD style="TEXT-ALIGN: left">
        <igsch:WebDateChooser id="WebDateChooser2" runat="server" Width="101px" Height="9px" AllowNull="False"></igsch:WebDateChooser>
        </TD><TD style="WIDTH: 405px">&nbsp; &nbsp; &nbsp;&nbsp;<asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Font-Size="9pt" Font-Names="宋体" Width="60px" Text="查询" Height="24px"></asp:Button> <asp:Button id="Button1" runat="server" Font-Size="9pt" Font-Names="宋体" Width="60px" Text="打印" Height="24px"></asp:Button> </TD></TR></TBODY></TABLE></FIELDSET> </TD></TR></TBODY></TABLE>　　　　　　　 
    </td>
    </tr>
    <tr>
        <td>
<asp:UpdatePanel id="UpdatePanel2" runat="server">  
    <contenttemplate>

<TABLE style="WIDTH: 850px" cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR><TD style="HEIGHT: 36px" colSpan=6>
<asp:GridView id="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound" GridLines="None" 
CellPadding="4" AutoGenerateColumns="False" ForeColor="#333333" AllowSorting="True" PageSize="15">
<PagerSettings PreviousPageText="上一页" Mode="NextPreviousFirstLast" LastPageText="末页" FirstPageText="首页" NextPageText="下一页"></PagerSettings>
<FooterStyle BackColor="#EFF3EE" HorizontalAlign="Center" Font-Bold="True"></FooterStyle>
<Columns>
<asp:BoundField DataField="cardid" SortExpression="cardid" HeaderText="卡号"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="bsum" AccessibleHeaderText="月初余额" SortExpression="bsum" HeaderText="月初余额"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="addsum" AccessibleHeaderText="本月充值额" SortExpression="addsum" HeaderText="本月充值额"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="ratsum" AccessibleHeaderText="本月奖励" SortExpression="ratsum" HeaderText="本月奖励"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="outsum" AccessibleHeaderText="本月消费额" SortExpression="outsum" HeaderText="本月消费额"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="ysum" AccessibleHeaderText="年费" SortExpression="ysum" HeaderText="年费"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="esum" AccessibleHeaderText="月末余额" SortExpression="esum" HeaderText="月末余额"></asp:BoundField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>
<EmptyDataTemplate>
     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
        <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
      
            <th scope="col">卡号</th>
            <th scope="col">月初余额</th>
            <th scope="col">本月充值额</th>
            <th scope="col">本月奖励</th>
            <th scope="col">本月消费额</th>
            <th scope="col">年费</th>
            <th scope="col">月末余额</th>
        </tr>
      </table>
</EmptyDataTemplate>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView>
</TD></TR></TBODY></TABLE>
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="dlogging" SelectMethod="Card_GetMonthData">
<SelectParameters>
    <asp:Parameter Name="datebeg" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
    <asp:Parameter Name="dateend" Type="String" DefaultValue="1900-01-01"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 
</contenttemplate>
    </asp:UpdatePanel>

        </td>
    </tr>
</table>
    
    
</asp:Content>

