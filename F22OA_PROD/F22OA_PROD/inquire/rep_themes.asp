<!--#include file="inc_header.asp"-->
<%
act=request.querystring("act")
itype=request.querystring("itype")
istate=request.querystring("istate")

stdate1=request.querystring("stdate1")
stdate2=request.querystring("stdate2")
eddate1=request.querystring("eddate1")
eddate2=request.querystring("eddate2")

if itype="" or not(isnumeric(itype)) then itype=0
if istate="" or not(isnumeric(istate)) then istate=0

%>
<div id="tmTable">
<table width="100%">
<form id="form1" name="form1" method="get" action="">
<input type="hidden" value="submit" name="act">
<tr>
  <td><label>类型：
      <select name="itype" id="itype" style="width:80px;">
      <%gettype itype%>
      </select>
      </label>
      &nbsp;开始日期：
      <input name="stdate1" type="text" id="stdate1" size="9" readonly="readonly" class="tbsearch" style="width:65px;" value="<%=stdate1%>"
       title="双击清除" onFocus="setday(this);" ondblclick="this.value=''"/>
      到
      <input name="stdate2" type="text" id="stdate2" size="9" readonly="readonly" class="tbsearch" style="width:65px;" value="<%=stdate2%>"
       title="双击清除"  onFocus="setday(this);" ondblclick="this.value=''"/>
      &nbsp;结束日期：
      <input name="eddate1" type="text" id="eddate1" size="9" readonly="readonly" class="tbsearch" style="width:65px;" value="<%=eddate1%>"
       title="双击清除" onFocus="setday(this);" ondblclick="this.value=''"/>
      到
      <input name="eddate2" type="text" id="eddate2" size="9" readonly="readonly" class="tbsearch" style="width:65px; value="<%=eddate2%>"
       title="双击清除"  onFocus="setday(this);" ondblclick="this.value=''"/>
      <label>
      &nbsp;状态：
      <select name="istate" id="istate" style="width:70px;">
      <%getstate istate%>
      </select>
      <input type="submit" name="search" id="search" value="查询" class="btn2" style="width:35px;" />
      </label></td>
</tr>    
</form>
</table>
<table width="100%">

<%
sql = " select a.dcid as 编号,b.typename as 类型, left(a.ititle,18) as 标题,c.statename as 状态,"&_
				"(select count(c.dcid) from i_todpt c where dcid=a.dcid and c.isok=1) as 已参与,"&_
				"(select count(c.dcid) from i_todpt c where dcid=a.dcid) as 总参店铺,"&_
			" CONVERT(varchar(100), a.crdate, 111) as 开始日期,CONVERT(varchar(100), a.eddate, 111) as 结束日期"&_
		  " from i_topics a,i_type b,i_state c where a.itype=b.[ID] and a.istate=c.[id]  "
			
'状态判断	
	if act<>"submit" then
		sql = sql&" and a.istate in (99) "
	elseif istate=0 then
		sql = sql&" and a.istate in (2,10,12) "
	else
		sql = sql&" and a.istate in ("&istate&") "
	end if
	
'开始日期	
	if stdate1<>"" and stdate2<>"" then
		sql = sql&" and a.stdate >= '"&stdate1&"' and a.stdate <= '"&stdate2&"' "
	end if

'结束日期	
	if eddate1<>"" and eddate2<>"" then
		sql = sql&" and a.eddate >= '"&eddate1&"' and a.eddate <= '"&eddate2&"' "
	end if
	
	
sql = sql&" order by a.eddate asc"

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
	response.write " <td align=center><a href='rep_showtheme.asp?dcid="&rs(0)&"'><img src='scripts/in_view.gif' border=0 align=absmiddle alt='分析'/></a></td>"
	response.write "</tr>"
rs.movenext
loop
rs.close

%>
</table>
</div>
	<script type="text/javascript">
    jsTable('tmTable','tm','100%','','center');
  </script>
<!--#include file="inc_footer.asp"-->
