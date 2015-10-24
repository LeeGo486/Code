<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_bs_model, App_Web_fp_bsmodel.aspx.a918743" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
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
<td valign="top" style="height: 356px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="modelid" CellPadding="4" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="modelid" HeaderText="方案编号">
<EditItemTemplate>
                     <asp:Label ID="LblmodelID" runat="server" Text='<%# Bind("modelid") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("modelid") %>'></asp:Label>
                
</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField SortExpression="modelcode" HeaderText="方案代码">
<EditItemTemplate>
                    <asp:TextBox ID="Txtmodelcode" runat="server" Text='<%# Bind("modelcode") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVmodelcode" runat="server" ControlToValidate="Txtmodelcode" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle >
</HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Lblmodelname" runat="server" Text='<%# Bind("modelcode") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="Txtmodelname" HeaderText="方案名称"><EditItemTemplate>
                    <asp:TextBox ID="Txtmodelname" runat="server" Text='<%# Bind("modelname") %>' Width="120px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVmodelname" runat="server" ControlToValidate="Txtmodelname" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle >
</HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("modelname") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="Commet" HeaderText="备注"><EditItemTemplate>
                    <asp:TextBox ID="TxtCommet" runat="server" Text='<%# Bind("Commet") %>' Width="100px"></asp:TextBox>
                
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("Commet") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField  HeaderText="操作"><EditItemTemplate>
<asp:LinkButton runat="server" Text="更新" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>

<HeaderStyle ></HeaderStyle>
<ItemTemplate>
<asp:LinkButton runat="server" Text="编辑" CommandName="Edit" CausesValidation="False" id="LinkButton1"></asp:LinkButton>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField  HeaderText="查看"><EditItemTemplate>
                   
              
</EditItemTemplate>

<ItemTemplate>
     <a href='FP_BsModelSub.aspx?modelid=<%# Eval("modelid") %>&modelname=<%# Eval("modelname").ToString()%>'>调查内容</a>
                
</ItemTemplate>
</asp:TemplateField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            style="background-color:#507CD1;border-color:#999999;border-width:1px;border-style:None;width:100%;border-collapse:collapse;">
		 <tr  Class="dgHeader">
		
			<th scope="col">方案编号</th>
			<th scope="col">方案代码</th>
			<th scope="col">方案名称</th>
			<th scope="col">备注</th>
			
		</tr>
	
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle CssClass="header" HorizontalAlign="Center" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
    <EditRowStyle  />
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="DC_UpModelMain" TypeName="ddl_FindProduct" SelectMethod="DC_GetModelMain" DeleteMethod="DC_DelModelMain" >
        <DeleteParameters>
            <asp:Parameter Name="modelid" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="modelid" Type="Int32" />
            <asp:Parameter Name="modelcode" Type="String" />
            <asp:Parameter Name="modelname" Type="String" />
            <asp:Parameter Name="commet" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
  
</td>
</tr>
   <tr>
     <td  >
     <hr  style="border:solid 0px #000;"/>
    
     </td>
     </tr>
<tr>
<td>
    
   
<table width="100%">
<tr>
<td align="left">
    &nbsp;方案代码：<asp:TextBox ID="TxtBoxCode" runat="server"  CssClass="tbox" MaxLength="50" ></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtBoxCode"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    方案名称：<asp:TextBox ID="TxtBoxName" runat="server" CssClass="tbox" MaxLength="50" ></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtBoxName"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>备注：<asp:TextBox ID="TxtBoxCommet" runat="server" CssClass="tbox" MaxLength="50" ></asp:TextBox>
    &nbsp;&nbsp;<asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="增加方案" ValidationGroup="add"  CssClass="btn"  /></td>
</tr>
<tr>
<td align="center">
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
