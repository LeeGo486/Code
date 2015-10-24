<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSExtranMain, App_Web_bp_bsextranmain.aspx.11713791" %>
 <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料符加信息管理</title>
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
    <td align="center"></td>
    </tr>
    <tr>
    <td>
    <table width="100%" height="400" bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1"  ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="ExtranMainID" CellPadding="4" 
AutoGenerateColumns="False"  Caption="如果多个模板所属类型相同,则以序号最小的那个的内容给供应商填写" CaptionAlign="Left"  AllowSorting="True" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="ExtranMainID" HeaderText="级别编号" >
<EditItemTemplate>
                     <asp:Label ID="LblExtranMainID" runat="server" Text='<%# Bind("ExtranMainID") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("ExtranMainID") %>'></asp:Label>
                
</ItemTemplate>
    <ItemStyle CssClass="hidden" />
    <HeaderStyle CssClass="hidden" />
    <FooterStyle CssClass="hidden" />
</asp:TemplateField>

<asp:TemplateField SortExpression="ExmainName" HeaderText="模板名称">
<EditItemTemplate>
                    <asp:TextBox ID="TxtExmainName" runat="server" Text='<%# Bind("ExmainName") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVExmainName" runat="server" ControlToValidate="TxtExmainName" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="LblExmainType" runat="server" Text='<%# Bind("ExmainName") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="TxtExmainType" HeaderText="所属类型">
<EditItemTemplate>
           <asp:DropDownList id="ddlType" Runat="server" AutoPostBack="true"  Width="65px"></asp:DropDownList>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ExmainType") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ExmainIndex" HeaderText="序号"><EditItemTemplate>
                    <asp:TextBox ID="TxtExmainIndex" runat="server" Text='<%# Bind("ExmainIndex") %>' Width="70px"></asp:TextBox>
                     <br />
                      <asp:RegularExpressionValidator ID="REVExmainIndex" runat="server" ErrorMessage="*数字类型" ValidationExpression="^[0-9]+$" ControlToValidate="TxtExmainIndex" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator id="RFVExmainIndex" runat="server" ControlToValidate="TxtExmainIndex" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle Width="90px">
</HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label44" runat="server" Text='<%# Bind("ExmainIndex") %>'></asp:Label>
                
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
<asp:TemplateField  HeaderText="查看">
<ItemTemplate>
     <a href='BP_BSExtranSub.aspx?mid=<%# Eval("ExtranMainID") %>'><img src="../../../icon/go3.gif" border="0" />模板内容</a>
                
</ItemTemplate>
</asp:TemplateField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            style="background-color:#507CD1;border-color:#999999;border-width:1px;border-style:None;width:100%;border-collapse:collapse;">
		 <tr  Class="dgHeader">
			<th scope="col">模板名称</th>
			<th scope="col">所属类型</th>
		    <th scope="col">序号</th>
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
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="CG_UpExtranModleMain" TypeName="ddl_cgnew" SelectMethod="CG_GetExtranModleMain" DeleteMethod="CG_DelExtranModleMain"  >
        <DeleteParameters>
            <asp:Parameter Name="ExtranMainID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExtranMainID" Type="Int32" />
            <asp:Parameter Name="ExmainName" Type="String" />
            <asp:Parameter Name="ExmainType" Type="String" />
            <asp:Parameter Name="ExmainIndex" Type="Int32" />
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
    &nbsp;模板名称：<asp:TextBox ID="TxtBoxCode" runat="server" CssClass="tbox" MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtBoxCode"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    所属类型：<asp:DropDownList ID="ddlType" runat="server" Width="200px"></asp:DropDownList>
    </td>
    <td></td>
</tr>
<tr>
<td align="left">
    &nbsp;模板序号：<asp:TextBox ID="TxtScore" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtScore"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="REVExmainIndex33" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtScore" Display="Dynamic"></asp:RegularExpressionValidator></td>
        <td align="center">
    <asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="增加模板" ValidationGroup="add"  CssClass="btn"  /></td>
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


