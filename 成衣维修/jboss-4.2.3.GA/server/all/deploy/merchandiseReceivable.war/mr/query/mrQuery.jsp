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
    
    <title>�ٻ�Ӧ�ղ�ѯ</title>
    
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
  		alert('���㵥û��¼��');
  		return ;
  	}
  	var url = $('#path').attr('value')+'/mr/main/viewSettleAttachment.jsp?settleBillID='+settleBillID;
  	window.open(url, "ͼƬ��ʾ", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
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
    				<!-- 	<input type="radio" name="noteState" value="0">δ��Ʊ
    				<input type="radio" name="noteState" value="1">�ѿ�Ʊ	-->	
    			</td>
    		</tr>
    		<tr>
    			<td align="left">
    				�������ƣ�<s:textfield name="queryCondition.depotName"></s:textfield>
    					���ڣ�<s:textfield id="bgnYM" name="queryCondition.acctPeriodBgnYM"></s:textfield>
    					-<s:textfield id="endYM" name="queryCondition.acctPeriodEndYM"></s:textfield>
    					<input type="button" value="����" onclick="query()">
    			</td>
    		</tr>
    	</table>
    	
    	
    
    </s:form>
  
  <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/merchan-receivable-query!query"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15"  xlsFileName="�ٻ�Ӧ��.xls"
		    classic="true">
			<ec:row recordKey="${record.acctPeriodID},${record.settleBillID},${record.acctYear},${record.acctMonth},${record.depotName},${record.noteState},${record.recvedState},${record.innerDeduceState}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���" property="acctYear" sortable="true" />
				<ec:column title="�·�" property="acctMonth" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="������" property="acctPeriodDate" sortable="true" />
				<ec:column title="��������" property="nums" style="text-align:right;" sortable="true" />
				<ec:column title="ԭ�۽��" property="j_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="POSʵ��" property="s_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="��ͬ����" property="CDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="�̳�����" property="marketSaleAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="Ԥ������" property="expectSettleAmout"  cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="Ԥ������" property="EDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				
				<ec:column title="ʵ�ʽ���" property="noteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ʿ���" property="RDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				
				<ec:column title="��Ʊ���" property="actualNoteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="Ӧ����ʵ������" property="diffamount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				
				<ec:column title="Ӧ�ջ�����" property="loanAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ջ�����" property="reportRcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="����״̬" property="recvedStateName" sortable="true" />
				<ec:column title="Ӧ���ڿ۽��" property="innerDiscountAmout" cell="number" format="0.00"style="text-align:right;" sortable="true" />
				<ec:column title="ʵ���ڿ۽��" property="rcvedAmoutinnerDis" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="�ڿ۲���" property="innerDiff" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				
				<ec:column title="�ڿ�״̬" property="innerDeduceStateName" sortable="true" />
				<ec:column title="���㵥����" property="settleAttachmentName" sortable="true" ondblclick="viewAttachment()"/>
				<ec:column title="ʵ��δ��ԭ��" property="unrecvdReason" sortable="true" />
				<ec:column title="��ע" property="remark" sortable="true" />
				<ec:column title="�½���" property="creater" sortable="true" />
				<ec:column title="������" property="modifier" sortable="true" />
			</ec:row>
			
		</ec:table>
  	<%-- 	<p style="color: red">��ɫ���ߵ���ɫ���ݣ���Ʊδ��&nbsp;&nbsp;&nbsp;&nbsp; ����ɫ���ݣ���Ʊ�ѿ�&nbsp;&nbsp;&nbsp;&nbsp;   ��ɫ���ݣ������ѵ�  &nbsp;&nbsp;&nbsp;&nbsp;��ɫ���ݣ��ڿ۷�Ʊ�ѵ�&nbsp;&nbsp;&nbsp;&nbsp; ��ɫ���ݣ��ѽ���
��ע������״̬�����ڿۡ�������ѵ��� </p> --%>

  </body>
</html>
