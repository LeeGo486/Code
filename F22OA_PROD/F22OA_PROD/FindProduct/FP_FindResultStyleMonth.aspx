<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindResultStyleMonth, App_Web_fp_findresultstylemonth.aspx.a918743" title="Untitled Page" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式销售报表</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
  <style type="text/css">
  A:link {
	COLOR: #005a5a; TEXT-DECORATION: none
}
  </style>
	
		<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">款式销售报表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->

      <div  class="BContent" style="width:100%">
<table width="100%">
<tr>
<td align="center" style="font-size: 18pt">
款式销售报表
</td>
</tr>
<tr>
<td align="left">
    销售总量:
    <asp:Label ID="LblAllNum" runat="server"></asp:Label></td>
</tr>
<tr>
<td align="left">

    <table width="100%">
    <tr>
    <td>
    销售数量前五名店铺:
    </td>
    </tr>
   
    <tr>
    <td>
     <asp:GridView ID="Gridtop5" runat="server" AllowPaging="True" AllowSorting="True"
              AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
              ForeColor="#333333" GridLines="None" Width="100%">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
                 
                  <asp:BoundField DataField="depotid" HeaderText="店铺编号" ReadOnly="True" SortExpression="depotid" />
                     
                  <asp:BoundField DataField="d_name" HeaderText="店铺名称" ReadOnly="True" SortExpression="d_name" />
                 <asp:BoundField DataField="nums" HeaderText="销售数量" ReadOnly="True" SortExpression="nums" />
               <asp:BoundField DataField="price" HeaderText="销售金额" ReadOnly="True" SortExpression="price" />
                
              </Columns>
              <RowStyle BackColor="#EFF3FB" />
              <EditRowStyle BackColor="#2461BF" />
              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
              <PagerStyle   CssClass="header" HorizontalAlign="Center" />
              <HeaderStyle   CssClass="header"  />
              <AlternatingRowStyle BackColor="White" />
               <EmptyDataTemplate>
              <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
		 <tr  Class="dgHeader">
			<th scope="col"><a href="#" style="color:White;">店铺编号</a></th>
			<th scope="col"><a href="#" style="color:White;">店铺名称</a></th>
			<th scope="col"><a href="#" style="color:White;">销售数量</a></th>
			<th scope="col"><a href="#" style="color:White;">销售金额</a></th>
		</tr>
	</table>
              </EmptyDataTemplate>
          </asp:GridView>
     
        
    </td>
    </tr>
    </table>
    </td>
</tr>
<tr>
<td align="left">
    
     <table width="100%">
    <tr>
    <td>
    <br />
<br />
     本月销售排行:
    </td>
    </tr>
   
    <tr>
    <td>
    <asp:GridView ID="GridMonth" runat="server" AllowPaging="True" AllowSorting="True"
              AutoGenerateColumns="False" CellPadding="3" 
              ForeColor="#333333" GridLines="None" Width="100%">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
                 
                  <asp:BoundField DataField="depotid" HeaderText="店铺编号" ReadOnly="True" SortExpression="depotid" />
                     
                  <asp:BoundField DataField="d_name" HeaderText="店铺名称" ReadOnly="True" SortExpression="d_name" />
                 <asp:BoundField DataField="nums" HeaderText="销售数量" ReadOnly="True" SortExpression="nums" />
               <asp:BoundField DataField="price" HeaderText="销售金额" ReadOnly="True" SortExpression="price" />
                
              </Columns>
              <RowStyle BackColor="#EFF3FB" />
              <EditRowStyle BackColor="#2461BF" />
              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
              <PagerStyle CssClass="header"  HorizontalAlign="Center" />
              <HeaderStyle CssClass="dgHeader" />
              <AlternatingRowStyle BackColor="White" />
              <EmptyDataTemplate>
              <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
		<tr   class="header">
			<th scope="col"><a href="#" style="color:White;">店铺编号</a></th>
			<th scope="col"><a href="#" style="color:White;">店铺名称</a></th>
			<th scope="col"><a href="#" style="color:White;">销售数量</a></th>
			<th scope="col"><a href="#" style="color:White;">销售金额</a></th>
		</tr>
	</table>
              </EmptyDataTemplate>
          </asp:GridView>
   
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

