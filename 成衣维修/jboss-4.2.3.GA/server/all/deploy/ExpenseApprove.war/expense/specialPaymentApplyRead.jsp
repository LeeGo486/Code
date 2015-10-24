<%@page import="ep.org.util.NumberUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.CashExpenseSubjectCost"%>
<%@page import="ep.org.branch.expense.dojo.CashExpensePurposeCost"%>
<%@page import="ep.org.branch.expense.dojo.SpecialPaymentPurposeCost"%>
<%@page import="ep.org.branch.expense.dojo.SpecialPaymentSubjectCost"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>特殊凭证报销申请</title>
    
	

  <link rel="stylesheet" type="text/css" href="<%=path %>/css/mycommon.css" />
		<script type="text/javascript" src="<%=path %>/myjs/myTime.js"></script>
		<script type="text/javascript" src="<%=path %>/js/jquery-1.5.2.min.js"></script>
	</head>
<script type="text/javascript">

  	
  	
  	
  	function initForm(){
  		
  		$('#applytitle', parent.document).html('特殊付款申请');
  		if($('#result').attr('value')=='1'){
  			alert('操作成功');
  		}
  		if($('#result').attr('value')=='2'){
  			alert('提交成功');
  			window.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';
  		}
  
  	}
	
	function do_submit(){
  		if(confirm('确定提交？')){
  			$('#action').attr('value','send');
  			document.forms[0].submit();
  		}
  	}
  
   function print(){
  	var stateCode = $('#applyStateCode').attr('value');
  	var expenseNo = $('#expenseNo').attr('value');
  
  	var url = $('#webcontent').attr('value')+'/specialPaymentApply.do?action=getPrintData&expenseNo='+expenseNo;	
  	window.open(url,'特殊付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');
  	
  }
  
  function refuse(){
  		if($('#refuseReason').attr('value')==null||$('#refuseReason').attr('value')==''){
  			alert('驳回理由不能为空！');
  			return;
  		}
  		if(confirm('确定驳回？')){
  			$('#action').attr('value','refuse');
  			document.forms[0].submit();
  		}
  }
  
 function showRefuseReason(){
 	$('#refuseReasonDiv').css('display','block');
 }
 function hiddenRefuseReason(){
 	$('#refuseReasonDiv').css('display','none');
 	$('#refuseReason').attr('value','');
 }
 
 function viewRefuseReCord(){
 	var expenseNo = $('#expenseNo').attr('value');
 	var url = $('#webcontent').attr('value')+'/refuseRecordQuery.do?action=init&expenseNo='+expenseNo;	
  	window.open(url,'驳回记录查询','scrollbars=yes,width=800,height=600,resizable=yes,menubar=no,status=no,location=no');
 }
 function showBudgt(){
 	var costCenter = $('#costCenter').attr('value');
 	var expenseNo=$('#expenseNo').attr('value');
 	var url = $('#webcontent').attr('value')+'/budgetQuery.do?action=init&costCenter='+costCenter+"&expenseNo="+expenseNo;
 	window.open(url,'科目预算查询',"scrollbars=yes,width=800px,height=600px,resizable=yes,menubar=no,status=no,location=no") 
 }
 </script>
