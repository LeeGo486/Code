<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String userID =request.getParameter("userID");
String pwd = request.getParameter("pwd");
//String	userID = "1138";
//String userID = "1332";
//String userID = "5036";
//String userID="5036";
//String userID="1340";
//String pwd="123456A";
//String pwd = "82065055abc";
//String pwd = "yaying123";	
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>快速调货</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	-->
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
  <body onload="document.forms[0].submit();">
  	<form action="/epqukcargotrans/mainMenu.do" method="post">
  		<input type="hidden" name="username" value="<%=userID%>">
  		<input type="hidden" name="password" value="<%=pwd%>">
  		<input type="hidden" name="action" value="init">
  	</form>
	
 </body>
</html>
