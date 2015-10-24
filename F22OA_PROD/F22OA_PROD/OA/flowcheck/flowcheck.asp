<!-- #include file="setup.asp" -->
<%act=HTMLEncode(request("act"))
set rs=server.CreateObject("adodb.recordset")
select case act
case "left"   CheckLeft
case "right"  CheckRight

case else     CheckMain
end select
set rs=nothing

Sub CheckMain%>
<table width="100%" height="25" border="0" cellpadding="1" cellspacing="1" bgcolor="#3399ff" ID="Table1">
<tr valign="middle">
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flowcheck.asp'" vAlign="baseline">
			<img src="../icon/menu/diary.gif" width="16" height="16"> 流程审批</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flownewadd.asp'" vAlign="baseline">
			<img src="../icon/menu/address.gif" width="16" height="16"> 新建审批</td>
</tr>
</table>
<table width="100%" height=430 border="0" cellpadding="1" cellspacing="1">
<tr height=430>
  <td width="15%"><iFrame Name=iFrmRef1 id=iFrmRef1 SRC="?act=left" width=100% height=100% scrolling="no" frameborder="0"></iFrame></td>
  <td width="85%"><iFrame Name=iFrmRef2 id=iFrmRef2 SRC="?act=right&typeid=0" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td>
</tr>
</table>
<%End Sub

Sub CheckLeft%>
<script language="javascript">
function reflash(url){
window.parent.document.iFrmRef2.location=url;
}
</script>
<%
  with response
    .write("<table border=0 cellpadding=1 cellspacing=1>")
	rs.open "select isnull(count(*),0) as cnt from o_threads where clname='"&request.cookies("userid")&"' and isov=0",conn,1,1
	.write("<tr onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor=''"">")
	.write("<td><a href=""javascript:reflash('?act=right&typeid=0')"">全 部 ("&rs("cnt")&")</a></td></tr>")
	rs.close
	Sql="select a.typeid,max(b.typename) as typename from o_threads a,o_type b "&_
	    "where a.typeid=b.typeid and a.clname='"&request.cookies("userid")&"' and a.isov=0 group by a.typeid"
    rs.open Sql,conn,1,1
	set tmp=server.createobject("adodb.recordset")
	while not rs.eof
 	  tmp.open "select isnull(count(*),0) as cnt from o_threads where clname='"&request.cookies("userid")&"' and isov=0 and typeid="&rs("typeid"),conn,1,1
	  .write("<tr onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor=''"">")
	  .write("<td><a href=""javascript:reflash('?act=right&typeid="&rs("typeid")&"')"">"&rs("typename")&" ("&tmp("cnt")&")</a></td></tr>")
	  tmp.close
	  rs.movenext
	Wend
	rs.close
	set tmp=nothing
    .write("</table>")
  end with
End Sub

Sub CheckRight%>
<table width="700" border="0" cellpadding="1" cellspacing="1" ID=CommonListArea>
<tr align=center>
   <td width=50>紧急程度</td>
   <td width=310>主题</td>
   <td width=80>提交人</td>
   <td width=180>提交日期</td>
   <td width=80>待处理人</td>
</tr>
<%typeid=RequestInt("typeid")
select case typeid
  case 0 Sql="select a.*,c.statename,d.username as clusername,c.color,"&_
             "case when convert(char(10),a.crdate,126)=convert(char(10),getdate(),126) then 1 else 0 end as shownew "&_
			 "from o_threads a,o_type b,o_state c,j_user d "&_
             "where a.typeid=b.typeid and a.stateid=c.stateid and a.isov=0 and a.clname='"&request.cookies("userid")&"' "&_
			 "and a.clname=d.userid order by c.orders desc"
  case else Sql="select a.*,c.statename,d.username as clusername,c.color,"&_
                "case when convert(char(10),a.crdate,126)=convert(char(10),getdate(),126) then 1 else 0 end as shownew "&_
                "from o_threads a,o_type b,o_state c,j_user d "&_
                "where a.typeid=b.typeid and a.stateid=c.stateid and a.isov=0 and a.clname='"&request.cookies("userid")&"' "&_
				"and a.typeid="&typeid&" and a.clname=d.userid order by c.orders desc"
end select
rs.open Sql,conn,1,1
While not rs.eof
  response.write("<tr height=25 bgcolor='#E0F3FF' onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor='#E0F3FF'"">")
  response.write("<td align=center><font color='"&rs("color")&"'>"&rs("statename")&"</font></td>")
  response.write("<td><a href=""javascript:void(null)"" onclick=""ShowOpen('flowread.asp?tid="&rs("tid")&"',1)""><font color='"&rs("color")&"'>"&rs("title")&"</font></a>")
  if rs("shownew")=1 then
     response.write(" <img src='img/flownew.gif'>")
  end if
  response.write("</td>")
  response.write("<td align=center>"&rs("crname")&"</td>")
  response.write("<td align=center>"&rs("crdate")&"</td>")
  response.write("<td align=center>"&rs("clusername")&"</td>")
  response.write("</tr>")
rs.movenext
Wend
rs.close%>
</table>
<%End Sub

call CloseConn
call Footer%>
