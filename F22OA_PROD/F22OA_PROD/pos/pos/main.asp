<%Dim cn,rs,ztname
set cn=server.CreateObject("adodb.connection")
cn.open session("cn")
set rs=server.CreateObject("adodb.recordset")
rs.open "select f18name from f18master.dbo.f18books where dbalia='"&session("dbname")&"'",cn
ztname=trim(rs("f18name"))
rs.close
set rs=nothing
set cn=nothing%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>F22POSϵͳ - [<%response.write(session("dbname")&ztname)%>]-[<%=session("dm").System_Depotid%><%=session("dm").System_DepotName%>]</title>
</head>

<frameset id="mf" rows="62,25,*" cols="*" framespacing="0" frameborder="NO" border="0">
  <frame src="main_top.asp" name="topFrame" scrolling="NO" noresize >
  <frame src="main_head.asp" name="headFrame" scrolling="NO" noresize >
  <frame src="f22/index_main.asp" name="mainFrame">
</frameset>
<noframes><body>

</body></noframes>
</html>
 