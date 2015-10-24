<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@page import="ep.org.quickcargotransfer.javabean.StockCargoInfo"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html>
  <head>
    <base href="<%=basePath%>">
    
    <title>取消发货</title>
    

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	

	<style type="text/css">
		body{font-weight: 500;font-size: 13}
		
		
	</style>
  </head>
  
  <script>
 	function cancelSendCargo(){
 		document.getElementById('action').value='cancelSendCargo';
 		document.getElementById('sendState').value='不发货';
  		document.forms[0].submit();
  		waitDetail();
 	}
  	function initForm(){
  		if(document.getElementById("detailResult").value=='1'){
  			alert('处理完毕！');
  			window.opener.reQuery();
  			window.close();
  		}
  	}
   function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
 
  </script>
  
  <body onload="initForm();">
    <div style="position: relative">
    <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;">正在处理，请稍后......</div>
    <div id="mainDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;">
      
      <input type="hidden" id="webcontent" name="webcontent" value="<%=path%>">
    
    <html:form action="/sendCargo" styleId="sendCargoForm" method="post">
    	<html:hidden property="action"/>
    	<html:hidden property="guid"/>
    	<html:hidden property="detailResult"/>
    	<html:hidden property="sendState"/>
    	
    	<div align="left">
    	<div style="height: 100;overflow: auto;" >
    	<bean:define id="cargoInfo" name="sendCargoForm" property="reqCargoInfo"></bean:define>
    	<bean:write name="cargoInfo" property="reqDepotName"/>&nbsp;店铺向您请求调货 &nbsp; 
  	    <font color="blue"><bean:write name="cargoInfo" property="clothingStyle" /></font>  &nbsp;款式<font color="red">1</font>件
  		<br />
  		该店可用库存数量：<font color="red"> <bean:write name="cargoInfo" property="resDepotKpNum" /></font>
  		<br />
  		该店近半月销售数量：<font color="red"><bean:write name="cargoInfo" property="resDepotSaleNums" /></font>
  		<br />
  		相关款式库存：
  		<br />
  		<%List stockCargoList =(List) request.getAttribute("stockCargoList"); 
  			if(stockCargoList!=null){
  			for(int i=0;i<stockCargoList.size();i++){
  				StockCargoInfo stockCargoInfo =(StockCargoInfo) stockCargoList.get(i);
  			%>
  			  <%=stockCargoInfo.getClothingID() %> &nbsp;<%=stockCargoInfo.getP_num() %>
  			<%} }%>
  		<br />
  		<br />
  		
  		</div>
  		你选择不发货，必须填写说明
  		<br />
  		 <html:textarea property="cancelReason" cols="40" rows="5"></html:textarea>
  		
  		<br />
  		<br />
  		&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
  		&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; 
  		&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
  		&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; 
  		<html:button property="refuse" onclick="cancelSendCargo()" style="width:50">确定</html:button>
  		&nbsp; &nbsp; &nbsp;
  		<html:button property="cancel" onclick="window.close()" style="width:50">取消</html:button>
  		
  		</div>
  	
  	</html:form>
  	
</div>
</div>
  
  </body>
</html:html>
  