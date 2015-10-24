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
    
    <title>�������</title>
    
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
  	function query(){
  		document.forms[0].submit();
  	}
  	
  	function relate(){
  		//var rcvedID = $('#rcvedID').attr('value');
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null){
  			alert('��ѡ�� ��Ҫ�����ļ�¼��');
  			return;
  		}
  		
  		var loanAmount = recordKey.split(',')[2];
  		var reportRcvedAmout = recordKey.split(',')[3];
  		if(loanAmount==''){
  			loanAmount = '0';
  		}
  		if(reportRcvedAmout==''){
  			reportRcvedAmout = '0';
  		}
  		
  		var needReportRcvedAmout = parseFloat(loanAmount)-parseFloat(reportRcvedAmout);
  		//alert(loanAmount+','+reportRcvedAmout+','+needReportRcvedAmout);
  		//if(needReportRcvedAmout<=0){
  		//	alert("Ӧ�ջ������С��ʵ�ջ����"); 
  		//	return ;
  		//}
  		
  		if(loanAmount!=null&&loanAmount!=''&&needReportRcvedAmout>0){
  			$('#reportLoanAoumt').attr('value',needReportRcvedAmout.toFixed(2));	
    	}else{
    		$('#reportLoanAoumt').attr('value','0.00');	
    	}
  		openAmountHidden();
  		//var rcvblID = recordKey.split(',')[0];
  		//var rcvedID = $('#rcvedID').attr('value');
  		//$('#rcvedRelateRcvbl').attr('action',$('#path').attr('value')+'/web/rcved-relate-rcvbl!relate?rcvblID='+rcvblID);
  		//document.forms[0].submit();
  	}
  	function saveConfirm(){
  		//var rcvedID = $('#rcvedID').attr('value');
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		var rcvblID = recordKey.split(',')[0];
  		//var rcvedID = $('#rcvedID').attr('value');
  		var reportLoanAoumt = $('#reportLoanAoumt').attr('value');
  		var availableAmount = $('#availableAmount').attr('value');
  		
  		if(parseFloat(availableAmount)<parseFloat(reportLoanAoumt)){
  			alert("���ʵ���Ŀɷ�����㣬���޸Ļ㱨�����");
  			return;
  		}
  		
  		
  		
  		$('#rcvedRelateRcvbl').attr('action',$('#path').attr('value')+'/web/rcved-relate-rcvbl!relate?rcvblID='+rcvblID+'&reportLoanAoumt='+reportLoanAoumt);
  		document.forms[0].submit();
  	}
  	
  	function cancelRelate(){
  		var rcvedID = $('#rcvedID').attr('value');
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null){
  			alert('��ѡ�� ��Ҫȡ�������ļ�¼��');
  			return;
  		}
  		var rcvblID = recordKey.split(',')[0];
  		var rcvedID = $('#rcvedID').attr('value');
  		$('#rcvedRelateRcvbl').attr('action',$('#path').attr('value')+'/web/rcved-relate-rcvbl!cancelRelate?rcvblID='+rcvblID);
  		document.forms[0].submit();
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
  			$.messager.alert("��ʾ","ʵ�ս��㣡");
  		}
  }
  
  
  function openAmountHidden(){
  	$('#amountHidden').window('open');
  }
  
  </script>
  <body onload="initForm()">
      <input type="hidden" id="path" value="<%=path%>">
  	  <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
      <s:form id="rcvedRelateRcvbl" action="/web/rcved-relate-rcvbl!query" method="post" theme="simple">
      	 <s:hidden id="rcvedID" name="rcvedID"></s:hidden>
      	 <s:hidden id="availableAmount" name="availableAmount"></s:hidden>
      	 <s:select id="relateState" name="relateState" list="#request.relateStateList" listKey="code" listValue="value"></s:select>
      	 <input type="button"  value="��ѯ" onclick="query()">
      	 <input type="button"  value="����" onclick="relate()">
      	 <input type="button"  value="ȡ������" onclick="cancelRelate()">
      	 
      	 <div id="amountHidden" class="easyui-window" data-options="closed:true,modal:true,title:'¼��㱨������'" style="width:600px;height:300px;">
			<s:textfield id="reportLoanAoumt" name="reportLoanAoumt"></s:textfield>
			<input type="button" value="ȷ��" onclick="saveConfirm()">
		</div>
		
		<table>
			<tr>
				<td width="80">�ܵ����</td>
				<td align="left" width="90"><s:property value="totalAmount"/> </td>
				<td width="50">�ѷ��䣺</td>
				<td align="left" width="90"><s:property value="distriAmount"/></td>
				<td width="50">���ã�</td>
				<td align="left" width="90"><s:property value="availableAmount"/></td>
			
			</tr>
		</table>
		
      	 
      </s:form>
  	  
  	  <ec:table  items="list" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="web/rcved-relate-rcvbl!query"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15"
		    classic="true">
			<ec:row recordKey="${record.guid},${record.settleID},${record.loanAmout},${record.reportRcvedAmout}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���" property="acctYear" sortable="true" />
				<ec:column title="�·�" property="acctMonth" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="������" property="acctPeriodDate" sortable="true" />
				<ec:column title="��������" property="nums" sortable="true" />
				<ec:column title="ԭ�۽��" property="j_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�����" property="s_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="��ͬ����" property="CDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="Ԥ������" property="EDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="Ԥ��������" property="expectSettleAmout"  cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="�̳����۶�" property="marketSaleAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ʿ���" property="RDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="Ӧ�ջ�����" property="loanAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ջ�����" property="reportRcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="����״̬" property="recvedStateName" sortable="true" />
				
				<ec:column title="��ע" property="remark" sortable="true" />
				<ec:column title="�½���" property="creater" sortable="true" />
				<ec:column title="������" property="modifier" sortable="true" />
			</ec:row>
			
		</ec:table>
  </body>
</html>
