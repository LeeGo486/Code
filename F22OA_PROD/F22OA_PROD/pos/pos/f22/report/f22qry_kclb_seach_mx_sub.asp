<!--#include file="inc/function.asp" -->
<%act=request.QueryString("act")
types=request.QueryString("types")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<title><%=types%>的库存明细</title>
</head>
<style media="print">.noprint { display: none }</style>
<body> 
<%select case act
case 1 a1="select a.styleid,max(b.s_name) as s_name,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_style b "
       a1=a1&"where b.st_year='"&types&"' and a.styleid=b.styleid and a.depotid ='"&session("dm").System_Depotid&"' "
       a1=a1&" group by a.styleid"
case 2 a1="select a.styleid,max(b.s_name) as s_name,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_style b "
       a1=a1&"where b.st_month='"&types&"' and a.styleid=b.styleid and a.depotid='"&session("dm").System_Depotid&"' "
       a1=a1&" group by a.styleid"
case 3 a1="select a.styleid,max(b.s_name) as s_name,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_style b "
       a1=a1&"where b.st_xl='"&types&"' and a.styleid=b.styleid and a.depotid ='"&session("dm").System_Depotid&"' "
       a1=a1&" group by a.styleid"
case 4 a1="select a.styleid,max(b.s_name) as s_name,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_style b "
       a1=a1&"where b.st_dl='"&types&"' and a.styleid=b.styleid and a.depotid ='"&session("dm").System_Depotid&"' "
       a1=a1&" group by a.styleid"
case 5 a1="select a.styleid,max(b.s_name) as s_name,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_style b "
       a1=a1&"where b.st_xz='"&types&"' and a.styleid=b.styleid and a.depotid ='"&session("dm").System_Depotid&"' "
       a1=a1&" group by a.styleid"
end select%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000"><%=types%></font>的款式库存情况</font></td>
  </tr>  
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td> 
	<td><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">库存数量</font></div></td> 
  </tr>  
  <%set rs=server.createobject("adodb.recordset")
  rs.open a1,cn
  while not rs.eof
   if round(rs(2))<>0 then%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><%=rs(0)%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%=rs(1)%></font></div></td>
	<td height="20"><div align="center"><font size="2"><a href="javascript:void(null);" title="查看明细" onclick="window.open('kc_mx1.asp?styleid=<%=rs("styleid")%>','','width=500,height=400,scrollbars=1')">
	                                                    <%response.write(rs(2))
	                                                     z_nums=z_nums+round(rs(2),0)%></a></font></div></td>
  </tr>
<%end if
 rs.movenext
 wend
rs.close
set rs=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20" colspan=2><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=z_nums%> 件</font></div></td>
  </tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onclick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>
