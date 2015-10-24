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
    
    <title>百货应收查询</title>
    
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
  	
  function viewAttachment(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	var settleBillID = recordKey.split(',')[1];
  	if(settleBillID==null || settleBillID==''){
  		alert('结算单没有录入');
  		return ;
  	}
  	var url = $('#path').attr('value')+'/mr/main/viewSettleAttachment.jsp?settleBillID='+settleBillID;
  	window.open(url, "图片显示", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  	
  	function query(){
  		document.forms[0].submit();
  	}
  	
  	
  	function changeRowColor(){
  	var arrayTr = $('#ecTable_table tr');
  	
  	for(var i=1;i<arrayTr.length;i++ ){
		var thisTr = arrayTr[i];
		noteState = jQuery.trim($(thisTr).attr('recordKey').split(',')[5]);
		rcvedState =  jQuery.trim($(thisTr).attr('recordKey').split(',')[6]);
		innerDeduceState = jQuery.trim($(thisTr).attr('recordKey').split(',')[7]);
		if(innerDeduceState=='1'&&rcvedState=='1'){
			$(thisTr).css({'background-color':'#737373'});
			ECSideUtil.removeClass(thisTr,'odd');
			ECSideUtil.removeClass(thisTr,'even');
		}else if(innerDeduceState=='1'){
			$(thisTr).css({'background-color':'#FFFF66'});
			ECSideUtil.removeClass(thisTr,'odd');
			ECSideUtil.removeClass(thisTr,'even');
		}else if(rcvedState=='1'){
			$(thisTr).css({'background-color':'#00FFCC'});
			ECSideUtil.removeClass(thisTr,'odd');
			ECSideUtil.removeClass(thisTr,'even');
		}else if(noteState=='1'){
			$(thisTr).css({'background-color':'#66CCFF'});
			ECSideUtil.removeClass(thisTr,'odd');
			ECSideUtil.removeClass(thisTr,'even');
		}
	}
  }
  
  function initForm(){
  	//changeRowColor();
  }
  
  </script>
  
  <body onload="initForm()">
    <input type="hidden" id="path" value="<%=request.getContextPath()%>">
    <s:form action="/web/merchan-receivable-query!query" method="post" theme="simple">
    	<table width="100%">
    		<tr>
    			<td align="left">
    			 <s:radio name="queryCondition.noteState" list="#request.radioList" listKey="code" listValue="name" cssClass="simple"></s:radio> <br />
    				<!-- 	<input type="radio" name="noteState" value="0">未开票
    				<input type="radio" name="noteState" value="1">已开票	-->	
    			</td>
    		</tr>
    		<tr>
    			<td align="left">
    				店铺名称：<s:textfield name="queryCondition.depotName"></s:textfield>
    					账期：<s:textfield id="bgnYM" name="queryCondition.acctPeriodBgnYM"></s:textfield>
    					-<s:textfield id="endYM" name="queryCondition.acctPeriodEndYM"></s:textfield>
    					<input type="button" value="搜索" onclick="query()">
    			</td>
    		</tr>
    	</table>
    	
    	
    
    </s:form>
  
  <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/merchan-receivable-query!query"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15"  xlsFileName="百货应收.xls"
		    classic="true">
			<ec:row recordKey="${record.acctPeriodID},${record.settleBillID},${record.acctYear},${record.acctMonth},${record.depotName},${record.noteState},${record.recvedState},${record.innerDeduceState}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="年份" property="acctYear" sortable="true" />
				<ec:column title="月份" property="acctMonth" sortable="true" />
				<ec:column title="店铺名称" property="depotName" sortable="true" />
				<ec:column title="店铺编号" property="depotNo" sortable="true" />
				<ec:column title="结帐期" property="acctPeriodDate" sortable="true" />
				<ec:column title="销售数量" property="nums" style="text-align:right;" sortable="true" />
				<ec:column title="原价金额" property="j_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="POS实销" property="s_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="合同扣率" property="CDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="商场销售" property="marketSaleAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="预估结算" property="expectSettleAmout"  cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="预估扣率" property="EDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				
				<ec:column title="实际结算" property="noteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="实际扣率" property="RDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				
				<ec:column title="开票金额" property="actualNoteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="应开与实开差异" property="diffamount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				
				<ec:column title="应收货款金额" property="loanAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="实收货款金额" property="reportRcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="货款状态" property="recvedStateName" sortable="true" />
				<ec:column title="应收内扣金额" property="innerDiscountAmout" cell="number" format="0.00"style="text-align:right;" sortable="true" />
				<ec:column title="实收内扣金额" property="rcvedAmoutinnerDis" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="内扣差异" property="innerDiff" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				
				<ec:column title="内扣状态" property="innerDeduceStateName" sortable="true" />
				<ec:column title="结算单附件" property="settleAttachmentName" sortable="true" ondblclick="viewAttachment()"/>
				<ec:column title="实收未到原因" property="unrecvdReason" sortable="true" />
				<ec:column title="备注" property="remark" sortable="true" />
				<ec:column title="新建人" property="creater" sortable="true" />
				<ec:column title="更新人" property="modifier" sortable="true" />
			</ec:row>
			
		</ec:table>
  	<%-- 	<p style="color: red">白色或者淡蓝色单据：发票未开&nbsp;&nbsp;&nbsp;&nbsp; 深蓝色单据：发票已开&nbsp;&nbsp;&nbsp;&nbsp;   绿色单据：货款已到  &nbsp;&nbsp;&nbsp;&nbsp;黄色单据：内扣发票已到&nbsp;&nbsp;&nbsp;&nbsp; 灰色单据：已结清
（注：结清状态代表内扣、货款均已到） </p> --%>

  </body>
</html>
