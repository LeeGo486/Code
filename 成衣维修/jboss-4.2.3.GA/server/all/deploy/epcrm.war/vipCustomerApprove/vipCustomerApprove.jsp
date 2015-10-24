<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="/tags/ecside" prefix="ec"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>大客户审批</title>

	 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
		
		<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
		
		<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
		<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>



	</head>
	<script type="text/javascript">
	var department;
	$(function() {

		$('#department').combogrid({
			panelWidth : 250,
			idField : 'dept_id',
			textField : 'dept_name',

			columns : [ [ {
				field : 'dept_id',
				title : '编号',
				width : 50
			}, {
				field : 'dept_name',
				title : '店铺名称',
				width : 200
			} ] ]
		});

		getDepartment();
		initForm();
	});

	function getDepartment() {
		if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				department = eval("(" + xmlhttp.responseText + ")");
				$("#department").combogrid("grid").datagrid("loadData", department);
			}
		};

		//var loginDeptID = document.getElementById("deptID").value;
		xmlhttp.open("post", "ajax.ajaxServlet", true);
		xmlhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xmlhttp.send("action=getDepartmentList");
	}
	
	function query(){
		document.forms[0].submit();
	}
	
	function approveBatch(){
		if(validateCheckBox()){
			$('#method').attr('value','approveBatch');
			document.forms[0].submit();
		}
	}
	
	function refuseBatch(){
		if(validateCheckBox()){
			$('#method').attr('value','refuseBatch');
			document.forms[0].submit();
		}
	}
	
	function approve(){
		var accountIDs = $('#account_id').attr('value');
		$('#accountIDs').attr('value',accountIDs);
		$('#method').attr('value','approve');
		document.forms[0].submit();
	}
	
	function refuse(){
		var accountIDs = $('#account_id').attr('value');
		$('#accountIDs').attr('value',accountIDs);
		$('#method').attr('value','refuse');
		document.forms[0].submit();
	}
	
	function initForm(){
		var result = $('#result').attr('value');
		if(result=='0'||result=='-1'||result=='-2'||result=='-3'){
			alert('操作失败');
			return;
		}
		if(result=='1'){
			alert('操作成功');
			return;
		}
		if(result=='2'){
			alert('部分操作成功');
			return;
		}
	}
	
	function hiddenDetail(){
		$('#customerDetail').hide();	
	}
	
	function viewDetail() { 
		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
		var para = new Object();
		para["accountID"] = recordKey;
		$.post(
				$('#path').attr('value') + '/vipCustomerApprove.do?method=viewDetail',para,
				function(rsp) {
					var datas = eval("(" + rsp + ")");
					if (datas.account_id == undefined) {
						$.messager.alert("提示", "找不到客户信息！");
						return;
					} else {
						$('#account_id').attr('value',datas.account_id);
						$('#account_name').html("姓名："+datas.account_name);
						$('#age').html("年龄："+datas.age);
						$('#manager').html("客户经理："+datas.manager);
						$('#sex').html("性别："+datas.sex);
						$('#industry').html("行业："+datas.industry);
						$('#job').html("岗位："+datas.job);
						$('#annual_revenue').html("家庭年收入："+datas.annual_revenue);
						$('#dept_name').html("店铺："+datas.dept_name);
						$('#ZXFJE').html("总消费金额："+datas.ZXFJE);
						$('#xiaofcs').html("总消费次数："+datas.xiaofcs);
						$('#thisyearsale').html("今年消费："+datas.thisyearsale);
						$('#lastdate').html("最近消费:"+datas.lastdate);
						$('#comment').html("备注:"+datas.comment);
						$('#customerDetail').show();	
					
					}
				}, "text").error(function() {
			$.messager.alert("提示", "获取详细信息失败！");
		});
	}

	function validateCheckBox() {
		var flag = true;
		var accountIDs = '';
		var arrayTr = $('#ecTable_table tr');
		for ( var i = 0; i < arrayTr.length; i++) {
			var thisTr = arrayTr[i];
			if ($(thisTr).find('input').eq(0).attr('checked')) {
				accountIDs = accountIDs + ',' + $(thisTr).attr('recordKey');
			}
		}
		accountIDs = accountIDs.substr(1, accountIDs.length - 1);
		if (accountIDs == '') {
			alert('请选择操作记录');
			flag = false;
		}

		$('#accountIDs').attr('value', accountIDs);
		return flag;

	}
