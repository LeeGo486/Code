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
    
    <title>店铺费用分摊查询</title>
    
	
	  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mycommon.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
		

  </head>
  
  <script type="text/javascript">
 function getMXInfos(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		var recordKey = selectedRow.getAttribute("recordKey");
		var keyArray = recordKey.split(',');		
		var url = keyArray[1];
		var expenseNo = keyArray[0];
		window.location.href=$('#webcontent').attr('value')+url+'&cashExpenseNo='+expenseNo+'&isView=1';
  	}
          
         
  function mouseonChange(obj){
      obj.style.cursor='hand';
  }
 
  
  function mouseoutChange(obj){
      obj.style.cursor='move';
      
  }
  
function resetCondition(){
 	$('#branchName').attr('value','');
 	$('#applyName').attr('value','');
 	$('#expenseNo').attr('value','');
 	$('#flowTypeID').attr('value','');
 	$('#flowBgnDate').attr('value','');
 	$('#flowEndDate').attr('value','');
 	$('#branchInfo').attr('value','');
 	$('#branchFinanceInfo').attr('value','');
 	$('#shopMgrInfo').attr('value','');
 	$('#HQFinanceInfo').attr('value','');
 	$('#cashierInfo').attr('value','');
 }
 
 function waitDetail(){
 	$('#waitDiv').slideDown('fast');
 	$('#mainDiv').slideUp('fast');
 }
 
 function searchByExpenseNo(){
 	if(event.keyCode==13){
 		waitDetail();
 		document.forms[0].submit();
 	}
 }
 
 function initForm(){
  		$('#applytitle', parent.document).html('店铺费用分摊查询');
 }
  </script>
  
  <body onload="initForm()">
    	<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
    	 <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 2;display: none;">正在处理，请稍后......</div>
    
    	 <div id="mainDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;">
    
    	<html:form action="/shopExpenseApportion" styleId="basicQueryForm">
    		<html:hidden styleId="action" property="action"  value="query"/>
    		<table >
    			
    			<tr>
    				<td align="right" width="100">分公司：</td>
    				<td align="left" width="200" >
    					<html:text styleId="branchName" property="branchName" style="width: 100%;"></html:text>
    				</td>
    				
    				<td align="right"  width="100">申请人：</td>
    				<td align="left"  width="200"><html:text styleId="applyName" property="applyName" style="width:100%"/> </td>
    				<td align="right" width="100">申请单号：</td>
    				<td align="left"  width="200"><html:text styleId="expenseNo" property="expenseNo" style="width:100%" onkeypress="searchByExpenseNo()"/> </td>
    				
    			</tr>
    			
    			
    			<tr>
    				<td align="right" width="100">费用类型：</td>
    				<td align="left"  width="200">
    					<html:select  styleId="flowTypeID" property="flowTypeID" style="width:100%">
    						<html:optionsCollection name="expenseTypeList" label="lable" value="lableCode"/>
    					</html:select>
    				</td>
    				<td align="right" width="100">起始日期：</td>
    				<td align="left"  width="200"><html:text styleId="flowBgnDate" property="flowBgnDate" onclick="setday(this)" readonly="true" style="width:100%"/> </td>
    				<td align="right" width="100">截止日期：</td>
    				<td align="left"  width="200"><html:text styleId="flowEndDate" property="flowEndDate" onclick="setday(this)" readonly="true" style="width:100%"/> </td>
    			</tr>
    			
    				<tr>
    				<td align="right" width="100">分公司提交：</td>
    				<td align="left" width="200">
    					<html:text styleId="branchInfo" property="branchInfo" onclick="setday(this)" readonly="true" style="width:100%"/>  
    			   </td>
    				
    				<td align="right" width="100">分公司财务提交：</td>
    				<td align="left"  width="200"><html:text styleId="branchFinanceInfo" property="branchFinanceInfo" onclick="setday(this)" readonly="true" style="width:100%"/>  </td>
    				
    				<td align="right" width="100">店铺管理部提交：</td>
    				<td align="left"  width="200"><html:text styleId="shopMgrInfo" property="shopMgrInfo" onclick="setday(this)" readonly="true" style="width:100%"/>  </td>
    				
    			</tr>
    			
    			<tr>
    				<td align="right" width="100">总部财务提交：</td>
    				<td align="left" width="200">
    					<html:text styleId="HQFinanceInfo" property="HQFinanceInfo" onclick="setday(this)" readonly="true" style="width:100%"/>  
    			   </td>
    				
    				<td align="right" width="100">出纳提交：</td>
    				<td align="left"  width="200"><html:text styleId="cashierInfo" property="cashierInfo" onclick="setday(this)" readonly="true" style="width:100%"/>  </td>
    				<td></td>
    				<td><html:button property="button" value="查询" onclick="waitDetail();document.forms[0].submit()" styleClass="btn_search" onmouseover="this.className='btn_search_on'" onmouseout="this.className='btn_search'"> </html:button> 
    					<html:button  property="button" value="清空" onclick="resetCondition()" styleClass="btn_reset" onmouseover="this.className='btn_reset_on'" onmouseout="this.className='btn_reset'"></html:button>
    			</tr>
    				
    		
    		</table>
    		
    		
    	</html:form>
    	
    
    	 
    	 <ec:table  items="infolist" var="record"  tableId="ecTable" 
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="shopExpenseApportion.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true"  style="table-layout:fixed;" xlsFileName="分摊费用报表.xls"
			filterable="true">
				 
			<ec:row rowId="ecrow" recordKey="${record.Expense_No},${record.FI_Action}" ondblclick="getMXInfos()"  onmouseover="mouseonChange(this);" onmouseout="mouseoutChange(this);">
				
				<ec:column width="40" property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column  title="单号" tipTitle="${record.Expense_No}" property="Expense_No" sortable="true"/>
				
			<%-- <ec:column title="当前节点" property="Node_Name" sortable="true"/>--%>	
				
				
				<ec:column tipTitle="${record.CostCenter}" title="成本中心代码"  property="CostCenter" sortable="true" />
				<ec:column tipTitle="${record.BranchName}" title="分公司名称"  property="BranchName" sortable="true" />
				<ec:column tipTitle="${record.Apply_Name}" title="申请人"  property="Apply_Name" sortable="true" />
				<ec:column tipTitle="${record.Bank_Accout_Code}" title="银行卡号"  property="Bank_Accout_Code" sortable="true" />
				
				
				<ec:column tipTitle="${record.FI_CreateperTime}" title="登记日期"  property="FI_CreateperTime" sortable="true" />
			
				<ec:column title="店铺名称" tipTitle="${record.SE_ShopName}" property="SE_ShopName" sortable="true"/>
				<ec:column title="店铺成本中心" tipTitle="${record.SE_CostCenter}" property="SE_CostCenter" sortable="true"/>
				<ec:column title="分摊金额"  tipTitle="${record.SE_Money}" property="SE_Money" cell="number" format="0.00"  style="text-align:right;" sortable="true"/>
				<ec:column title="备注" tipTitle="${record.SE_Remark}" property="SE_Remark" sortable="true"/>
					
				<ec:column title="发票寄回日期" tipTitle="${record.Invoice_BackDate}" property="Invoice_BackDate" sortable="true"/>
				
				<ec:column title="状态" tipTitle="${record.ZT_Name}" property="ZT_Name" sortable="true"/>
				<ec:column title="已审核人" tipTitle="${record.Last_User}" property="Last_User" sortable="true" />
				<ec:column title="当前审核人" tipTitle="${record.FI_CurrentUser}" property="FI_CurrentUser" sortable="true" />
				
				<ec:column tipTitle="${record.Approve_Info_title}" style="width:100" title="审核信息" property="Approve_Info" sortable="true"  />
				
				
			
			
			</ec:row>
			
		</ec:table>

    	</div>
  </body>
</html>
