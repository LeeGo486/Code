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
<%dim rs,id,sql,userid,flag,s,ext
dim setdepotid,setdptname,set_nums,set_sums,nums,setsure_date,cy
dim sums_clothingid,sums_nums,sums_set_nums,sums_x_price,sums_cy
sums_clothingid=0
sums_nums=0
sums_set_nums=0
sums_x_price=0
sums_cy=0
ext=1
flag=true
id = trim(request.QueryString("id"))
userid=trim(session("dm").System_UserId)
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
rs.LockType = 3

		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindentchk a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		 end select
rs.source = sql
rs.open
%>
<table width="100%" border="0" class="bar">
  <tr>
    <td>业务处理 &gt;&gt; 根据审批单发货</td>
  </tr>
</table>
<table width="100%" border="1" class="f14" bordercolordark="#FFEFEF">
  <tr>
    <th>款号</th>
    <th>颜色</th>
    <th>尺码</th>
    <th>收货数量</th>
    <th>发货数量</th>
    <th>差异</th>
    <th>进货价</th>
    <th>零售价</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
  <%while not rs.eof
    nums=rs("nums")
	set_nums=rs("set_nums")
	cy=nums-set_nums
	sums_cy = sums_cy+cy
	sums_nums = sums_nums+nums
	sums_set_nums = sums_set_nums+set_nums
	sums_x_price = sums_x_price + cdbl(rs("x_price"))
	sums_clothingid = sums_clothingid+1
  %>
  <tr <%if flag then response.write("bgcolor=""#FFEFEF"")") end if%>>
    <td><a href="javascript:clothing('<%=rs("clothingid")%>')"><%=rs("clothingid")%></a></td>
    <td><%=rs("c_name")%>(<%=rs("colorid")%>)</td>
    <td><%=rs("sizeid")%></td>
    <td><%=nums%></td>
    <td><%=set_nums%></td>
    <td><font color="#FF0000"><%=cy%></font></td>
    <td><%=rs("j_price")%></td>
    <td><%=rs("x_price")%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%rs.movenext
  flag = not flag
  wend%>
    <tr bgcolor="#C6E7FF">
    <td><%=sums_clothingid%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><%=sums_nums%></td>
    <td><%=sums_set_nums%></td>
    <td><%=sums_cy%></td>
    <td>&nbsp;</td>
    <td><%=sums_x_price%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

</table>
<%rs.close
set rs = nothing
cn.close
set cn= nothing
%>
</body>
</html>
