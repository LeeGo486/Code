<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript">
function clothing(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}
</script>
<title>无标题文档</title>
</head>

<body>
<%dim rs,id,sql,userid,flag,show
dim setdepotid,setdptname,set_nums,set_sums,nums,setsure_date,cy
dim sums_clothingid,sums_nums,sums_set_nums,sums_x_price,sums_cy
sums_clothingid=0
sums_nums=0
sums_set_nums=0
sums_x_price=0
sums_cy=0
flag=true
id = trim(request.QueryString("id"))
show=request.QueryString("show")
userid=trim(session("dm").System_UserId)
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
rs.LockType = 3

if show="Z" then
   sql="select sum(set_nums) as nums from d_movesub where moveid="&qts(id)
else
sql = " select a.clothingid,a.colorid,a.sizeid,a.set_nums as nums,a.x_price,a.j_cost,a.j_price,b.c_name"& _
	  "  "& _
	  " from d_movesub as a ,j_color b"& _
	  " where a.colorid=b.colorid and a.moveid="&qts(id)
	  'de sql
end if
rs.source = sql
rs.open
if show="Z" then%>
<table width="100%" border="1" class="f14" bordercolordark="#FFEFEF"><tr height="80"><td align="center"><font size="8" color="#FF0000"><%=rs("nums")%></font></td></tr></table>
<%else%>
<table width="100%" border="1" class="f14" bordercolordark="#FFEFEF">
  <tr>
    <th>款号</th>
    <th>颜色</th>
    <th>尺码</th>
    <th>发货数量</th>
    <th>零售价</th>
  </tr>
  <%dim rs1
    set rs1=server.CreateObject("adodb.recordset")
    rs1.open "select sum(set_nums) as nums,sum(set_nums*x_price) as sums from d_movesub where moveid='"&id&"'",cn
	response.write("<tr bgcolor=#C6E7FF><td></td><td>&nbsp;</td><td>&nbsp;</td><td>"&rs1("nums")&"</td><td>"&rs1("sums")&"</td></tr>")
	rs1.close
	set rs1=nothing
	
    while not rs.eof
    nums=rs("nums")
	'set_nums=rs("set_nums")
	'cy=nums-set_nums
	'sums_cy = sums_cy+cy
	sums_nums = sums_nums+nums
	'sums_set_nums = sums_set_nums+set_nums
	sums_x_price = sums_x_price + cdbl(rs("x_price"))*rs("nums")
	sums_clothingid = sums_clothingid+1
  %>
  <tr <%if flag then response.write("bgcolor=""#FFEFEF"")") end if%>>
    <td><a href="javascript:clothing('<%=rs("clothingid")%>')"><%=rs("clothingid")%></a></td>
    <td><%=rs("c_name")%>(<%=rs("colorid")%>)</td>
    <td><%=rs("sizeid")%></td>
    <td><%=nums%></td>
    <td><%=rs("x_price")%></td>
  </tr>
  <%rs.movenext
  flag = not flag
  wend%>
    <tr bgcolor="#C6E7FF">
    <td><%=sums_clothingid%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><%=sums_nums%></td>
    <td><%=sums_x_price%></td>
  </tr>
</table>
<%end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
</body>
</html>