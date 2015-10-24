<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>成功调货</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>


  </head>
  <script type="text/javascript">
     function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  
  </script>
  <body>
  	供方<br/>
  	 <ec:table  items="infos" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  listHeight="180" listWidth="100%"
			retrieveRowsCallback="process" action="baseReport.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row onmouseover="mouseonChange(this)" onmouseout="mouseoutChange(this)">
				
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  width="4%"/>
				
				<ec:column title="调货单号" property="THDH" sortable="true" width="8%"/>
				<ec:column title="发货日期" property="SJFHRQ" sortable="true" width="8%"/>
				<ec:column title="供方编号" property="GFBH" sortable="true" width="6%"/>
				<ec:column title="供方名称" property="GFMC" sortable="true" width="6%"/>
				<ec:column title="所属大区" property="GFSSDQ" sortable="true" width="6%"/>
				
				<ec:column title="店长" property="DZ" sortable="true"  width="6%"/>
				<ec:column title="电话" property="DH" sortable="true"  width="8%"/>
				<ec:column title="供方地址" property="GFDZ" sortable="true" width="20%"/>
			
				<ec:column title="该店近半月销售额" property="NUMS" sortable="true" width="10%"/>
				<ec:column title="需方评价" property="XFPJ" sortable="true" width="6%"/>
				<ec:column title="需方评价意见" property="XFPJYJ" sortable="true" width="14%"/>
				
		</ec:row>
			
		</ec:table>
  
  </body>
 
</html>
