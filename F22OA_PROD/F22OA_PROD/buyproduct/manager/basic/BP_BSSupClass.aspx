<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSupClass, App_Web_bp_bssupclass.aspx.11713791" %>
 <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商级别管理</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
    
        
    <div  class="BContent">
    <table width="100%" cellpadding="1" cellspacing="1" align="center">
    <!----->
    <tr>
    <td>
    <table width="100%" height="400" bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1"  ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="TyperID" CellPadding="4" 
AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="TyperID" HeaderText="级别编号" >
<EditItemTemplate>
                     <asp:Label ID="LblTyperID" runat="server" Text='<%# Bind("TyperID") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("TyperID") %>'></asp:Label>
                
</ItemTemplate>
    <ItemStyle CssClass="hidden" />
    <HeaderStyle CssClass="hidden" />
    <FooterStyle CssClass="hidden" />
</asp:TemplateField>

<asp:TemplateField SortExpression="TyperNo" HeaderText="级别代码">
<EditItemTemplate>
                    <asp:TextBox ID="TxtTyperNo" runat="server" Text='<%# Bind("TyperNo") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVTyperNo" runat="server" ControlToValidate="TxtTyperNo" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="LblTyperName" runat="server" Text='<%# Bind("TyperNo") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="TxtTyperName" HeaderText="级别名称"><EditItemTemplate>
                    <asp:TextBox ID="TxtTyperName" runat="server" Text='<%# Bind("TyperName") %>' Width="120px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVTyperName" runat="server" ControlToValidate="TxtTyperName" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("TyperName") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TxtTtyperScore" HeaderText="级别分数"><EditItemTemplate>
                    <asp:TextBox ID="TxtTtyperScore" runat="server" Text='<%# Bind("TtyperScore") %>' Width="70px"></asp:TextBox>
                     <br />
                      <asp:RegularExpressionValidator ID="REVTtyperScore" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtTtyperScore" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator id="RFVTtyperScore" runat="server" ControlToValidate="TxtTtyperScore" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle Width="90px">
</HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label44" runat="server" Text='<%# Bind("TtyperScore") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Commet" HeaderText="备注"><EditItemTemplate>
                    <asp:TextBox ID="TextCommet" runat="server" Text='<%# Bind("Commet") %>' Width="100px"></asp:TextBox>
                
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("Commet") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>



<asp:TemplateField  HeaderText="操作"><EditItemTemplate>
<asp:LinkButton runat="server" Text="更新" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton runat="server" Text="编辑" CommandName="Edit" CausesValidation="False" id="LinkButton1"></asp:LinkButton>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            style="background-color:#507CD1;border-color:#999999;border-width:1px;border-style:None;width:100%;border-collapse:collapse;">
		 <tr  Class="dgHeader">
			<th scope="col">级别代码</th>
			<th scope="col">级别名称</th>
		    <th scope="col">级别分数</th>
			<th scope="col">备注</th>
		</tr>
		 <tr  bgcolor="White">
             <th scope="col"> &nbsp;</th>
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
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="CG_UpClassSupply" TypeName="ddl_cgnew" SelectMethod="CG_GetClassSupply" DeleteMethod="CG_DelClassSupply"  >
        <DeleteParameters>
            <asp:Parameter Name="TyperID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TyperID" Type="Int32" />
            <asp:Parameter Name="TyperNo" Type="String" />
            <asp:Parameter Name="TyperName" Type="String" />
            <asp:Parameter Name="TtyperScore" Type="Single" />
            <asp:Parameter Name="Commet" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
  
</td>
</tr>
     <tr>
     <td style="height: 1px" >
     <hr  style="display:inline;border:solid 0px #000;"/>
    
     </td>
     </tr>
<tr>
<td>
    
   
<table width="100%">
<tr>
<td align="left">
    &nbsp;级别代码：<asp:TextBox ID="TxtBoxCode" runat="server" CssClass="tbox" MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtBoxCode"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    级别名称：<asp:TextBox ID="TxtBoxName" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtBoxName"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    </td>
    <td></td>
</tr>
<tr>
<td align="left">
    &nbsp;级别分数：<asp:TextBox ID="TxtScore" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtScore"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="REVTtyperScore33" runat="server"  ValidationGroup="add"  ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtScore" Display="Dynamic"></asp:RegularExpressionValidator>备 &nbsp;&nbsp; 注：<asp:TextBox ID="TxtCommet" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    </td>
        <td align="center">
    <asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="增加级别" ValidationGroup="add"  CssClass="btn"  /></td>
</tr>
<tr>
<td align="center" colspan="2">
 <asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
</tr>
</table>
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

