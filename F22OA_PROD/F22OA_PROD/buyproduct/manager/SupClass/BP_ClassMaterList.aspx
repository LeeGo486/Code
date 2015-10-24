<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_SupClass_BP_ClassMaterList, App_Web_bp_classmaterlist.aspx.b80b976e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料分配审核</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
           <script language="javascript" type="text/javascript">
           function GoUrlShowAddTrack(pid) 
           {
		      var url="BP_PublishSuperList.aspx?SupmaterID="+pid
	          LoadWindow(url,860,653);
	       }
            </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">历史供货记录</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
  
    
        
    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
    <tr>
    <td><asp:Label ID="LblTitle" runat="server"  Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupmaterID"  CssClass="tbGrid" CellSpacing="1"  
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:BoundField DataField="PublishCode" HeaderText="PublishCode" ReadOnly="True" SortExpression="PublishCode" Visible="False" />
                    <asp:BoundField DataField="MaterID" HeaderText="物料编号" SortExpression="MaterID" />
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="Maternum" HeaderText="供应量" SortExpression="Maternum" />
                   <asp:BoundField DataField="Score" HeaderText="综合所得分" SortExpression="Score"  /> 
                 
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">物料编号</th>
                            <th scope="col">物料名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">采购数量</th>
                            <th scope="col">供应商编号</th>
                            <th scope="col">供应商供应量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货日期</th>
                    </tr>
                      <tr  bgcolor="White">
                      <th scope="col"></th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetClassSupMater" TypeName="ddl_cgnew" OldValuesParameterFormatString="original_{0}" >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSupplyerID" Name="SupplyerID" PropertyName="Value"
                    Type="String" />
            </SelectParameters>
           
        </asp:ObjectDataSource>
    </td>
    </tr>
        <tr>
    <td>
    <table width="100%">

        <tr>
    <td valign="top">
        &nbsp;
        <asp:HiddenField ID="HFSupplyerID" runat="server" />
    
    </td>
   
    </tr>
    </table>
    </td>
    </tr>
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>

