<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_sort_all, App_Web_book_sort_all.aspx.c640126d" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Book_sort_all</title>
	
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body leftMargin="1"  topMargin="1">
    <form id="form1" runat="server" >
    <div >
     <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <br />
        <br />   
    <TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" bgColor="#666666">
				<TR>
					<TD bgColor="#ffffff">
					
					<INPUT class="btn" id="btadd" accessKey="a" onclick="LoadWindow('../../manager/book/book_sort.aspx',340,210,'新增图书类别',true);"
							type="button" value="新建(A)" name="btadd">
						查找内容:
						<asp:textbox id="tbvalue" runat="server" CssClass="tbox"></asp:textbox><asp:imagebutton id="btsearch" runat="server" ToolTip="可以是编号或名称，留空则查询所有记录" ImageUrl="../../icon/search.gif" OnClick="btsearch_Click"></asp:imagebutton></TD>
				</TR>
				<TR>
					<TD class="header" bgColor="#ffffff">图书类别</TD>
				</TR>
				<TR>
					<TD bgColor="#ffffff"><asp:datagrid id="dgmng" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="选择">
									<HeaderStyle Width="26px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.sortid") %>'>
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="编号">
									<HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
									<ItemStyle Wrap="False"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.sortid") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=8 ID=tbitemid Width=55px Text='<%# DataBinder.Eval(Container, "DataItem.sortid") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="图书类别">
									<ItemTemplate>
										<asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.sortname") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" CssClass="tbox" MaxLength=40 Width=80px ID=tbitem Text='<%# DataBinder.Eval(Container, "DataItem.sortname") %>'>
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
										<asp:TextBox ID="TextBox1" runat="server" CssClass="tbox" MaxLength=4 Text='<%# DataBinder.Eval(Container, "DataItem.seq") %>' Width=35px>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" HeaderText="编辑" CancelText="取消" EditText="修改当前行"></asp:EditCommandColumn>
								<asp:BoundColumn DataField="d1" ReadOnly="True" HeaderText="借阅天数"></asp:BoundColumn>
								<asp:BoundColumn DataField="dd" ReadOnly="True" HeaderText="续借次数"></asp:BoundColumn>
								<asp:BoundColumn DataField="d2" ReadOnly="True" HeaderText="续借天数"></asp:BoundColumn>
								<asp:TemplateColumn HeaderText="编辑">
									<ItemTemplate>
										<a onclick='LoadWindow("../../manager/book/book_rule.aspx?sortid=<%# DataBinder.Eval(Container, "DataItem.sortid") %>",340,290,"图书借阅规则设置",true)' href=#>
											<img src="../../icon/book/Accounting.gif" border="0"></a>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></TD>
				</TR>
				<TR>
					<TD bgColor="#ffffff">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" border="0">
							<TR>
								<TD><INPUT id="chkAll1" accessKey="z" onclick="javascript:return SelectAll(this.checked,this.id)"
										type="checkbox" name="chkAll1">全选(Z)
								</TD>
								<TD><asp:button id="btdel" accessKey="d" runat="server" Text="删除所选(D)" CssClass="btn" OnClick="btdel_Click"></asp:button></TD>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
