<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_sort, App_Web_book_sort.aspx.c640126d" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新增图书类别</title>

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body  topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" bgColor="#999999" border="0" width="100%">
		<TR>
					<TD class="header" colSpan="2">图书类别:</TD>
				</TR>
				<TR>
					<TD class="tdright" bgColor="#ffffff">类别编号(A):</TD>
					<TD bgColor="#ffffff">
					<asp:TextBox id="tbcode" accessKey="a" runat="server" nullable="n" cname="类别编号" strnum="y" MaxLength="8"
							CssClass="tbox" ToolTip="不能和已有编号重复!"></asp:TextBox></TD>
			</TR>
				<TR>
					<TD class="tdright" bgColor="#ffffff">名称(B):</TD>
					<TD bgColor="#ffffff">
						<asp:TextBox id="tbname" accessKey="b" runat="server" nullable="n" cname="名称" MaxLength="40"
							CssClass="tbox"></asp:TextBox></TD>
				</TR>
				<TR>
					<TD class="tdright" bgColor="#ffffff">排序(C):</TD>
					<TD bgColor="#ffffff">
						<asp:TextBox id="tbseq" accessKey="c" runat="server" nullable="n" cname="排序" MaxLength="8" CssClass="tbox"
							datatype="n">1</asp:TextBox></TD>
				</TR>
				<TR>
					<TD class="footer" align="center" colSpan="2">
						<asp:Button id="btsave" accessKey="s" runat="server" CssClass="btn" Text="保存(S)" OnClick="btsave_Click"></asp:Button>
            &nbsp;
            <INPUT class="btn" accessKey="z" onclick="javascript:CloseWindow('新增图书类别');" type="button"
							value="关闭(Z)"></TD>
				</TR>
			</TABLE>
    </div>
    </form>

</body>
</html>
