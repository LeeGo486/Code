<!--#include file="inc_header.asp"-->
<%
act=request("act")
act2=request("act2")
if act2="edit" then
	typeid=request.form("typeid")
	itype=request.form("itype")
	cn.execute("update i_type set [typename]='"&itype&"' where [id]="&typeid)
	response.Redirect("list_type.asp")
elseif act2="add" then
	itype=request.form("itype")
	cn.execute("insert into i_type ([typename],[cruser]) values ('"&itype&"','"&username&"')")
	response.Redirect("list_type.asp")
elseif act2="del" then
	typeid=request("typeid")
	cn.execute("delete from i_type where [id]="&typeid)
	response.Redirect("list_type.asp")
end if
%>
<div id="tmTable">
<table width="100%">
  <form id="form1" name="form1" method="post" action="?">
<%
set rs2=server.CreateObject("adodb.recordset")
sql = " select id as 编号,typename as 类别名称,cruser as 创建人,crdate as 创建日期 from i_type order by crdate asc"
rs.open sql,cn,1,1
	response.write "<tr>"
	for i = 0 to rs.fields.count-1
		response.write " <td align=center><strong>"&rs(i).name&"</strong></td>"
	Next
		response.write " <td align=center>操作</td>"
	response.write "</tr>"
do while not rs.eof
	response.write "<tr>"
	for i = 0 to rs.fields.count-1
		response.write " <td>"&rs(i)&"</td>"
	Next
	response.write " <td align=center>"
	
	rs2.open "select count(dcid) from i_topics where itype="&rs(0)&"",cn,1,1
	if pedit then
	response.write "<a href='?act=edit&typeid="&rs(0)&"'><img src='scripts/edit.gif' border=0 alt=编辑 /></a> "
	else
	response.write "<img src='scripts/edit.gif' border=0 alt=您没有编辑权 /> "
	end if
	if not(rs2.eof and rs2.bof) then
		if rs2(0)>0 then
		response.write "<img src='scripts/c_remove.gif' border=0 alt=该类型已使用，不能删除 />"
		elseif pdel then
		response.write "<a href='?act2=del&typeid="&rs(0)&"' onclick=""return confirm('删除后不能撤消，确定删除吗？')""><img src='scripts/del.gif' border=0 alt=删除 /></a>"
		else
		response.write "<img src='scripts/c_remove.gif' border=0 alt=权限不足，不能删除 />"
		end if
	end if
	response.write "</td>"
	rs2.close
	response.write "</tr>"
rs.movenext
loop
rs.close
set rs2=nothing
%>
</form>

<form id="form2" name="form2" method="post" action="?">
  <%if act="edit" and  pedit then
	typeid=request("typeid")
	sql="select typename from i_type where id="&typeid
	rs.open sql,cn,1,1
		itypename = rs(0)
	rs.close
	%>
  <input type="hidden" name="act2" id="act2" value="<%=act%>" />
  <input type="hidden" name="typeid" id="typeid" value="<%=typeid%>" />
    <tr>
      <td align=center>修改：</td>
      <td colspan=4>
      <input name="itype" type="text" value="<%=itypename%>" style='width:300px' maxlength="255" />
      <label>
      <input type="submit" name="update" id="update" value="更　新" class="btn2" />
      <input type="button" name="aaaa" id="aaaa" value="取　消" class="btn2" onclick="location.href='?'" />
      </label>  </td>
    </tr>
  <% Elseif padd then %>
  <input type="hidden" name="act2" id="act2" value="add" />
    <tr>
      <td align=center>新增：</td>
      <td colspan=4>
      <input name="itype" type="text" id="itype" style='width:300px' value="" maxlength="255" />
      <label>
      <input type="submit" name="add" id="add" value="添　加" class="btn2" />
      </label>  </td>
    </tr>
  <% End If %>
  
  </form>
</table>
</div>
	<script type="text/javascript">
    jsTable('tmTable','tm','86%','40','center');
  </script>
<!--#include file="inc_footer.asp"-->
