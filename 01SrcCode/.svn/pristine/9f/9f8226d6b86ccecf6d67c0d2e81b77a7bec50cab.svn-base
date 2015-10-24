<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>登帐审核</title>
	<script language="javascript">
		function openChild(){ 
		var k = window.showModalDialog("crmMethod.jsp",window,"dialogWidth:335px;status:no;dialogHeight:300px");
		 if(k != null)
		document.getElementById("txt11").value = k;
		}
	</script>
  </head>
  <body>
  	传递到父窗口的值:<input id="txt9" type="text" value="3333333333333" ><br> 
	返回的值:<input id="txt11" type="text"><br> 
	子窗口设置的值:<input id="txt10" type="text"><br> 
  	<input type ="button" value="登帐" onclick="openChild()">
  	
  	<!--
  	<s:a action="/chkSure.action?userid=D001&outindentid=FHD006-2011-09-28-0001&chksuredate" >登帐</s:a>
  	-->
  </body>
</html>