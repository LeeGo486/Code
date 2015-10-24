<%@page import="org.hy.mr.mode.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo"); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	

  </head>
  
  <body>
      <%=userInfo.getUsername() %>£¬»¶Ó­Äã£¡
  </body>
</html>
