<!--#include file="inc_header.asp"-->
<%
act=request.querystring("act")
dcbrand=request.querystring("dcbrand")
istate=request.querystring("istate")

stdate1=request.querystring("stdate1")
stdate2=request.querystring("stdate2")
eddate1=request.querystring("eddate1")
eddate2=request.querystring("eddate2")

if istate="" or not(isnumeric(istate)) then istate=0

%>
<div id="tmTable">
<table width="100%">

<%
sql = " select b.lookname as 品牌,"&_
	" (select isnull(count(dcid),0) from i_topics where dcid in (select dcid from i_subject where dcbrand=b.lookname)) as 相关调查,"&_
	" (select isnull(count(dcid),0) from i_subject where dcbrand=b.lookname) as 相关题目"&_
	" from j18_lookupsub b where lookupid='8001'"

'竞争品牌	
	if dcbrand<>"" then
		sql = sql&" and  b.lookname='"&dcbrand&"' "
	end if
sql = sql&" order by b.lookname asc"

rs.open sql,cn,1,1

	response.write "<tr>"
	for i = 0 to rs.fields.count-1
		response.write " <td align=center><strong>"&rs(i).name&"</strong></td>"
	Next
		response.write " <td align=center>查看</td>"
	response.write "</tr>"
do while not rs.eof
	response.write "<tr>"
	for i = 0 to rs.fields.count-1
		response.write " <td>"
		if i=3 then
			if rs(i)="进行中" then
			response.write "<span style='color:green'>"&rs(3)&"</span>"
			elseif rs(i)="未发布" then
			response.write "<span style='color:#666'>"&rs(3)&"</span>"
			elseif rs(i)="待审核" then
			response.write "<span style='color:blue'>"&rs(3)&"</span>"
			'elseif rs(i)="未通过审核" then
			'response.write "<span style='color:red'>"&rs(3)&"</span>"
			else
			response.write "<span style='color:#333'>"&rs(3)&"</span>"
			end if
		else
				response.write rs(i)
		end if
		response.write "</td>"
	Next
	response.write " <td align=center><a href='rep_showbrand.asp?brand="&server.URLEncode(rs(0))&"'><img src='scripts/in_view.gif' border=0 align=absmiddle alt='分析'/></a></td>"
	response.write "</tr>"
rs.movenext
loop
rs.close

%>
</table>
</div>
	<script type="text/javascript">
    jsTable('tmTable','tm','96%','','center');
  </script>
<!--#include file="inc_footer.asp"-->
