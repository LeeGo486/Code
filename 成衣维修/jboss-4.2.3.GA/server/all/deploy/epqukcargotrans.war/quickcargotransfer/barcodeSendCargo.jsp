<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>条码发货</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
    
	<style type="text/css">
		body{font-weight: 500;font-size: 14}
		
		
	</style>
  </head>
  <script type="text/javascript"><!--
  function initForm(){
    document.getElementById('barCode').focus();
  	if(document.getElementById('detailResult').value=='1'){
  		if(confirm('POS中调拨发货单已自动生成，单号'+document.getElementById('cargoTransferID').value+',需要打印发货单吗？')){
  			var guid = document.getElementById('guid').value;
  			var url = document.getElementById('webcontent').value+'/sendCargo.do?action=printSendCargo'
  			+'&guid='+guid;
  			window.open(url,'调货单打印',"scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no");
  			
  		}
  		window.opener.reQuery();
  		window.close();
  	}else if(document.getElementById('detailResult').value=='0'){
  		alert('发货失败，请重试！');
  	}
 }
 
  
  
  function barcodeSendCargo(){
  	if(document.getElementById('barcodeScanNum').value==null||document.getElementById('barcodeScanNum').value==''){
		alert('条码已扫描数量为0件！不能确认!');
		return;
  	}
  	
  	document.getElementById('action').value='barcodeSendCargo';
  	document.getElementById('sendState').value='已发货';
  	document.forms[0].submit();
  	waitDetail();
  }
  
  function validateClothingStyle(){
  	if(event.keyCode==13){
  		if(document.getElementById('barCode').value.toUpperCase()!=document.getElementById('clothingSytle').value.toUpperCase()){
  			var xmlhttp;
  			if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  				xmlhttp=new XMLHttpRequest();
  			}else{// code for IE6, IE5
  				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  			}
				xmlhttp.onreadystatechange=function() {
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
    					var styleID = xmlhttp.responseText;
    					if(styleID.toUpperCase()==document.getElementById('clothingSytle').value.toUpperCase()){
  							if(document.getElementById('barcodeScanNum').value=='1'){
  								alert('扫描数量已经超过需求数量！');
  								document.getElementById('barCode').value='';
  								return;
  							}else{
  								document.getElementById('barcodeScanNum').value='1';
  								document.getElementById('barCode').value='';
  							}
  						}else{
  							alert('货品不符！');
  							return;
  						}
    				}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    					alert('网络错误，请重新输入');
    					$(obj).attr('value','');
    					return;
    				}
 				}
 			var uniqueCode = $('#barCode').attr('value');
			xmlhttp.open("post","ajax.ajaxServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("action=getSytleID&uniqueCode="+uniqueCode);
  		}else{
  			if(document.getElementById('barcodeScanNum').value=='1'){
  				alert('扫描数量已经超过需求数量！');
  				document.getElementById('barCode').value='';
  				return;
  			}else{
  				document.getElementById('barcodeScanNum').value='1';
  				document.getElementById('barCode').value='';
  			}
  		}
  	}
  }
  
  
 function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
  </script>
  
  <body onload="initForm()">
   	  <div style="position: relative">
    <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;">正在处理，请稍后......</div>
    <div id="mainDiv" style="position:absolute;top: 20;left:20;width: 100%;height: 100;z-index: -1;display: block;">
    
   	  
   	  <input type="hidden" id="webcontent" name="webcontent" value="<%=path%>">
   	<html:form action="/sendCargo" styleId="sendCargoForm" method="post">
   		<html:hidden property="action"/>
    	<html:hidden property="guid"/>
    	<html:hidden property="detailResult"/>
    	<html:hidden property="sendState"/>
    	<html:hidden property="cargoTransferID"/>
    	<html:hidden property="clothingSytle"/>
   		<bean:define id="reqCargo" name="sendCargoForm" property="reqCargoInfo"></bean:define>
   		需求方：<bean:write name="reqCargo" property="reqDepotName"/>
   		<br />
   		<br />
   		需求款号：<bean:write name="reqCargo" property="clothingStyle"/>
   		<br />
   		<br />
   		需求数量：<bean:write name="reqCargo" property="reqNum" />
   		<br />
   		<br />
   		条码已扫描数量：<html:text property="barcodeScanNum" style="border-style: none; " readonly="true"></html:text>
   		<br />
   		<br />
   		条码：<html:text property="barCode" onkeypress="validateClothingStyle()"></html:text>
   		
   		<br />
   		<br />
   		&nbsp; &nbsp;  &nbsp;
   		<html:button property="button1" value="确定" onclick="barcodeSendCargo()" style="width:50" ></html:button>
   		&nbsp; &nbsp; &nbsp; &nbsp;  
   		<html:button property="button2" value="取消" onclick="window.close()" style="width:50"></html:button>
   		
   	</html:form>
   	</div>
   	</div>
  </body>
</html>
