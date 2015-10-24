<%@ page language="C#" autoeventwireup="true" inherits="manager_user_duty, App_Web_duty.aspx.d341d34a" %>

<%@ Register Assembly="AspNetpager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title>职位设置</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body style="margin:0px;">
    <form id="form1" runat="server">
    <table cellSpacing="1" cellPadding="1" width="100%" align="center">
				<tr>
					<td class="header"><FONT face="宋体">职位设置</FONT></td>
				</tr>
				<tr>
					<td>
						<INPUT class="btn" id="btadd" accessKey="a" type="button" value="新建(A)" onclick="LoadWindow('../../manager/user/duty_add.aspx',340,220,'新建职位',true);">
						<FONT face="宋体">查找内容:
							<asp:textbox id="tbvalue" cname="查找内容" runat="server" CssClass="tbox" ToolTip="可以是编号或名称，留空则查询所有记录"></asp:textbox>
							<asp:button id="btsearch" accessKey="s" runat="server" CssClass="btn" Text="查找(S)" OnClick="btsearch_Click"></asp:button></FONT></td>
				</tr>
				<tr>
					<td>
    <div id="jsTable">
						<asp:datagrid id="dgmng" runat="server" Width="100%" AutoGenerateColumns="False" ForeColor="#696969" OnItemCommand="dg_ItemCommand">
							<AlternatingItemStyle BackColor="#EDF3F3"></AlternatingItemStyle>
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<HeaderStyle CssClass="HEADER" Wrap="False" HorizontalAlign="Center"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="选择">
									<HeaderStyle Width="26px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.dutyid") %>'>
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="编号">
									<HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
									<ItemStyle Wrap="False"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dutyid") %>' ID="Label21" NAME="Label21">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=8 ID=tbitemid Width=55px Text='<%# DataBinder.Eval(Container, "DataItem.dutyid") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="职位名称">
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.duty") %>' ID="Label2" NAME="Label2">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=40 Width=80px ID=tbitem Text='<%# DataBinder.Eval(Container, "DataItem.duty") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="排序">
									<HeaderStyle Width="40px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" ID=tbseq Text='<%# DataBinder.Eval(Container, "DataItem.orderby") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=4 Text='<%# DataBinder.Eval(Container, "DataItem.orderby") %>' Width=35px ID="Textbox1" NAME="Textbox1">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" HeaderText="编辑" CancelText="取消" EditText="修改当前行"></asp:EditCommandColumn>
							</Columns>
						</asp:datagrid>
            </div>
            </td>
				</tr>
				<tr>
					<td>
						<table cellpadding="1" cellspacing="1" border="0">
							<tr>
								<td>
									<INPUT id="chkAll1" accessKey="z" type="checkbox" onclick="javascript:return SelectAll(this.checked,this.id)">全选(Z)
								</td>
								<td>
									<asp:button id="btdel" accessKey="d" runat="server" CssClass="btn" Text="删 除(D)" OnClick="btdel_Click"></asp:button>
								</td>
								<td>
                      <webdiyer:aspnetpager id="ap" runat="server"></webdiyer:aspnetpager>
                      <input type="button" onclick="closeTab(0)" value="关 闭(C)" class="btn" accessKey="c" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    <script type="text/javascript" defer="defer">
    	jsTable('jsTable','tm','98%','','center')
    </script>
    
    </form>
</body>
</html>
