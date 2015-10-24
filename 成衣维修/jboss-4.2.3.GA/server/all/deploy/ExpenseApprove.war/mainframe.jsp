<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="ep.org.branch.expense.dojo.UserInfo"%>

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
  			$("#leftFrame").css("display","none");
  			$("#barFrame").css("left","0");
  			$("#mainFrame").css("width","99.5%");
  			$("#mainFrame").css("left","0.5%");
  			$("#barImg").attr("src","img/changebar2.JPG");
  		}else{
  			$("#leftFrame").css("width","120");
  			$("#leftFrame").css("display","block");
  			$("#barFrame").css("left","120");
  			$("#mainFrame").css("left","130");
  			$("#mainFrame").css("width","1100");
  			$("#barImg").attr("src","img/changebar.JPG");
  		}
  		
  	}
  	
  	
  	function gotoCashExpenseApply(obj){
  		var webContext = $("#path").attr("value");
  		document.getElementById("detailView").src=webContext+"/cashExpenseApply.do?action=init&username="+ $("#username").attr("value");
  		//document.frames['detailView'].location.href=webContext+"/cashExpenseApply.do?action=init&username="+ $("#username").attr("value");
  		menuOnclick(obj)
  	}
  	
  	function gotoMainFlow(obj){
  		var webContext = $("#path").attr("value");
  		document.frames['detailView'].location.href=webContext+"/expenseMainFlow.do?action=init&username="+ $("#username").attr("value");
  		menuOnclick(obj)
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
 
  function gotoSpecialPayment(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/specialPaymentApply.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
   function gotoWagePayment(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/wagePaymentApply.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
    function gotoTripExpense(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/tripExpenseApply.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
   function gotoPaymentExpense(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/paymentApply.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
   function gotoPurposeMergeQuery(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/purposeCostMergeQuery.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
  
   function gotoSubjectMergeQuery(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/subjectMergeQuery.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
   function gotoShopExpenseApportion(obj){
  	var webContext = $("#path").attr("value");
  	document.frames['detailView'].location.href=webContext+"/shopExpenseApportion.do?action=init&username="+ $("#username").attr("value");
  	menuOnclick(obj)
  }
  
  function menuChange(){
  	$('#101').toggle();
  	 
  	 
  	 $('#2001').css('display','none');
  	 $('#2002').css('display','none');
  	 $('#2003').css('display','none');
  	 $('#2004').css('display','none');
  	 $('#2005').css('display','none');
  	 
  	 $('#3001').css('display','none');
  	 $('#3002').css('display','none');
  	 $('#3003').css('display','none');
  	
  }
  
  function menuOnclick(obj){
      $('#branchApply').find('td').each(function(){
          if($(this).attr('id')!='1002-td' && $(this).attr('id')!='1003-td'){
          	$(this).css({"font-weight": "500","background-color":"#E7ECF3"});
          }
      })
      
      	$(obj).css({"font-weight": "700","background-color":"#FFEEDD"});
      
  }
  
  function initForm(){
  	 $('#2001').css('display','none');
  	 $('#2002').css('display','none');
  	 $('#2003').css('display','none');
  	 $('#2004').css('display','none');
  	 $('#2005').css('display','none');
  	 
  	 $('#3001').css('display','none');
  	 $('#3002').css('display','none');
  	 $('#3003').css('display','none');
  }
  </script>
  <body bgcolor="#E7ECF3" onload="initForm()">
  	
  	<input type="hidden" id="path" value="<%=path%>">
  	<input type="hidden" id="username" value="<%=request.getAttribute("username")%>" >
  <table style="width: 1250;height: 20;">
  	<tr>
  		<td style="font-size: 12;height: 20;width: 15%;">  当前登录人：<%=userInfo.getRealname()%>
  			
  		</td>
  		<td id="applytitle" style="font-size: 12;font-weight:700;height: 20;width: 80%">
  			待办任务
  		</td>
  		
  		<td style="font-size: 12;height: 20;text-align: left;width: 5%; "> 
  		<div style="position: relative;">
  			<div style="position: absolute;top: -2;z-index: 2">
  				<a onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)" onclick="logout()"> 注销 </a>
  			
  			</div>
  			<div style="position: absolute;top: -25;z-index: 1;">
  			<img alt="注销" src="<%=path%>/css/images/logout.png" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)" onclick="logout()">
  			</div>
  		</div>
  		</td>
  		
  	</tr>
  </table> 
     <div style="position: relative; display: inline-block; width: 1200; height: 100%;">
     	<div id="leftFrame" style="position: absolute;top:0;left:0; width: 150;height: 100%;background-color: #E7ECF3" >
    				 <div style="position: absolute;top:0;left:-20; width: 150;height: 100%;background-color: #E7ECF3;z-index: -1">
    				 	<img alt="" src="<%=path%>/img/Logo1.png">
    				 </div>
    				 
    				  <div style="position: absolute;top:65;left:-20;z-index: 0">
    				  	<img alt=""  src="<%=path%>/img/headerBgH.gif" width="150" height="20" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)"  onclick="">
    				  </div>
    				  	
    				  	
    				  	
    				  	<div style="position :absolute; top:70;z-index: 1;font-size: 14;font-weight: 700" onclick="menuChange()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    				  	
    				  	    分公司费用审批
    					</div>
    				
    				
    				<div id="101" style="position: absolute;top: 85;left:-20;width: 150">
    					<table id="branchApply" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#AFC7D6">
    					
    						<tr><td id="task" class="td_text_menu" onclick="gotoMainFlow(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						待办任务
    						</td></tr>
    						
    					<%if(userInfo.getUserRole().equals("0")){ %>	
    						
    						<tr height="22" onclick="$('#2001').toggle();$('#2002').toggle();$('#2003').toggle();$('#2004').toggle();$('#2005').toggle();$('#3001').css('display','none');$('#3002').css('display','none');$('#3003').css('display','none')"><td id="1002-td" align="center" class="td_text_menu2" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						费用单据填写
    						</td></tr>
    						
    						<tr id="2001"><td class="td_text_menu" onclick="gotoCashExpenseApply(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						现金付款
    						</td></tr>
    						
    						<tr id="2002"><td class="td_text_menu" onclick="gotoSpecialPayment(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						特殊付款
    						</td></tr>
    						
    						<tr id="2003"><td class="td_text_menu"  onclick="gotoWagePayment(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						工资付款 
    						</td></tr>
    						
    						
    						<tr id="2004"><td class="td_text_menu" onclick="gotoTripExpense(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						差旅费报销
    						</td></tr>
    						
    						<tr id="2005"><td class="td_text_menu" onclick="gotoPaymentExpense(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						付款申请单
    						</td></tr>
    					<%} %>
    						<tr height="22" onclick="$('#3001').toggle();$('#3002').toggle(); $('#3003').toggle();$('#2001').css('display','none');$('#2002').css('display','none');$('#2003').css('display','none');$('#2004').css('display','none');$('#2005').css('display','none');"><td  id="1003-td" align="center" class="td_text_menu2"   onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						查询
    						</td></tr>
    						
    						<tr id="3001"><td class="td_text_menu"  onclick="gotoPurposeMergeQuery(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						费用单据查询
    						</td></tr>
    						<tr id="3002"><td class="td_text_menu"  onclick="gotoShopExpenseApportion(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						店铺分摊费用查询
    						</td></tr>
    						<tr id="3003"><td class="td_text_menu"  onclick="gotoSubjectMergeQuery(this)" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
    						科目单据查询
    						</td></tr>
    					</table>
    					</div>	
    					
    					
    					
    	
    	</div>
    	
    		
    	
    	<div id="barFrame" style="position: absolute;top:0;left:120; width: 10;height: 100%;background-color: #EFF8FF">
    		<img id='barImg' alt=""  src="img/changebar.JPG" onclick="changeArea()" style="position: absolute;top:40%;">
    	</div>
    	
    	<div id="mainFrame" style="position: absolute;top:0;left:130;width: 1100;height: 100%;background-color: blue">
    		<iframe id="detailView" name="detailView" width="100%" height="100%" frameborder="0" src="<%=path%>/expenseMainFlow.do?action=init&username=<%=request.getAttribute("username") %>"></iframe>
    	</div>
    </div>
  </body>
</html>
