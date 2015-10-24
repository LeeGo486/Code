<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<%@taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>汇报开票界面</title>
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
  </head>
  <script type="text/javascript">
  	 $(function(){
  		$('#noteDate').datebox();
  	}); 
  	function save(){
  		document.forms[0].submit();
  	}
  	function initForm(){
  		var rs = $('#result').attr('value');
  		if(rs=='1'){
  			window.opener.freshDataGrid();
  			$.messager.alert("提示","保存成功！");
  			return;
  		}else if(rs=='0'){
  			$.messager.alert("提示","保存失败！");
  		}
  	}
  	
  	function unEffect(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var  selectedRow = ecsideObj.selectedRow;
  		if(selectedRow==null){
	      	$.messager.alert("提示","必须选择一条记录！");
	      	return;
      	}
  		
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
	      	$.messager.alert("提示","必须选择一条记录！");
	      	return;
      	}
      	if(recordKey.split(',')[1]=='0'){
      		$.messager.alert("提示","只能作废生效的开票记录！");
      		return;
      	}
      	if(!confirm('确定作废该开票记录!')){
      		return;
      	}
      	
  		$('#noteForm').attr('action',$('#path').attr('value')+'/web/report-note!setNoteUneffect?unEffecID='+recordKey.split(',')[0]);
  		document.forms[0].submit();
  	}
  	
  	function newNote(){
  		$('#guid').attr('value','');
  		$('#noteDate').datebox('setValue','');
  		$('#noteNo').attr('value','');
  		$('#noteAmout').attr('value','');
  		$('#salesNum').attr('value','');
  	}
  </script>
  
  <body onload="initForm()">
    <input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
    <input type="hidden" id="path" value="<%=path%>">
    <s:form id="noteForm" action="/web/report-note!saveReportNote" method="post" theme="simple">
      <s:hidden  name="acctPeriodID" ></s:hidden>
     <s:hidden  id="guid" name="reportNote.guid" ></s:hidden>
     <s:hidden  name="reportNote.acctPeriodID" ></s:hidden>
     <s:hidden  name="reportNote.settleBillID" ></s:hidden>
     <s:hidden  name="YM" ></s:hidden>
     <s:hidden  name="depotName" ></s:hidden>
     

    <center>
    
    <table width="100%">
    	<tr>
    		<td>年月：</td>
    		<td><s:property value="YM"/> </td>
    		<td>店铺：</td>
    		<td><s:property value="depotName"/></td>
    		<td>开票日期：</td>
    		<td><s:textfield id="noteDate"  name="reportNote.noteDate" /></td>
    	</tr>
    	<tr>
    		<td>开票号码：</td>
    		<td><s:textfield id="noteNo" name="reportNote.noteNo"></s:textfield> </td>
    		<td>开票金额：</td>
    		<td><s:textfield id="noteAmout" name="reportNote.noteAmount"></s:textfield> </td>
    		<td>开票数量：</td>
    		<td><s:textfield id="salesNum" name="reportNote.salesNum"></s:textfield>  </td>
    	</tr>
    	<tr>
    		<td>累计开票金额：</td>
    		<td><s:property value="sumNoteAmount"/></td>
    		<td></td>
    		<td> </td>
    		<td></td>
    		<td> </td>
    	</tr>
    	<tr>
    		<td><input type="button" value="失效" onclick="unEffect()"></td>
    		<td></td>
    		<td></td>
    		<td></td>
    		<td></td>
    		<td><input type="button" value="保存" onclick="save()"><input type="button" value="新建" onclick="newNote()"></td>
    	</tr>
    </table>
    </center>
    
    
    </s:form>
    
     <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/report-note!queryNote"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15" xlsFileName="开票.xls"
		    classic="true">
			<ec:row recordKey="${record.guid},${record.noteState}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="开票号码" property="noteNo" sortable="true" />
				<ec:column title="开票金额" property="noteAmount" cell="number" format="0.00" sortable="true" />
				<ec:column title="开票日期" property="noteDate" sortable="true" />
				<ec:column title="开票状态" property="noteStateName" sortable="true" />
				<ec:column title="开票数量" property="salesNum" cell="number" format="0" sortable="true" />
			</ec:row>
		</ec:table>
    
    
  </body>
</html>
