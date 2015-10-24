<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function alt2(){//选发货地
  showModalDialog('../selectdepot.asp?action=set&title=选择发货地&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>

<body>
<%dim page,cid
cid=trim(request.QueryString("cid"))
select case session("dm").System_UserType
case 1,2,3
  if cid="" then cid="3002"
case 4
  if cid="" then cid="2000"
end select
page="f22qry_xssub.asp?act="&cid%>
<iframe name="is" id="is" width="100%" height="92%" frameborder="0" src="<%=page%>"></iframe>
</body>
</html>
