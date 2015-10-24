
<!--#include file="inc_header.asp"-->
<%
istate=request.querystring("istate")
if istate="" then 
	if pchk then
		istate=1
	else
		istate=2
	end if
end if
%>
<p align=left><strong>状态：</strong>&nbsp;|&nbsp;
<a href="?istate=-1" <%if istate="-1" then response.write "style='font-weight:bold'"%>>全部</a>&nbsp;|&nbsp;
<%
rs.open "select ID,statename from i_state",cn,1,1
do while not rs.eof
	response.write "<a href=""?istate="&rs(0)&""" "
		if cdbl(istate)=rs(0) and istate<>"" then response.write "style='font-weight:bold'"
	response.write " >"&rs(1)&"</a>&nbsp;|&nbsp;"
rs.movenext
loop
rs.close
%>
</p>
<div id="tmTable">
<table width="100%">
<%
sql = " select a.dcid as 编号,b.typename as 类型, left(a.ititle,18) as 标题,c.statename as 状态,a.cruser as 创建人,"&_
			" CONVERT(varchar(100), a.crdate, 111) as 开始日期,CONVERT(varchar(100), a.eddate, 111) as 结束日期"&_
		  " from i_topics a,i_type b,i_state c where a.itype=b.[ID] and a.istate=c.[id]  "
			
if isnumeric(cdbl(istate)) and istate<>"-1" then
sql=sql&" and a.istate="&istate
else

end if

sql =sql&" order by a.crdate desc"
rs.open sql,cn,1,1
	response.write "<tr>"
	for i = 0 to rs.fields.count-1
		response.write " <td align=center><strong>"&rs(i).name&"</strong></td>"
	Next
		response.write " <td>操作</td>"
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
		response.write "<td align=center>"
		
		if rs(3)="未发布" and pedit then
	       response.write " <a href='add_tpinquire.asp?act=edit&dcid="&rs(0)&"'><img src='scripts/edit.gif' border=0 align=absmiddle alt='编辑' /></a>"
	    else
		response.write " <a href='add_tpinquire.asp?act=view&dcid="&rs(0)&"'><img src='scripts/search.gif' border=0 align=absmiddle alt='查看'/></a>"
	    end if
	    
	    if rs(3)="待审核" and pchk then 
	    response.write " <a href='add_tpinquire.asp?act=pass&dcid="&rs(0)&"'><img src='scripts/right.gif' border=0 align=absmiddle alt='审核通过' /></a>"
	    end if 
	    
	    if rs(3)="进行中" and pchk then
	    response.write " <a href='add_tpinquire.asp?act=over&dcid="&rs(0)&"'><img src='scripts/c_remove.gif' border=0 align=absmiddle alt='结束' /></a>"
	    end if
		if rs(3)="进行中" or rs(3)="正常结束" or rs(3)="人为结束" then
		response.write " <a href='rep_showtheme.asp?dcid="&rs(0)&"'><img src='scripts/in_view.gif' border=0 align=absmiddle alt='分析'/></a>"
		end if
	response.write "</td></tr>"
rs.movenext
loop
rs.close

%>
</form>
</table>
</div>
	<script type="text/javascript">
    jsTable('tmTable','tm','96%','','center');
  </script>
<!--#include file="inc_footer.asp"-->
