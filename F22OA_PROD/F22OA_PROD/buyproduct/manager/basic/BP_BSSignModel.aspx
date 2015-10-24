<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSignModel, App_Web_bp_bssignmodel.aspx.11713791" %>
 <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购跟进流程管理</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
     <script type="text/javascript">
        var GB_ROOT_DIR = "../../../greybox/";
    </script>

    <script type="text/javascript" src="../../../greybox/AJS.js"></script>
    <script type="text/javascript" src="../../../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../../../greybox/gb_scripts.js"></script>
   <link href="../../../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
   	<script type="text/javascript">
GB_myShow = function(caption, url, /* optional */ height, width, callback_fn) {
    var options = {
        caption: caption,
        height: height || 550,
        width: width || 700,
        fullscreen: false,
        show_loading: false,
        callback_fn: callback_fn
    }
    var win = new GB_Window(options);
    return win.show(url);
}

</script>
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="新增模板" CssClass="btn"   OnClientClick="window.location.href='BP_BSSignModelAdd.aspx'; return false;"   />
    
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
        
    <div  class="BContent" style="height:100%">
    <table width="100%" cellpadding="1" cellspacing="1" align="center">
    <!----->
    <tr>
    <td>
    <table width="100%"  bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center"
 GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="SignModelID" CellPadding="4" 
AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="ModelNo" HeaderText="合同模板编号"><EditItemTemplate>
                     <asp:Label ID="LblModelNo" runat="server" Text='<%# Bind("ModelNo") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("ModelNo") %>'></asp:Label>
                
</ItemTemplate>
<HeaderStyle Width="90px"></HeaderStyle>
</asp:TemplateField>



<asp:TemplateField SortExpression="ModelName" HeaderText="合同模板名称"><EditItemTemplate>
                    <asp:TextBox ID="TxtModelName" runat="server" Text='<%# Bind("ModelName") %>' Width="70px"></asp:TextBox>
                     <br />
                    
</EditItemTemplate>



<ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ModelName") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="ModelComment" HeaderText="备注"><EditItemTemplate>
                    <asp:TextBox ID="TxtModelComment" runat="server" Text='<%# Bind("ModelComment") %>' Width="100px"></asp:TextBox>
                
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("ModelComment") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>



<asp:TemplateField  HeaderText="操作"><EditItemTemplate>
<asp:LinkButton runat="server" Text="更新" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
   <a href='BP_BSSignModelEdit.aspx?sid=<%# Eval("SignModelID") %>'>编辑</a>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField  HeaderText="查看">
<ItemTemplate>
     <a href='BP_BSSignModelDetail.aspx?sid=<%# Eval("SignModelID") %>' rel="gb_pageset[search_sites]"><img src="../../../icon/go3.gif" border="0" />查看</a>
                
</ItemTemplate>
</asp:TemplateField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            style="background-color:#507CD1;border-color:#999999;border-width:1px;border-style:None;width:100%;border-collapse:collapse;">
		 <tr  Class="dgHeader">
			<th scope="col">合同模板编号</th>
			<th scope="col">合同模板名称</th>
			<th scope="col">备注</th>
		</tr>
	 <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle CssClass="header" HorizontalAlign="Center" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
    <EditRowStyle  />
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_cgnew" SelectMethod="CG_GetSignModel" DeleteMethod="CG_DelSignModel"   >
        <DeleteParameters>
            <asp:Parameter Name="SignModelID" Type="Int32" />
        </DeleteParameters>
      
    </asp:ObjectDataSource>
  
</td>
</tr>
     <tr>
     <td style="height: 1px" >
    
     </td>
     </tr>
<tr>
<td>
    

   </td>
</tr>
</table>
    </td>
    </tr>
    <!----->
    
    </table>
 
    
    </div>
    </form>
</body>
</html>

