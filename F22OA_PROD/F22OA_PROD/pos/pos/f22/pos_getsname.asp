<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%
dim id,rs,depotid
id=trim(request.QueryString("id"))
depotid=trim(Session("dm").System_depotid)

if id<>"" then
  set ds=server.CreateObject("ADODB.RecordSet")
  ds.ActiveConnection = cn
  ds.Source = "select names from j_employee where depotid="&qts(depotid)&" and employeeid="&qts(id)
  ds.open
  if ds.eof then
    ds.close
	set ds=nothing
    call sclose("n")
  else
    s=ds(0)
    ds.close
	set ds=nothing
    call sclose(s)
  end if
end if
%>
<%sub sclose(str)%>
<script language="javascript">
window.returnValue="<%=str%>";
window.close();
</script>
<%response.End()
end sub%>
</body>
</html>
