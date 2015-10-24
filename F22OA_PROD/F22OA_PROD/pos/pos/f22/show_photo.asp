<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>图片查看</title>
</head>

<body>
<img name="sp" src="show_photo_sub.asp?<%=request.ServerVariables("QUERY_STRING")%>" alt="<%=request.QueryString("id")%>">
</body>
</html>
