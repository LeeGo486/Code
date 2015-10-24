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
    
    <title>货款关联</title>
    
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
  			alert('请选择 需要关联的记录！');
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
  		//	alert("应收货款金额不能小于实收货款金额！"); 
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
  			alert("本笔到款的可分配金额不足，请修改汇报货款金额！");
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
  			alert('请选择 需要取消关联的记录！');
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
  			$.messager.alert("提示","操作成功！");
  			return;
  		}else if(rs=='0'){
  			$.messager.alert("提示","操作失败！");
  			return;
  		}else if(rs=='-1'){
  			$.messager.alert("提示","实收金额不足！");
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
      	 <input type="button"  value="查询" onclick="query()">
      	 <input type="button"  value="关联" onclick="relate()">
      	 <input type="button"  value="取消关联" onclick="cancelRelate()">
      	 
      	 <div id="amountHidden" class="easyui-window" data-options="closed:true,modal:true,title:'录入汇报货款金额'" style="width:600px;height:300px;">
			<s:textfield id="reportLoanAoumt" name="reportLoanAoumt"></s:textfield>
			<input type="button" value="确定" onclick="saveConfirm()">
		</div>
		
		<table>
			<tr>
				<td width="80">总到款金额：</td>
				<td align="left" width="90"><s:property value="totalAmount"/> </td>
				<td width="50">已分配：</td>
				<td align="left" width="90"><s:property value="distriAmount"/></td>
				<td width="50">可用：</td>
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
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="年份" property="acctYear" sortable="true" />
				<ec:column title="月份" property="acctMonth" sortable="true" />
				<ec:column title="店铺名称" property="depotName" sortable="true" />
				<ec:column title="店铺编号" property="depotNo" sortable="true" />
				<ec:column title="结帐期" property="acctPeriodDate" sortable="true" />
				<ec:column title="销售数量" property="nums" sortable="true" />
				<ec:column title="原价金额" property="j_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="实销金额" property="s_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="合同扣率" property="CDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="预估扣率" property="EDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="预估结算金额" property="expectSettleAmout"  cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="商场销售额" property="marketSaleAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="实际扣率" property="RDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="应收货款金额" property="loanAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="实收货款金额" property="reportRcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="货款状态" property="recvedStateName" sortable="true" />
				
				<ec:column title="备注" property="remark" sortable="true" />
				<ec:column title="新建人" property="creater" sortable="true" />
				<ec:column title="更新人" property="modifier" sortable="true" />
			</ec:row>
			
		</ec:table>
  </body>
</html>
