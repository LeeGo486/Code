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
    
    <title>���ڵ�����ѯ</title>
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
  		window.open(url, "������������", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  
  function modifyConfig(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("��ʾ","����ѡ��һ����¼��");
      		return;
      	}
  		
  		var url = $('#path').attr('value')+'/web/acct-config!initModify?afterDepotNo='+recordKey.split(',')[0]+'&depotName='+recordKey.split(',')[1];
  		window.open(url, "�޸���������", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  
  function deleteConfig(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("��ʾ","����ѡ��һ����¼��");
      		return;
      	}
      	if(confirm('ȷ��Ҫɾ���õ�����¼��')){
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
  				<td align="left"><s:textfield name="depotName"></s:textfield><s:submit value="��ѯ"></s:submit></td>
  				<td align="right">
	  				<input type="button" value="����" onclick="newConfig()">
	  				<input type="button" value="�޸�" onclick="modifyConfig()">
	  				 <input type="button" value="ɾ��" onclick="deleteConfig()"> 
	  				 <input type="button" id="generate" value="�����˿�" onclick=" generateData()">
  				 </td>
  			</tr>
  		</table>
  		
  		
  	</s:form>
  	
  	 <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/acct-config!queryConfigList"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15" xlsFileName="���ڵ���.xls"
		    classic="true">
			<ec:row recordKey="${record.depotNo},${record.depotName},${record.guid}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="������λ����" property="marketName" sortable="true" />
				<ec:column title="��ͬ��ʼ����" property="bgnContractDate" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="��ͬ��������" property="endContractDate" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="��ͬ����" property="contractDeductrate" cell="number" format="0.000" sortable="true" />
				<ec:column title="��������" property="acctPeriodFlag"  sortable="true" />
				<ec:column title="���ڽ�ֹ��" property="endPeriodDay"  sortable="true" />
			</ec:row>
		</ec:table>
    
  </body>
</html>
