<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看要货回复</title>
    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
  	function queryZBinfo(){
  		document.getElementById('action').value='queryZBInfo';
  		document.forms[0].submit();
  		waitDetail();
  	}
  
  	function queryDateChange(){
  		var select = document.getElementById('queryDate');
  		var selValue = select.options[select.options.selectedIndex].value;
  		if(selValue=='1'){
  			var url = document.getElementById('path').value+'/quickcargotransfer/openTime.jsp';
  			window.open(url, "选择查询日期", "scrollbars=yes,width=200px,height=100px,resizable=yes,menubar=no,status=no,location=no");	
  		}else{
  			queryZBinfo();
  		}
  	}
  	
  	function getMXInfos(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
  		//document.getElementById('GUID').value=recordKey;
  		document.frames['mxReport'].location.href=document.getElementById('path').value
  			+'/viewCargoApplyRes.do?action=queryMX&zbguid='+recordKey;
  	}
  	
  	function initForm(){
  		var checkBoxString = document.getElementById('checkBoxHiddenValue').value;
  		var checkBoxArray =  document.getElementsByName("zts");
  		//checkBoxString.split(',');
  		for(var i=0;i<checkBoxArray.length;i++){
  			var index = checkBoxString.lastIndexOf(checkBoxArray[i].value);
  			if(index>-1){
  				checkBoxArray[i].checked=true;
  			}
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
   
      <html:hidden property="path" value="<%=path%>"/>
      
      <html:form action="/viewCargoApplyRes" styleId="viewCargoApplyResForm">
        <html:hidden property="isFirstReq"/>
        <html:hidden property="bgnDate"/>
        <html:hidden property="endDate"/> 
        <html:hidden property="action"/>
        <html:hidden property="checkBoxHiddenValue"/>
        <div id="queryCondition" >
          
          <html:checkbox property="zts" value="待确认" onclick="queryZBinfo()">待确认</html:checkbox>
          <html:checkbox property="zts" value="已确认" onclick="queryZBinfo()">已确认</html:checkbox>
          <html:checkbox property="zts" value="已拒绝" onclick="queryZBinfo()">已拒绝</html:checkbox>
          <html:checkbox property="zts" value="已关闭" onclick="queryZBinfo()">已关闭</html:checkbox>
          <html:select property="queryDate" onchange="queryDateChange()">
              <html:optionsCollection name="arrayTime" label="timeLab" value="timeValue"/>
          </html:select>
      	
      	</div>
      </html:form>
      
       
       <ec:table  items="zbApplyInfo" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  listHeight="160" listWidth="100%"
			retrieveRowsCallback="process" action="viewCargoApplyRes.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row recordKey="${record.GUID}" onclick="getMXInfos()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}" width="6%" />
				<ec:column title="需求款式" property="XQKH" sortable="true" width="10%" />
				<ec:column title="颜色" property="YS" sortable="true"  width="10%" />
				<ec:column title="尺码" property="CM" sortable="true"  width="10%" />
				<ec:column title="需求数量" property="XQSL"  width="10%" />
				<ec:column title="最晚回复日期" property="YQHFRQ" sortable="true" width="12%"/>
				<ec:column title="最晚到货日期" property="XQRQ" sortable="true" width="12%"/>
				<ec:column title="申请日期" property="SQRQ" sortable="true" width="10%"/>
				<ec:column title="状态" property="ZT" sortable="true" width="10%"/>
			
			</ec:row>
			
		</ec:table>
		
		
		
		<br />
		
		<div style="width: 100%;height: 80%;">
		<iframe width="100%" height="100%" name="mxReport" src="<%=path%>/viewCargoApplyRes.do?action=queryMX"></iframe>
     	 
     	 </div>
     	 </div>
     	 </div>
  </body>
</html>
