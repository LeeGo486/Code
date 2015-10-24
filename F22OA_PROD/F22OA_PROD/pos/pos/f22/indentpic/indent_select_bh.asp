<!--#include file="../inc/function.asp"-->
<%
if request.Cookies("pic_indentid")="" then
  djid=getid("d_indent","indentid","BH",session("dm").System_UserId)
  sql="insert into d_indent (indentid,indent,merchantid,setdate,sure,chk_sure,depotid,getdate,d_type,cr_name,ov_sure,"&_
      "cr_date,backrate,backdate,get_depotid,parentid) values "&_
	  "('"&djid&"','"&djid&"','"&session("dm").System_unitid&"',getdate(),0,0,'"&request.Cookies("pic_indentdepotid")&"',getdate(),2,"&_
	  "'"&session("dm").system_username&"',0,getdate(),0,getdate()+30,'"&session("dm").system_depotid&"','"&session("dm").system_parentid&"')"
  cn.execute sql
  response.Cookies("pic_indentid")=djid
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>看图补货</title>
</head>

<body leftmargin="0" topmargin="0" style="cursor:url('img/pen_i.cur');overflow-x:hidden;overflow-y:hidden">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="15%"><iFrame Name=iFrmRef1 id=iFrmRef1 SRC="showtree.asp" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td>
    <td width="85%"><iFrame Name=iFrmRef2 id=iFrmRef2 SRC="indent_select_sub.asp?page=1&st_year=&st_month=&st_dl=&types=1" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td>
  </tr>
</table>
</body>
</html>
<%cn.close
set cn=nothing%>