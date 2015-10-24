<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info");
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>流程信息</title>
    
	
	  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mycommon.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
		

  </head>
  
  <script type="text/javascript">
  	var x = 0;
  	var y = 0;
  	function getMXInfos(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
		var keyArray = recordKey.split(',');		
		var url = keyArray[1];
		var expenseNo = keyArray[0];
		var currentUser = keyArray[4];
		window.location.href=$('#webcontent').attr('value')+url+'&cashExpenseNo='+expenseNo+'&currentUser='+currentUser;
  	}
  	
  	function showMsg(obj){
  		var recordKey = $(obj).attr("recordKey");
		var keyArray = recordKey.split(',');
		var expenseNo = keyArray[0];
		var xmlhttp;
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
    			
    			var msg =xmlhttp.responseText;
    			var left = x-10;
    			var top = y+10;
    			$('#showMsg').html(msg);
    			$('#showMsg').css({"position": "absolute","left":left,"top":top,"display":"block","z-index":"1"});

    			
    			
    		}
 		};
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=getRecordInfo&expenseNo="+expenseNo);
  	}
  	
  	function hiddenMsg(obj){
  		$('#showMsg').css({"display":"none"});
  	}
  	

  	
     $(document).ready(function(){
     	 $(document).mousemove(function(e){
			x=event.clientX;
			y=event.clientY;
		 });
     
     }) ;         
          
         
  function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  
  function initForm(){
  	if($('#result').attr('value')=='1'){
  		alert('操作成功！');
  	}
  	if($('#result').attr('value')=='0'){
  		alert($('#failExpenseNo').attr('value')+'删除失败！');
  	}
  	
  	var arrayTr = $('#ecTable_table tr');
	var thisTr = arrayTr[1];
  	if(arrayTr.length>1){
	
		var state = $(thisTr).attr('recordKey').split(',')[5];
		if(state==='F02'){
  			$('#button2').hide();
  		}
  	}
  	
  	$("#applytitle",parent.document).html("待办任务");
  	
  	$('#branchApply',parent.document).find('td').each(function(){
			if($(this).attr('id')!='1002-td' && $(this).attr('id')!='1003-td'){
          		$(this).css({"font-weight": "500","background-color":"#E7ECF3"});
      		}
      });
  	
  	
  	$("#task",parent.document).css({"font-weight": "700","background-color":"#FFEEDD"});
  }
  	
  
  
  
  function deleteBatch(){
  	 if(validateCheckBox('0')){
  	 	 $('#action').attr('value','deleteBatch');
  	 	 document.forms[0].submit();
  	 }
  	
  }
  
  function approveBatch(){
  	if(validateCheckBox('1')){
  	 	 $('#action').attr('value','approveBatch');
  	 	 document.forms[0].submit();
  	 }
  }
  
  function validateCheckBox(operateFlag){
  	var flag = true;
  	var expenseNo = '';
  	var branchName = '';
  	var flowState = '';
  	var CurrentUser = '';
  	var realName = $('#realName').attr('value');
  	var arrayTr = $('#ecTable_table tr');
  	
  	for(var i=0;i<arrayTr.length;i++ ){
		var thisTr = arrayTr[i];
		if($(thisTr).find('input').eq(0).attr('checked')){
			expenseNo = expenseNo+','+$(thisTr).attr('recordKey').split(',')[0];
			branchName = branchName+','+$(thisTr).attr('recordKey').split(',')[3];
			CurrentUser = $(thisTr).attr('recordKey').split(',')[4];
		}
	}
  	expenseNo=expenseNo.substr(1,expenseNo.length-1); 
  	branchName=branchName.substr(1,expenseNo.length-1); 
  	if(expenseNo==''){
  		alert('请选择操作记录');
  		flag = false;
  	}
  	if(CurrentUser!=realName){
  		alert('对不起，您不是申请单的当前执行人，无法执行该操作！');
  		flag = false;
  	}
  	
  	
  	$('#expenseNos').attr('value',expenseNo);
  	$('#branchNames').attr('value',branchName);
  	return flag;
  	
  } 
  
  function searchByExpenseNo(){
 	if(event.keyCode==13){
 		waitDetail();
 		document.forms[0].submit();
 	}
 }
 
  function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
 
 
  </script>
  
  <body onload="initForm()">
    	<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
    	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
    	<input type="hidden" id="failExpenseNo" value="<%=request.getAttribute("failExpenseNo") %>"> 
    	<input type="hidden" id="realName" value="<%=userInfo.getRealname() %>">
    	
    	
    	<div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;">正在处理，请稍后......</div>
    
    	 <div id="mainDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;">
    	
    	<html:form action="/expenseMainFlow" styleId="expenseMainFlowForm">
    		<html:hidden styleId="action" property="action"  value="query"/>
    		<html:hidden styleId="expenseNos"  property="expenseNos" />
    		<html:hidden styleId="branchNames"  property="branchNames" />
    		<table >
    			
    			<tr>
    				<td align="right" width="100">分公司：</td>
    				<td align="left" width="150">
    					<html:text property="branchName" style="width: 100%;"></html:text></td>
    				
    				<td align="right" width="100">申请人：</td>
    				<td align="left"  width="150"><html:text property="employee" style="width:100%"/> </td>
    				<td align="right" width="100">申请单号：</td>
    				<td align="left"  width="150"><html:text property="expenseNo" style="width:100%" onkeypress="searchByExpenseNo()"/> </td>
    				<td align="right" width="100">审批状态</td>
    				<td align="left"  width="150">
    					<html:select property="approveState" style="width:100%" onchange="document.forms[0].submit()">
    						<html:optionsCollection name="approveStateList" label="label" value="value"/>
    					</html:select>
    				</td>
    			</tr>
    			
    			
    			<tr>
    				<td align="right" >费用类型：</td>
    				<td align="left"  >
    					<html:select property="expenseTypeCode" style="width:100%">
    						<html:optionsCollection name="expenseTypeList" label="lable" value="lableCode"/>
    					</html:select>
    				</td>
    				<td align="right" >起始日期：</td>
    				<td align="left"  ><html:text property="queryBgnDate" onclick="setday(this)" readonly="true" style="width:100%"/> </td>
    				<td align="right" >截止日期：</td>
    				<td align="left" ><html:text property="queryEndDate" onclick="setday(this)" readonly="true" style="width:100%"/> </td>
    				<td ></td>
    				<td ><html:button property="button" value="查询" onclick="document.forms[0].submit()" styleClass="btn_search" onmouseover="this.className='btn_search_on'" onmouseout="this.className='btn_search'"> </html:button> </td>
    			</tr>
    			
    			
    		
    		</table>
    		
    		<hr width="90%" color="#E7ECF3"/>
    		
    		<%if(userInfo.getUserRole().equals("0")){ %>	
    		 <div style="height: 20" align="right">
    		<html:button styleId="button1" property="button1" value="删除" onclick="deleteBatch()" styleClass="btn_delete1" onmouseover="this.className='btn_delete1_on'" onmouseout="this.className='btn_delete1'"> </html:button>
    		</div>
    		<%}else{ %>
    		<html:button styleId="button2" property="button2" value="审核" onclick="approveBatch()" styleClass="btn_submit" onmouseover="this.className='btn_submit_on'" onmouseout="this.className='btn_submit'"> </html:button>
    		<br />
    		<%} %>
    		
    		<br />
    	</html:form>
    	
    	
    	
    	
    	
    	 <ec:table  items="infolist" var="record"  tableId="ecTable" 
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="expenseMainFlow.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true" 
			filterable="true">
				 
			<ec:row rowId="ecrow" recordKey="${record.FI_ExpenseNo},${record.FI_Action},${record.FI_FlowState},${record.BranchName},${record.FI_CurrentUser},${record.FI_CurNode}" ondblclick="getMXInfos()" onmouseover="mouseonChange(this);" onmouseout="mouseoutChange(this);">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column property="_0"  alias="选择" headerCell="checkbox" cell="checkbox" style="text-align:center"></ec:column>
				<ec:column tipTitle="${record.Approve_Info_title}" title="申请单号" property="FI_ExpenseNo" sortable="true" onmouseover=""/>
				<ec:column tipTitle="${record.Approve_Info_title}" title="分公司" property="BranchName" sortable="true" />
				<ec:column tipTitle="${record.Approve_Info_title}" title="费用流程类型" property="FI_FlowName" sortable="true" />
				<ec:column tipTitle="${record.Approve_Info_title}" title="金额" property="FI_ExpenseAmount" cell="number" format="0.00"  style="text-align:right;" sortable="true"/>
				
				<ec:column tipTitle="${record.Approve_Info_title}" title="申请人" property="EmployeeName" sortable="true" />
				<ec:column tipTitle="${record.Approve_Info_title}" title="申请日期" property="FI_CreateperTime" sortable="true" />
				<ec:column tipTitle="${record.Approve_Info_title}" title="当前执行人" property="FI_CurrentUser" sortable="true" />
				
				<ec:column tipTitle="${record.Approve_Info_title}" title="流程状态" property="FI_FlowStateName" sortable="true" />
				
			
			
			</ec:row>
			
		</ec:table>
		</div>
    	
  </body>
</html>
