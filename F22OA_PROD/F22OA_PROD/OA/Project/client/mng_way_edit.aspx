<%@ page language="C#" autoeventwireup="true" inherits="Project_client_mng_way_edit, App_Web_mng_way_edit.aspx.fc906236" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>客户行业设置</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table cellSpacing="1" cellPadding="1" width="99%" bgColor="#666666">
				<tr>
					<td>
						</td>
				</tr>
				<tr>
					<td bgColor="#ffffff">
						<INPUT class="button" id="btadd" accessKey="a" type="button" value="新建(A)" onclick="LoadClass('mng_way_add.aspx','新建');">
						<FONT face="宋体">查找内容:
							<asp:textbox id="tbvalue" cname="查找内容" runat="server" CssClass="tbox" ToolTip="可以是编号或名称，留空则查询所有记录"></asp:textbox>
							<asp:button id="btsearch" accessKey="s" runat="server" CssClass="button" Text="查找(S)" OnClick="btsearch_Click"></asp:button></FONT></td>
				</tr>
				<tr>
					<td bgColor="#ffffff" class="header"><FONT face="宋体">客户行业设置</FONT></td>
				</tr>
				<tr>
					<td bgColor="#ffffff">
						<asp:datagrid id="dgmng" runat="server" Width="100%" AutoGenerateColumns="False" ForeColor="#696969" OnItemCommand="dg_ItemCommand">
							<AlternatingItemStyle BackColor="#EDF3F3"></AlternatingItemStyle>
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<HeaderStyle CssClass="HEADER" Wrap="False" HorizontalAlign="Center"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="选择">
									<HeaderStyle Width="26px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.wayid") %>'>
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="编号">
									<HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
									<ItemStyle Wrap="False"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.wayid") %>' ID="Label1">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=8 ID=tbitemid Width=55px Text='<%# DataBinder.Eval(Container, "DataItem.wayid") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="行业名称">
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.way") %>' ID="Label2">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=40 Width=120px ID=tbitem Text='<%# DataBinder.Eval(Container, "DataItem.way") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="排序">
									<HeaderStyle Width="40px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" ID=tbseq Text='<%# DataBinder.Eval(Container, "DataItem.seq") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=4 Text='<%# DataBinder.Eval(Container, "DataItem.seq") %>' Width=35px ID="Textbox1">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" HeaderText="编辑" CancelText="取消" EditText="修改当前行"></asp:EditCommandColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
				<tr>
					<td bgColor="#ffffff">
						<table cellpadding="1" cellspacing="1" border="0">
							<tr>
								<td>
									<INPUT id="chkAll1" accessKey="z" type="checkbox" onclick="javascript:return SelectAll(this.checked,this.id)">全选(Z)
								</td>
								<td>
									<asp:button id="btdel" accessKey="d" runat="server" CssClass="button" Text="删除(D)" OnClick="btdel_Click"></asp:button>
								</td>
								<td>
									<webdiyer:aspnetpager id="ap" runat="server" SubmitButtonText="转到" SubmitButtonClass="button" ShowInputBox="Always" OnPageChanged="ap_PageChanged"></webdiyer:aspnetpager>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
