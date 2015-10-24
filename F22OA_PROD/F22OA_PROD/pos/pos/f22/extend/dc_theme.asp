<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>自定义调查</title>
<style>
input,textarea,select{ font-family:tahoma; font-size:9pt;}
*{
font-size:12px;
font-family:tahoma;
}
ul{
margin:0 0 0 20px;
}
#jstable{
background:#DDD;
}
#jstable th{
background:#d9e5f4;
}
#jstable td{
background:#FFF;
border-bottom:solid 1px #99bbe8;
}
</style>
</head>

<body>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk" style="font-size:12px ">
  <tr>
    <td height="21"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 自定义调查</td>
<!--    
    <td align="right"><a href="dc_newlist.asp">返 回</a></td>
    
-->  </tr>
</table>
<table width="100%"  border="0" cellpadding="5" cellspacing="0" id="jstable">
<%
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)

set conn=server.CreateObject("adodb.connection")
conn.open session("cn")
set rs=server.CreateObject("adodb.recordset")

conn.execute("update i_topics set istate=10 where (getdate()-1)>eddate and istate=2")

sql = " SELECT a.dcid as 编号,d.statename as 状态,c.typename as 类型,a.ititle as 标题,CONVERT(varchar(100), a.stdate, 111) as 开始日期,"&_
			" CONVERT(varchar(100), a.eddate, 111) as 结束日期,isnull(b.isok,0) FROM I_Topics a,I_todpt b,i_type c,i_state d "&_
			" where b.depotid='"&depotid&"' and a.dcid=b.dcid and a.itype=c.[id] and a.istate=d.[ID] and a.istate=2 "&_
			" and getdate()>=a.stdate "
if isnumeric(cdbl(istate)) and istate<>"" then
sql=sql&" and a.istate="&istate
else

end if

sql =sql&" order by a.crdate desc"
rs.open sql,cn,1,1
if rs.eof and rs.bof then
	response.write " <p>&nbsp;</p><p align=center style='color:red'>当前店铺没有相关调查任务!</p>"
else
	response.write "<tr>"
	for i = 0 to rs.fields.count-2
		response.write " <th align=center><strong>"&rs(i).name&"</strong></th>"
	Next
		response.write " <th align=center>操作</th>"
	response.write "</tr>"
	do while not rs.eof
		response.write "<tr>"
		for i = 0 to rs.fields.count-2
			response.write " <td>"&rs(i)&"</td>"
		Next
			response.write " <td align=center><a href='dc_showtheme.asp?dcid="&rs(0)&"'>"
			if rs(6)=0 then
			response.write "填写调查"
			else
			response.write "查看"
			end if
			response.write "<a></td>"
		response.write "</tr>"
	rs.movenext
	loop
end if
rs.close
set rs=nothing
%>
</form>
</table>
</body>
</html>
