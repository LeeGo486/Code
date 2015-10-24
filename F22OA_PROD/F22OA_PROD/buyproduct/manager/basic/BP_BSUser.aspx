<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSUser, App_Web_bp_bsuser.aspx.11713791" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商级别管理</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/project.js"></script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
    
        
    <div  class="BContent">
    <table width="100%" cellpadding="1" cellspacing="1" align="center">
    <tr>
    <td align="right">
    <asp:Button ID="BtnAddItem" runat="Server"  Text="增加管理员" OnClientClick="LoadWindow('BP_BSUserSelect.aspx','860','653')" ValidationGroup="add"  CssClass="btn"  /><br />
    </td>
    </tr>
    <!----->
    <tr>
    <td>
    <table width="100%" height="400" bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1"  
 ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None"
  DataSourceID="ObjectDataSource1" DataKeyNames="userNo" CellPadding="4" 
AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="userNo" HeaderText="级别编号" >
<EditItemTemplate>
                     <asp:Label ID="LblTyperID" runat="server" Text='<%# Bind("userNo") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("userNo") %>'></asp:Label>
                
</ItemTemplate>
    <ItemStyle CssClass="hidden" />
    <HeaderStyle CssClass="hidden" />
    <FooterStyle CssClass="hidden" />
</asp:TemplateField>

<asp:TemplateField SortExpression="userid" HeaderText="编号">
<EditItemTemplate>
                    <asp:TextBox ID="Txtuserid" runat="server" ReadOnly="true" Text='<%# Bind("userid") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVTyperNo" runat="server" ControlToValidate="Txtuserid" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="LblTyperName" runat="server" Text='<%# Bind("userid") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="username" HeaderText="名称"><EditItemTemplate>
                    <asp:TextBox ID="Txtusername" runat="server" Text='<%# Bind("username") %>' Width="120px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVTyperName" runat="server" ControlToValidate="Txtusername" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="usermain" HeaderText="管理员">
<EditItemTemplate>
              <asp:CheckBox ID="CheckBoxCom" runat="server" />
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label57" runat="server" Text='<%# Eval("usermain").ToString()=="True"?"是":"否" %>'></asp:Label>
                
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
			<th scope="col">编号</th>
			<th scope="col">名称</th>

		</tr>
		 <tr  bgcolor="White">
             <th scope="col"> &nbsp;</th>
             <th scope="col"> &nbsp;</th>

          </tr>
	
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle CssClass="header" HorizontalAlign="Center" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="CG_UpUser" TypeName="ddl_cgnew" 
 SelectMethod="CG_GetUser" DeleteMethod="CG_DelUser"  >
        <DeleteParameters>
            <asp:Parameter Name="userNo" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="userNo" Type="Int32" />
            <asp:Parameter Name="userid" Type="String" />
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="usermain"  Type="Boolean"/>
        </UpdateParameters>
    </asp:ObjectDataSource>
  
</td>
</tr>
     <tr>
     <td style="height: 1px" >
    
     </td>
     </tr>
<tr>
<td>
    
   
<table width="100%">
<tr>
<td align="left">
    &nbsp;<asp:TextBox ID="TxtBoxCode" runat="server" CssClass="tbox" MaxLength="50" Width="200px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtBoxName" runat="server" CssClass="tbox"  MaxLength="50" Width="200px" Visible="False"></asp:TextBox>
    </td>
    <td>
    </td>
</tr>
<tr>
<td align="left">
    <asp:CheckBox ID="CheckBoxCom" runat="server" Visible="False" /></td>
        <td align="center">
    </td>
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


