<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>科目预算余额</title>
    
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mycommon.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
		

  </head>
  
  <body>
    	 
    	 <ec:table  items="subjectBudgetList" var="record"  tableId="ecTable" 
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="budgetQuery.do"
			pageSizeList="10,20,30,50" rowsDisplayed="50" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row rowId="ecrow">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column  title="科目代码" property="acctcode" sortable="true" />
				<ec:column  title="科目名称" property="acctname" sortable="true" />
				<ec:column  title="预算金额" property="budget" cell="number" format="0.00"  style="text-align:right;" sortable="true" />
				<ec:column  title="已用金额" property="usedMoney" cell="number" format="0.00"  style="text-align:right;" sortable="true"/>
				<ec:column  title="本期预算金额" property="thisbudget" cell="number" format="0.00"  style="text-align:right;" sortable="true" />
				<ec:column  title="本期已用金额" property="thisusedMoney" cell="number" format="0.00"  style="text-align:right;" sortable="true"/>
				
				
			</ec:row>
		</ec:table>
  </body>
</html>
