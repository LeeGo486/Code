<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_type, App_Web_mat_type.aspx.e229d74d" %>
<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>店铺施工单位</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
 <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
	<script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>
    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script> 
</head>
<body> 
<form id="form1" runat="server" >
<uc1:uc_pagehead id="Uc_pagehead1" runat="server" /> 
<div  class="BContent" >
<table width="100%">    
<tr> 
    <td>
   <a id="abtnAdd" runat="server" style="width:100px" href="mat_type_add.aspx"  rel="gb_page_center[300,150]"> 
      <input type="button" id="Button1" style="width:100px;" runat="server" value="添加种类" class="btn" />
   </a>
   <a id="A1" runat="server" style="width:100px" href="mat_type_addx.aspx"  rel="gb_page_center[300,150]"> 
      <input type="button" id="Button2" style="width:100px;" runat="server" value="添加品类" class="btn" />
   </a>
      <asp:Button ID="btnChk_sure" Width="100px" runat="server" CssClass="btn" Text="审核" OnClick="btnChk_sure_Click" />
      <asp:Button ID="btnunChk_sure" Width="100px" runat="server" CssClass="btn" Text="反审核" OnClick="btnunChk_sure_Click" />
      <asp:Button ID="btnDel" Width="100px" runat="server" CssClass="btn" Text="删除" OnClick="btnDel_Click" />
    <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click" />
   
    </td>
</tr>
<tr>
  <td> 
      <asp:ScriptManager ID="ScriptManager1" runat="server">
      </asp:ScriptManager>
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
      <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="typeid"
          AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
          ForeColor="#333333" GridLines="None" Width="100%" PageSize="15" 
          onpageindexchanged="gv_PageIndexChanged" onrowcommand="gv_RowCommand" 
           onrowcreated="gv_RowCreated"  onrowdeleted="gv_RowDeleted" 
         onpageindexchanging="gv_PageIndexChanging" onrowdeleting="gv_RowDeleting">
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <Columns>           
            <asp:TemplateField HeaderText="选择" >
                <HeaderTemplate><asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                </HeaderTemplate>
                <ItemTemplate><asp:CheckBox runat="server"  ID="ckbDel" Width="2%" OnCheckedChanged="chk_OnCheckedChanged" AutoPostBack="true"  ToolTip='<%# Eval("typeid") %>'  /> </ItemTemplate>
            </asp:TemplateField>                    
              <asp:BoundField DataField="typeid" HeaderText="编号"  />           
              <asp:TemplateField HeaderText="类别名称"><ItemTemplate>
               <a style="text-decoration:underline" href='mat_type_upd.aspx?id=<%# Eval("typeid") %>&chk_sure=<%# Eval("chk_sure") %> '  rel="gb_page_center[600,400]"><%# Eval("typename")%></a>
              </ItemTemplate>
              </asp:TemplateField>    
             <asp:TemplateField HeaderText="审核">
                  <ItemTemplate>  <%# Eval("chk_sure").ToString() == "1" ? "是" : "否" %> </ItemTemplate>
              </asp:TemplateField>   
              <asp:BoundField DataField="chk_date" HeaderText="审核时间" SortExpression="chk_date" DataFormatString="{0:d}" />           
              <asp:BoundField DataField="chk_name" HeaderText="审核人"  />           
              <asp:BoundField DataField="crdate" HeaderText="创建时间" SortExpression="crdate" DataFormatString="{0:d}" HtmlEncode="False" />
              <asp:BoundField DataField="crname" HeaderText="创建人" />   
              <asp:TemplateField  HeaderText="备注" HeaderStyle-Width="60" >
               <ItemTemplate>
               <%# Eval("comment").ToString().Length > 10 ? "<marquee  width='60' scrolldelay='300'>" + Eval("comment") + "</marquee>" : Eval("comment")%>
                </ItemTemplate>
            </asp:TemplateField>  
           <asp:TemplateField>
            <ItemTemplate>                
            <asp:ImageButton id="btnDel" runat="server" ImageUrl="../icon/delete.gif" CommandName="delete" OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" />
            </ItemTemplate>
            </asp:TemplateField>  
          </Columns>
          <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
         <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
           <EmptyDataTemplate>
          <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
	    <tr class="header" >
		<th scope="col"><a href="#">编号</a></th>
		<th scope="col"><a href="#" >类别名称</a></th>
		<th scope="col"><a href="#" >审核</a></th>	
		<th scope="col"><a href="#" >审核时间</a></th>	
		<th scope="col"><a href="#" >审核人</a></th>	
		<th scope="col"><a href="#" >创建时间</a></th>
		<th scope="col"><a href="#" >创建人</a></th>
		<th scope="col"><a href="#" >备注</a></th>			
	  </tr>
      </table>
          </EmptyDataTemplate>
          <EditRowStyle BackColor="#2461BF" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <PagerStyle CssClass="header"  HorizontalAlign="Left" />
          <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
          <AlternatingRowStyle BackColor="White" />
      </asp:GridView>
       </ContentTemplate>
       <Triggers>
               <asp:AsyncPostBackTrigger ControlID="BtnSearch" />
               <asp:AsyncPostBackTrigger ControlID="btnDel" />
               <asp:AsyncPostBackTrigger ControlID="btnChk_sure" />
               <asp:AsyncPostBackTrigger ControlID="btnunChk_sure" />
          </Triggers>
      
      </asp:UpdatePanel>   
  </td>
</tr>
</table>
     
    </div>
    </form>
</body>
</html>