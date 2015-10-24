<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindPublishchk, App_Web_fp_findpublishchk.aspx.a918743" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查发布审核</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
	
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		    <script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>

    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script>
   <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />


</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
<uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
    <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看已审调查" CssClass="btn"  CausesValidation="false"  OnClientClick="window.location.href='FP_FindPublishchkHave.aspx'; return false;"   />

     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
   
    <div  class="BContent"  style="height:100%">
    <!----contant------------------>
  
        <table width="100%">
        <tr>
        <td>
        待审核款式调查发布列表：
        </td>
        </tr>
    <tr>
    <td valign="top">
    <asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="TitleCode" CellPadding="4" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"   PageSize="30">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="TitleCode" HeaderText="单据编号">
<ItemTemplate>
<a href="FP_FindPublishchkDetail.aspx?TitleCode=<%# Eval("TitleCode")%>" 
                     rel="gb_pageset[search_sites]" title='<%# Eval("TitleCode")%>发布明细' target="_blank"><%# Eval("TitleCode") %></a>
                        
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
<a href='FP_FindPublishchkDetail.aspx?TitleCode=<%# Eval("TitleCode") %>'>进入审核</a>&nbsp;

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
         <asp:Parameter DefaultValue="0" Name="state" Type="Int32" />
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
