<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_basis_all, App_Web_book_basis_all.aspx.c640126d" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    	<title>book_basis_all</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body topmargin="1" leftmargin="1" >
    <form id="form1" runat="server" >
    <div>  
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                        <br />
                        <br />
                      
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="99%" >
				<TR>
					<td  bgcolor="white" >
                      
                        <INPUT class="btn" id="btadd" accessKey="a" onclick="LoadClass('manager/book/book_basis.aspx?action=add','新建书籍');"
							type="button" value="新建(A)" name="btadd">
						书籍查询：
						<asp:textbox id="tbvalue" runat="server" CssClass="book_tb"></asp:textbox>
						<asp:DropDownList id="ddlsort" runat="server" CssClass="select" Width="120px"></asp:DropDownList>
						
						<asp:ImageButton id="btsearch" runat="server" ImageUrl="../../icon/search.gif"
						 ToolTip="可以是书号或书名，留空查询所有记录" OnClick="btsearch_Click"></asp:ImageButton></td>
				</TR>
				<TR>
					<td class="header" bgColor="#ffffff" >所有图书</td>
				</TR>
				<TR>
					<td bgColor="#ffffff">
						<asp:datagrid id="dgmng" runat="server" GridLines="None" ToolTip="点击标题,查看明细;点击数量,更改数量" CssClass="tbGrid"  CellSpacing="1" 
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
										<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.bookid") %>'>
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="sortname" ReadOnly="True" HeaderText="类别">
									<ItemStyle Wrap="False"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="bookid" HeaderText="编号"></asp:BoundColumn>
								<asp:TemplateColumn HeaderText="图书名称">
									<ItemTemplate>
										<a href='#' onclick='LoadClass("manager/book/book_basis.aspx?action=edit&bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>",this.innerHTML.replace(".",""))'><%# DataBinder.Eval(Container, "DataItem.bookname") %></a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="location" ReadOnly="True" HeaderText="架位"></asp:BoundColumn>
								<asp:BoundColumn DataField="price" ReadOnly="True" HeaderText="价格">
									<ItemStyle Wrap="False"></ItemStyle>
								</asp:BoundColumn>
								<asp:TemplateColumn HeaderText="数量">
									<ItemTemplate>
										<a href='#' id='Amount<%# DataBinder.Eval(Container, "DataItem.bookid") %>' onclick='LoadWindow("../../manager/book/book_amount.aspx?action=edit&bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>",350,120,"更改数量")'>
											<%# DataBinder.Eval(Container, "DataItem.amount") %>
										</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="可用">
									<ItemTemplate>
										<asp:CheckBox ID="ck1" Runat="server" Checked='<%# DataBinder.Eval(Container, "DataItem.usable") %>' Enabled="False">
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</TR>
				<tr>
					<td class="tip"><ol>
							<li>
							点击数量，可以修改馆藏数量。
							<li>
							当图书应用后，是不可以删除的。
							<li>
								点击图书名称，可以修改书籍明细。
							</li>
						</ol>
					</td>
				</tr>
				<TR>
					<td bgColor="#ffffff">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" border="0">
							<TR>
								<td style="height: 24px"><INPUT id="chkAll1" accessKey="z" onclick="javascript:return SelectAll(this.checked,this.id)"
										type="checkbox" name="chkAll1">全选(Z)
								</td>
								<td style="height: 24px">
									<asp:button id="btapply" accessKey="d" runat="server" CssClass="btn" Text="应用所选图书" OnClick="btapply_Click"></asp:button><FONT face="宋体">&nbsp;</FONT>
									<asp:button id="btdel" accessKey="d" runat="server" CssClass="btn" Text="删除(D)" OnClick="btdel_Click"></asp:button></td>
								<td style="height: 24px"></td>
							</TR>
						</TABLE>
					</td>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
