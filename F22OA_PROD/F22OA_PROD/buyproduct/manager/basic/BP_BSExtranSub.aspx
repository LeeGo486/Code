<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSExtranSub, App_Web_bp_bsextransub.aspx.11713791" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商级别档案</title>
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
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">物料大类管理</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="返回信息模板" CssClass="btn"   OnClientClick="window.location.href='BP_BSExtranMain.aspx'; return false;"   />

     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
  
        
    <div  class="BContent" style="height:100%">
        <asp:HiddenField ID="HFPid" runat="server" />
        &nbsp;&nbsp;
        <asp:Label ID="LblTitle" runat="server" Text=""></asp:Label>
    <table width="100%" cellpadding="1" cellspacing="1" align="center">
    <!----->
    <tr>
    <td>
    <table width="100%" height="400" bordercolor="507CD1" border="0">
<tr>
<td valign="top" style="height: 386px">
<asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1"  ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None"  DataKeyNames="ExtranSubID" CellPadding="4" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating" >
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="ExsubName" HeaderText="字段名称">
<EditItemTemplate>
                     <asp:Label ID="LblExsubName" runat="server" Text='<%# Bind("ExsubName") %>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("ExsubName") %>'></asp:Label>
                
</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField SortExpression="ExsubIndex" HeaderText="排列序号">
<EditItemTemplate>
                    <asp:TextBox ID="TxtExsubIndex" runat="server" Text='<%# Bind("ExsubIndex") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVExsubIndex" runat="server" ControlToValidate="TxtExsubIndex" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="LblExsubRow" runat="server" Text='<%# Bind("ExsubIndex") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="ExsubRow" HeaderText="表格行号">
<EditItemTemplate>
                    <asp:TextBox ID="TxtExsubRow" runat="server" Text='<%# Bind("ExsubRow") %>' Width="120px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVExsubRow" runat="server" ControlToValidate="TxtExsubRow" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ExsubRow") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ExsubType" HeaderText="行中列数">
<EditItemTemplate>
              <asp:DropDownList id="ddlType" Runat="server" AutoPostBack="true"  Width="65px" >
               <asp:ListItem Text="1" Value="1"></asp:ListItem>
               <asp:ListItem Text="2" Value="2"></asp:ListItem>
               </asp:DropDownList>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label66" runat="server" Text='<%# Bind("ExsubType") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ExsubIsCom" HeaderText="是否是备注">
<EditItemTemplate>
              <asp:CheckBox ID="CheckBoxCom" runat="server" />
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label57" runat="server" Text='<%# Eval("ExsubIsCom").ToString()=="0"?"否":"是" %>'></asp:Label>
                
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
		
			<th scope="col">字段名称</th>
			<th scope="col">排列序号</th>
			<th scope="col">表格行号</th>
			<th scope="col">行中列数</th>
		
			
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
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="CG_UpExtranModleSub" TypeName="ddl_cgnew" SelectMethod="CG_GetExtranModleSub" DeleteMethod="CG_DelExtranModleSub"  >
        <DeleteParameters>
            <asp:Parameter Name="ExtranSubID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HFPid" Name="ExtranMainID" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExtranSubID" Type="Int32" />
            <asp:Parameter Name="ExtranMainID" Type="Int32" />
            <asp:Parameter Name="ExsubName" Type="String" />
            <asp:Parameter Name="ExsubType" Type="Int32" />
            <asp:Parameter Name="ExsubIndex" Type="Int32" />
            <asp:Parameter Name="ExsubRow" Type="Int32" />
            <asp:Parameter Name="ExsubIsCom" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
  
</td>
</tr>
<tr>
<td align="right"><a href="BP_BSExtranSubShow.aspx?mid=<%=HFPid.Value.ToString() %>" onclick="return GB_myShow('', this.href)" ><asp:Button ID="Button1" runat="server"  Text="预览表格" CausesValidation="false"  CssClass="btn"  /> </a></td>
</tr>
     <tr>
     <td  >
     <hr  style="border:solid 0px #000;"/>
    
     </td>
     </tr>
<tr>
<td>
    
   
<table width="100%" >

<tr>
<td align="left">
    &nbsp;字段名称：<asp:TextBox ID="TxtBoxCode" runat="server" CssClass="tbox" MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtBoxCode"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>&nbsp; 排列序号：<asp:TextBox ID="TxtBoxName" runat="server" CssClass="tbox" MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtBoxName"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtBoxName"
        ErrorMessage="*只能是数字型" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator></td>
        <td align="center">
    </td>
</tr>
<tr>
<td align="left">
    &nbsp;表格行号：<asp:TextBox ID="TxtScore" runat="server" CssClass="tbox"  MaxLength="50" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtScore"
        ErrorMessage="*" ValidationGroup="add"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="REVExmainIndex33" runat="server" ErrorMessage="*数字类型" ValidationExpression="^[0-9]+$" ControlToValidate="TxtScore" Display="Dynamic"></asp:RegularExpressionValidator>
         所在行列数：<asp:RadioButton ID="RBtnOne" runat="server"　 Text="一行一列" GroupName="col" Checked="true" />
         <asp:RadioButton ID="RBtnTwo" runat="server"　 Text="一行两列" GroupName="col"/>
         </td>
        <td align="center">
        
    </td>
</tr>
<tr>
<td align="left">
    是否是备注(所填写的内容更多)<asp:CheckBox ID="CheckBoxCom" runat="server" /></td>
<td align="center"><asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="增加内容" ValidationGroup="add"  CssClass="btn"  /></td>
</tr>
<tr>
<tr>
<td align="left" colspan="2">
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
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