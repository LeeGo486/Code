<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSTrackModel, App_Web_bp_bstrackmodel.aspx.11713791" %>
<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购跟进流程管理</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
          <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
   
        
    <div  class="BContent" style="height:100%">
    <table width="100%" cellpadding="1" cellspacing="1" align="center">
    <!----->
    <tr>
    <td>
    <table width="100%"  bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="TrackModelID" CellPadding="4" 
AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="TrackModelID" HeaderText="进阶编号"><EditItemTemplate>
                     <asp:Label ID="LblTrackModelID" runat="server" Text='<%# Bind("TrackModelID") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("TrackModelID") %>'></asp:Label>
                
</ItemTemplate>
    <ItemStyle CssClass="hidden" />
    <HeaderStyle CssClass="hidden" />
    <FooterStyle CssClass="hidden" />
</asp:TemplateField>



<asp:TemplateField SortExpression="TrackName" HeaderText="进阶名称"><EditItemTemplate>
                    <asp:TextBox ID="TxtTrackName" runat="server" Text='<%# Bind("TrackName") %>' Width="70px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVTrackName" runat="server" ControlToValidate="TxtTrackName" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle Width="90px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("TrackName") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TrackTime" HeaderText="所需时间(天)">
<EditItemTemplate>
                    <asp:TextBox ID="TxtTrackTime" runat="server" Text='<%# Bind("TrackTime", "{0:#,##0.00}") %>'  Width="70px"  ToolTip="完成该阶段所需时间/天"></asp:TextBox>
                     <br />
                      <asp:RegularExpressionValidator ID="REVTrackTime" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtTrackTime" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator id="RFVTrackTime" runat="server" ControlToValidate="TxtTrackTime" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>


<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label54" runat="server" Text='<%# Bind("TrackTime", "{0:#,##0.00}") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TrackIndex" HeaderText="顺序"><EditItemTemplate>
                    <asp:TextBox ID="TxtTrackIndex" runat="server" Text='<%# Bind("TrackIndex", "{0:#,##0}") %>'  Width="70px"  ToolTip=""></asp:TextBox>
                     <br />
                      <asp:RegularExpressionValidator ID="REVTrackIndex" runat="server" ErrorMessage="*整数" ValidationExpression="^[0-9]*$" ControlToValidate="TxtTrackIndex" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator id="RFVTrackIndex" runat="server" ControlToValidate="TxtTrackIndex" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label64" runat="server" Text='<%# Bind("TrackIndex", "{0:#,##0}") %>'></asp:Label>
                
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
			<th scope="col">进阶编号</th>
			<th scope="col">进阶名称</th>
			<th scope="col">完成所需时间/天</th>
			<th scope="col">顺序</th>
			<th scope="col">备注</th>
		</tr>
	 <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
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
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="CG_UpTrackModel" TypeName="ddl_cgnew" SelectMethod="CG_GetTrackModel" DeleteMethod="CG_DelTrackModel"   >
        <DeleteParameters>
            <asp:Parameter Name="TrackModelID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TrackModelID" Type="Int32" />
            <asp:Parameter Name="TrackIndex" Type="Int32" />
            <asp:Parameter Name="TrackName" Type="String" />
            <asp:Parameter Name="TrackTime" Type="Single" />
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
    &nbsp;进阶名称：<asp:TextBox ID="TxtBoxName" runat="server" CssClass="tbox" MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtBoxName"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    所需时间：<asp:TextBox ID="TxtBoxTime" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtBoxTime"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtBoxTime"
        Display="Dynamic" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)"></asp:RegularExpressionValidator></td>
    <td></td>
</tr>
<tr>
<td align="left">
    &nbsp;排 &nbsp;&nbsp; 序：<asp:TextBox ID="TxtIndex" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtIndex"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="REVTtyperScore33" runat="server" ErrorMessage="*整数" ValidationExpression="^[0-9]*$" ControlToValidate="TxtIndex" Display="Dynamic"></asp:RegularExpressionValidator>备 &nbsp;&nbsp; 注：<asp:TextBox ID="TxtCommet" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    </td>
        <td align="center">
    <asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="增加阶段" ValidationGroup="add"  CssClass="btn"  /></td>
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

