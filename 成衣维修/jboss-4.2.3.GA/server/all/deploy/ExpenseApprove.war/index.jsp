<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ page session="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>分公司费用审批系统用户登录</title>
	
	<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
  </head>
  
  
  <script type="text/javascript">
  function login(){
  	
  	if(window.top!=window.self){
  		
  	
  		window.top.location.href=$('#path').attr('value')+"/login.do?action=init&username="+$('#username').attr('value')+"&password="+$('#password').attr('value');
  	}else{
		var url = $('#path').attr('value')+'/img/loginafter.png';
  		$('#buttonImg').attr('src',url);
  		document.forms[0].submit();
	}  	
  	
  }
  

  
  function initForm(){
  	if($('#result').attr('value')=='-1'){
  		alert('用户名或密码错误！');
  		return;
  	}
  	if($('#result').attr('value')=='0'){
  		alert('该用户没有权限！');
  		return;
  	}
  	if($('#result').attr('value')=='-2'){
  		alert('用户登录失效！');
  		return;
  	}
  	if($('#result').attr('value')=='-3'){
  		alert('已经有用户登录，请先注销已登录用户！');
  		return;
  	}
  }
  
  function nextInput(inputID){
 	if(event.keyCode==13){
 		$('#'+inputID).focus();
 	}
 }
 
 function do_submit(){
 	if(event.keyCode==13){
 		login();
 	}
 }
 
   function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  </script>
  
  <body bgcolor="#DCF0FB" onload="initForm()">
  	<input type="hidden" id="result" value="<%=request.getAttribute("result")==null?request.getParameter("result"):request.getAttribute("result") %>">
  	<input type="hidden" id="path" value="<%=path %>">
  	
  	<html:form action="/login" styleId="loginForm">
  		<html:hidden property="action" value="init"/>
  	
  	<div style="width: 100%;height: 100%" align="center">
  	
  	<div style="position: relative;width:1024;height: 600;" align="center">
  		<div style="position: absolute;left: 700;top: 150" align="right">
  		<font style="font-family:黑体;font-size: 14">	 系统编号：ST0502C</font>
  		</div>
  		
  		<div style="position: absolute;left: 780;top: 430">
  			<font style="font-family:黑体;font-size: 14">版本V2.0</font>
  		</div>
  		
  		<div style="position: absolute;left: 220;top: 520" align="center">
  		 <font style="font-family:黑体;font-size: 14">  Copyright © 2012 HWAYI Investment/elegant prosper Garment. All Rights Reserved. <br />
  			华之毅投资公司/雅莹服装公司 版权所有</font>
  		</div>
  		
  		<img alt="" src="<%=path%>/img/login2.jpg" width="1024">
  		
  		<div style="position: absolute;left: 55%;top: 43%" >
  		<table width="200">
  			<tr>
  				<td style="width: 55;font-size: 13">用户名：</td>
  				<td>
  				 <input type="text" id="username" name="username" style="width:105;font-size: 13" value="" onkeypress="nextInput('password')"/>
  				<%-- <html:text property="username"></html:text>--%> 
  				
  				</td>
  			</tr>
  			
  			<tr>	
  				<td style="width: 45;font-size: 13;" align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
  				
  				<td><html:password styleId="password" style="width:105;font-size:13" property="password"  onkeypress="do_submit()"></html:password></td>
  			</tr>
  			
  			<tr>
  				
  					<td colspan="2" align="center"><img id="buttonImg" alt="" src="<%=path%>/img/loginbefor.png" onkeypress="do_submit()" onclick="login()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> </td>
  				
  			</tr>
  		
  		</table>
  		
  
  		</div>
  		
  	</div>
  </div>	
  	</html:form>
  </body>
</html>
