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
    
    <title>�㱨�ڿ۷�Ʊ</title>
    
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
  	
  	$(function(){
  		$('#innernoteDate').datebox();
  	}); 
  	
  	function initForm(){
  		var rs = document.getElementById("result").value;
  		if(rs=='1'){
  			window.opener.freshDataGrid();
  			alert("����ɹ���");
  			return;
  		}
  		if(rs=='0'){
  			alert("����ʧ�ܣ�");
  			return;
  		}
  		
  	}
  	function do_save(){
  		document.forms[0].submit();
  	}
  	
  	
  	function unEffect(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var  selectedRow = ecsideObj.selectedRow;
  		if(selectedRow==null){
	      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
	      	return;
      	}
  		
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
	      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
	      	return;
      	}
  		if(recordKey.split(',')[1]=='0'){
      		$.messager.alert("��ʾ","ֻ��������Ч���ڿۼ�¼��");
      		return;
      	}
      	
      	if(!confirm('ȷ�����ڿۼ�¼ʧЧ!')){
      		return;
      	}
  		//$('#unEffecID').attr('value',recordKey.split(',')[0]);
  		//alert($('#path').attr('value')+'/web/report-inner-discount-note!setInnerNoteUneffect?unEffecID='+recordKey.split(',')[0]);
  		$('#innerForm').attr('action',$('#path').attr('value')+'/web/report-inner-discount-note!setInnerNoteUneffect?unEffecID='+recordKey.split(',')[0]);
  		document.forms[0].submit();
  	}
  	
  	function newNote(){
  		$('#guid').attr('value','');
  		$('#innernoteDate').datebox('setValue','');
  		$('#rcvedAmout').attr('value','');
  		$('#comment').attr('value','');
  	}
  </script>
  <body onload="initForm()">
  	<input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
  	<input type="hidden" id="path" value="<%=path%>">
  	<s:form id="innerForm" action='/web/report-inner-discount-note!saveNoteInfo'  method="post" theme="simple">
  		<%-- <s:hidden  name="unEffecID" ></s:hidden>--%>
      	<s:hidden  name="acctPeriodID" ></s:hidden>
  		<s:hidden name="noteInfo.depotNo" > </s:hidden>
  		<s:hidden name="noteInfo.settleID" > </s:hidden>
  		<s:hidden name="noteInfo.acctPeriodID" > </s:hidden>
  		<s:hidden id="guid" name="noteInfo.guid" > </s:hidden>
  		<s:hidden name="noteInfo.noteYm" > </s:hidden>
  		<s:hidden name="noteInfo.depotName" > </s:hidden>
  		<s:hidden name="noteInfo.rcvlAmout" > </s:hidden>
  		
  		
  		<center>
  		<table width="100%">
  			<tr>
  				<td>���£�<s:property value="noteInfo.noteYm"></s:property> </td>
  				<td>���̣�<s:property value="noteInfo.depotName"></s:property> </td>
  				<td>�ڿ����ڣ� </td>
  				<td>
  					<s:textfield id="innernoteDate" name="noteInfo.innernoteDate"></s:textfield>
  				</td>
  				
  				<td></td>
  				<td>
  					<input type="button" value="����" onclick="do_save()"> 
  					<input type="button" value="�½�" onclick="newNote()">
  				</td>
  			</tr>
  			<tr>
  				<td>Ӧ���ڿ۽� </td>
  				<td>
  					<s:property value="noteInfo.rcvlAmout"></s:property>
  				</td>
  				
  				<td>
  					ʵ���ڿ۽�
  				</td>
  				<td>
  					<s:textfield id="rcvedAmout" name="noteInfo.rcvedAmout"></s:textfield>
  				</td>
  				<td>��ע�� </td>
  				<td>
  					<s:textarea id="comment" name="noteInfo.comment"></s:textarea>
  				</td>
  				
  				
  			</tr>
  		
  		</table>
  	</center>
  	<input type="button" value="ʧЧ" onclick="unEffect()">
  	</s:form>
  	
  	<ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/report-inner-discount-note!queryInnerNoteList"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15" xlsFileName="�ڿ�.xls"
		    classic="true">
			<ec:row recordKey="${record.guid},${record.innernoteState}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="�ڿ۽��" property="rcvedAmoutinnerDis"  style="text-align:right;"  cell="number" format="0.00" sortable="true" />
				<ec:column title="�ڿ�ʱ��" property="innernoteDate"  sortable="true" />
				<ec:column title="��ע" property="comment" sortable="true" />
				<ec:column title="�ڿ�״̬" property="innernoteStateName" sortable="true" />
			</ec:row>
		</ec:table>
  </body>
</html>
