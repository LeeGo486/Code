<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>收货评价</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
	<style type="text/css">
		body{font-weight: 500;font-size: 13}
		
		
	</style>
    
	

  </head>
  <script type="text/javascript">
 function initForm(){
  	if(document.getElementById('detailResult').value=='1'){
  		alert('评价成功！');
  		window.close();
  	}else if(document.getElementById('detailResult').value=='0'){
  		alert('评价失败，请重试！');
  	}
  	
  }
 
  function do_submit(){
  	document.getElementById('action').value='receiveAppraise';
  	document.forms[0].submit();
  }
  
   function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
  </script>
  <body onload="initForm()">
	
  	 <div style="position: relative">
    <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;">正在处理，请稍后......</div>
    <div id="mainDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;">
    
  	 <input type="hidden" id="webcontent" name="webcontent" value="<%=path%>">
  	 <html:form action="/receiveCargo" styleId="receiveCargoForm" method="post">
  	 	<html:hidden property="action"/>
    	<html:hidden property="guid"/>
    	<html:hidden property="detailResult"/>
  	 	<div align="center" style="height:200px" title="评价">
			<html:radio property="appraiseValue" value="0" ><img alt="好评" src="<%=path %>/img/good.JPG"/></html:radio>
			<html:radio property="appraiseValue" value="1" ><img alt="中评" src="<%=path %>/img/commonly.JPG"/></html:radio>
			<html:radio property="appraiseValue" value="2" ><img alt="差评" src="<%=path %>/img/bad.JPG"/></html:radio>
			<br />
		<html:textarea property="appraiseComment" style="width:400px;height:100px"></html:textarea>
	</div>
	<div align="center" >
		<html:button style="align:center;width:50;" property="button" onclick="do_submit()" value="确定" ></html:button>
		
		&nbsp; &nbsp; &nbsp; &nbsp;  
		<html:button style="align:center;width:50;" property="button" onclick="window.close();" value="取消"></html:button>
	
	</div>
  	</html:form>
  	</div>
  	</div>
  </body>
</html>
