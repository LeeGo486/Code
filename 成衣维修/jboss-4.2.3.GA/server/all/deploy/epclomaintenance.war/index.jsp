<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String userID = request.getParameter("userID");
String pwd =  request.getParameter("pwd"); 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>成衣店铺维修</title>
    
	

  </head>
 
  <body onload="document.forms[0].submit();">
  	<html:form action="/cloMaintenanceMain" styleId="cloMaintenanceForm" method="post">
		<html:hidden property="userID" value="<%=userID%>"/>
		<html:hidden property="pwd" value="<%=pwd%>"/>
		<html:hidden property="method" value="init"/>
	
	</html:form> 
  </body>
</html>
