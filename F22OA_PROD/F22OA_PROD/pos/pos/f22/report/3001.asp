<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>

<body>
<table width="600"  border="1" cellspacing="1" bordercolor="#ECD5CF" class="f14">
  <tr>
    <td width="8%">���</td>
    <td width="8%">�·�</td>
    <td width="16%">��������</td>
    <td width="15%">���۽��</td>
    <td width="49%">&nbsp;</td>
  </tr>
  <%
  dim rs,i,userid
  userid=trim(session("dm").System_UserId)
  set rs=server.CreateObject("ADODB.Recordset") 
  rs.source = "select Year(a.crdate) y,Month(a.crdate) m,sum(a.nums) as n,sum(a.nums*a.s_price) as s "& _
  			" from d_retailsub a,d_retail b,webp_depot c where a.retailid=b.retailid and b.depotid=c.depotid and c.userid="&qts(userid)& _
			" group by Year(a.crdate),Month(a.crdate) Order by Year(a.crdate),Month(a.crdate) "
  rs.Activeconnection = cn
  rs.open
  i=0
  while not rs.eof
  i=i+1
  'for i=1 to 12%>
  <tr>
    <td><%=rs("y")%></td>
    <td><%=rs("m")%></td>
    <td><%=rs("n")%></td>
    <td><%=rs("s")%></td>
    <td>�鿴��ϸ</td>
  </tr>
  <%'next
  rs.movenext
  wend
  rs.close
  set rs=nothing%>
</table>
</body>
</html>
