<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<%dim title
title=trim(request.QueryString("title"))%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=title%></title>
<link rel="stylesheet" type="text/css" href="css/f22.css">
<script language="javascript" src="inc/abc.js"></script>
<base target="_self">
</head>

<body>
<!--#include file="inc/list.asp"-->
</body>
</html>
