<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>���ڲ�ѯ</title>
    

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	 <script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>

  </head>
  
  <body>
     <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="operaterecord.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="true"
		    classic="true"
			filterable="true">
			<ec:row recordKey="${record.acctPeriodID}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���" property="acctYear" sortable="true" />
				<ec:column title="�·�" property="acctMonth" sortable="true" />
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="�������ڿ�ʼ" property="thisPeriodBgnDate" sortable="true" />
				<ec:column title="�������ڽ���" property="thisPeriodEndDate" sortable="true" />
			</ec:row>
			
		</ec:table>
  </body>
</html>
