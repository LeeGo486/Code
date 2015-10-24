<%@ page language="C#" autoeventwireup="true" inherits="help_help_list, App_Web_help_list.aspx.87a0902e" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>帮助帮助列表</title>
      <link  href="../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">菜单帮助列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <div>
   
    
    <table width="100%">
    <tr>
    <td align="right">
        
        </td>
    </tr>
    </table>
    <table width="100%">
    <tr>
    <td>
        菜单组：</td>
    <td>
        菜单名称
        
        <input class="btn" onclick="window.location.href='help_add.aspx?action=&helpid='" runat="server" visible="false" type="button"
            value="新增帮助" /></td>
    
    </tr>
    <tr>
    <td width="200px" valign="top" style="overflow:hidden;width:150px;">
    <div>
    					<asp:listbox id="lbdep" runat="server" Width="100%" AutoPostBack="True" BackColor="Menu" ForeColor="Navy"
							  OnSelectedIndexChanged="lbdep_SelectedIndexChanged" Height="400px"></asp:listbox></div>
    </td>
     <td valign="top">
      		<asp:datagrid id="dgUser" runat="server" GridLines="None" DataKeyField="helpID"  CssClass="tbGrid"  CellSpacing="1" 
 AutoGenerateColumns="False" ShowFooter="True" CellPadding="1" ForeColor="#333333" PageSize="20"
								Width="100%" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" OnItemDataBound="dguser_itembound">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader" Height="26px"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
								<Columns>
						
								<asp:BoundColumn DataField="menuid" HeaderText="菜单编号"></asp:BoundColumn>
								<asp:BoundColumn DataField="menutitle" HeaderText="菜单名称"></asp:BoundColumn>
								<asp:BoundColumn DataField="groupid" HeaderText="权限组编号"></asp:BoundColumn>
									<asp:BoundColumn DataField="groupname" HeaderText="权限组名称"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="帮助">
										<ItemTemplate>
											<label id="lblhelpid" runat="server"><%# Eval("helpid").ToString()=="0"?"无":"有" %></label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="新增/编辑">
										<ItemTemplate>
											 <a href='help_add.aspx?action=<%# Eval("helpid").ToString()=="0"?"add":"edit" %>&helpid=<%# DataBinder.Eval(Container, "DataItem.helpID") %>&menuid=<%# Eval("menuid") %>'><img src="../icon/go3.gif" border="0" /><%# Eval("helpid").ToString()=="0"?"新增":"编辑" %></a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="查看">
										<ItemTemplate>
											 <a href='help_show.aspx?menuid=<%# Eval("menuid") %>' ><%# Eval("helpid").ToString()=="0"?"":"查看" %></a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="删除">
										<ItemTemplate>
											<asp:LinkButton ID="btDel" runat="server" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("helpid") %>' CausesValidation="false" Visible='<%# Eval("helpid").ToString()=="0"?false:true %>'></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid>
							<webdiyer:AspNetpager id="ap" runat="server" PageSize="20" ShowInputBox="Always" SubmitButtonText="前往"
							InputBoxClass="tb" InputBoxStyle="bt" SubmitButtonClass="bt" ShowBoxThreshold="15" AlwaysShow="True" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
         <asp:HiddenField ID="HFgroupid" runat="server" />
     </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
