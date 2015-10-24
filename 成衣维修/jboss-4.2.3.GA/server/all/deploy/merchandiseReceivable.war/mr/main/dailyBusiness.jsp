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
    
    <title>�ٻ�Ӧ����ҵ�����</title>
    
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
  	document.forms[0].submit();
  	//parent. freshSubWindow();
  }
  
  function freshDataGrid(){
  	 query();
  }
  
  function  inputSettleBill(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	//if(recordKey.split(',')[1]!=null && recordKey.split(',')[1]!=''){
  		//alert("�����ڵĽ��㵥�Ѿ����ڣ��޷���¼��");
  		//return;
  	//}
  	var url= $('#path').attr('value')+'/web/settle-bill-input!init?acctPeriodID='+recordKey.split(',')[0];
  	window.open(url, "���㵥¼��", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
  	
  }
  
  function reportNote(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("��ʾ","����ѡ��һ����¼��");
      		return;
      	}
  		var acctPeriodID = recordKey.split(',')[0];
  		var settleBillID = recordKey.split(',')[1];
  		var ym = recordKey.split(',')[2]+recordKey.split(',')[3];;
  		var depotName = recordKey.split(',')[4];
  		var url= $('#path').attr('value')+'/web/report-note!init?acctPeriodID='+acctPeriodID
  			+'&settleBillID='+settleBillID
  			+'&YM='+ym
  			+'&depotName='+depotName;
  		window.open(url, "��Ʊ", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function reportReceived(){
  	
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	if(recordKey==null || recordKey==""){
      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
      	return;
    }
  	var settleBillID = recordKey.split(',')[1];
  	var acctPeriodID = recordKey.split(',')[0]; 
  	var url= $('#path').attr('value')+'/web/report-received!init?settleBillID='+settleBillID+'&acctPeriodID='+acctPeriodID;
  	window.open(url, "�㱨����", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function reportInnerDiscountNote(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var  selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	if(recordKey==null || recordKey==""){
      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
      	return;
    }
  	var settleBillID = recordKey.split(',')[1]; 
  	var acctPeriodID = recordKey.split(',')[0]; 
  	//if(settleBillID=='' || settleBillID==null){
  		//$.messager.alert("��ʾ","����¼����㵥��");
  	//}
  	var url= $('#path').attr('value')+'/web/report-inner-discount-note!init?settleID='+settleBillID+'&acctPeriodID='+acctPeriodID;
    window.open(url, "�㱨�ڿ۷�Ʊ", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  }
  function viewAttachment(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	var settleBillID = recordKey.split(',')[1];
  	if(settleBillID==null || settleBillID==''){
  		alert('���㵥û��¼��');
  		return ;
  	}
  	var fileName = jQuery.trim(recordKey.split(',')[8]);
  	if(fileName==null || fileName==''){
  		alert('�����ڽ��㵥����');
  		return;
  	}
  	var index = fileName.lastIndexOf('.');
  	var suffix = fileName.substring(index+1).toUpperCase();
  	//var suffix = fileName.split('.')[1];
  	if(suffix=='JPG' || suffix=='JPEG' || suffix=='GIF'||suffix=='PNG' || suffix=='BMP' || suffix=='TIFF' || suffix=='RAW'){
  		var url = $('#path').attr('value')+'/mr/main/viewSettleAttachment.jsp?settleBillID='+settleBillID;
  		window.open(url, "ͼƬ��ʾ", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  	}else{
  		var url = $('#path').attr('value')+'/rest/settleBill/downAttachment/'+settleBillID;
  		window.open(url, "ͼƬ��ʾ", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  	}
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
  	var result = $('#result').attr('value');
  	if(result=='1'){
  		$.messager.alert("��ʾ","ԭ��¼��ɹ���");
  		return;
  	}else if(result=='0'){
  		$.messager.alert("��ʾ","ԭ��¼��ʧ�ܣ�");
  		return;
  	}
  }
  function inputUnrecvdReason(){
  	  var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	  var selectedRow = ecsideObj.selectedRow;
  	  var recordKey = selectedRow.getAttribute("recordKey");
      if(recordKey==null || recordKey==""){
      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
      	return;
      }
  	  $('#acctPeriodID').attr('value',recordKey.split(',')[0]);
  	  var para = new Object();
  	  $.post($('#path').attr('value')+ '/web/daily-business!queryReason?acctPeriodID='+recordKey.split(',')[0],para,function(rsp) {
				$('#unrecvdReason').attr('value',rsp);
				$('#reasonHidden').window('open');
			}, "text").error(
							function() {
								$('#unrecvdReason').attr('value','');
								$('#reasonHidden').window('open');
									$.messager.alert("��ʾ","��ȡ��Ϣ����");
			});
		
  	  
  	  
  }
  function saveConfirm(){
  	  $('#dailyForm').attr('action',$('#path').attr('value')+'/web/daily-business!save?unrecvdReason='+ $('#unrecvdReason').attr('value'));
  	  
  	  document.forms[0].submit();
  	
  }
	
  function searchByDepotNo(){
      if(event.keyCode==13){
 	     // waitDetail();
 	      document.forms[0].submit();
      }
   }
   function importFMData(){
   		var url = $('#path').attr('value')+'/web/finance-data-import!init';
  		window.open(url, "�������ݵ���", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
   }  
  </script>
  
  <body onload="initForm()">
    <input type="hidden" id="path" value="<%=request.getContextPath()%>"> 
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>"> 
    <s:form id="dailyForm" action="/web/daily-business!query" method="post" theme="simple">
    	<s:hidden id="acctPeriodID" name="acctPeriodID"></s:hidden>
    	<table width="100%">
    		<tr>
    			<td width="50%">
    				<div>
    					 <s:radio name="noteState" list="#request.radioList" listKey="code" listValue="name" cssClass="simple"></s:radio> <br />
    					�������ƣ�<s:textfield name="depotName" onkeypress="searchByDepotNo()"></s:textfield>
    					���ڣ�<s:textfield id="bgnYM" name="bgnYM"></s:textfield>
    			<%-- 	<s:textfield id="endYM" name="endYM"></s:textfield>--%>	
    					<input type="button" value="����" onclick="query()">
    				</div>
    			</td>
    			<td>
    				<input type="button" value="���㵥��Ϣ" style="width: 70" onclick="inputSettleBill()">
    				
    			
    			
    					<input type="button" value="��Ʊ" onclick="reportNote()">
    					<input type="button" value="����" onclick="reportReceived()">
    					<input type="button" value="�ڿ�" onclick="reportInnerDiscountNote()">
    				<input type="button" value="δ��ԭ��" style="width: 70" onclick="inputUnrecvdReason()">
    				<input type="button" value="�����������" style="width: 90" onclick="importFMData()">
    			</td>
    		</tr>
    		
    		
    	
    	</table>
    	
    	<div id="reasonHidden" class="easyui-window" data-options="closed:true,modal:true,title:'δ����ԭ��¼��'" style="width:600px;height:300px;">
			
			<s:textfield id="unrecvdReason" name="unrecvdReason" size="80"></s:textfield>
			<input type="button" value="ȷ��" onclick="saveConfirm()">
		</div>
    
    </s:form>
    
    
  
  	<ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="web/daily-business!query"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15"  xlsFileName="�ٻ�Ӧ��.xls"
		    classic="true">
			<ec:row recordKey="${record.acctPeriodID},${record.settleBillID},${record.acctYear},${record.acctMonth},${record.depotName},${record.noteState},${record.recvedState},${record.innerDeduceState},${record.settleAttachmentName}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���" property="acctYear" sortable="true" />
				<ec:column title="�·�" property="acctMonth" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<%-- 
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="������" property="acctPeriodDate" sortable="true" />
				
				<ec:column title="��������" property="nums" style="text-align:right;" sortable="true" />
				<ec:column title="ԭ�۽��" property="j_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				--%>
				
				<ec:column title="POSʵ��" property="s_price" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<%-- 
				<ec:column title="��ͬ����" property="CDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				<ec:column title="Ԥ������" property="EDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				--%>
				<ec:column title="�̳�ʵ��" property="marketSaleAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="Ԥ������" property="expectSettleAmount"  cell="number" format="0.00"style="text-align:right;"  sortable="true" />
			
				<ec:column title="ʵ�ʽ���" property="noteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ʿ���" property="RDR" cell="number" format="0.000"style="text-align:right;"  sortable="true" />
				
				<%--
				<ec:column title="��Ʊ����" property="noteNo" sortable="true" />
				--%>
				<ec:column title="��Ʊ���" property="actualNoteAmount" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="Ӧ�ջ���" property="loanAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="ʵ�ջ���" property="reportRcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="����״̬" property="recvedStateName" sortable="true" />
				<ec:column title="Ӧ���ڿ�" property="innerDiscountAmout" cell="number" format="0.00"style="text-align:right;" sortable="true" />
				<ec:column title="ʵ���ڿ�" property="rcvedAmoutinnerDis" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="�ڿ�״̬" property="innerDeduceStateName" sortable="true" />
				<%--
				<ec:column title="���㵥����" property="settleAttachmentName" sortable="true" ondblclick="viewAttachment()"/>
				
				
				<ec:column title="ʵ��δ��ԭ��" property="unrecvdReason" sortable="true" />
				--%>
				<%-- 
				<ec:column title="��ע" property="remark" sortable="true" />
				<ec:column title="�½���" property="creater" sortable="true" />
				<ec:column title="������" property="modifier" sortable="true" />
				--%>
			</ec:row>
			
		</ec:table>
  	<%-- 	<table >
  			<tr>
  				<td style="background-color: #F3F4F3">��ɫ���ߵ���ɫ���ݣ���Ʊδ��</td>
  				<td style="background-color: #66CCFF">����ɫ���ݣ���Ʊ�ѿ�</td>
  				<td style="background-color: #00FFCC">��ɫ���ݣ������ѵ�</td>
  				<td style="background-color: #FFFF66">��ɫ���ݣ��ڿ۷�Ʊ�ѵ� </td>
  				<td style="background-color: #737373">��ɫ���ݣ��ѽ��壨ע������״̬�����ڿۡ�������ѵ���</td>
  			</tr>
  		</table> --%>
  	
