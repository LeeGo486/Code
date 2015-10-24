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
    
    <title>找货</title>
    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	


  </head>
  <script>
  	function queryCargo(){
  		
  		if(document.getElementById("ks").value==''||document.getElementById("ks").value==null){
  			alert("需求款式不能为空！");
  			return;
  		}
  		
  		if(document.getElementById("color").value==''||document.getElementById("color").value==null){
  			alert("颜色不能为空！");
  			return;
  		}
  		
  		if(document.getElementById("size").value==''||document.getElementById("size").value==null){
  			alert("尺码不能为空！");
  			return;
  		}
  		
  		document.getElementById("action").value='searchCargo';
  		document.forms[0].submit();
  		waitDetail();
  	}
  	
  	function requireCargo(){
  		var strID='';
  		var strName='';
  		for (var i=0;i<document.forms[1].elements.length;i++){ 
			var e = document.forms[1].elements[i]; 
			if(e.type == "checkbox"){         
				if(e.checked==true){     
    				var arrayValue = e.value.split(",");
    				strID+=","+arrayValue[0]; 
					strName+=","+arrayValue[1]
			
			}
					
		} 
  		
	}
 	strID=strID.substr(1,strID.length-1); 
  	if(strID==null || strID==''){
  		alert('请选择调货店铺！');
  		return;
  	}
  	strName=strName.substr(1,strName.length-1); 
 	document.getElementById('gfdepotids').value=strID;
 	document.getElementById('gfdepotnames').value=strName;
 	document.getElementById("action").value='applyStoreCargo';
 	document.forms[0].submit();
 	waitDetail();
 }
  
 function initForm(){
 	if(document.getElementById("isFindRs").value=='0'){
 		alert('未找到货源!');
 	}
 	
 	if(document.getElementById("applySate").value=='1'){
 		var msg = '已经向店铺:\n';
 		arrayID = document.getElementById('gfdepotids').value.split(",");
 		arrayName = document.getElementById('gfdepotnames').value.split(",");
 		for(var i=0;i<arrayID.length;i++){
 			msg += arrayID[i]+':'+arrayName[i]+'\n'
 		}
 		msg += '提出要货询问';
 		alert(msg);
 		document.getElementById("applySate").value='';
 	}else if(document.getElementById("applySate").value=='0'){
 		alert('提出要货询问操作失败，请联系IT部门处理');
 		document.getElementById("applySate").value='';
 	}
 }
 
 function nextInput(inputID){
 	if(event.keyCode==13){
 		$('#'+inputID).focus();
 	}
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
    
    <html:form action="/searchCargo" styleId="searchStoreCargoForm" method="post">
    	<html:hidden property="action"/>
    	<html:hidden property="depotid"/>
    	<html:hidden property="gfdepotids"/>
    	<html:hidden property="applyks"/>
    	<html:hidden property="applycolor"/>
    	<html:hidden property="applysize"/>
    	<html:hidden property="gfdepotnames"/>
    	<html:hidden property="applySate"/>
    	<html:hidden property="isFindRs"/>
    	<table>
    		<tr>
    			<td>需求款式</td>
    			<td><html:text styleId="ks" property="ks" onkeypress="nextInput('color')"/></td>
    			<td>颜色</td>
    			<td><html:text styleId="color" property="color" onkeypress="nextInput('size')"/></td>
    			<td></td>
    			<td></td>
    		</tr>
    		<tr>
    			<td>尺码</td>
    			<td><html:text styleId="size" property="size" onkeypress="nextInput('searchCargo')"/> </td>
    			<td>需求数量</td>
    			<td><html:text styleId="amount" property="amount"  value="1" readonly="true" style="background-color:#CAE4FF;text-align:right" /></td>
    			<td></td>
    			<td></td>
    		</tr>
    		<tr>
    			<td>最晚到货日期</td>
    			<td><html:text styleId="latestArriveDate" property="latestArriveDate" onclick="setday(this)" readonly="true" ></html:text> </td>
    			<td>最晚回复日期</td>
    			<td><html:text styleId="latestResponseDate" property="latestResponseDate" onclick="setday(this)" readonly="true" ></html:text> </td>
    			<td><html:button styleId="searchCargo" property="searchCargo" value="查询" onclick="queryCargo();" style="width:60"/></td>
    			<td><html:button property="requestCargo" value="要货询问" onclick="requireCargo()" style="width:60"/></td>
    		</tr>
    	</table>
  	</html:form>
  	
  	<ec:table  items="storeCargos" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="searchCargo.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row recordKey="${record.depotid}" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
				
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column property="_0"  alias="选择" cell="checkbox" value="${record.depotid},${record.d_name}"></ec:column>
				<ec:column title="可配库存数" property="p_num" sortable="true" />
				<ec:column title="近半月销售数" property="nums" sortable="true" />
				<ec:column title="今天被申请数" property="sl" sortable="true" />
				<ec:column title="店铺编号" property="depotid" sortable="true" />
				<ec:column title="仓店名称" property="d_name" sortable="true" />
				<ec:column title="店铺大区" property="d_dq"  sortable="true"/>
				<ec:column title="地址" property="address" sortable="true" />
				<ec:column title="管理员" property="r_name" sortable="true" />
				<ec:column title="电话" property="tel" sortable="true" />
				
				
				
		</ec:row>
			
		</ec:table>
  	</div>
  	</div>
  </body>
</html:html>
