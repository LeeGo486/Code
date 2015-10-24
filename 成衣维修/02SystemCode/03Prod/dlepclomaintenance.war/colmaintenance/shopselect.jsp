<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>


<html:html>

<head>
<title>店铺选择</title>

	<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath() %>/ecside/css/ecside_style.css" />

	<script type="text/javascript" src="<%=request.getContextPath() %>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript"
			src="<%=request.getContextPath() %>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/ecside/js/ecside.js"></script>


</head>
<script>
	

	function setParentShopID(){
		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var shopID = selectedRow.getAttribute("recordKey");
		opener.document.getElementById("dpbm").value= shopID;
		opener.getShopInfo();
		//opener.getEmployeeList();
		window.close();
	} 

</script>

<body>
	<ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process"  action="/eidtMaintenanceBill.do" pageSizeList="50,100,200,500" rowsDisplayed="100" editable="false"
		    classic="true"
			filterable="true">
				 
			
			
			
			
			<ec:row recordKey="${record.depotid}" ondblclick="setParentShopID()">
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="店铺编码" property="depotid" sortable="true" />
				<ec:column title="店铺名称" property="d_name" sortable="true" />
				<ec:column title="地址" property="address" sortable="true" />
				<ec:column title="店铺大区" property="d_dq" sortable="true" />
				
				
		</ec:row>
			
		</ec:table>

</body>
</html:html>