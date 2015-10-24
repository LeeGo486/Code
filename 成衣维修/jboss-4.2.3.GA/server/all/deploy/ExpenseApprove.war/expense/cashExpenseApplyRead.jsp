<%@page import="ep.org.util.NumberUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.CashExpensePurposeCost"%>
<%@page import="ep.org.branch.expense.dojo.CashExpenseShopCost"%>
<%@page import="ep.org.branch.expense.dojo.CashExpenseSubjectCost"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>现金付款申请</title>
    
	

  <link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
		<script type="text/javascript" src="<%= path%>/myjs/myTime.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
	</head>
<script type="text/javascript">
	
  
  	
  	
  	function initForm(){
  		$('#applytitle', parent.document).html('现金付款申请');
  		if($('#result').attr('value')=='1'){
  			alert('操作成功');
  		}
  		if($('#result').attr('value')=='2'){
  			alert('提交成功');
  			window.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';
  		}
  
  		
  	
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
  
	function do_submit(){
  		if(confirm('确定审核通过？')){
  			$('#action').attr('value','send');
  			document.forms[0].submit();
  		}
  	}
  	
  function print(){
  	var stateCode = $('#applyStateCode').attr('value');
  	var cashExpenseNo = $('#cashExpenseNo').attr('value');
  	var url = $('#webcontent').attr('value')+'/cashExpenseApply.do?action=getPrintData&cashExpenseNo='+cashExpenseNo;	
  	window.open(url,'现金付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');
  }
  
   function showRefuseReason(){
 	$('#refuseReasonDiv').css('display','block');
  }
 
  function hiddenRefuseReason(){
 	$('#refuseReasonDiv').css('display','none');
 	$('#refuseReason').attr('value','');
  }
  
   function viewRefuseReCord(){
 	var expenseNo = $('#cashExpenseNo').attr('value');
 	var url = $('#webcontent').attr('value')+'/refuseRecordQuery.do?action=init&expenseNo='+expenseNo;	
  	window.open(url,'驳回记录查询','scrollbars=yes,width=800,height=600,resizable=yes,menubar=no,status=no,location=no');
 }
 
 
 function showBudgt(){
 	var costCenter = $('#costCenter').attr('value');
 	var expenseNo = $('#cashExpenseNo').attr('value');
 	var url = $('#webcontent').attr('value')+'/budgetQuery.do?action=init&costCenter='+costCenter+"&expenseNo="+expenseNo;
 	
 	window.open(url,'科目预算查询',"scrollbars=yes,width=800px,height=600px,resizable=yes,menubar=no,status=no,location=no") 
 }
 </script>
	<body onload="initForm()">
		<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
		<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
		<input type="hidden" id="hiddenPurposeTotalCost"  value="<%=request.getAttribute("s_purposeTotalCost")%>">
		<input type="hidden" id="hiddenShopTotalCost" value="<%=request.getAttribute("s_shopTotalCost")%>">
		<input type="hidden" id="hiddenSubjectTotalCost" value="<%=request.getAttribute("s_subjectTotalCost")%>">
		
		<div style="width: 95%">
		
			
		
		<html:form action="/cashExpenseApply" styleId="cashExpenseForm">
			<html:hidden styleId="applyStateCode" property="applyStateCode"/>
			<html:hidden styleId="action" property="action"/>
			<html:hidden styleId="cashExpenseInfoID" property="cashExpenseInfoID"/>
			<html:hidden styleId="cashExpenseNo" property="cashExpenseNo"/>
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
			<img alt="" src="<%= path%>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">分公司费用申请单：</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field" width="14%">
						单据状态：
					</td>
					<td class="td_text" width="19%" >
						<html:text property="applyStateName" styleClass="text_read_red" disabled="true"></html:text>
					</td>

					<td class="td_field" width="14%">
						单号：
					</td>
					
					<td class="td_text" colspan="3">						
						<html:text property="cashExpenseNo" styleClass="text_read_red" disabled="true"></html:text>					
					</td>

				</tr>
				
				<tr >
					<td class="td_field" width="14%">
						分公司代码：
					</td>
					<td class="td_text" width="19%">
						<html:select property="branchCode"  style="width: 100%" disabled="true">
						<html:optionsCollection name="branchList" value="value" label="lable"/>
					</html:select>	
					<%-- 
						<html:text property="branchCode" styleClass="text_read_common"></html:text>		
					--%>		
					</td>
					<td class="td_field" width="14%">
						申请人：
					</td>
					<td class="td_text" width="19%">
						<html:text property="applyUserName" styleClass="text_read_common" disabled="true"></html:text>	
					</td>
				
					<td class="td_field" width="14%">
						<font color="red">*</font>员工编号：
					</td>
					<td class="td_text" width="19%">
						<html:text styleId="applyUserID" property="applyUserID" styleClass="text_write_common" disabled="true"></html:text>	
					</td>
				</tr>


			</table>

		</div>



		<div
			style="position: relative; display: inline-block; width: 100%; height: 100px;">
			<img alt="" src="<%= path%>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">费用信息：</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					
					<td class="td_field" width="16.5%">
						<font color="red">*</font>登记日期：
					</td>
					<td class="td_text" width="16.5%">						
						<html:text property="applyDate" onclick="setday(this)" readonly="readonly" disabled="true"></html:text>
					</td>

					<td class="td_field" width="16.5%">
						<font color="red">*</font>发票寄回日期：
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="sendInvoiceDate" onclick="setday(this)" disabled="true" disabled="true"></html:text>
					</td>

					<td class="td_field" width="16.5%">
						<font color="red">*</font>银行账号
					</td>
					<td class="td_text" colspan="1">
						<html:text property="bankAccount" styleClass="text_write_common" disabled="true"></html:text>
					</td>

				</tr>
				<tr>

					<td class="td_field" width="16.5%">
						<font color="red">*</font>金额：
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="applyAmount"  styleClass="text_read_common" disabled="true"></html:text>
						￥
					</td>

					<td class="td_field" width="16.5%">
						预算总额：
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="budget" styleClass="text_read_common" disabled="true"></html:text>
					</td>

					<td class="td_field" width="16.5%">
						已用费用：
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="usedAmount" styleClass="text_read_common" disabled="true"></html:text>
					</td>

				</tr>
			
					

				
				
				<tr>
					
					<td class="td_field">
						联系电话：
					</td>
					<td class="td_text">						
						<html:text property="telephone" styleClass="text_write_common" style="width:95%" disabled="true"></html:text>
					</td>
					

					<td class="td_field">
						移动电话：
					</td>
					<td class="td_text">
						<html:text property="mobilephone" styleClass="text_write_common" style="width:95%" disabled="true"></html:text>
					</td>
					
					<td class="td_field">
						<font color="red">*</font>上司：
					</td>
					<td class="td_text">
						<html:text property="leadername" styleClass="text_write_common" style="width:95%" disabled="true"></html:text>
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
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_purposeTotalCost"))%>)
					</td>

					<td class="td_field_title" width="15%">
						使用日期
					</td>

				</tr>
				

				<%List purposeCostList = (List)request.getAttribute("purposeCostList");
				 int purposeCostListSize = 0;
				 if(purposeCostList!=null){
				 	 purposeCostListSize = purposeCostList.size();
				 }
				
				 for (int i = 0; i < purposeCostListSize; i++) {
				     	CashExpensePurposeCost purposeCost =(CashExpensePurposeCost) purposeCostList.get(i);
				%>
				<tr id="<%=1101+i%>-tr" >
					<td class="td_text_center" align="center">
						<input type="checkbox" id="<%=1101+i%>" value="<%=1101+i%>">
					</td>
					
					<td class="td_text_center">
						<textarea id="<%=1101+i %>-expensePurpose"  rows="1" style="width: 100%"  disabled="disabled"><%=purposeCost.getExpensePurpose()%> </textarea>
					</td>
					
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseAmout"  type="text" value="<%=NumberUtil.formatFloatDecimal(2,(String)purposeCost.getExpenseAmout())%>" disabled="disabled">
					</td>
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseDate" type="text" value="<%=purposeCost.getExpenseDate() %>" onclick="setday(this)" disabled="disabled">
					</td>
					
					
					
					
				</tr>
				
				<%} %>
				

			</table>
		</div>


		<br />
		<div>
			<input type="button" style="background-color: #E2E9F1" value="添加"
				align="left" >
			<input type="button" style="background-color: #E2E9F1" value="删除"
				align="right" >



			<table id='200' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">

				<tr>
					<td class="td_field_title" width="4%">
						<input type="checkbox">
					</td>

					<td class="td_field_title" width="24%">
						店铺成本中心
					</td>
					
					<td class="td_field_title" width="24%">
						店铺名
					</td>
				

					<td id="shopTotalCost" class="td_field_title" width="24%">
						奖励金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_shopTotalCost"))%>)
					</td>

					<td class="td_field_title" width="24%">
						备注
					</td>
				</tr>
				
				
				<%List shopCostList = (List)request.getAttribute("shopCostList");
				 int shopCostListSize = 0;
				 if(shopCostList!=null){
				 	 shopCostListSize = shopCostList.size();
				 }
					
				 for (int i = 0; i < shopCostListSize; i++) {
				     	CashExpenseShopCost shopCost =(CashExpenseShopCost) shopCostList.get(i);
				%>
				<tr id="<%=2101+i%>-tr">
					<td class="td_text_center">
						<input type="checkbox" id="<%=2101+i%>" value="2001">
					</td>
					
					<td class="td_text_center">
						<input id="<%=2101+i%>-shopCostCenterCode" type="text" value="<%=shopCost.getShopCostCenterCode()%>" class="text_write_common" disabled="disabled">
					</td>
					
					<td class="td_text_center">
						<input id="<%=2101+i%>-shopName" type="text" value="<%=shopCost.getShopName()%>" class="text_write_common" disabled="disabled">
					</td>
					


					<td class="td_text_center">
						<input id="<%=2101+i%>-expenseAmout" type="text" value="<%=NumberUtil.formatFloatDecimal(2,(String)shopCost.getExpenseAmout())%>" class="text_write_common" disabled="disabled">
					</td>



					<td class="td_text_center">
						<input id="<%=2101+i%>-comment" type="text"  value="<%=shopCost.getComment()%>"	class="text_write_common" disabled="disabled">
					</td>
				</tr>
				
				
				<%}%>
				
			</table>

		</div>


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
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_subjectTotalCost"))%>)
					</td>
					<td class="td_field_title" width="19.2%">
						备注
					</td>
				</tr>

				
				<%List subjectCostList = (List)request.getAttribute("subjectCostList");
					
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	CashExpenseSubjectCost subjectCost =(CashExpenseSubjectCost) subjectCostList.get(i);
				%>
				<tr id="<%=3101+i%>-tr">
					<td class="td_text_center">
						<input type="checkbox" id="<%=3101+i%>" id="<%=3101+i%>" >
					</td>

					<td class="td_text_center">
						<select id="<%=3101+i%>-categoryCode" disabled="disabled" >
							
							<%List categoryList = (List)request.getAttribute("categoryList");  
							 for(int j=0;j<categoryList.size();j++){
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
						
						<select  id="<%=3101+i%>-subjectCode" name="subjectCode"   style="width: 100%" disabled="disabled">
							</select>
					</td>



					<td class="td_text_center" >
						<input id="<%=3101+i%>-accountCode" type="text"  class="text_write_common" disabled="disabled" value="<%=subjectCost.getAccountCode() %> ">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectAmout" type="text" class="text_write_common" disabled="disabled" value="<%=NumberUtil.formatFloatDecimal(2,(String)subjectCost.getSubjectAmout())%>">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-comment" type="text" class="text_write_common" disabled="disabled" value="<%=subjectCost.getComment()%>">
					</td>
				</tr>
				
				<%} %>
				
				
				
				
				

			</table>
		</div>
	
		
	</div>
	
	
	</div>
	</body>
</html>
