<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_Findnochekchshop, App_Web_fp_findnochekchshop.aspx.a918743" title="Untitled Page" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">店铺列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->

   <div class="BContent"  style="height:100%">     
<table width="100%">
    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="3" DataKeyNames="WN_depotid"  CssClass="tbGrid" CellSpacing="1" 
                DataSourceID="ObjectDataSourceNochkshop" ForeColor="#333333" GridLines="None" Width="100%">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <Columns>
               
                    <asp:BoundField DataField="WN_depotid" HeaderText="店铺编号" ReadOnly="True" SortExpression="WN_depotid" />
                    <asp:BoundField DataField="d_name" HeaderText="店铺名称" SortExpression="d_name" />
                    <asp:BoundField DataField="Tel" HeaderText="电话" SortExpression="Tel" />
                    <asp:BoundField DataField="Fax" HeaderText="传真" SortExpression="Fax" />
                    <asp:BoundField DataField="email" HeaderText="电子邮箱" SortExpression="email" />
                </Columns>
                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle  CssClass="header" HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"  />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
     
            <asp:ObjectDataSource ID="ObjectDataSourceNochkshop" runat="server" SelectMethod="F22_GetStyleNochkShoplist" TypeName="ddl_FindProduct">
                <SelectParameters>
                   <asp:Parameter DefaultValue="-" Name="titlecode" Type="String" />
                    <asp:Parameter DefaultValue="1" Name="styleid" Type="String" />
                    <asp:Parameter DefaultValue="0" Name="intstate" Type="int16" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>
