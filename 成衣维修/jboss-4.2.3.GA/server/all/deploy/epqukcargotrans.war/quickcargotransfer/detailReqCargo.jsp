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
    
    <title>处理要货请求</title>
    

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
	<style type="text/css">
		body{font-weight: 500;font-size: 13}
		
		
	</style>

  </head>
  
  <script>
 	function detailReq(state){
 		if(state=='0'){
 			if(confirm('确定要拒绝该店的调货请求？')){
 				document.getElementById("detailState").value='已拒绝';
 				document.getElementById("action").value='detailReqCargo';
 				document.forms[0].submit();
 				waitDetail();
 			}
 		}
 		if(state=='1'){
 			if(confirm('确定要同意该店的调货请求？')){
 				document.getElementById("detailState").value='已确认';
 				document.getElementById("action").value='detailReqCargo';
 				document.forms[0].submit();
 				waitDetail();
 			}
 		}
 		
 	}
  	
  	function initForm(){
  		if(document.getElementById("detailResult").value=='1'){
  			alert('处理完毕！');
  			window.opener.reQuery();
  			window.close();
  		}else if(document.getElementById("detailResult").value=='0')
  		{
  			alert('处理异常，请重试！');
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
    
    <html:form action="/responseCargoApply" styleId="responseCargoApplyForm" method="post">
    	<html:hidden property="action"/>
    	<html:hidden property="depotid"/>
    	<html:hidden property="detailState"/>
    	<html:hidden property="guid"/>
    	<html:hidden property="detailResult"/>
    	<div align="left" style="width: 450">
    	
    	<div style="height: 100;overflow: auto;" >
    	<bean:define id="cargoInfo" name="responseCargoApplyForm" property="reqCargoInfo"></bean:define>
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
  			  <%=stockCargoInfo.getClothingID() %> &nbsp;<%=stockCargoInfo.getP_num() %> <br/>
  			<%} }%>
  		</div>
  		<br />
  		
  		承诺调货数量&nbsp; <html:text property="resNum" value="1" readonly="true" style="background-color:#CAE4FF"></html:text>
  		<br />
  		承诺调货日期&nbsp; <html:text property="cnDate" onclick="setday(this)" readonly="true"></html:text>
  		
  		<br />
  		<br />
  		<html:button property="refuse" onclick="detailReq(0)" style="width:60;">拒绝调货</html:button>
  		&nbsp; &nbsp; &nbsp; 
  		<html:button property="agree" onclick="detailReq(1)" style="width:60;">同意调货</html:button>
  		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
  		<html:button property="cancel" onclick="window.close()" style="width:60;">取消</html:button>
  	
  		</div>
  	
  	</html:form>
  	
	</div>
  	</div>
  
  </body>
</html:html>
  