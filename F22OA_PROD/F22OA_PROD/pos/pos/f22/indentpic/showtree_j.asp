<!-- #include file="gettree.asp" -->
<HTML><HEAD><TITLE></TITLE>
<META content="texhtml; charset=gb2312" http-equiv=Content-Type>
<STYLE type=text/css>TD {
	FONT-FAMILY: "宋体"; FONT-SIZE: 9pt
}
BODY {
	FONT-FAMILY: "宋体"; FONT-SIZE: 9pt
}
SELECT {
	FONT-FAMILY: "宋体"; FONT-SIZE: 9pt
}
A {
	COLOR: #000000; FONT-FAMILY: "宋体"; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:hover {
	COLOR: #ff0000; FONT-FAMILY: "宋体"; FONT-SIZE: 9pt; TEXT-DECORATION: underline
}
</STYLE>

<SCRIPT language=javascript src="img/foldernav.js"></SCRIPT>

<META content="MSHTML 5.00.2920.0" name=GENERATOR></HEAD>
<BODY>
<DIV id=mParent style="FONT-SIZE: 14px; HEIGHT: 19px; WIDTH: 144px">
<A href="indent_select_sub_j.asp?page=1&st_year=&st_month=&st_dl=&types=1" onfocus="blur();" target=iFrmRef2>全部款式</A></DIV>
<%s=1
for m=0 to ubound(tree1)%>
<DIV id=m<%=s%>Parent style="FONT-SIZE: 14px">
<A href=# name=m<%=s%>Parentm<%=s%>a onfocus="blur();" onclick="FolderExpand('m<%=s%>Parentm<%=s%>','','<%=ubound(tree2)+1%>');return false;" target=_self>
<IMG align=absMiddle border=0 name=m<%=s%>Parentm<%=s%>Tree src="img/Tplus.gif"></a><a href="indent_select_sub_j.asp?page=1&st_year=<%=trim(tree1(m))%>&st_month=&st_dl=&types=2" onfocus="blur();" onclick="FolderExpand('m<%=s%>Parentm<%=s%>','','<%=ubound(tree2)+1%>');" target="iFrmRef2"><%=tree1(m)%>年</a></DIV>

<%b=1
for x=0 to ubound(tree2)%>
<DIV class=child id=m<%=s%>Parentm<%=b%>Child>
<a class=item href=# onfocus="blur();" name=mm<%=s%>Parentm<%=b%>a onclick="FolderExpand1('mm<%=s%>Parentm<%=b%>','','1');return false;" target="_self">
<IMG align=absMiddle border=0 name=mm<%=s%>Parentm<%=b%>Tree src="img/I.gif"><IMG align=absMiddle border=0 name=mm<%=s%>Parentm<%=b%>Tree1 src="img/Tplus.gif"></a><a class=item onfocus="blur();" href="indent_select_sub_j.asp?page=1&st_year=<%=trim(tree1(m))%>&st_month=<%=trim(tree2(x))%>&st_dl=&types=3" onclick="FolderExpand1('mm<%=s%>Parentm<%=b%>','','1');" target="iFrmRef2"><%=tree2(x)%></a></div>

<DIV class=child id=mm<%=s%>Parentm<%=b%>Child>
<%for n=0 to ubound(tree3)%>
<A class=item onfocus="blur();" href="indent_select_sub_j.asp?page=1&st_year=<%=trim(tree1(m))%>&st_month=<%=trim(tree2(x))%>&st_dl=<%=trim(tree3(n))%>&types=4" target="iFrmRef2"><SCRIPT>linew()</SCRIPT><%=tree3(n)%></A><BR>
<%next
response.write("</DIV>")
b=b+1
next
s=s+1
next%>
</BODY></HTML>
