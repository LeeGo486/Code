<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.quickcargotransfer.javabean.UserInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
System.out.println(path);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userinfo = (UserInfo) request.getSession().getAttribute("user_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>快速调货</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
	 <link rel="stylesheet" type="text/css" href="<%=path%>/css/mycommon.css">
	
  </head>
  <script>
  function mouseonChange(obj){
      obj.style.cursor='hand';
  }
  function mouseonChangeText(obj){
      var cssName = obj.className;
      obj.className=cssName.substring(0,6)+'2';
  }
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  function mouseoutChangeText(obj){
  	  var cssName = obj.className;
      obj.className=cssName.substring(0,6)+'1';
  }
 
  function initForm(){
  	 if(document.getElementById("comfirmed-hidden").value!=0){
  	 	document.getElementById("comfirmed").className='text2_1';
  	 }
  	 
  	 if(document.getElementById("transfered-hidden").value!=0){
  	 	document.getElementById("transfered").className='text2_1';
  	 }
  	 
  	 if(document.getElementById("beiconfirm-hidden").value!=0){
  	 	document.getElementById("beiconfirm").className='text2_1';
  	 }
  	 
  	 if(document.getElementById("betransfer-hidden").value!=0){
  	 	document.getElementById("betransfer").className='text2_1';
  	 }
  	 
  }
  
  function searchCargo(){
  	var url = document.getElementById("webConent").value+"/searchCargo.do?action=init";
  	window.open(url, "我要找货", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function responseCargoApply(){
  	var url = document.getElementById("webConent").value+"/responseCargoApply.do?action=init";
  	window.open(url, "回复要货请求", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function notifyCargo(){
  	var url = document.getElementById("webConent").value+"/notifyCargo.do?action=init";
  	window.open(url, "通知发货", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function sendCargo(){
  	var url = document.getElementById("webConent").value+"/sendCargo.do?action=init";
  	window.open(url, "发货", "scrollbars=yes,width=1200px,height=800px,resizable=no,menubar=no,status=no,location=no");	
  }
    
  
  function viewReport(zt){
  	var url = document.getElementById("webConent").value+"/baseReport.do?action=init&zt="+zt;
  	window.open(url, "报表查询", "scrollbars=yes,width=1200px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function viewCargoApplyRes(){
  	var url = document.getElementById("webConent").value+"/viewCargoApplyRes.do?action=init";
  	window.open(url, "查看要货回复", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function viewWaitSendCargo(){
  	var url = document.getElementById("webConent").value+"/waitSendCargo.do?action=init";
  	window.open(url, "查看待发货品", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function receiveCargo(){
  	var url = document.getElementById("webConent").value+"/receiveCargo.do?action=init";
  	window.open(url, "收货", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function waitSendCargoNotify(){
  	var url = document.getElementById("webConent").value+"/waitSendNotify.do?action=init";
  	window.open(url, "等待发货通知", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
   function waitReceiveCargo(){
  	var url = document.getElementById("webConent").value+"/waitReceiveCargo.do?action=init";
  	window.open(url, "查看在途货品", "scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  </script>
  
  <body onload="initForm()">
    <input type="hidden" id="comfirmed-hidden" value="${cargoTransferInfo.comfirmed}">
   	<input type="hidden" id="transfered-hidden" value="${cargoTransferInfo.transfered}">
   	<input type="hidden" id="beiconfirm-hidden" value="${cargoTransferInfo.beiconfirm}">
    <input type="hidden" id="betransfer-hidden" value="${cargoTransferInfo.betransfer}">
    <input type="hidden" id="webConent" value="<%=path%>">
    	
    <div style="position:relative;width: 926;height: 434;vertical-align: middle;" align="center">
    	<div style="width: 100%;height: 100%;vertical-align: middle;" align="center">
    		<img border="0" src="<%=path%>/img/main1.JPG">
    	</div>
    	<div style="position: absolute;top: 50;left: 190">
    		<img border="0" src="<%=path%>/img/main2.JPG" onmouseover="mouseonChange(this)" onclick="searchCargo()">
    	</div>
    	<div class="text1_1" style="width: 50;height: 10;position: absolute;top: 120;left: 205" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="searchCargo()">我要找货</div>
    	
    	<div style="position: absolute;top: 62;left: 385">
    		<img border="0" src="<%=path%>/img/main3.JPG" onmouseover="mouseonChange(this)" onclick="viewCargoApplyRes()">
    	</div>
   		<div class="text1_1" style="width: 75;height: 10;position: absolute;top: 120;left: 380" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="viewCargoApplyRes()">查看要货回复</div> 
   		
   		<div style="position: absolute;top: 54;left: 505">
    		<img border="0" src="<%=path%>/img/main4.JPG" onmouseover="mouseonChange(this)" onclick="notifyCargo()">
    	</div>
    	<div id="comfirmed" class="text1_1" style="width: 75;height: 10;position: absolute;top: 120;left: 500" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="notifyCargo()">通知发货(${cargoTransferInfo.comfirmed})</div> 
    	
    	<div style="position: absolute;top: 54;left: 625">
    		<img border="0" src="<%=path%>/img/main5.JPG" onmouseover="mouseonChange(this)" onclick="viewWaitSendCargo()">
    	</div>
    	
    	<div class="text1_1" style="width: 75;height: 10;position: absolute;top: 120;left: 620" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="viewWaitSendCargo()">查看待发货品</div> 
    	
    	<div style="position: absolute;top: 54;left: 730">
    		<img border="0" src="<%=path%>/img/main6.JPG" onmouseover="mouseonChange(this)" onclick="receiveCargo()">
    	</div>
    	
    	<div id="transfered" class="text1_1" style="width: 75;height: 10;position: absolute;top: 120;left: 720" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="receiveCargo()">收货(${cargoTransferInfo.transfered})</div> 
    
    	<div style="position: absolute;top: 180;left: 385">
    		<img border="0" src="<%=path%>/img/main7.JPG" onmouseover="mouseonChange(this)" onclick="responseCargoApply()">
    	</div>
    	<div id="beiconfirm" class="text1_1" style="width: 95;height: 10;position: absolute;top: 235;left: 380" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="responseCargoApply()">回复要货请求(${cargoTransferInfo.beiconfirm})</div> 
    
    	<div style="position: absolute;top: 176;left: 507">
    		<img border="0" src="<%=path%>/img/main8.JPG" onmouseover="mouseonChange(this)" onclick="waitSendCargoNotify()">
    	</div>
    	<div class="text1_1" style="width: 90;height: 10;position: absolute;top: 235;left: 495" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="waitSendCargoNotify()">等待发货通知</div> 
    
    	<div style="position: absolute;top: 175;left:630">
    		<img border="0" src="<%=path%>/img/main9.JPG" onmouseover="mouseonChange(this)" onclick="sendCargo()">
    	</div>
    	<div id="betransfer" class="text1_1" style="width: 90;height: 10;position: absolute;top: 235;left: 615" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="sendCargo()">发货(${cargoTransferInfo.betransfer})</div> 
    
    	<div style="position: absolute;top: 180;left:725">
    		<img border="0" src="<%=path%>/img/main10.JPG" onmouseover="mouseonChange(this)" onclick="waitReceiveCargo()">
    	</div>
    	<div class="text1_1" style="width: 90;height: 10;position: absolute;top: 235;left: 720" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="waitReceiveCargo()">查看在途货品</div> 
    
    	<div style="position: absolute;top: 287;left:186">
    		<img border="0" src="<%=path%>/img/main11.JPG" onmouseover="mouseonChange(this)" onclick="viewReport('已取消')">
    	</div>
    	<div class="text1_1" style="width: 90;height: 10;position: absolute;top: 350;left: 175" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="viewReport('已取消')">被取消通知发货</div> 
  
    	<div style="position: absolute;top: 287;left:295">
    		<img border="0" src="<%=path%>/img/main12.JPG" onmouseover="mouseonChange(this)" onclick="viewReport('不发货')">
    	</div>
    	<div class="text1_1" style="width: 90;height: 10;position: absolute;top: 350;left: 285" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="viewReport('不发货')">被取消发货</div> 
  
    
    	<div style="position: absolute;top: 286;left:395">
    		<img border="0" src="<%=path%>/img/main13.JPG" onmouseover="mouseonChange(this)" onclick="viewReport('已收货')">
    	</div>
    	<div class="text1_1" style="width: 90;height: 10;position: absolute;top: 350;left: 380" onmouseover="mouseonChange(this);mouseonChangeText(this)" onmouseout="mouseoutChange(this);mouseoutChangeText(this)" onclick="viewReport('已收货')">成功的调货</div> 
 		<div style="width:720;height:10;position: absolute;top: 390;left: 400">
 			<font size="2">店铺：<%=userinfo.getJ_username()%></font>
 		</div>
    </div>
  </body>
</html>
