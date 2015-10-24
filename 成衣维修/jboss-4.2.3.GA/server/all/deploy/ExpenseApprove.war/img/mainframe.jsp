<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>

<%UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info");
  String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>费用审批</title>
    
	
	<script type="text/javascript" src="js/jquery-1.5.2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
  </head>
  <script type="text/javascript">
  	function changeArea(){
  		if($("#barImg").attr("src")=='img/changebar.JPG'){
  			$("#leftFrame").css("width","0");
  			$("#barFrame").css("left","0");
  			$("#mainFrame").css("width","99.5%");
  			$("#mainFrame").css("left","0.5%");
  			$("#barImg").attr("src","img/changebar2.JPG");
  		}else{
  			$("#leftFrame").css("width","9.5%");
  			$("#barFrame").css("left","9.5%");
  			$("#mainFrame").css("left","10%");
  			$("#mainFrame").css("width","90%");
  			$("#barImg").attr("src","img/changebar.JPG");
  		}
  		
  	}
  	
  	
  	function gotoCashExpenseApply(){
  		var webContext = $("#path").attr("value");
  		document.frames['detailView'].location.href=webContext+"/cashExpenseApply.do?action=init";
  	}
  	
  	function gotoMainFlow(){
  		var webContext = $("#path").attr("value");
  		document.frames['detailView'].location.href=webContext+"/expenseMainFlow.do?action=init";
  	}
  	
  function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  
  function logout(){
  	window.location.href=$('#path').attr('value')+'/login.do?action=logout';
  }
 
  function gotoSpecialPayment(){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/specialPaymentApply.do?action=init";
  }
  
   function gotoWagePayment(){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/wagePaymentApply.do?action=init";
  }
  
    function gotoTripExpense(){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/tripExpenseApply.do?action=init";
  }
  
  </script>
  <body bgcolor="#E7ECF3">
  	
  	<input type="hidden" id="path" value="<%=path%>">
  
  <table style="width: 100%;height: 20;">
  	<tr>
  		<td style="font-size: 12;height: 20">  当前登录人：<%=userInfo.getRealname()%></td>
  		<td style="font-size: 12;height: 20;text-align: right;"> <a onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)" onclick="logout()"> 注销 </a></td>
  	</tr>
  </table> 
     <div style="position: relative; display: inline-block; width: 100%; height: 100%;">
     	<div id="leftFrame" style="position: absolute;top:0;left:0; width: 120;height: 100%;background-color: #E7ECF3" >
    				  <div align="center">
    				  	<img alt="" src="<%=path%>/img/headerBgH.gif" width="120" height="20" onclick="">
    				 </div>		
    					
    					<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
    						<tr><td class="td_text_menu">
    						<div style="position: absolute;top:20;left:15;width=80;" onclick="gotoMainFlow()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> <font color="blue" >申请单查询</font> </div>
    						</td></tr>
    						
    						<tr><td class="td_text_menu">
    						<div style="position: absolute;top:50;left:15;width=80;" onclick="gotoCashExpenseApply()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> <font color="blue" >现金报销</font> </div>
    						</td></tr>
    						
    						<tr><td class="td_text_menu">
    						<div style="position: absolute;top:80;left:15;width=80;" onclick="gotoSpecialPayment()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> <font color="blue" >特殊付款</font> </div>
    						</td></tr>
    						
    						<tr><td class="td_text_menu">
    						<div style="position: absolute;top:110;left:15;width=80;" onclick="gotoWagePayment()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> <font color="blue" >工资付款</font> </div>
    						</td></tr>
    						
    						
    						<tr><td class="td_text_menu" o>
    						<div style="position: absolute;top:140;left:15;width=80;" onclick="gotoTripExpense()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"> <font color="blue" >差旅费报销</font> </div>	
    						</td></tr>
    					</table>
    	</div>
    	
    	<div id="barFrame" style="position: absolute;top:0;left:9.5%; width: 0.5%;height: 100%;background-color: #EFF8FF">
    		<img id='barImg' alt=""  src="img/changebar.JPG" onclick="changeArea()" style="position: absolute;top:40%;">
    	</div>
    	
    	<div id="mainFrame" style="position: absolute;top:0;left:10%;width: 91%;height: 100%;background-color: blue">
    		<iframe id="detailView" name="detailView" width="100%" height="100%" frameborder="0" src="<%=path%>/expenseMainFlow.do?action=init"></iframe>
    	</div>
    </div>
  </body>
</html>