</script>

	<body>
	<%-- 	<input type="text" id="department">--%>
		<input type="hidden" id="path" value="<%=path%>">
		<input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
		<html:form styleId="vipCustomerApproveForm" action="/vipCustomerApprove" method="post">
			 <html:hidden styleId="method" property="method" value="query"/>
			 <html:hidden styleId="accountIDs" property="accountIDs"/>
			 <table>
			 	<tr>
			 		<td>店铺名称：</td>
			 		<td><html:text styleId="department"  property="department" style="width: 180"></html:text></td>
			 		<td>顾客姓名：</td>
			 		<td><html:text styleId="customerName"  property="customerName" style="width: 180"></html:text></td>
			 		<td><input type="button" value="查询" onclick="query()" style="width: 60"> </td>
			 	</tr>
			 	<tr>
			 		<td>VIP卡号：</td>
			 		<td><html:text styleId="vipNo" property="vipNo" style="width: 180"></html:text></td>
			 		<td>手机号码：</td>
			 		<td><html:text styleId="customerPhone" property="customerPhone" style="width: 180"></html:text></td>
			 		<td></td>
			 	</tr>
			 </table>
			<br />
			 
			<input type="button" value="批量审批" onclick="approveBatch()">	
			<input type="button" value="批量驳回" onclick="refuseBatch()">	
			 
			
		</html:form>
		
		<div id="customerDetail" style="position:absolute; display: none;background-color: #F3F4F3;height: 200;width:400;overflow: auto;border-color: gray;border-style: solid;border: 2;left:350;z-index: 2; text-align: center;">
			<input type="hidden" id="account_id">
			<table>
				<tr>
					<td>基本信息</td>
					<td><input type="button" value="审批" onclick="approve()"><input type="button" value="驳回" onclick="refuse()"><input type="button" value="关闭" onclick="hiddenDetail()"></td>
				</tr>
				<tr>
					<td id="account_name"></td>
					<td id="age"></td>
				</tr>
				<tr>
					<td id="manager"></td>
					<td id="sex"></td>
				</tr>
				<tr>
					<td id="industry"></td>
					<td id="job"></td>
				</tr>
				<tr>
					<td id="annual_revenue"></td>
					<td id="dept_name"></td>
				</tr>
				<tr>
					<td id="comment" colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2">
					
					</td>
				</tr>
				<tr>
					<td colspan="2">
						消费信息
					</td>
				</tr>
				<tr>
					<td id="ZXFJE"></td>
					<td id="xiaofcs"></td>
				</tr>
				<tr>
					<td id="thisyearsale"></td>
					<td id="lastdate"></td>
				</tr>
			</table>
			
		</div>
		 
		 <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="vipCustomerApprove.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20"
		    classic="true">
			<ec:row recordKey="${record.account_id}">
				<ec:column property="_0"  alias="选择" headerCell="checkbox" cell="checkbox" style="text-align:center"></ec:column>
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"   ondblclick="viewDetail()"/>
				<ec:column title="分公司" property="region" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="店铺" property="dept_name" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="姓名" property="account_name" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="客户经理" property="manager" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="卡号" property="vipcode" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="手机号码" property="account_mobile_phone" sortable="true"  ondblclick="viewDetail()"/>
				<ec:column title="创建时间" property="Create_time" sortable="true" cell="date" format="yyyy-MM-dd" ondblclick="viewDetail()"/>
			</ec:row>
			
		</ec:table>
		
	</body>
</html>
