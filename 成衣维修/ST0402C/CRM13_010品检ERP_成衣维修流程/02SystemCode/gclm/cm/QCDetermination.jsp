<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-json-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<%String webContext = request.getContextPath(); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>成衣维修品检判定</title>
<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext %>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=webContext %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=webContext %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		var index = 0;
		function addTab(){
			index++;
			$('#tt').tabs('add',{
				title:'New Tab ' + index,
				content:'Tab Body ' + index,
				iconCls:'icon-save',
				closable:true,
				tools:[{
					iconCls:'icon-mini-refresh',
					handler:function(){
						alert('refresh');
					}
				}]
			});
		}
		function getSelected(){
			var tab = $('#tt').tabs('getSelected');
			alert('Selected: '+tab.panel('options').title);
		}
		function update(){
			index++;
			var tab = $('#tt').tabs('getSelected');
			$('#tt').tabs('update', {
				tab: tab,
				options:{
					title:'new title'+index,
					iconCls:'icon-save'
				}
			});
		}
	</script>
</head>
<body>
	<h2 align="center">成衣维修</h2>
	<div class="demo-info">
		<div class="demo-tip icon-tip"></div>
		<div></div>
	</div>
	
	<div style="margin:10px 0">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" href="javascript:void(0)" onclick="addTab()">add tab</a>
		<a class="easyui-linkbutton" href="javascript:void(0)" onclick="getSelected()">getSelected</a>
		<a class="easyui-linkbutton" href="javascript:void(0)" onclick="update()">Update</a>
	</div>
	
	<div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width:700px;height:250px;">
		<div title="Tab1" data-options="tools:'#p-tools'" style="padding:20px;">
		</div>
		<div title="Tab2" data-options="closable:true,cache:false,href:'tabs_href_test.html'" style="padding:20px;">
			This is Tab2 with close button.
		</div>
		<div title="Tab3" data-options="iconCls:'icon-reload',closable:true" style="padding:20px;">
			<table id="test" class="easyui-datagrid" data-options="fit:true">
				<thead>
					<tr>
						<th data-options="field:'f1',width:60">field1</th>
						<th data-options="field:'f2',width:60">field2</th>
						<th data-options="field:'f3',width:60">field3</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>d1</td>
						<td>d2</td>
						<td>d3</td>
					</tr>
					<tr>
						<td>d11</td>
						<td>d21</td>
						<td>d31</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div title="Tab4 with iframe" data-options="closable:true" style="overflow:hidden">
			<iframe scrolling="yes" frameborder="0"  src="http://www.jeasyui.com/forum/index.php" style="width:100%;height:100%;"></iframe>
		</div>
		<div title="Tab5 with sub tabs" data-options="closable:true,iconCls:'icon-cut'" style="padding:10px;">
			<div class="easyui-tabs" data-options="fit:true,plain:true">
				<div title="Title1" style="padding:10px;">Content 1</div>
				<div title="Title2" style="padding:10px;">Content 2</div>
				<div title="Title3" style="padding:10px;">Content 3</div>
			</div>
		</div>
	</div>
	
	<div id="tab-tools">
		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="javascript:alert('add')"></a>
		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'" onclick="javascript:alert('save')"></a>
	</div>
	<div id="p-tools">
		<a href="#" class="icon-mini-add" onclick="alert('add')"></a>
		<a href="#" class="icon-mini-edit" onclick="alert('edit')"></a>
		<a href="#" class="icon-mini-refresh" onclick="alert('refresh')"></a>
	</div>
</body>
</html>