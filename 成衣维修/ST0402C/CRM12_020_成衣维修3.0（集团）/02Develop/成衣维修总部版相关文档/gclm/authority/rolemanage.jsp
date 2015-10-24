<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%
	String webContext = request.getContextPath();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<title>成衣维修操作列表</title>
	</head>
	<title>角色管理</title>
	<link rel="stylesheet" type="text/css"
		href="<%=webContext%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css"
		href="<%=webContext%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css"
		href="<%=webContext%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css"
		href="<%=webContext%>/jquery-easyui-1.3.1/themes/icon.css">
	<script type="text/javascript"
		src="<%=webContext%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript"
		src="<%=webContext%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="<%=webContext%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>


	<script type="text/javascript">
	var selectedRoleID;
	$(function() {
		$('#roleGrid').datagrid({
			title : '角色',
			iconCls : 'icon-save',
			height : 350,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			collapsible : true,
			url :  $('#webContext').attr('value')+'/rest/queryRole/all',
			method : 'post',
			sortOrder : 'desc',
			remoteSort : false,
			singleSelect: true,
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
				sortable : true,
				editor : "validatebox"
			}, {
				field : 'roledesc',
				title : '角色描述',
				width :200,
				sortable : true,
				editor : "validatebox"
			}

			] ],
			pagination : true,
			rownumbers : true,
			onClickRow: function (rowIndex) {
				queryMenu();
			}, 

			toolbar : [ {
				id : 'btnadd',
				text : '新增',
				iconCls : 'icon-add',
				handler : function() {
					$('#btnsave').linkbutton('enable');
					$('#roleGrid').datagrid('appendRow', {id:'',rolename:'',roledesc:''});
					var rows = $('#roleGrid').datagrid('getRows');
					$('#roleGrid').datagrid('beginEdit', rows.length - 1);

				}
			},{id: 'btnedit',
				text : "编辑",
				iconCls : "icon-edit",
				handler : function() {
					$('#btnsave').linkbutton('enable');
					var row = $('#roleGrid').datagrid('getSelected');
					if (row) {
					 var rowIndex = $('#roleGrid').datagrid('getRowIndex', row);
					 $('#roleGrid').datagrid('beginEdit', rowIndex);
					}
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
					endEdit();
					if ($('#roleGrid').datagrid('getChanges').length) {
						var inserted = $('#roleGrid').datagrid('getChanges',"inserted");
						var deleted = $('#roleGrid').datagrid('getChanges',"deleted");
						
						var updated = $('#roleGrid').datagrid('getChanges',"updated");
						var effectRow = new Object();
						if (inserted.length) {
							effectRow["inserted"] = JSON.stringify(inserted);
						}
						if (deleted.length) {
							effectRow["deleted"] = JSON.stringify(deleted);
						}
						if (updated.length) {
							effectRow["updated"] = JSON.stringify(updated);
						}
					
						$.post(	$('#webContext').attr('value')+ '/rest/roleChange',effectRow,function(rsp) {
							$.messager.alert("提示","提交成功！");
							$('#roleGrid').datagrid('acceptChanges');
							queryRole();
						},'text').error(function() {$.messager.alert("提示","提交错误了！");											});
						}
					
						var rows = $('#roleGrid').datagrid('getRows');
						for ( var i = 0; i < rows.length; i++) {
							$('#roleGrid').datagrid('endEdit', i);
						}
					
					
				}
			} ]
		});
		var p = $('#roleGrid').datagrid('getPager');
		$(p).pagination({
			onSelectPage: function( pageNumber, pageSize ) {
				var grid = $('#datagrid');  
				var options = grid.datagrid('getPager').data("pagination").options;  
				var curr = options.pageNumber;  
				var total = options.total;  
				var max = Math.ceil(total/options.pageSize);  
				
			},
			onBeforeRefresh : function() {

				alert('before refresh');
			}
		});
		
		
		function endEdit(){
           		var rows = $('#roleGrid').datagrid('getRows');
           		 for ( var i = 0; i < rows.length; i++) {
                	$('#roleGrid').datagrid('endEdit', i);
           		 }
        	};
						
		
		$('#menuGrid').datagrid({
							title : '菜单',
							iconCls : 'icon-save',
							height : 350,
							nowrap : true,
							autoRowHeight : false,
							striped : true,
							collapsible : true,
							url : $('#webContext').attr('value') + '/rest/queryMenu/id/-1',
							method : 'post',
							sortOrder : 'desc',
							remoteSort : false,
							columns : [ [ {
								field : 'menuid',
								title : '主键',
								hidden : true
							}, {
								field : 'menuname',
								title : '菜单名',
								width : 300,
								sortable : true
							} ] ],
							pagination : true,
							rownumbers : true,

							toolbar : [
									{
										id : 'btnadd',
										text : '新增',
										iconCls : 'icon-add',
										handler : function() {
											selectedRoleID = $('#roleGrid').datagrid('getSelected').roleid;
											
											if(selectedRoleID==null || selectedRoleID==''){
												alert('必须选择角色');
											}
							
											$('#menuGridNo').datagrid('options').url = $('#webContext').attr('value')+'/rest/queryMenu/notGrant/id/'+selectedRoleID;
											
											$('#menuGridNo').datagrid('load');
											openRoleHidden();
											
										}
									},
									{
										id : 'btncut',
										text : '删除',
										iconCls : 'icon-cut',
										handler : function() {
											$('#btnsave').linkbutton('enable');
											var row = $('#menuGrid').datagrid('getSelected');
											if (row) { 
												var rowIndex = $('#menuGrid').datagrid('getRowIndex', row);
												$('#menuGrid').datagrid('deleteRow', rowIndex);
											}
										}
									},
									'-',
									{
										id : 'btnsave',
										text : '保存',
										disabled : false,
										iconCls : 'icon-save',
										handler : function() {
											//$('#btnsave').linkbutton('disable');
											endEdit();
											if ($('#menuGrid').datagrid('getChanges').length) {
												var deleted = $('#menuGrid').datagrid('getChanges',"deleted");
												var effectRow = new Object();
												if (deleted.length) {
													effectRow["deleted"] = JSON.stringify(deleted);
												}
												selectedRoleID = $('#roleGrid').datagrid('getSelected').roleid;
												$.post(	$('#webContext').attr('value')+ '/rest/delMenu/id/'+selectedRoleID,effectRow,function(rsp) {
																	alert(rsp);
																	if (rsp=='1') {
																		$.messager.alert("提示","提交成功！");
																		$('#menuGrid').datagrid('acceptChanges');
																	}
																}, "JSON")
														.error(
																function() {
																	$.messager.alert("提示","提交错误了！");
																});
											}
										}
									} ]
								});
								
				
						
						
					

		var p = $('#menuGrid').datagrid('getPager');
		$(p).pagination({
			onSelectPage: function( pageNumber, pageSize ) {
				alert(pageSize);
				var grid = $('#datagrid');  
				var options = grid.datagrid('getPager').data("pagination").options;  
				var curr = options.pageNumber;  
				var total = options.total;  
				var max = Math.ceil(total/options.pageSize);  
				
			},
			onBeforeRefresh : function() {

				alert('before refresh');
			}
		});

	
		$('#menuGridNo').datagrid({
			title : '未分配菜单',
			iconCls : 'icon-save',
			
			height : 350,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			collapsible : true,
			url :  $('#webContext').attr('value')+'/rest/queryMenu/notGrant/id/-1',
			method : 'post',
			sortOrder : 'desc',
			remoteSort : false,
			idField:'menuid',
			columns : [ [ {
								field : 'menuid',
								title : '主键',
								hidden : true
							}, {
								field : 'menuname',
								title : '菜单名',
								width : 300,
								sortable : true
							} ] ],
			rownumbers : true,

			toolbar : [{
				id : 'btnsave',
				text : '保存',
				disabled : false,
				iconCls : 'icon-save',
				handler : function() {
					
					//$('#btnsave').linkbutton('disable');
					var selectedRows = $('#menuGridNo').datagrid('getSelections');
					if (selectedRows.length>0) {
						
						var roleidStr='-1';
						/*for(var i=0;i<=selectedRows.length;i++){
							
							roleidStr = roleidStr+","+selectedRows[i].menuid;
							alert(selectedRows[i].menuid);
						}
						alert('1111');
						roleidStr = roleidStr.substring(1,3);*/
						//alert(JSON.stringify(selectedRows));
						var effectRow = new Object();
						effectRow["grant"] = JSON.stringify(selectedRows);
					
						$.post(	$('#webContext').attr('value')+ '/rest/addMenu/id/'+selectedRoleID+'/'+roleidStr,effectRow,function(rsp) {
							if(rsp=='1'){
								$.messager.alert("提示","提交成功！");
								$('#menuGridNo').datagrid('options').url = $('#webContext').attr('value')+'/rest/queryMenu/notGrant/id/'+selectedRoleID;
								$('#menuGridNo').datagrid('load');
								$('#menuGrid').datagrid('options').url = $('#webContext').attr('value')+'/rest/queryMenu/id/'+selectedRoleID;
								$('#menuGrid').datagrid('load');
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

	function queryRole() {
		var roleName = $('#roleName').attr('value');
		if (roleName != '' && roleName != null) {
			alert(roleName);
			$('#roleGrid').datagrid('options').url = $('#webContext').attr('value')
					+ '/rest/queryRole/name/' + roleName;
		} else {
			$('#roleGrid').datagrid('options').url = $('#webContext').attr('value')
					+ '/rest/queryRole/all';
		}
		$('#roleGrid').datagrid('load');

	}

	function queryMenu() {
		var selected = $('#roleGrid').datagrid('getSelected');
		var roleid = selected.roleid;
		$('#menuGrid').datagrid('options').url = $('#webContext').attr('value')
				+ '/rest/queryMenu/id/' + roleid;
		$('#menuGrid').datagrid('load');

	}

	function saveChangeData() {

	}
	
	
	//---------------弹出窗口	
		
		
		function openRoleHidden(){
			$('#menuHidden').window('open');
			
		}
</script>
	<body>
		<input type="hidden" id="webContext" value="<%=webContext%>">
		
		<div style="position:relative;width:100%;height:100%;border:1px solid #ccc;overflow:auto;">
		
		<div data-options="region:'west',split:true" title="角色"
			style="width: 800px; padding1: 1px; overflow: hidden;">
			<div class="easyui-accordion" data-options="fit:true,border:false">
				<table>
					<tr>
						<td>
							角色名：
						</td>

						<td>
							<input type="text" id="roleName" />
						</td>

						<td>
							<input type="button" id="button1" value="查询"
								onclick="queryRole()" />
						</td>
					</tr>
				</table>
				</div>
			
			<table width="800">
			
			<tr>
			<td width="400">
				<div data-options="region:'center'" title="角色管理" style="overflow: hidden;">
					<table id="roleGrid"></table>
				</div>

			</td>
	

		<td width="400">
			<div data-options="region:'center'" title="菜单"	 style="overflow: hidden;" >
				<table id="menuGrid"></table>

			</div>
		</td>
		</tr>
	</table>
	</div>
</div>
	
	<div id="menuHidden" class="easyui-window" data-options="closed:true,modal:true,title:'Test Window'" style="width:600px;height:300px;">
		<table id="menuGridNo"></table>
	</div>


	</body>
</html>