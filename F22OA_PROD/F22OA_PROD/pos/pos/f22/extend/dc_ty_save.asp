<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>
<%dim aid(),qid(),tid(),i,c,depotid
c=trim(request.Form("count"))
depotid=trim(session("dm").System_depotid)
Redim aid(c)
Redim qid(c)
Redim tid(c)
for i=1 to c
  aid(i)=trim(request.Form("aid"&i))
  qid(i)=trim(request.Form("qid"&i))
  tid(i)=trim(split(aid(i),",")(1))
  aid(i)=trim(split(aid(i),",")(0))
next

for i=0 to c
  response.Write aid(i)&"&nbsp;"
  response.Write qid(i)&"&nbsp;"
  response.Write tid(i)&"&nbsp;"
  response.Write "<br>"
next
response.End()
dim cd
set cd=server.CreateObject("ADODB.Command")
cd.ActiveConnection = cn
cd.CommandType = 1

for i=0 to c
  cd.CommandText = "insert into web_back(qid,score,depotid) values("&qid(i)&","&aid(i)&","&qts(depotid)&")"
  cd.Execute
next

set cd=Nothing
%>
<script language="javascript">
alert("提交调查成功!谢谢您对本公司的支持!");
window.location.href="dc_ty.asp";
</script>
</body>
</html>
