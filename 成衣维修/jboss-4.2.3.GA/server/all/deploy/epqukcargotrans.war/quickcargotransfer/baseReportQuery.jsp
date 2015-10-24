<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zt = (String)request.getAttribute("zt");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=request.getAttribute("zt") %>  </title>
    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
    

  </head>
  <script>
  	function getMXInfos(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
  		//document.getElementById('GUID').value=recordKey;
  		document.frames['mxReport'].location.href=document.getElementById('path').value
  			+'/baseReport.do?action=queryMXRepoertInfos&zbGuid='+recordKey
  			+'&zt='+document.getElementById('zt').value;
  	}
  	
  function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  	
  </script>
  <body>
      需求方<br/>
      <html:hidden property="path" value="<%=path%>"/>
      
      <html:form action="/baseReport" styleId="baseReportForm">
      	<html:hidden property="action"/>
      	<html:hidden property="zt"/>
      </html:form>
     
        
      <ec:table  items="baseInfos" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"   
			retrieveRowsCallback="process" action="baseReport.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" listHeight="230" listWidth="100%"
			filterable="true">
				 
			<ec:row recordKey="${record.GUID}" onclick="getMXInfos()" onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
				
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  width="4%"/>
				
				<ec:column title="需求款式" property="XQKH" sortable="true" width="7%"/>
				<ec:column title="颜色" property="YS" sortable="true" width="4%"/>
				<ec:column title="尺码" property="CM" sortable="true" width="4%"/>
				<ec:column title="店铺编号" property="DPBH" sortable="true" width="6%"/>
				<ec:column title="店铺名称" property="DPMC" sortable="true" width="9%"/>
				<ec:column title="申请日期" property="SQRQ" sortable="true" width="8%"/>
				<ec:column title="店长" property="DZ" sortable="true" width="5%"/>
				<ec:column title="电话" property="DH" sortable="true" width="8%"/>
				<ec:column title="店铺地址" property="DPDZ" sortable="true" width="15%"/>
				<ec:column title="状态" property="ZT" sortable="true" width="3%"/>
				<ec:column title="店铺类别" property="DPLB" sortable="true" width="5%"/>
				<ec:column title="最晚回复日期" property="YQHFRQ" sortable="true" width="8%"/>
				<ec:column title="最晚到货日期" property="XQRQ" sortable="true" width="8%"/>
				
		</ec:row>
			
		</ec:table>
		
		<br />
		<div style="width: 100%;height: 30%;overflow-y:auto;">
			<iframe width="100%" height="100%" name="mxReport" src="<%=path%>/baseReport.do?action=queryMXRepoertInfos&zt=<%=zt%>"></iframe>
		</div>
  </body>
</html>
