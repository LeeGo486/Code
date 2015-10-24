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
    
    <title>�㱨����</title>
     
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
  		alert('��ѡ��ʵ�ռ�¼��');
  		return;
  	}
  	
  	var relatedState = recordKey.split(',')[1];
  	if(relatedState=='�ѷ���'){
  		alert('�������Ѵ��ڹ�����ʱ���¼������ȡ��������');
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
  		alert('��ѡ��ʵ�ռ�¼��');
  		return;
  	}
  	var relatedState = recordKey.split(',')[1];
  	if(relatedState=='δ����'){
  		alert('�����ڲ����ڹ�����ʱ���¼���޷�ȡ��������');
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
  		alert('��ѡ�������¼');
  		flag = false;
  	}
  	
  	$('#rcvedID').attr('value',rcvedID);
  	return flag;
  	
  } 
  
  function initForm(){
  	var rs = $('#result').attr('value');
  	if(rs=='1'){
  		window.opener.freshDataGrid();
  		$.messager.alert("��ʾ","�����ɹ���");
  		return;
  	}else if(rs=='0'){
  		$.messager.alert("��ʾ","����ʧ�ܣ�");
  		return;
  	}else if(rs=='-1'){
  		$.messager.alert("��ʾ","ʵ����ˮ�����ڣ�");
  	}else if(rs=='-2'){
  		$.messager.alert("��ʾ","ʵ�ս��㣡");
  	}
  }
  
  function openAmountHidden(){
  	$('#amountHidden').window('open');
			
 }
 
 function saveConfirm(){
 	var reportAmout = $('#reportAmout').attr('value');
 	if(reportAmout==null || reportAmout=='null' || reportAmout==''){
 		alert('��¼��㱨������');
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
    <br><input type="button" value="�������" onclick="rcvedRelated()">
    <input type="button" value="ȡ������" onclick="cancelRcvedRelated()">
    <s:form id="rcvedForm" action="/web/report-received!relateRcved" method="post" theme="simple">
    	
    	<s:hidden id="settleBillID" name="settleBillID"></s:hidden>
    	<s:hidden id="acctPeriodID" name="acctPeriodID"></s:hidden>
    	<s:hidden id="rcvedID" name="rcvedID"></s:hidden>
    	<s:hidden id="rcvedAction" name="rcvedAction"></s:hidden>
    	<s:hidden id="rcvblAmout" name="rcvblAmout"></s:hidden>
    	<s:select id="distriStateQuery" name="distriStateQuery" list="#request.distriStateList" listKey="value" listValue="code"></s:select>
    	<input type="button" value="��ѯ" onclick="query()">
    	
    	<div id="amountHidden" class="easyui-window" data-options="closed:true,modal:true,title:'¼��㱨������'" style="width:600px;height:300px;">
			<s:textfield id="reportAmout" name="reportAmout"></s:textfield>
			<input type="button" value="ȷ��" onclick="saveConfirm()">
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
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="������" property="recvedYMD" sortable="true" />
				<%-- <ec:column title="��������" property="depotName" sortable="true" />--%>
				<ec:column title="��ҵ����" property="marketName" sortable="true" />
				<ec:column title="���루��" property="rcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѷ��䣨��" property="distriAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="������" property="importer" sortable="true" />
				<ec:column title="����ʱ��" property="importTime" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="����״̬" property="distriState" sortable="true" />
				<ec:column title="����״̬" property="relatedState" sortable="true" />
			</ec:row>
		</ec:table>
    
  </body>
</html>
