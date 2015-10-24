<%@ page language="C#" autoeventwireup="true" inherits="Company_PingpaInfo_PI_infoListByplShoplist, App_Web_pi_infolistbyplshoplist.aspx.1b4e1445" title="Untitled Page" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式调查结果</title>
  <link   href="../../css/project.css" type="text/css"  rel="stylesheet">
	
</head>
<body> 
    <form id="form1" runat="server">
     <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">竟争品牌调查</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <div class="BContent">
<table width="100%" >
    <tr>
      <td align="left">
         <table width="100%">
         <tr>
            <td align="left">
                &nbsp; &nbsp;
            </td>
         </tr>
         </table>
        
      </td>
    </tr>
    <tr>
      <td>
      <table width="100%" class="tbborderB">
          <tr>
             <td>
               <asp:GridView ID="GridViewPinpalist" runat="server" AllowPaging="True" AllowSorting="True"
              AutoGenerateColumns="False"   CssClass="tbGrid"  DataSourceID="ODSourcePinglist" Width="100%" CellPadding="4" CellSpacing="1" ForeColor="#333333" GridLines="None" OnRowCreated="GridViewPinpalist_RowCreated">
              <Columns>
                 
                  <asp:BoundField DataField="compete" HeaderText="品牌名称" SortExpression="compete" />
                  <asp:BoundField DataField="d_name" HeaderText="店铺名称" SortExpression="d_name" />
                    <asp:BoundField DataField="years" HeaderText="年份" SortExpression="years" />
                  <asp:BoundField DataField="m1" HeaderText="1月份" SortExpression="months" />
                  <asp:BoundField DataField="m2" HeaderText="2月份" />
                  <asp:BoundField DataField="m3" HeaderText="3月份" />
                  <asp:BoundField DataField="m4" HeaderText="4月份" />
                  <asp:BoundField DataField="m5" HeaderText="5月份" />
                  <asp:BoundField DataField="m6" HeaderText="6月份" />
                  <asp:BoundField DataField="m7" HeaderText="7月份" />
                  <asp:BoundField DataField="m8" HeaderText="8月份" />
                  <asp:BoundField DataField="m9" HeaderText="9月份" />
                  <asp:BoundField DataField="m10" HeaderText="10月份" />
                  <asp:BoundField DataField="m11" HeaderText="11月份" />
                  <asp:BoundField DataField="m12" HeaderText="12月份" />
              </Columns>
              <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
              <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="dgHeader"/>
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <EditRowStyle BackColor="#2461BF" />
                   <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                   <PagerStyle CssClass="header" HorizontalAlign="Center" />
                   <AlternatingRowStyle BackColor="White" />
          </asp:GridView>
                 &nbsp;
          
          <asp:ObjectDataSource ID="ODSourcePinglist" runat="server" SelectMethod="F22_GetPinpaByNameYearShop"
              TypeName="ddl_FindProduct">
              <SelectParameters>
                  <asp:Parameter DefaultValue="-" Name="compete" Type="String" />
                  <asp:Parameter DefaultValue="2007" Name="year" Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>
             </td>
          </tr>
      </table>
      </td>
    </tr>
</table>
</div>
  </form>
</body>
</html>


