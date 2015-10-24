<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindPublishchkHave, App_Web_fp_findpublishchkhave.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查发布审核</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>

</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
     <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">款式调查发布审核</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
        <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看未审申请" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='FP_FindPublishchk.aspx'; return false;"   />
      
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

    <div  class="BContent"  >
    <!----contant------------------>
  
        <table width="100%">
        <tr>
        <td>
            已审核款式调查发布列表：
        </td>
        </tr>
    <tr>
    <td valign="top">
    <asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="TitleCode" CellPadding="4" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"   PageSize="30">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="TitleCode" HeaderText="单据编号">
<ItemTemplate>
                    <asp:Label ID="LblmodelID" runat="server" Text='<%# Bind("TitleCode") %>'></asp:Label>          
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="TitleName" HeaderText="发布主题">
<ItemTemplate>
                    <asp:Label ID="Lblmodelname" runat="server" Text='<%# ZH.Public.ZHFuntion.GetLength( Eval("TitleName").ToString(),12) %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="modelname" HeaderText="调查模板">
<ItemTemplate>
    <asp:Label ID="Label5" runat="server" Text='<%# ZH.Public.ZHFuntion.GetLength(Eval("modelname").ToString(),12) %>'></asp:Label>          
</ItemTemplate>
</asp:TemplateField>


<asp:BoundField DataField="TitleDateBegin" HeaderText="开始时间" ReadOnly="True" SortExpression="TitleDateBegin" DataFormatString="{0:d}" HtmlEncode="False" />
<asp:BoundField DataField="TitleDateEnd" HeaderText="结束时间" ReadOnly="True" SortExpression="TitleDateEnd" DataFormatString="{0:d}" HtmlEncode="False" />
<asp:TemplateField  HeaderText="操作">
<ItemTemplate>
<a href='FP_FindPublishchkHaveDetail.aspx?TitleCode=<%# Eval("TitleCode") %>'>查看</a>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            style="background-color:#507CD1;border-color:#999999;border-width:1px;border-style:None;width:100%;border-collapse:collapse;">
		<tr class="header">
		
			<th scope="col">单据编号</th>
			<th scope="col">发布主题</th>
			<th scope="col">调查模板</th>
			<th scope="col">开始时间</th>
			<th scope="col">结束时间</th>
		</tr>
	
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle  CssClass="header" HorizontalAlign="Center" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
    <EditRowStyle  />
</asp:GridView>
 <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_FindProduct" DeleteMethod="DC_DelPublishMain" SelectMethod="DC_GetPublishUnchk"  >
        <DeleteParameters>
            <asp:Parameter Name="TitleCode" Type="String" />
        </DeleteParameters>
     <SelectParameters>
         <asp:Parameter DefaultValue="1" Name="state" Type="Int32" />
     </SelectParameters>
       
    </asp:ObjectDataSource>
  
    </td>
    </tr>
    </table>
     <!----contant------------------>
    </div>
    </form>
</body>
</html>
