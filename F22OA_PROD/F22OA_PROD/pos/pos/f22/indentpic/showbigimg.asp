<html>
<head>
<title><%=request.QueryString("styleid")%>的图片</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
<NOSCRIPT><IFRAME SRC=*.html></IFRAME></NOSCRIPT>
<img src=showimg.asp?styleid=<%=request.QueryString("styleid")%> onMousedown="alert('不允许下载！')">
</body>
</html>
