<%dim retailid,depotid,clothingid,cn,sql
retailid=session("retailid")
depotid=session("dm").System_Depotid
clothingid=request("zsid")
set cn=server.createobject("ADODB.Connection")
cn.open session("cn")

if clothingid<>"" then
  if cdbl(session("totalzsnums"))=0 then
     response.write("<script>alert('已没有可赠送数量！');location.href='pos_zssub.asp';</script>")
	 response.end
  end if
  set rs=server.createobject("adodb.recordset")
  rs.open "select clothingid from j_clothing where clothingid='"&clothingid&"' or oldclothingid='"&clothingid&"'",cn
  if rs.eof then
     response.write("<script>alert('款号不存在！');location.href='pos_zssub.asp';</script>")
	 response.end
  else
     clothingid=rs("clothingid")
  end if
  rs.close
  sql="select 1 from d_retailzstmp a,j_clothing b where a.retailid='"&retailid&"' and b.clothingid='"&clothingid&"' "&_
      "and a.styleid=b.styleid and a.colorid=b.colorid"
  rs.open sql,cn
  if rs.eof then
     response.write("<script>alert('款号不在赠送列表中！');location.href='pos_zssub.asp';</script>")
	 response.end
  end if
  rs.close
  rs.open "select 1 from webtmp_zs where retailid='"&retailid&"' and clothingid='"&clothingid&"'",cn
  if rs.eof then
  sql="insert into webtmp_zs (retailid,clothingid,styleid,colorid,sizeid,j_price,x_price,discount,s_price,nums) "&_
      "select '"&retailid&"',b.clothingid,b.styleid,b.colorid,b.sizeid,a.j_price,a.x_price,a.rate,a.s_price,1 "&_
	  "from d_retailzstmp a,j_clothing b where a.retailid='"&retailid&"' and a.styleid=b.styleid and a.colorid=b.colorid "&_
	  "and b.clothingid='"&clothingid&"'"
  else
  sql="update webtmp_zs set nums=isnull(nums,0)+1 where retailid='"&retailid&"' and clothingid='"&clothingid&"'"
  end if
  cn.execute sql
  rs.close
  session("totalzsnums")=session("totalzsnums")-1
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title></title>
</head>

<body onload="document.form1.zsid.focus()">
<form name="form1" method="get" action="pos_zssub.asp">
输入赠送货品 <input type=text name='zsid' size='20'>
可赠送总数量：<%=session("totalzsnums")%>
</form>
<table width='100%' border="0" align="center"  class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
    <td>款号</td>
    <td>现价</td>
    <td>单价</td>
	<td>数量</td>
    <td>金额</td>
  </tr>
<%set rs=server.createobject("adodb.recordset")
rs.open "select clothingid,x_price,discount,s_price,nums,s_price*nums as sums from webtmp_zs where retailid='"&retailid&"'",cn
while not rs.eof
   response.write("<tr><td>"&rs("clothingid")&"</td>")
   response.write("<td>"&rs("x_price")&"</td>")
   response.write("<td>"&rs("s_price")&"</td>")
   response.write("<td>"&rs("nums")&"</td>")
   response.write("<td>"&rs("sums")&"</td></tr>")
rs.movenext
wend
rs.close
set rs=nothing%>
</table>
</body>
</html>
