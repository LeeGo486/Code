<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%String webContext = request.getContextPath();
  String guid = request.getParameter("zbguid");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>����ά�޲�����¼</title>
</head>
<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/demo/demo.css">
<script type="text/javascript" src="<%=webContext %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=webContext %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
			$('#operateRecordGrid').datagrid({
				title:'����ά�޲�����¼',
				//iconCls:'icon-save',
				width:700,
				height:350,
				nowrap: true,
				loadMsg:'����Ŭ���������ݡ���',singleSelect:true,
				autoRowHeight: false,
				striped: true,
				collapsible:true,
				url:$('#webContext').attr('value')+ '/rest/queryCMOperateRecord/'+$('#guid').attr('value'),
				method:'post',
				sortOrder: 'desc',
				remoteSort: false,
				columns:[[
					//{field:'guid',title:'����',width:120,sortable:true},
					{field:'czbmmc',title:'��������',width:120,sortable:true},
					{field:'czyxm',title:'����Ա',width:120,sortable:true},
					{field:'czsj',title:'�����¼�',width:120,sortable:true},
					{field:'czlx',title:'��������',width:120,sortable:true}
				]],
				pagination:true,
				rownumbers:true
				
			});
			
			var p = $('#operateRecordGrid').datagrid('getPager');
			$(p).pagination({
				onBeforeRefresh:function(){
					$('#operateRecordGrid').datagrid('reload');
				}
			});
		});

</script>
<body>
	<input type="hidden" id="guid" value="<%=guid%>">
	<input type="hidden" id="webContext" value="<%=webContext%>">
	<table id="operateRecordGrid"></table>
</body>
</html>