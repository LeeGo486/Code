<!-- #include file="conn.asp" -->
<div id="task_div"><ul>
<%
function click(url)
click="showModalDialog('flowcheck/flowread.asp?tid="+url+"',window,'dialogWidth:80;dialogHeight:80;center: yes;help:no;resizable:yes;status:no');"
end function
act=RequestInt("act")
set rs=server.CreateObject("adodb.recordset")
select case act
case 1  ShowFlowCheck
case 2  ShowFlowOver
case 3  ShowFlowSee
end select
set rs=nothing
%></ul></div>
<div class="x-clear" />
<%
Sub ShowFlowCheck%>

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
  response.write("<li><div><img src=""images/ext/icons/icon-blue.gif"" align=""left""/>")
  response.write("<a href=""#"" onclick="""&click(""&rs("tid")&"")&""" title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
	response.write("</font></a>")
  if rs("shownew")=1 then
     response.write(" <img src='flowcheck/img/flownew.gif'>")
  end if
  response.write("</div></li>")
i=i+1
rs.movenext
Wend
%>
<li><div align=right>共 <font color=red><%=Allcount%></font> 条待审记录&nbsp;&nbsp;&nbsp;
<a href="flowcheck/flowcheck.asp" title="待审批记录">全部...</a></div></li>
<%
rs.close%>
<%End Sub

Sub ShowFlowOver%>
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
  response.write("<li><div><img src=""images/ext/icons/icon-blue.gif"" align=""left""/>")
  response.write("<a href='#' onclick="""&click(""&rs("tid")&"")&"""   title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
	response.write("</font></a>")
  if rs("shownew")=1 then
     response.write(" <img src='flowcheck/img/flownew.gif'>")
  end if
  response.write("</div></li>")
i=i+1
rs.movenext
Wend
%>
<li><div align=right>共 <font color=red><%=Allcount%></font> 条已完成记录&nbsp;&nbsp;&nbsp;
<a href='flowcheck/flowmyyesfinish.asp?tname=我的已完成记录' title="未看的已结束记录">全部...</a></div></li>
<%

rs.close%>
<%End Sub

Sub ShowFlowSee%>
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
  response.write("<li><div><img src=""images/ext/icons/icon-blue.gif"" align=""left""/>")
  response.write("<a href=""#"" onclick="""&click(""&rs("tid")&"")&""" title='"&rs("title")&" "&rs("crdate")&"'>")
  response.write("<font color='"&rs("color")&"'>")
  if len(Str)>19 then
     response.write(left(Str,19)&"... "&postdate)
  else
     response.write(Str&" "&postdate)
  end if
	response.write("</font></a>")
  if rs("shownew")=1 then
     response.write(" <img src='flowcheck/img/flownew.gif'>")
  end if
  response.write("</div></li>")
i=i+1
rs.movenext
Wend

%>
<li><div align=right>共 <font color=red><%=Allcount%></font> 条未看记录&nbsp;&nbsp;&nbsp;
<a href='flowcheck/flowmysee.asp?tname=需我查阅的记录' title="未看的查阅记录">全部...</a></div></li>
<%
rs.close%>
<%End Sub

Call CloseConn
%>
