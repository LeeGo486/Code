<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String rs = request.getParameter("result");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>�ٻ�Ӧ��ϵͳ��¼</title>
    
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>

  </head>
  <script type="text/javascript">
  
  	
  
   function initForm(){
       
       var rs = $('#result').attr('value');
       if(rs=='0'){
           	alert('�û��������벻��ȷ��');
       		return;
       }
       if($('#rs').attr('value')=='-2'){
       		alert('�Ѿ����û���¼������ע����');
       }
       
   }
   
   
   function login(){
   	document.forms[0].submit();
   }
  </script>
  <body onload="initForm()">
 	<input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
 	<input type="hidden" id="rs" value="<%=rs%>">
 	<input type="hidden" id="webContext" value="<%=path%>">
 	<s:form  id="loginForm" action="/web/login!login" method="post" theme="simple">
    	<s:hidden id="logid" name="logid" ></s:hidden>
   
    <div style="position:absolute;  width: 100%;top: 0px;" >
    	 <center>
    	
    	<div style="position: relative;width:1024; " >
    	
   		<img alt="" src="<%=path %>/img/login.jpg">
   		<%-- <div style="position:relative; top: -200;left: 150">
   			�û�����<input type="text" id="userid" name="userInfo.userid" width="160" >
   		</div> 
    	
    	<div style="position:relative; top: -200;left: 500">
   			
   		</div > 
   		
   		<div style="position:relative; top: -200;left: 500;">
   			
   		</div> --%>
   		<table style="position: relative;top:-200">
   			<tr><td>�û�����<input type="text" id="userid" name="userInfo.userid" width="160" ></td> 
   			<td>���룺<input type="password" id="password" name="userInfo.password" width="160"></td> 
   			<td><img alt="" src="<%=path %>/img/button.jpg" onclick="login();" ></td> </tr>
   		</table>
   		
    	</div>
    	</center>
    </div>
   
    
	</s:form>
  </body>
</html>
