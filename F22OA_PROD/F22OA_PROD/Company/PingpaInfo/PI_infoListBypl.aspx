<%@ page language="C#" autoeventwireup="true" inherits="Company_PingpaInfo_PI_infoListBypl, App_Web_pi_infolistbypl.aspx.1b4e1445" title="Untitled Page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
                <asp:Label ID="Label1" runat="server" Text="品牌名称:" Width="62px"></asp:Label>
                <asp:TextBox ID="TxtPingID" runat="server" Width="163px"></asp:TextBox>
                 <asp:Label ID="Label2" runat="server" Text="销售年份:" Width="62px"></asp:Label>
                <asp:DropDownList ID="DDLMothsart" runat="server">
             
                 </asp:DropDownList>
                <asp:Button ID="BtnSearch" runat="server" Text="查询" CssClass="btn" Width="100px" OnClick="BtnSearch_Click" /></td>
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
              AutoGenerateColumns="False" DataSourceID="ODSourcePinglist" Width="100%" CellPadding="4" CellSpacing="1" ForeColor="#333333" GridLines="None" OnRowCreated="GridViewPinpalist_RowCreated">
              <Columns>
                  <asp:TemplateField HeaderText="品牌名称">
                      <ItemTemplate>
                          
                              <a href="<%# Eval("compete", "PI_infoListByplShoplist.aspx?pname={0}&year="+strYear) %>" target="_blank"><%# Eval("compete")%></a>
                      </ItemTemplate>
                  </asp:TemplateField>
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
              <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="dgHeader"  />
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <EditRowStyle BackColor="#2461BF" />
                   <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                   <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                   <AlternatingRowStyle BackColor="White" />
                   <EmptyDataTemplate>
                       <table cellspacing="1" cellpadding="4" border="0" id="ctl00_ctplhder_GridViewPinpalist" style="color:#333333;width:100%;">
		<tr align="center" valign="middle" class="dgHeader" >
			<td colspan="2"></td><td colspan="12">月销售额</td>
		</tr>
		<tr align="center" valign="middle" class="dgHeader">
			<th scope="col">品牌名称</th><th scope="col">年份</th><th scope="col">1月份</th><th scope="col">2月份</th><th scope="col">3月份</th><th scope="col">4月份</th><th scope="col">5月份</th><th scope="col">6月份</th><th scope="col">7月份</th><th scope="col">8月份</th><th scope="col">9月份</th><th scope="col">10月份</th><th scope="col">11月份</th><th scope="col">12月份</th>
		</tr>
		<tr align="center" valign="middle" style="background-color:#EFF3FB;">
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
                   </EmptyDataTemplate>
          </asp:GridView>
    
                 
          <asp:ObjectDataSource ID="ODSourcePinglist" runat="server" SelectMethod="F22_GetPinpaByNameYear"
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

