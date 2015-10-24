<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%String webContext = request.getContextPath(); %>
<head>
	<title>成衣维修</title>
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/icon.css">
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>
	

	<script type="text/javascript">
		
		var selectUserID;
	
		 $(function() {  
         	$(document).ready(function() {  
          		initTree();
          		
        	});  
  
   			$('#roleGrid').datagrid({
			title : '角色',
			iconCls : 'icon-save',
			width:400,
			height : 350,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			collapsible : true,
			url :  $('#webContext').attr('value')+'/rest/DrpUser/queryrole/-1',
			method : 'post',
			sortOrder : 'desc',
			remoteSort : false,
			//idField:'rolename,roledesc',
			columns : [ [

			{
				field : 'roleid',
				title : '主键',
				hidden : true
			}, {
				field : 'rolename',
				title : '角色名称',
				width : 150,
				sortable : true
				
			}, {
				field : 'roledesc',
				title : '角色描述',
				width :200,
				sortable : true
			}

			] ],
			rownumbers : true,

			toolbar : [ {
				id : 'btnadd',
				text : '新增',
				iconCls : 'icon-add',
				handler : function() {
					$('#roleGridNo').datagrid('options').url = $('#webContext').attr('value')+'/rest/DrpUser/queryRoleNoGrant/'+selectUserID;
					$('#roleGridNo').datagrid('load');
					openRoleHidden();
					

				}
			}, 
			
			{
				id : 'btncut',
				text : '删除',
				iconCls : 'icon-cut',
				handler : function() {
					$('#btnsave').linkbutton('enable');
					var row = $('#roleGrid').datagrid('getSelected');
					if (row) { 
						var rowIndex = $('#roleGrid').datagrid('getRowIndex', row);
						$('#roleGrid').datagrid('deleteRow', rowIndex);
					}
					
				}
			}, '-', {
				id : 'btnsave',
				text : '保存',
				disabled : true,
				iconCls : 'icon-save',
				handler : function() {
					$('#btnsave').linkbutton('disable');
					if ($('#roleGrid').datagrid('getChanges').length) {
						
						var deleted = $('#roleGrid').datagrid('getChanges',"deleted");
						var effectRow = new Object();
						
						if (deleted.length) {
							effectRow["deleted"] = JSON.stringify(deleted);
						}
						
					
						$.post(	$('#webContext').attr('value')+ '/rest/DrpUser/delRole/'+selectUserID,effectRow,function(rsp) {
						
							//if (rsp.status) {
							$.messager.alert("提示","提交成功！");
							$('#roleGrid').datagrid('acceptChanges');
							
							//}
						},'text').error(function() {
											$.messager.alert("提示","提交错误了！");
											});
						}
					
						var rows = $('#roleGrid').datagrid('getRows');
						for ( var i = 0; i < rows.length; i++) {
							$('#roleGrid').datagrid('endEdit', $('#roleGrid').datagrid('getRowIndex',rows[i]));
						}
					
					
				}
			} ]
		});
   	
   		
   		$('#roleGridNo').datagrid({
			title : '未分配角色',
			iconCls : 'icon-save',
			
			height : 350,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			collapsible : true,
			url :  $('#webContext').attr('value')+'/rest/DrpUser/queryRoleNoGrant/-1',
			method : 'post',
			sortOrder : 'desc',
			remoteSort : false,
			idField:'roleid',
			columns : [ [

			{
				field : 'roleid',
				title : '主键',
				hidden : true
			}, {
				field : 'rolename',
				title : '角色名称',
				width : 150,
				sortable : true
				
			}, {
				field : 'roledesc',
				title : '角色描述',
				width :200,
				sortable : true
			}

			] ],
			rownumbers : true,

			toolbar : [{
				id : 'btnsave',
				text : '保存',
				disabled : false,
				iconCls : 'icon-save',
				handler : function() {
					$('#btnsave').linkbutton('disable');
					var selectedRows = $('#roleGridNo').datagrid('getSelections');
					if (selectedRows.length>0) {
						var roleidStr='-1';
						
						var effectRow = new Object();
						effectRow["grant"] = JSON.stringify(selectedRows);
					
						$.post(	$('#webContext').attr('value')+ '/rest/DrpUser/addRole/'+selectUserID+'/'+roleidStr,effectRow,function(rsp) {
							if(rsp=='1'){
								$.messager.alert("提示","提交成功！");
								$('#roleGridNo').datagrid('options').url = $('#webContext').attr('value')+'/rest/DrpUser/queryRoleNoGrant/'+selectUserID;
								$('#roleGridNo').datagrid('load');
								$('#roleGrid').datagrid('options').url = $('#webContext').attr('value')+'/rest/DrpUser/queryrole/'+selectUserID;
								$('#roleGrid').datagrid('load');
							}
							
							
							//}
						},'text').error(function() {
											$.messager.alert("提示","提交错误了！");
											});
						}
									
				}
			} ]
		});
   	
   	
   	});  
		
		
		function addChildren(node){
			var usergroup =  node.id;
			var para = new Object();
			para['usergroup']=usergroup;
			$.post(	$('#webContext').attr('value')+ '/rest/DrpUser/get/usergroup',para,function(rsp) {
				var datas = eval("(" + rsp + ")");
				//$('#tt2').tree('remove',node.target);
				$('#tt2').tree('append',{
				parent: node.target,
				data:datas
			});
			
			$("#tt2").tree('expand', node.target);
						}, "text")
														.error(
																function() {
																	$.messager.alert("提示","提交错误了！");
																});
		}
		
		function initTree(){
			var para = new Object();
			$.post(	$('#webContext').attr('value')+ '/rest/DrpDept/get/all',para,function(rsp) {
				var datas = eval("(" + rsp + ")");
				//$('#tt2').tree('remove',node.target);
				$("#tt2").tree({  
               		data : datas,
           			onClick: function(node){
								var children = $(this).tree('getChildren', node.target);
								selectUserID = node.id;
								if(children.length==0){
									addChildren(node);
								}else{
									
									$(this).tree('toggle', node.target);
								}
								queryRoleByUser(selectUserID);
							},
					
			
					onContextMenu: function(e,node){
								e.preventDefault();
								$(this).tree('select',node.target);
				
								$('#mm').menu('show',{
									left: e.pageX,
									top: e.pageY
								});
					}
           		}); 
																}, "text")
														.error(
																function() {
																	$.messager.alert("提示","提交错误了！");
																});
		}
		
		
	
	
	
	
	//---------------弹出窗口	
		
		function queryRoleByUser(userID){
			$('#roleGrid').datagrid('options').url=$('#webContext').attr('value')+'/rest/DrpUser/queryrole/'+userID;
			$('#roleGrid').datagrid('load');
		}
		function openRoleHidden(){
			$('#roleHidden').window('open');
			
		}
	</script>
	
</head>
<body>
	<input type="hidden" id="webContext" value="<%=webContext%>">
	
	
	
				
				<div style="position:absolute; left:10px; top:0px;width:400px;height:100%;border:1px solid #ccc;overflow:auto;">
	
				<ul id="tt2"></ul>
				</div>
	
	
		
			
			<div style="position:absolute; left: 420px;top: 0px">
			
		
				<table id="roleGrid"></table>
			
	
			</div>
		
	

	
	
	<div id="roleHidden" class="easyui-window" data-options="closed:true,modal:true,title:'Test Window'" style="width:600px;height:300px;">
		<table id="roleGridNo"></table>
	</div>
	
</body>
</html>