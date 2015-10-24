<!-- #include file="setup.asp" -->
<meta http-equiv="refresh" content="1800">
<style>
.tab1{border-bottom:1px solid #F4F0E6;}
</style>
<%act=RequestInt("act")
set rs=server.CreateObject("adodb.recordset")
select case act
case 1  ShowFlowCheck
case 2  ShowFlowOver
case 3  ShowFlowSee
end select
set rs=nothing

Sub ShowFlowCheck%>
<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
<tr height=10><td></td></tr>
<%
Sql="select isnull(count(*),0) as cnt from o_threads where isov=0 and clname='"&request.cookies("userid")&"'"
rs.open Sql,conn,1,1
Allcount=rs("cnt")
rs.close

Sql="select top 5 a.*,c.statename,b.typename,convert(char(10),a.crdate,126) as postdate,c.color, "&_
    "case when convert(char(10),a.crdate,126)=convert(char(10),getdate(),126) then 1 else 0 end as shownew "&_
	"from o_threads a,o_type b,o_state c "&_
    "where a.typeid=b.typeid and a.stateid=c.stateid and a.isov=0 and a.clname='"&request.cookies("userid")&"' "&_
	"order by c.orders desc"
rs.open Sql,conn,1,1
i=0
while not rs.eof
postdate=rs("postdate")
if postdate<>"" then postdate=right(year(postdate),2)&"/"&month(postdate)&"/"&day(postdate)
  Str="["&rs("statename")&"]["&rs("typename")&"]"&rs("title")
  response.write("<tr height=23 bgcolor='#FFFFFF' onMouseMove=""this.bgColor='#FAF7F2'"" onMouseOut=""this.bgColor='#FFFFFF'"">")
  response.write("<td class=tab1><img src='../icon/arrow.GIF'  alt=''/> ")
  response.write("<a href='javascript:void(null)' onclick=""ShowOpen('../flowcheck/flowread.asp?tid="&rs("tid")&"',1)"" title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
  if rs("shownew")=1 then
     response.write("</font></a> <img src='../flowcheck/img/flownew.gif'>")
  end if
  response.write("</td>")
  response.write("</tr>")
i=i+1
rs.movenext
Wend
response.write("<tr height=25><td align=right>共 <font color=red>"&Allcount&"</font> 条待审记录&nbsp;&nbsp;&nbsp;")
response.write("<a href='javascript:void(null)' onclick=""window.parent.location='../flowcheck/flowcheck.asp'"">全部...</a></td></tr>")
rs.close%>
</table>
<script language="javascript">window.parent.document.all.iFrmRef1.height=40+<%=i*25%></script>
<%End Sub

Sub ShowFlowOver%>
<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
<tr height=10><td></td></tr>
<%
Sql="select isnull(count(*),0) as cnt from o_threads where isov=1 and crname='"&request.cookies("username")&"' "&_
    "and tid not in (select tid from o_logov where userid='"&request.cookies("userid")&"')"
rs.open Sql,conn,1,1
Allcount=rs("cnt")
rs.close

Sql="select top 5 a.*,c.statename,b.typename,convert(char(10),a.crdate,126) as postdate,c.color, "&_
    "case when convert(char(10),a.crdate,126)=convert(char(10),getdate(),126) then 1 else 0 end as shownew "&_
	"from o_threads a,o_type b,o_state c "&_
    "where a.typeid=b.typeid and a.stateid=c.stateid and a.isov=1 and a.crname='"&request.cookies("username")&"' "&_
	"and a.tid not in (select tid from o_logov where userid='"&request.cookies("userid")&"') order by c.orders desc"
rs.open Sql,conn,1,1
i=0
while not rs.eof
postdate=rs("postdate")
if postdate<>"" then postdate=right(year(postdate),2)&"/"&month(postdate)&"/"&day(postdate)
  Str="["&rs("statename")&"]["&rs("typename")&"]"&rs("title")
  response.write("<tr height=23 bgcolor='#FFFFFF' onMouseMove=""this.bgColor='#FAF7F2'"" onMouseOut=""this.bgColor='#FFFFFF'"">")
  response.write("<td class=tab1><img src='../icon/arrow.GIF'  alt=''/> ")
  response.write("<a href='javascript:void(null)' onclick=""ShowOpen('../flowcheck/flowread.asp?tid="&rs("tid")&"',1)"" title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
  if rs("shownew")=1 then
     response.write("</font></a> <img src='../flowcheck/img/flownew.gif'>")
  end if
  response.write("</td>")
  response.write("</tr>")
i=i+1
rs.movenext
Wend
response.write("<tr height=25><td align=right>共 <font color=red>"&Allcount&"</font> 条未看记录&nbsp;&nbsp;&nbsp;")
response.write("<a href='javascript:void(null)' onclick=""window.parent.location='../flowcheck/flowmyyesfinish.asp?tname=我的已完成记录'"">全部...</a></td></tr>")
rs.close%>
</table>
<script language="javascript">window.parent.document.all.iFrmRef2.height=40+<%=i*25%></script>
<%End Sub

Sub ShowFlowSee%>
<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
<tr height=10><td></td></tr>
<%
Sql="select isnull(count(*),0) as cnt from o_threads "&_
    "where isov=1 and baseid in (select baseid from o_basesub where userid='"&request.cookies("userid")&"' and ifedit=1) "&_
    "and tid not in (select tid from o_logsee where userid='"&request.cookies("userid")&"')"
rs.open Sql,conn,1,1
Allcount=rs("cnt")
rs.close

Sql="select top 5 a.*,c.statename,b.typename,convert(char(10),a.crdate,126) as postdate,c.color, "&_
    "case when convert(char(10),a.crdate,126)=convert(char(10),getdate(),126) then 1 else 0 end as shownew "&_
	"from o_threads a,o_type b,o_state c where a.typeid=b.typeid and a.stateid=c.stateid and a.isov=1 "&_
	"and a.baseid in (select baseid from o_basesub where userid='"&request.cookies("userid")&"' and ifedit=1) "&_
	"and a.tid not in (select tid from o_logsee where userid='"&request.cookies("userid")&"') order by a.isov desc,c.orders desc"
rs.open Sql,conn,1,1
i=0
while not rs.eof
postdate=rs("postdate")
if postdate<>"" then postdate=right(year(postdate),2)&"/"&month(postdate)&"/"&day(postdate)
  Str="["&rs("statename")&"]["&rs("typename")&"]"&rs("title")
  'response.write("<tr height=25 ")
  'if rs("isov")=1 then
  '   response.write("bgcolor='#FFF8DC'")
  'else
  '   response.write("bgcolor='#FFFFFF'")
  'end if
  'response.write(" onMouseMove=""this.bgColor='#FAF7F2'"" ")
  'if rs("isov")=1 then
  '   response.write("onMouseOut=""this.bgColor='#FFF8DC'"">")
  'else
  '   response.write("onMouseOut=""this.bgColor='#FFFFFF'"">")
  'end if
  response.write("<tr height=23 bgcolor='#FFFFFF' onMouseMove=""this.bgColor='#FAF7F2'"" onMouseOut=""this.bgColor='#FFFFFF'"">")
  response.write("<td class=tab1><img src='../icon/arrow.GIF'  alt=''/> ")
  response.write("<a href='javascript:void(null)' onclick=""ShowOpen('../flowcheck/flowread.asp?tid="&rs("tid")&"',1)"" title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
  if rs("shownew")=1 then
     response.write("</font></a> <img src='../flowcheck/img/flownew.gif'>")
  end if
  response.write("</td>")
  response.write("</tr>")
i=i+1
rs.movenext
Wend
response.write("<tr height=25><td align=right>共 <font color=red>"&Allcount&"</font> 条未看记录&nbsp;&nbsp;&nbsp;")
response.write("<a href='javascript:void(null)' onclick=""window.parent.location='../flowcheck/flowmysee.asp?tname=需我查阅的记录'"">全部...</a></td></tr>")
rs.close%>
</table>
<script language="javascript">window.parent.document.all.iFrmRef3.height=40+<%=i*25%></script>
<%End Sub

Call CloseConn
Call Footer%>