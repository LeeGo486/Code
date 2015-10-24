<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>


<html:html>

<head>
	<title>操作记录</title>
	<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />


	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

</head>
<script>

</script>

<body>
	<ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="operaterecord.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="true"
		    classic="true"
			filterable="true">
				 
			
			
			
			
			<ec:row>
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="操作部门" property="CZBM" sortable="true" />
				<ec:column title="操作员" property="CZY" sortable="true" />
				<ec:column title="操作时间" property="CZSJ" sortable="true" />
				<ec:column title="操作类型" property="CZLX" sortable="true" />
				
				
		</ec:row>
			
		</ec:table>

</body>
</html:html>