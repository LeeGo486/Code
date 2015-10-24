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
    
    <title>汇报货款</title>
     
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>

	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
  	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
  function rcvedRelated(){
    
    //var settleID = $('#settleBillID').attr('value');
    var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	if(recordKey==null){
  		alert('请选择实收记录！');
  		return;
  	}
  	
  	var relatedState = recordKey.split(',')[1];
  	if(relatedState=='已分配'){
  		alert('本账期已存在关联的时候记录，请先取消关联！');
  		return;
  	}
  	
  	$('#rcvedID').attr('value',recordKey.split(',')[0]);
  	$('#rcvedAction').attr('value','related');
  	//if(settleID=='' || settleID==null){
    var reprotAmout =  $('#rcvblAmout').attr('value');
    if(reprotAmout!=null){
    	$('#reportAmout').attr('value',reprotAmout);
    }
    openAmountHidden();
    	//return 
    //}
    //if(parseFloat($('#rcvblAmout').attr('value'))==0){ 
  		//openAmountHidden();
    	//return 
  	//}
    
  	//document.forms[0].submit();
  }
  
  function cancelRcvedRelated(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	if(recordKey==null){
  		alert('请选择实收记录！');
  		return;
  	}
  	var relatedState = recordKey.split(',')[1];
  	if(relatedState=='未分配'){
  		alert('本账期不存在关联的时候记录，无法取消关联！');
  		return;
  	}
  	$('#rcvedID').attr('value',recordKey.split(',')[0]);
  	$('#rcvedAction').attr('value','cancelRelated');
  	document.forms[0].submit();
  	
  }
  
   function validateCheckBox(){
  	var flag = true;
  	var rcvedID = '';
  	var arrayTr = $('#ecTable_table tr');
  	
  	for(var i=0;i<arrayTr.length;i++ ){
		var thisTr = arrayTr[i];
		if($(thisTr).find('input').eq(0).attr('checked')){
			rcvedID = rcvedID+','+$(thisTr).attr('recordKey').split(',')[0];
		}
	}
  	rcvedID=rcvedID.substring(1,rcvedID.length); 
  	if(rcvedID==''){
  		alert('请选择操作记录');
  		flag = false;
  	}
  	
  	$('#rcvedID').attr('value',rcvedID);
  	return flag;
  	
  } 
  
  function initForm(){
  	var rs = $('#result').attr('value');
  	if(rs=='1'){
  		window.opener.freshDataGrid();
  		$.messager.alert("提示","操作成功！");
  		return;
  	}else if(rs=='0'){
  		$.messager.alert("提示","操作失败！");
  		return;
  	}else if(rs=='-1'){
  		$.messager.alert("提示","实收流水不存在！");
  	}else if(rs=='-2'){
  		$.messager.alert("提示","实收金额不足！");
  	}
  }
  
  function openAmountHidden(){
  	$('#amountHidden').window('open');
			
 }
 
 function saveConfirm(){
 	var reportAmout = $('#reportAmout').attr('value');
 	if(reportAmout==null || reportAmout=='null' || reportAmout==''){
 		alert('请录入汇报货款金额');
 		return;
 	}
 	
 	$('#rcvedAction').attr('value','related');
 	$('#rcvedForm').attr('action',$('#path').attr('value')+'/web/report-received!relateRcved?reportAmout='+$('#reportAmout').attr('value'));
  	document.forms[0].submit();
 }
 function query(){
 	$('#rcvedForm').attr('action',$('#path').attr('value')+'/web/report-received!query');
 	document.forms[0].submit();
 }
  </script>
  
  <body onload="initForm()">
 	 <input type="hidden" id="path" value="<%=path%>">
  	<input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    <br><input type="button" value="货款关联" onclick="rcvedRelated()">
    <input type="button" value="取消关联" onclick="cancelRcvedRelated()">
    <s:form id="rcvedForm" action="/web/report-received!relateRcved" method="post" theme="simple">
    	
    	<s:hidden id="settleBillID" name="settleBillID"></s:hidden>
    	<s:hidden id="acctPeriodID" name="acctPeriodID"></s:hidden>
    	<s:hidden id="rcvedID" name="rcvedID"></s:hidden>
    	<s:hidden id="rcvedAction" name="rcvedAction"></s:hidden>
    	<s:hidden id="rcvblAmout" name="rcvblAmout"></s:hidden>
    	<s:select id="distriStateQuery" name="distriStateQuery" list="#request.distriStateList" listKey="value" listValue="code"></s:select>
    	<input type="button" value="查询" onclick="query()">
    	
    	<div id="amountHidden" class="easyui-window" data-options="closed:true,modal:true,title:'录入汇报货款金额'" style="width:600px;height:300px;">
			<s:textfield id="reportAmout" name="reportAmout"></s:textfield>
			<input type="button" value="确定" onclick="saveConfirm()">
		</div>
    	
    </s:form>
    
    <br />
     <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/report-received!init"
			pageSizeList="10,20,30,50" rowsDisplayed="20" 
		    classic="true">
			<ec:row recordKey="${record.guid},${record.relatedState}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="年月日" property="recvedYMD" sortable="true" />
				<%-- <ec:column title="店铺名称" property="depotName" sortable="true" />--%>
				<ec:column title="物业名称" property="marketName" sortable="true" />
				<ec:column title="收入（金额）" property="rcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="已分配（金额）" property="distriAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="导入人" property="importer" sortable="true" />
				<ec:column title="导入时间" property="importTime" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="分配状态" property="distriState" sortable="true" />
				<ec:column title="关联状态" property="relatedState" sortable="true" />
			</ec:row>
		</ec:table>
    
  </body>
</html>
