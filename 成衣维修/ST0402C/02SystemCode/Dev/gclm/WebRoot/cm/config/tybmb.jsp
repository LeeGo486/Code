<%@page import="org.hy.model.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
%>

<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset= GBK  ">
   
    <title>������Ϣά��ҳ��</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.2/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.2/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.2/src/jquery.parser.js"></script>
	
	<script type="text/javascript" src="<%=path%>/common/util/jsonUtil.js"></script>
	<script type="text/javascript" src="<%=path%>/common/util/dateUtil.js"></script>
	<script type="text/javascript" src="<%=path%>/common/commondata/basedata.js"></script>
	<script type="text/javascript" src="<%=path%>/cm/config/tybmb.js"></script>
<script type="text/javascript">
    
     
 
</script>
   
 <style type="text/css">
  
</style>

  </head>
  
  <body>
  	<input type="hidden" id="userName" value="<%=userInfo.getUsername()%>">
  	<input type="hidden" id="path" value="<%=path%>">
  	
	<input id="jclx_combobox" class="easyui-combobox" name="language" data-options="
				data:JCSJ,
				valueField: 'typeName',
				textField: 'typeName',
				panelWidth: '150',
				panelHeight: 'auto',
				onSelect:function(record){
					editIndex = undefined;
					$('#dg').datagrid('loadData',basedate_getJCSJinfo(encodeURI(record.typeName)));
				},
				onShowPanel : function() {
					
				}
			">
	<BR><BR>
	<!--  <table id="bbaseInfGrid" style="width: 1024px"></table>-->
	<!-- <table id="dg" class="easyui-datagrid"  style="width:1000px;height:400px"
			data-options="
				idField:'guid',
				pageSize:20,
				pageList : [ 10, 15, 20, 50, 100 ],
				pagination:false,
				rownumbers:true,
				nowrap: false,
				toolbar: '#tb',
				onDblClickRow:onDblClickRow
			">
		<thead>
			<tr >
				<th data-options="field:'ck',width:30,checkbox:true">ѡ��</th>
				<th data-options="field:'guid',width:10,hidden:true">ID</th>
				<th data-options="field:'type',width:80">����</th>
				<th data-options="field:'typeSeqID',width:80,editor:{type:'numberbox',options:{precision:0}}">�������</th>
				<th data-options="field:'typeCode',width:80,editor:'text'">���ʹ���</th>
				<th data-options="field:'typeName',width:120,editor:'text'">��������</th>
				<th data-options="field:'remark',width:100,editor:'text'">Ȩ��</th>
				<th data-options="field:'typeAttr1',width:100,editor:'text'">����1</th>
				<th data-options="field:'typeAttr2',width:100,editor:'text'">����2</th>
				<th data-options="field:'typeAttr3',width:100,editor:'text'">����3</th>
				<th data-options="field:'typeAttr4',width:200,editor:'text'">����4</th>
				<th data-options="field:'typeAttr5',width:100,editor:'text'">����5</th>
				<th data-options="field:'status',width:100, 
					editor:{
						type:'combobox',
						options:{
							valueField:'statevs',
							textField:'statets',
							data:protimesZT,
							panelHeight:'auto'
						}	
					}
				">״̬</th>
				
				<th data-options="field:'modifier',width:100">�޸���</th>
				<th data-options="field:'modifyTime',width:100">�޸�ʱ��</th>
			</tr>
		</thead>
	</table> -->
	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">����</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removed()">ɾ��</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">����</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">����</a>
	</div>
	<table id="dg" class="easyui-datagrid"></table>

	
  
 
 
  
 
  </body>
 
</html>
