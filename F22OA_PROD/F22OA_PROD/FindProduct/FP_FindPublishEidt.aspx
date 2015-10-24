<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindPublishEidt, App_Web_fp_findpublisheidt.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>发布申请维护列表（未审）</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">发布申请维护（未审）</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="新增调查发布" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='FP_FindPublish.aspx'; return false;"   />
     
        </td> 
    </tr>
    </table>
    <!--menu----->
  
    <div>
    <table width="100%">
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
<a href='FP_FindPublishEidtDetail.aspx?TitleCode=<%# Eval("TitleCode") %>'>查看修改</a>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table id="ctl00_ctplhder_GridView11" cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
		 <tr  Class="dgHeader">
		
			<th scope="col">单据编号</th>
			<th scope="col">发布主题</th>
			<th scope="col">调查模板</th>
			<th scope="col">开始时间</th>
			<th scope="col">结束时间</th>
		</tr>
	
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle  CssClass="header" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
    <EditRowStyle  />
</asp:GridView>
 <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_FindProduct" DeleteMethod="DC_DelPublishMain" SelectMethod="DC_GetPublishUnchk"  >
        <DeleteParameters>
            <asp:Parameter Name="TitleCode" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
  
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
