<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info");
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>驳回记录查询</title>
    
	
	  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mycommon.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
		

  </head>
  
  <script type="text/javascript">
  	
  </script>
  
  <body>
    	<ec:table  items="infoList" var="record"  tableId="ecTable" 
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="refuseRecordQuery.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row >
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column  title="申请单号" property="FI_ExpenseNo" sortable="true" onmouseover=""/>
				<ec:column title="驳回时间" property="FI_OperaterTime" sortable="true" />
				<ec:column title="驳回人" property="FI_CurrentUser" sortable="true" />
				<ec:column title="驳回理由" property="FI_RefuseReason" sortable="true" />
			
			
			
			</ec:row>
			
		</ec:table>
		
  </body>
</html>
