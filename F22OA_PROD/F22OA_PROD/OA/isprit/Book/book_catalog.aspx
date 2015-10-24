<%@ page language="C#" autoeventwireup="true" inherits="isprit_Book_book_catalog, App_Web_book_catalog.aspx.b5839e7c" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>馆藏书目详细信息</title>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div> <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    	    <div ><h2><strong>
               
                </strong></h2></div>
			<table cellSpacing="1" cellPadding="1" width="100%">
			<tr>
					<td>
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD>关键字:</TD>
								<TD><asp:textbox id="tbkey" runat="server" CssClass="book_tb"></asp:textbox></TD>
								<TD><asp:checkbox id="ckusable" Text="只查询未借出的图书" Runat="server" ForeColor="#0000C0" Checked="True"></asp:checkbox></TD>
								<TD><asp:dropdownlist id="ddlsort" runat="server" CssClass="select" Width="112px"></asp:dropdownlist></TD>
								<TD><asp:Button ID="Button1" runat="server" CssClass="btn" Text="查    询" OnClick="imbsearch_Click" /></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
				<tr>
					<td><table width="100%" cellpadding="2" cellspacing="1" class="tbGrid">
							<asp:repeater ID="dlbook" Runat="server">
								<HeaderTemplate>
									<TR class="dgHeader" style="height:26px">
										<TD width="200">书名</TD>
										<TD width="80">类别</TD>
										<td width="40">架位</td>
										<TD width="100">出版社|作者</TD>
										<TD width="40">可借数</TD>
										<TD>备注</TD>
									</TR>
								</HeaderTemplate>
								<ItemTemplate>
									<tr height="24px" title='价格:<%# DataBinder.Eval(Container, "DataItem.price","{0:￥#,##0.00}")%>' align="center" bgcolor=#ffffff >
										<td width="200px" align="left" nowrap>
											<img src="../../icon/book/forward.gif" border="0"> <a href='book_show.aspx?bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>' target=_self >
												<%# DataBinder.Eval(Container, "DataItem.bookname") %>
											</a>
										</td>
										<td width="80px"><%# DataBinder.Eval(Container, "DataItem.sortname") %></td>
										<td width="40"><%# DataBinder.Eval(Container, "DataItem.location") %></td>
										<td width="100px"><%# DataBinder.Eval(Container, "DataItem.bookman") %></td>
										<td width="40px"><%# DataBinder.Eval(Container, "DataItem.amount") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.remark") %></td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr height="24px" title='价格:<%# DataBinder.Eval(Container, "DataItem.price","{0:￥#,##0.00}")%>' align="center" bgcolor=#eeeeee >
										<td width="200px" align="left" nowrap>
											<img src="../../icon/book/forward.gif" border="0"> <a href='book_show.aspx?bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>' target=_self >
												<%# DataBinder.Eval(Container, "DataItem.bookname") %>
											</a>
										</td>
										<td width="80px"><%# DataBinder.Eval(Container, "DataItem.sortname") %></td>
										<td width="40"><%# DataBinder.Eval(Container, "DataItem.location") %></td>
										<td width="100px"><%# DataBinder.Eval(Container, "DataItem.bookman") %></td>
										<td width="40px"><%# DataBinder.Eval(Container, "DataItem.amount") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.remark") %></td>
									</tr>
								</AlternatingItemTemplate>
								<FooterTemplate>
									<tr>
										<td colspan="6" class="title"><IMG src="../../icon/menu/tree_blankl.gif">点击书名,查看详细信息</td>
									</tr>
								</FooterTemplate>
							</asp:repeater></table>
					</td>
				</tr>
				<tr>
					<td class=tip><ol>
							<li>
							Tip:查询某书时，请在关键字栏中输入书名，比如《李敖全集》，只要输入“李”或其中某个字即可.
							<li>
							要查询所有的图书（包括已借出和未借完的图书），请把只查询未借图书的勾去掉
							<li>
								当图书相当多，查询较慢时，建议选择类别，按类别查询</li></ol>
					</td>
				</tr>
			</table>
			&nbsp;
    </div>
    </form>
</body>
</html>
