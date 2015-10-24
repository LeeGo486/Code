<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.hy.model.*" %>
<%@ page language="java" import="java.sql.Timestamp" %>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>总部发货单</title>
  </head>
  
  <body>
  
	        <div id="kdd" style="display: none">
	        <input id="zbfh_bzr" type="text"/>
	        <input id="zbfh_shr" type="text"/>
	        <input id="zbfh_shrdh" type="text"/>
	        <input id="zbfh_fhdz" type="text"/>
	        <input id="zbfh_shdz" type="text"/>
	       
	        </div>
	   
  </body>
</html>
