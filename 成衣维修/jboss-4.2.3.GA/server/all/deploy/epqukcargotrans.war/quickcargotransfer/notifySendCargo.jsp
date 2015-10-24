<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html>
  <head>
    <base href="<%=basePath%>">
    
    <title>通知发货</title>
    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	


  </head>
  
  <script>
  	function setGuid(){
  		document.getElementById('responseButton2').disabled = false;
  		document.getElementById('responseButton1').disabled = false;
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
  		document.getElementById('guid').value=recordKey;
  	}
  
  
  function notifyDetail(state){
  	var guid = document.getElementById('guid').value;
  	if(guid=='' || guid==null){
  		alert('请选择记录！');
  		return;
  	}
  	if(state==1){
  		if(confirm('确定要通知发货？')){
  			document.getElementById("notifySate").value='待发货';
 			document.getElementById("action").value='notifySendCargo';
 			document.forms[0].submit();	
  			waitDetail();
  		}
  	}
  	if(state==0){
  		if(confirm('确定要取消发货通知？')){
  			document.getElementById("notifySate").value='已取消';
 			document.getElementById("action").value='notifySendCargo';
 			document.forms[0].submit();	
  			waitDetail();
  		}
  	}
  	
  
  }
  
  function initForm(){
  	
  	if(document.getElementById('detailResult').value=='1'){
  		alert('处理完成！');
  		document.getElementById('detailResult').value=='';
  	}
  	if(document.getElementById('detailResult').value=='0'){
  		alert('处理失败！');
  		document.getElementById('detailResult').value=='';
  	}
  	//$('#ecTable').find('').each(function(){
  }
  
  
   function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
 
 
 function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  </script>
  
  <body onload="initForm()">
    
    <div style="position: relative">
    <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;">正在处理，请稍后......</div>
    <div id="mainDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;">
    
    <input type="hidden" id="webcontent" name="webcontent" value="<%=path%>">
    
    
    <html:form action="/notifyCargo" styleId="notifySendCargoForm" method="post">
    	<html:hidden property="action"/>
    	<html:hidden property="depotid"/>
    	<html:hidden property="notifySate"/>
    	<html:hidden property="guid"/>
    	<html:hidden property="detailResult"/>
  	</html:form>
  	
  	<ec:table  items="reponsedCargoApply" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="notifyCargo.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row recordKey="${record.guid}" onclick="setGuid()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
				
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"   />
				
				<ec:column title="需求款式" property="XQKH" sortable="true" />
				<ec:column title="颜色" property="YS" sortable="true" />
				<ec:column title="尺码" property="CM" sortable="true" />
				<ec:column title="最晚回复日期" property="YQHFRQ" sortable="true" />
				<ec:column title="最晚到货日期" property="XQRQ" sortable="true" />
				<ec:column title="申请日期" property="SQRQ" sortable="true" />
				<ec:column title="承诺调货日期" property="CNDHRQ"  sortable="true"/>
				<ec:column title="供方编号" property="GFBH" sortable="true" />
				<ec:column title="供方名称" property="GFMC" sortable="true" />
				<ec:column title="店铺类别" property="DPLB" sortable="true" />
				
				<ec:column title="所属大区" property="GFSSDQ" sortable="true" />
				<ec:column title="店长" property="DZ" sortable="true" />
				
				<ec:column title="电话" property="DH" sortable="true" />
				<ec:column title="该店半月销售额" property="NUMS" sortable="true" />
				
				
				
				
		</ec:row>
			
		</ec:table>
		
			<html:button styleId="responseButton1" property="responseButton1" value="通知发货" onclick="notifyDetail(1)" disabled="true"></html:button>
  			<html:button styleId="responseButton2" property="responseButton2" value="取消发货" onclick="notifyDetail(0)" disabled="true"></html:button>
  </div>
  </div>
  </body>
</html:html>
  