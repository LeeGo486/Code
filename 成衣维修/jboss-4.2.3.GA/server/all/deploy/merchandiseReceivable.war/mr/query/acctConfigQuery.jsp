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
    
    <title>账期档案查询</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
    
	

  </head>
  <script type="text/javascript">
  function do_submit(){
  	$('#configList').attr('action',$('#path').attr('value')+'/web/acct-config!queryConfigList');
  	document.forms[0].submit();
  }
  
  function newConfig(){
  		var url = $('#path').attr('value')+'/web/acct-config!init';
  		window.open(url, "新增账期配置", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  
  function modifyConfig(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("提示","必须选择一条记录！");
      		return;
      	}
  		
  		var url = $('#path').attr('value')+'/web/acct-config!initModify?afterDepotNo='+recordKey.split(',')[0]+'&depotName='+recordKey.split(',')[1];
  		window.open(url, "修改账期配置", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  
  function deleteConfig(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("提示","必须选择一条记录！");
      		return;
      	}
      	if(confirm('确定要删除该档案记录？')){
      		$('#guid').attr('value',recordKey.split(',')[2]);
  			$('#configList').attr('action',$('#path').attr('value')+'/web/acct-config!deleteConfig');
  			document.forms[0].submit();
      	}
      	
  		
  		
  }
  
  function generateData(){
  		//$('#generate').attr("disabled",true); 
  		var url= $('#path').attr('value')+'/web/acct-config!generateAcctPeriodDataBatch';
   		$('#configList').attr('action',url);
  		document.forms[0].submit();
  }
  </script>
  <body>
  	<input type="hidden" id="path" value="<%=path%>">
  	<s:form  id="configList" action="/web/acct-config!queryConfigList" theme="simple" method="post">
  		<s:hidden id="guid" name="guid"></s:hidden>
  		<table width="100%">
  			<tr>
  				<td align="left"><s:textfield name="depotName"></s:textfield><s:submit value="查询"></s:submit></td>
  				<td align="right">
	  				<input type="button" value="新增" onclick="newConfig()">
	  				<input type="button" value="修改" onclick="modifyConfig()">
	  				 <input type="button" value="删除" onclick="deleteConfig()"> 
	  				 <input type="button" id="generate" value="生成账款" onclick=" generateData()">
  				 </td>
  			</tr>
  		</table>
  		
  		
  	</s:form>
  	
  	 <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/acct-config!queryConfigList"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15" xlsFileName="账期档案.xls"
		    classic="true">
			<ec:row recordKey="${record.depotNo},${record.depotName},${record.guid}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="店铺编号" property="depotNo" sortable="true" />
				<ec:column title="店铺名称" property="depotName" sortable="true" />
				<ec:column title="往来单位名称" property="marketName" sortable="true" />
				<ec:column title="合同开始日期" property="bgnContractDate" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="合同结束日期" property="endContractDate" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="合同扣率" property="contractDeductrate" cell="number" format="0.000" sortable="true" />
				<ec:column title="账期类型" property="acctPeriodFlag"  sortable="true" />
				<ec:column title="账期截止日" property="endPeriodDay"  sortable="true" />
			</ec:row>
		</ec:table>
    
  </body>
</html>
