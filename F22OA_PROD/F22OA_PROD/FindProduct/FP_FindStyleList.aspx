<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindStyleList, App_Web_fp_findstylelist.aspx.a918743" %>

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
					<span id="rm_MainPanel_lFunctionName">款式列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
>
   <div class="BContent"  style="height:100%">     
<table width="100%">
    <tr>
        <td>
               <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%"  CssClass="tbGrid" CellSpacing="1" 
                                            AutoGenerateColumns="False" DataKeyNames="styleid"  CellPadding="4"  BorderWidth="1" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center" >
                                            <Columns>
                                                
                     <asp:BoundField DataField="styleid" HeaderText="款式编号" ReadOnly="True" SortExpression="styleid" />
                             
                                                <asp:TemplateField HeaderText="款式名称" SortExpression="s_name">
                                               
                                                    <ItemTemplate>
                                                        <asp:Label ID="Labeld_name" runat="server" Text='<%# Bind("s_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                              <asp:BoundField DataField="J_cost" HeaderText="成本价" ReadOnly="True" SortExpression="J_cost" />
                                               <asp:BoundField DataField="J_price" HeaderText="结算价" ReadOnly="True" SortExpression="J_price" />
                                               <asp:BoundField DataField="comment" HeaderText="备注" ReadOnly="True" SortExpression="comment" />
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle CssClass="header" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dgHeader"   HorizontalAlign="Center"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                              <EmptyDataTemplate>
                                                <table cellspacing="0" cellpadding="0" border="1" height="5px" id="GridView1" style="color:#333333;font-size:10pt;width:100%;border-collapse:collapse;">
			                                        <tr class="header" height="3px" >
				                                        <th scope="col">&nbsp;</th>
				                                        <th scope="col"><a href="#" >款式编号</a></th>
				                                        <th scope="col"><a href="#" >款式名称</a></th>
			                                        </tr>
			                                   
			
		                                            </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSourceNochkshop" runat="server" SelectMethod="F22_GetStylelist" TypeName="ddl_FindProduct">
                <SelectParameters>
                   <asp:Parameter DefaultValue="-" Name="titlecode" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>
