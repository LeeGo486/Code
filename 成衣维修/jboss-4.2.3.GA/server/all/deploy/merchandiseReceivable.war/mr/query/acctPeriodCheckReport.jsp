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
    
    <title>�ٻ�Ӧ��ҵ�����ݻ��˱���</title>
    
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
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
  	$(function(){
  		$('#bgnYM').datebox({
  			onSelect:function(date){
  				var year = date.getFullYear();
  				var month = '0'+(date.getMonth()+1);
  				month = month.substring(month.length-2,month.length);
  				var ym =  year+'-'+month;
  				$('#bgnYM').datebox('setValue',ym);
  			}
  		});
  		$('#endYM').datebox({
  			onSelect:function(date){
  				var year = date.getFullYear();
  				var month = '0'+(date.getMonth()+1);
  				month = month.substring(month.length-2,month.length);
  				var ym =  year+'-'+month;
  				$('#endYM').datebox('setValue',ym);
  			}
  		});
  		
  	
  	}); 
  	
  
  	
  	function query(){
  		$('#queryButton').attr("disabled","disabled");
  		document.forms[0].submit();
  	}
  	
  function initForm(){
  	//changeRowColor();
  	$('#queryButton').removeAttr("disabled"); 
  }
  	
  function openDailyBusiness(state){
  	var bgnYM;
  	var endYM;
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
    if(recordKey==null || recordKey==""){
      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
      	return;
      }
  	if(recordKey=='�ܼ�'){
  		bgnYM = $('#bgnYM').attr('value').substring(0,4)+$('#bgnYM').attr('value').substring(5,7);
  		endYM = $('#endYM').attr('value').substring(0,4)+$('#endYM').attr('value').substring(5,7);
  		
  	}else{
  		bgnYM = recordKey;
  		endYM = recordKey;
  		
  	}
  	var url = $('#path').attr('value')+'/web/daily-business!query?state='+state+'&bgnYM='+bgnYM+'&endYM='+endYM;
  	parent.openTab(url,'�ٻ�Ӧ�ղ���',2);
  
  }
  /* function openReportRcved(){
  	var url =  $('#path').attr('value')+'/web/daily-business!init';
  }
   */
  </script>
  
  <body onload="initForm()">
    <input type="hidden" id="path" value="<%=request.getContextPath()%>">
    <s:form action="/web/acct-period-check-report!query" method="post" theme="simple">
    	<table width="100%">
    		<tr>
    			<td align="left">
    					���ڣ�<s:textfield id="bgnYM" name="acctPeriodBgnYM"></s:textfield>
    					-<s:textfield id="endYM" name="acctPeriodEndYM"></s:textfield>
    					<input id="queryButton" type="button" value="��ѯ" onclick="query()" disabled="disabled">
    			</td>
    		</tr>
    	</table>
    	
    	
    
    </s:form>
  
  <ec:table  items="recordList" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/acct-period-check-report!query"
			pageSizeList="100" rowsDisplayed="100"  xlsFileName="�ٻ�Ӧ��ҵ�����ݻ��˱���.xls"
		    classic="true">
			<ec:extendrow location="top">
				 
				<tr>
    				<td class="tableHeader" colspan="1"> </td>
    				<td class="tableHeader" colspan="1"> </td>
    				<td class="tableHeader" colspan="4">��������</td>
					<td class="tableHeader" colspan="4">������Ϣ����</td>
					<td class="tableHeader" colspan="4">���㵥����</td>
					<td class="tableHeader" colspan="4">��Ʊ</td>
					<td class="tableHeader" colspan="4">����</td>
				</tr>			
			
			</ec:extendrow>
			
			
			
			<ec:row recordKey="${record.acctYM}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="��������" property="acctYM" sortable="true" />
				
				<ec:column title="������" property="genAcctPeriodNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="������ռ��" property="genAcctPeriodRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				<ec:column title="δ����" property="notGenAcctPeriodNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="δ����ռ��" property="notGenAcctPeriodRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				
				<ec:column title="�ѵ���" property="importNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѵ���ռ��" property="importRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				<ec:column title="δ����" property="notImportNum" cell="number" format="0"style="text-align:right;text-decoration:underline"  sortable="true"   ondblclick="openDailyBusiness('0')" />
				<ec:column title="δ����ռ��" property="notImportRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				
				<ec:column title="�ѵ�" property="settleBillArriveNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѵ�ռ��" property="settleBillArriveRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				<ec:column title="δ��" property="settleBillNotArriveNum" cell="number" format="0"style="text-align:right;text-decoration:underline"  sortable="true" ondblclick="openDailyBusiness('1')" />
				<ec:column title="δ��ռ��" property="settleBillNotArriveRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				
				<ec:column title="�ѿ�" property="noteReportNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѿ�ռ��" property="noteReportRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				<ec:column title="δ��" property="noteNoteReportNum" cell="number" format="0"style="text-align:right;text-decoration:underline"  sortable="true" ondblclick="openDailyBusiness('2')" />
				<ec:column title="δ��ռ��" property="noteNoteReportRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				
				<ec:column title="�ѵ�" property="rcvedArriveNum" cell="number" format="0"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѵ�ռ��" property="rcvedArriveRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				<ec:column title="δ��" property="rcvedNotArriveNum" cell="number" format="0"style="text-align:right;text-decoration:underline"  sortable="true" ondblclick="openDailyBusiness('3')" />
				<ec:column title="δ��ռ��" property="rcvedNotArriveRatio" cell="number" format="0.00%"style="text-align:right;"  sortable="true" />
				
				
				
				
			</ec:row>
			
		</ec:table>
  	

  </body>
</html>
