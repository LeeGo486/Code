<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>退货发货</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <!-- 
    	<s:a action="/returnGoods.action?userid=D001&outindentid=FHD006-2011-09-28-0001" >退货发货</s:a>
 -->
    	<br>
    	<table style="color: red;"><tr><td><s:fielderror></s:fielderror></td></tr></table>
    	<br>    	
  </body>
  <script type="text/javascript">
  var ischeck='<%= request.getAttribute("ischeck") %>'
	if(ischeck!='' && 'null'!=ischeck){
		alert(ischeck);
		ischeck='';
		window.open('http://192.168.2.221:88/pos/pos/f22/search_frame.asp?action=search','_self','');
		//history.back();
		//history.back();
	}
	</script>
</html>