<body onload="initForm()">
		
		
		<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
		<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
		<input type="hidden" id="hiddenPurposeTotalCost"  value="<%=request.getAttribute("SPPurposeTotalCost")%>">
		<input type="hidden" id="hiddenSubjectTotalCost" value="<%=request.getAttribute("SPSubjectTotalCost")%>">

	
	
	<div style="width: 95%">
	
	
		
	
	
	
	
	<html:form action="/specialPaymentApply" styleId="specialPaymentApplyForm">
		
		<html:hidden styleId="applyStateCode" property="applyStateCode"/>
		<html:hidden styleId="action" property="action"/>
		<html:hidden styleId="expenseInfoID" property="expenseInfoID"/>
		<html:hidden styleId="expenseNo" property="expenseNo"/>
		<html:hidden  styleId="printFlag" property="printFlag"/>
		<html:hidden styleId="costCenter" property="branchCode"/>
		
		<div id="refuseReasonDiv"  style="position:absolute; display: none;background-color: #F3F4F3;height: 500;width:100%;overflow: auto;border-color: gray;border-style: solid;border: 2;z-index: 2; text-align: center;">
			<font color="red">*</font>驳回理由：<br/>
			<html:textarea styleId="refuseReason" property="refuseReason" cols="80" rows="5"></html:textarea><br />
			<input type="button" onclick="refuse()" value="确定" style="width:60" >&nbsp;&nbsp;<input type="button" onclick="hiddenRefuseReason()" value="取消" style="width:60"> 
		</div>
		
		
		
		<div>
			<%UserInfo userinfo = (UserInfo)request.getSession().getAttribute("user_info") ;
			  if(!ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())) {
			%>
			
			<%String isView = (String)request.getAttribute("isView"); 
			if(!"1".equals(isView)){
			%>
			<input type="button" value="审核" onclick="do_submit()" class="btn_submit" onmouseover="this.className='btn_submit_on'" onmouseout="this.className='btn_submit'">
			&nbsp;&nbsp;
			<input type="button" value="驳回" onclick="showRefuseReason()" class="btn_back" onmouseover="this.className='btn_back_on'" onmouseout="this.className='btn_back'" >
			&nbsp;&nbsp;
			<%} %>
			
			<%} %>
			
			
			<button onclick="print()" class="btn_print" onmouseover="this.className='btn_print_on'" onmouseout="this.className='btn_print'" >打印</button>
			&nbsp;&nbsp;
			<button onclick="viewRefuseReCord()" class="btn_refuse" onmouseover="this.className='btn_refuse_on'" onmouseout="this.className='btn_refuse'" >驳回记录</button>
			
			</div>
			
			<br />
		
		<div
			style="position: relative; display: inline-block; width: 100%; height: 72px;">
			<img alt="" src="<%=path %>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">分公司特殊付款申请</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field">
						单据状态：
					</td>
					<td class="td_text" >
						<html:text property="applyStateName" styleClass="text_read_red" disabled="true"></html:text>
					</td>

					<td class="td_field" >
						单号：
					</td>
					
					<td class="td_text" >						
						<html:text property="expenseNo" styleClass="text_read_red" disabled="true"></html:text>					
					</td>
					
					<td class="td_field" width="11%">
						分公司代码：
					</td>
					<td class="td_text" width="22%">
						<html:select property="branchCode" onchange="changeBranchCode()" disabled="true" style="width:95%">
						<html:optionsCollection name="branchList" value="value" label="lable"/>
					</html:select>	
					<%-- 
						<html:text property="branchCode" styleClass="text_read_common"></html:text>		
					--%>		
					</td>

				</tr>
				
				<tr >
					<td class="td_field" width="11%">
						员工编号：
					</td>
					<td class="td_text" width="22%">
						<html:text property="applyUserID" styleClass="text_read_common" disabled="true"></html:text>	
					</td>
					
					<td class="td_field" width="11%">
						申请人：
					</td>
					<td class="td_text" width="22%">
						<html:text property="applyUserName" styleClass="text_read_common" disabled="true"></html:text>	
					</td>
					
					
					<td class="td_field" width="11%">
						分公司名称：
					</td>
					<td class="td_text" width="22%">
						<html:text styleId="branchName" property="branchName" disabled="true"></html:text>
					
					</td>
					
				</tr>

				
				
				<tr >
					<td class="td_field" >
						电话号码：
					</td>
					
					<td class="td_text" >
						<html:text styleId="telephone" property="telephone" styleClass="text_write_common" disabled="true"></html:text>
					<%-- 
						<html:text property="branchCode" styleClass="text_read_common"></html:text>		
					--%>		
					</td>
					
					<td class="td_field" >
						移动电话号码：
					</td>
					
					<td class="td_text" >
						<html:text styleId="mobilephone" property="mobilephone" styleClass="text_write_common" disabled="true"></html:text>
					</td>
					
					<td class="td_field" >
						<font color="red">*</font>登记日期：
					</td>
					
					<td class="td_text" >						
						<html:text styleId="applyDate" styleClass="text_write_common" property="applyDate" onclick="setday(this)" readonly="readonly" disabled="true"></html:text>
					</td>
					
					
				
				</tr>
				
				
			</table>

		</div>



		<div
			style="position: relative; display: inline-block; width: 100%; height: 100px;">
			<img alt="" src="<%=path %>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">费用信息：</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				
				<tr>	
					<td class="td_field" width="11%">
						收款人全称：
					</td>
					<td class="td_text" width="22%">
						<html:text styleId="receiverFullName" property="receiverFullName" styleClass="text_write_common" disabled="true"></html:text>
					</td>
					
					<td class="td_field" width="11%">
						省/市：
					</td>
					<td class="td_text" width="22%">
						<html:text styleId="province_city" property="province_city" styleClass="text_write_common" disabled="true"></html:text>
					</td>
					
					<td class="td_field" width="11%">
						开户银行：
					</td>
					<td class="td_text" width="22%">
						<html:text styleId="bankName" property="bankName" styleClass="text_write_common" disabled="true"></html:text>
					</td>
					
					
				</tr>
				<tr>
					
					<td class="td_field" >
						银行帐号：
					</td>
					<td class="td_text" >
						<html:text styleId="bankAccount" property="bankAccount" styleClass="text_write_common" disabled="true"></html:text>
					</td>
					
					
					<td class="td_field" >
						其他付款说明
					</td>
					<td class="td_text" >
						<html:text styleId="payComment" property="payComment" styleClass="text_write_common" onchange="validateBankCode()" disabled="true"></html:text>
					</td>
					
					
					<td class="td_field" >
						<font color="red">*</font>发票寄回日期：
					</td>
					<td class="td_text">
						<html:text styleId="sendInvoiceDate" property="sendInvoiceDate" onclick="setday(this)" styleClass="text_write_common" readonly="readonly" disabled="true"></html:text>
					</td>

		

				</tr>
				
				<tr>

					<td class="td_field">
						<font color="red">*</font>金额：
					</td>
					<td class="td_text">
						￥<html:text styleId="applyAmount" property="applyAmount"  styleClass="text_read_common" disabled="true"></html:text>
						
					</td>

					<td class="td_field">
						预算总额：
					</td>
					<td class="td_text" >
						<html:text styleId="budget" property="budget" styleClass="text_read_common" disabled="true"></html:text>
					</td>

					<td class="td_field">
						已用费用：
					</td>
					<td class="td_text">
						<html:text styleId="usedAmount" property="usedAmount" styleClass="text_read_common" disabled="true"></html:text>
					</td>

				</tr>
				
				

					

			</table>

		</div>
		
		</html:form>

		<br />
		
		<div id="topDiv">
		
		<div>
			<input type="button" style="background-color: #E2E9F1" value="添加"
				align="left">
			<input type="button" style="background-color: #E2E9F1" value="删除"
				align="right">
			<table id='100' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field_title" width="4%">
						<input type="checkbox" >
					</td>

					<td class="td_field_title" width="66%">
						费用用途
					</td>



					<td id="purposeTotalCost" class="td_field_title" width="15%">
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("SPPurposeTotalCost"))%>)
					</td>

					<td class="td_field_title" width="15%">
						使用日期
					</td>

				</tr>
				

				<%List purposeCostList = (List)request.getAttribute("SPPurposeCostList");
				 int purposeCostListSize = 0;
				 if(purposeCostList!=null){
				 	 purposeCostListSize = purposeCostList.size();
				 }
				
				 for (int i = 0; i < purposeCostListSize; i++) {
				     	SpecialPaymentPurposeCost purposeCost =(SpecialPaymentPurposeCost) purposeCostList.get(i);
				%>
				<tr id="<%=1101+i%>-tr" >
					<td class="td_text_center" align="center">
						<input type="checkbox" id="<%=1101+i%>" value="<%=1101+i%>">
					</td>
					
					<td class="td_text_center">
						<textarea id="<%=1101+i %>-expensePurpose"  rows="1" style="width: 100%" onchange="modifyExpense('1',this,'费用用途')" disabled="disabled"><%=purposeCost.getExpensePurpose()%> </textarea>
					</td>
					
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseAmout"  type="text" value="<%=NumberUtil.formatFloatDecimal(2,(String)purposeCost.getExpenseAmout())%>" onchange="modifyExpenseNumber('1',this,'金额'),changePurposeTotalCost(this);" disabled="disabled">
					</td>
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseDate" type="text" value="<%=purposeCost.getExpenseDate() %>" onclick="setday(this)" readonly="readonly"  onpropertychange="modifyExpense('1',this,'使用日期')" disabled="disabled">
					</td>
					
					
					
					
				</tr>
				
				<%} %>
				
				
				
				
			</table>
		</div>


		<br />


		<br />
		<div>
			<input type="button" style="background-color: #E2E9F1" value="添加"
				align="left" >
			<input type="button" style="background-color: #E2E9F1" value="删除"
				align="right" >
			<input type="button" style="background-color: #E2E9F1" value="预算"
				align="right" onclick="showBudgt()">
			<table id='300' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field_title" width="4%">
						<input type="checkbox" >
					</td>

					<td class="td_field_title" width="19.2%">
						大类
					</td>
					<td class="td_field_title" width="19.2%">
						所属科目
					</td>
					<td class="td_field_title" width="19.2%">
						科目代码
					</td>
					<td id="subjectTotalCost" class="td_field_title" width="19.2%">
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("SPSubjectTotalCost"))%>)
					</td>
					<td class="td_field_title" width="19.2%">
						备注
					</td>
				</tr>

				
				<%List subjectCostList = (List)request.getAttribute("SPSubjectCostList");
					
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	SpecialPaymentSubjectCost subjectCost =(SpecialPaymentSubjectCost) subjectCostList.get(i);
				%>
				<tr id="<%=3101+i%>-tr">
					<td class="td_text_center">
						<input type="checkbox" id="<%=3101+i%>" id="<%=3101+i%>">
					</td>

					<td class="td_text_center">
						<select id="<%=3101+i%>-categoryCode" onchange="getaccountList(this,'大类');modifyExpense('1',this,'大类');" disabled="disabled" style="width: 100%">
							
							<%List categoryList = (List)request.getAttribute("categoryList");  
							  int categoryListSize = 0;
							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
							if(!selectOptionObj.getValue().equals(subjectCost.getCategoryCode())){
							%>
							
								<option value="<%=selectOptionObj.getValue() %>" ><%=selectOptionObj.getLable()%></option>
							
							<%}else{ %>
								<option value="<%=selectOptionObj.getValue() %>" selected="selected"><%=selectOptionObj.getLable()%></option>
								
							<%}} %>
						
						</select>	
					
					</td>

					<td id="<%=3101+i%>-accountNameTD" class="td_text_center">
						<input id="<%=3101+i%>-accountName"  type="text" class="text_write_common" readonly="readonly" value="<%=subjectCost.getAccountName() %>" disabled="disabled">
					
					</td>
					
					<td id="<%=3101+i%>-subjectCodeTD" class="td_text_center_nodisplay">
						
						<select  id="<%=3101+i%>-subjectCode" name="subjectCode"  onchange="getAccountCode(this);modifyExpense('1',this,'科目');" style="width: 100%" disabled="disabled">
							</select>
					</td>



					<td class="td_text_center">
						<input id="<%=3101+i%>-accountCode" type="text"  class="text_write_common" onpropertychange="modifyExpense('1',this,'科目代码');" value="<%=subjectCost.getAccountCode() %> " disabled="disabled">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectAmout" type="text" class="text_write_common" onchange="modifyExpenseNumber('1',this,'金额');changeSubjectTotalCost(this);" value="<%=NumberUtil.formatFloatDecimal(2,(String)subjectCost.getSubjectAmout())%>" disabled="disabled">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-comment" type="text" class="text_write_common" onchange="modifyExpense('1',this,'备注');" value="<%=subjectCost.getComment()%>" disabled="disabled">
					</td>
				</tr>
				
				<%} %>
				
				
			
				
			</table>
		</div>
	
	
		</div>
	</div>

	</body>
</html>
