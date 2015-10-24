<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.util.NumberUtil"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseDetail"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseSubjectCost"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseShopCost"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    		
  		<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
		<script type="text/javascript" src="<%= path%>/myjs/myTime.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>

  </head>
  <script type="text/javascript">
  	var handleThread=0;
	var thisTextID;
	var thisTextValue;
	var gasolineCost;
	var trainCost;
	var taxiCost;
	var airplaneCost;
	var others;
	var hotelCost;
	var meal_allowance_cost;
	
	function getLastTextValue(obj){
		var textID = $(obj).attr('id');
		if(textID!=thisTextID){
			thisTextID = textID;
			thisTextValue = $(obj).attr('value');
		}
		
	}
	
	function modifyExpenseNumber(modifyFlag,obj,desc){
  		var xmlhttp;
  		var objValue = $(obj).attr('value');
  		if(isNaN(objValue)){
  			alert('只允许输入数值!');
  			return false;
  		}else{
  			return modifyExpense(modifyFlag,obj,desc);
  		}
  	}
	
	function modifyExpense(modifyFlag,obj,desc){
		var objID = $(obj).attr('id');
		var objIDs = $(obj).attr('id').split('-');
		var value = $(obj).attr('value');
		var xmlhttp;
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var rs = xmlhttp.responseText;
				
				
				if(rs=='0'&& objIDs[1]!= 'expenseDate'&&objIDs[1]!='accountCode'){
					alert('输入失败，请重新输入'+desc);
    				$(obj).attr('value','');
					return;
				}
				handleThread--;
				if(objIDs[1]=='gasolineCost'||objIDs[1]=='trainCost'||objIDs[1]=='taxiCost'||objIDs[1]=='airplaneCost'||objIDs[1]=='others'||objIDs[1]=='hotelCost'||objIDs[1]=='meal_allowance_cost'){
					changeCost(obj);
				}
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入'+desc);
    			$(obj).attr('value','');
    			handleThread--;
    			return;
    		}
    	}	
		
		
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=addTripExpenseDetail&modifyFlag="+modifyFlag+"&mapKey="+objIDs[0]+"&field="+objIDs[1]+"&fieldValue="+value);
		handleThread++;
	}
	
	function modifyExpenseNumber(modifyFlag,obj,desc){
  		var xmlhttp;
  		var objValue = $(obj).attr('value');
  		if(isNaN(objValue)){
  			alert('只允许输入数值!');
  		}else{
  			modifyExpense(modifyFlag,obj,desc);
  		}
  	}
	
	
  	
  	
  	function changeBranchCode(){
  		var selecttext = $("#branchCode").find("option:selected").text(); 
  		var branchName = selecttext.split('|')[1];
  		$("#branchName").attr("value",selecttext);
  	}
  	
  	
  	
  	
  	
  
 function changeCost(obj){
	  var field = $(obj).attr('id').split('-')[1];
	  var fieldSum = 0;
	  var total = 0;
	  $('#tirpDetailTable').find('tr').each(function(){
	      
	      $(this).find('input').each(function(){
	          var objIDs = $(this).attr('id');
	          var objIDArray = objIDs.split('-');
	          
	          if(objIDArray.length>1){
	          	  var field1 = objIDArray[1];
	              if(field==field1){
	          	    var temp = $(this).attr('value');
	          	    
	          	    if(temp==null||temp==''){
	          	    	temp='0.0000'
	          	    }
	          	    
	          	    
	          	    fieldSum = fieldSum+parseFloat(temp); 
	          	  }
	      	  }
	      })
	  })
	  
	  if(field=='gasolineCost'){
	  	gasolineCost = parseFloat(fieldSum).toFixed(2);
	  	 $('#gasolineCost').attr('value',gasolineCost);
	  }
	  if(field=='trainCost'){
	  	trainCost = parseFloat(fieldSum).toFixed(2);
	  	$('#trainCost').attr('value',trainCost);
	  }
	  
	  if(field=='taxiCost'){
	  	taxiCost = parseFloat(fieldSum).toFixed(2);
	  	$('#taxiCost').attr('value',taxiCost);
	  }
	  
	  if(field=='airplaneCost'){
	  	airplaneCost = parseFloat(fieldSum).toFixed(2);
	 	$('#airplaneCost').attr('value',airplaneCost);
	  }
	  
	  if(field=='others'){
	  	others = parseFloat(fieldSum).toFixed(2);
	    $('#others').attr('value',others);
	  }
	  
	  
	  if(field=='hotelCost'){
	  	hotelCost = parseFloat(fieldSum).toFixed(2);
	  $('#hotelCost').attr('value',hotelCost);
	  }
	  
	   if(field=='meal_allowance_cost'){
	  	meal_allowance_cost = parseFloat(fieldSum).toFixed(2);
	  	 $('#meal_allowance_cost').attr('value',meal_allowance_cost);
	  }
	  
	  total=parseFloat(gasolineCost)+parseFloat(trainCost)+parseFloat(taxiCost)+parseFloat(airplaneCost)
	  	+parseFloat(others)+parseFloat(hotelCost)+parseFloat(meal_allowance_cost);

	  total = total.toFixed(2);
	  $('#totalMoney').attr('value',total);
	
  	 
  }
  
  
  function checkMustFill(){
  		var flag = true;
  		var fieldName = '';
  		var fieldID = '';
  		if($('#invoiceBackDate').attr('value')==null || $('#invoiceBackDate').attr('value')==''){
  			alert('发票寄回日期不能为空！');
  			return false;
  		}
  		if($('#tripAddress').attr('value')==null || $('#tripAddress').attr('value')==''){
  			alert('出差地点不能为空！');
  			return false;
  		}
  		
  		if($('#tripPurposes').attr('value')==null || $('#tripPurposes').attr('value')==''){
  			alert('出差事由不能为空！');
  			return false;
  		}
  		
  		$('#topDiv').find('tr').each(function(){
 			var totalel = 0;
 			var fillel = 0;
 			var value = '';
 			$(this).find('textarea').each(function(){
 				totalel++;
 				value = $(this).attr('value');
 				if(value!=''&&value!=null){
 					fillel++;
 				}else{
 					fieldName = $(this).attr('name');
 				}
 
 			});
 			
 			$(this).find('input').each(function(){
 				if($(this).attr('type')!='checkbox'){
 					
 					var id=$(this).attr('id');
 					var ids = id.split('-');
 					
 					if(ids[1]=='fromAdress'||ids[1]=='fromDate'||ids[1]=='toAdress'||ids[1]=='toDate'){
 						totalel++;
 						value = $(this).attr('value');
 						if(value!=''&&value!=null){
 							fillel++;
 						}else{
 							fieldName = $(this).attr('name');
 						}
 					}
 				}
 			});
			if(fillel!=0 && totalel!=fillel){
				alert(fieldName + "为必填项，请检查！");
				flag = false;
				return false;
			}
		});
  		return flag;
  	}
  	
  	
  	function save(){
  		
  		if(checkMustFill()){
  			$('#action').attr('value','save');
  			document.forms[0].submit();
  		}
  	}
  	
  	function do_submit(){
  		if(confirm('确定提交？')){
  			$('#action').attr('value','send');
  			document.forms[0].submit();
  		}
  		
  	}
  	
  	function refuse(){
  		if(confirm('确定驳回？')){
  			$('#action').attr('value','refuse');
  			document.forms[0].submit();
  		}
  	}
  	
  	
  	
  	function initForm(){
  		$('#applytitle', parent.document).html('差旅费报销单');
  		if($('#result').attr('value')=='1'){
  			alert('单号为'+$('#expenseNo').attr('value')+'申请单保存成功');
  		
  		}
  		if($('#result').attr('value')=='2'){
  			alert('提交成功');
  			window.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';
  		}
  		if($('#result').attr('value')=='3'){
  			print();
  		}
  		
  		gasolineCost = $('#gasolineCost').attr('value');
		trainCost = $('#trainCost').attr('value');
		taxiCost = $('#taxiCost').attr('value');
		airplaneCost = $('#airplaneCost').attr('value');
		others = $('#others').attr('value');
		hotelCost = $('#hotelCost').attr('value');
		meal_allowance_cost = $('#meal_allowance_cost').attr('value');
  	
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
  
  function print(){
  	var stateCode = $('#applyStateCode').attr('value');
  	var expenseNo = $('#expenseNo').attr('value');
  	var url = $('#webcontent').attr('value')+'/tripExpenseApply.do?action=getPrintData&expenseNo='+expenseNo;	
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
	
    	<div style="width: 95%">
    	<html:form action="/tripExpenseApply" styleId="tripExpenseApplyForm">
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
    		
    		<div style="position: relative; display: inline-block; width: 100%; height: 72px;">
			<img alt="" src="<%=path%>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">分公司差旅费申请</font>
    		<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#AFC7D6">
    			<tr>
    				<td class="td_field" width="20%" >申请单状态：
    					
    				</td>
    				
    				<td class="td_field" width="20%" >
    					
    					<html:text property="applyStateName" styleId="applyStateName" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%" >申请单号：
    					
    				</td>
    				<td class="td_field" colspan="2">
    					<html:text property="expenseNo" styleId="expenseNo" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				
    				
    			</tr>
    			
    			<tr>
    				<td class="td_field" width="20%">出差人姓名
    					<br />
    					<html:text property="tripName" styleId="tripName" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				<td class="td_field" width="20%">职员编码
    					<br />
    					<html:text property="employeeID" styleId="employeeID" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%">成本中心代码
    					<br />
    					 <html:select styleId="branchCode" property="branchCode" onchange="changeBranchCode()" style="width: 100%" disabled="true">
							<html:optionsCollection name="branchList" value="value"  label="lable"/>
						</html:select>	
    				
    				</td>
    				
    				<td class="td_field" width="20%">部门
    					<br />
    					<html:text  property="branchName" styleId="branchName" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%">电话
    					<br />
    					<html:text property="telephone" styleId="telephone" styleClass="text_write_common" disabled="true"></html:text>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="td_field" >出差地点
    					<br />
    					<html:textarea rows="1" property="tripAddress" styleId="tripAddress" styleClass="text_write_common" disabled="true"></html:textarea>
    				</td>
    				<td class="td_field">出差事由
    					<br />
    					<html:textarea rows="1" property="tripPurposes" styleId="tripPurposes" styleClass="text_write_common" disabled="true"></html:textarea>
    				</td>
    				<td class="td_field">随同人员
    					<br />
    					<html:textarea rows="1" property="tripMenber" styleId="tripMenber" styleClass="text_write_common" disabled="true"></html:textarea>
    				</td>
    				<td class="td_field">日期
    					<br />
    					<html:text property="applyDate" styleId="applyDate" onclick="setday(this)" readonly="readonly" styleClass="text_write_common" disabled="true"></html:text>
    				</td>
    				
    				<td class="td_field">
    					发票寄回日期
    					<br />
    					<html:text styleId="invoiceBackDate" property="invoiceBackDate" onclick="setday(this)" readonly="readonly"  styleClass="text_write_common" disabled="true"></html:text>
    				</td>
    			
    			</tr>
    			
    			<tr>
    				<td class="td_field">
    					总金额<br />
    					￥<html:text  property="totalMoney" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("tripCost"))%>" styleId="totalMoney" styleClass="text_read_common" disabled="true"></html:text>
    					
    				</td>
    				
    				<td class="td_field">
    					预算金额<br />
    					<html:text property="budget" styleId="budget" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				<td class="td_field">
    					已用金额<br />
    					<html:text property="usedAmount" styleId="usedAmount" styleClass="text_read_common" disabled="true"></html:text>
    				</td>
    				
    				
    				
    				<td colspan="1" class="td_field">
    					   附件<br /> <html:text styleId="attachments" property="attachments" style="background-color:white;width:60;	font-size: 12;" disabled="true"></html:text>P/张		
    					
    				</td>
    				
    				<td class="td_field">收款人
    					<br />
    					<html:text property="receiveName" styleId="receiveName" styleClass="text_write_common" disabled="true"></html:text>
    				</td>
    			
    			</tr>
    			
    			<tr>
    				<td class="td_field" colspan="5">付款说明
    					<br />
    					<html:textarea property="payComment" styleId="payComment"  styleClass="text_write_common" disabled="true"></html:textarea>
    				</td>
    			</tr>
    				
    			
    		</table>
    		</div>
    		</html:form>
    		
    		<div id="topDiv" style="width: 95%">
    		
    		
    		<table id="tirpDetailTable"  border="0" cellpadding="2" cellspacing="1"	bgcolor="#AFC7D6">
    			<tr>
    				<td   class="td_field_title" colspan="2">出发		
    				</td>
    				<td   class="td_field_title" colspan="2">到达		
    				</td>
    				<td   class="td_field_title" colspan="2">里程	
    				</td>
    				<td  class="td_field_title" colspan="6">交通和住宿费和补贴费	</td>
    			</tr>
    			
    			<tr>
    				<td class="td_field_title"  >起点
    				</td>
    				
    				<td class="td_field_title" >日期

    				</td>
    				
    				<td class="td_field_title" >终点
    				</td>
    				
    				<td class="td_field_title" >日期</td>
    				
    				<td class="td_field_title" >公里 </td>
    				
    				<td class="td_field_title" >汽油费</td>
    				
    				<td class="td_field_title" >火车票</td>
    				
    				<td class="td_field_title" >出租车</td>
    				
    				<td class="td_field_title" >飞机票
    				</td>
    				
    				<td class="td_field_title" >其他交通
    				</td>
    				
    				<td class="td_field_title" >住宿费
    				</td>
    				
    				<td class="td_field_title" >餐费和补贴
    				</td>
    			</tr>
    			
    							
    			<% List  detailList =(List)request.getAttribute("detailList"); 
    			   int detailListSize = 0;
    			   if(detailList != null){
    			   	   detailListSize =  detailList.size();
    			   }
    			   int beginIndex = 1101;
    			   for(int i=0;i<detailListSize;i++){
    			   	 TripExpenseDetail detail = (TripExpenseDetail) detailList.get(i);
    			   	 beginIndex = beginIndex+i;
    			%>
    			<tr id="<%=beginIndex%>">
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"   name="起点起点" id="<%=beginIndex%>-fromAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'出发')" value="<%=detail.getFromAdress()%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期"  onclick="setday(this)" id="<%=beginIndex%>-fromDate" class="text_write_noborder_trip"  onpropertychange="modifyExpense('1',this,'日期')" value="<%=detail.getFromDate()%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="终点" id="<%=beginIndex%>-toAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'终点')" value="<%=detail.getToAdress()%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期" onclick="setday(this)" id="<%=beginIndex%>-toDate" class="text_write_noborder_trip" onpropertychange="modifyExpense('1',this,'日期')" value="<%=detail.getToDate()%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="公里" id="<%=beginIndex%>-KM" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'公里')" value="<%=detail.getKM()==null?"":detail.getKM()%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="汽油费" id="<%=beginIndex%>-gasolineCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'汽油费')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getGasolineCost()==null?"":detail.getGasolineCost())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="火车票" id="<%=beginIndex%>-trainCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'火车票')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getTrainCost()==null?"":detail.getTrainCost())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text" name="出租车" id="<%=beginIndex%>-taxiCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'出租车')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getTaxiCost()==null?"":detail.getTaxiCost())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="飞机票" id="<%=beginIndex%>-airplaneCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'飞机票')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getAirplaneCost()==null?"":detail.getAirplaneCost())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="其他交通" id="<%=beginIndex%>-others" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'其他交通')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getOthers()==null?"":detail.getOthers())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="住宿费" id="<%=beginIndex%>-hotelCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'住宿费')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getHotelCost()==null?"":detail.getHotelCost())%>" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="餐费和补贴" id="<%=beginIndex%>-meal_allowance_cost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'餐费和补贴')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getMeal_allowance_cost()==null?"":detail.getMeal_allowance_cost())%>" disabled="disabled"> </td>
    			</tr>
    			
    			<% }%>
    			
    			<% 
    			int loopLen = 10-detailListSize;
    		     beginIndex = 1000;
    			for(int i=0;i<loopLen;i++){ 
    				beginIndex++; 
    			%>
    			
    			<tr id="<%=beginIndex%>">
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"   name="起点起点" id="<%=beginIndex%>-fromAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'出发')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期"  onclick="setday(this)" id="<%=beginIndex%>-fromDate" class="text_write_noborder_trip"  onpropertychange="modifyExpense('1',this,'日期')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="终点" id="<%=beginIndex%>-toAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'终点')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期" onclick="setday(this)" id="<%=beginIndex%>-toDate" class="text_write_noborder_trip" onpropertychange="modifyExpense('1',this,'日期')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="公里" id="<%=beginIndex%>-KM" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'公里')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="汽油费" id="<%=beginIndex%>-gasolineCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'汽油费')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="火车票" id="<%=beginIndex%>-trainCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'火车票')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text" name="出租车" id="<%=beginIndex%>-taxiCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'出租车')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="飞机票" id="<%=beginIndex%>-airplaneCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'飞机票')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="其他交通" id="<%=beginIndex%>-others" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'其他交通')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="住宿费" id="<%=beginIndex%>-hotelCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'住宿费')" disabled="disabled"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="餐费和补贴" id="<%=beginIndex%>-meal_allowance_cost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'餐费和补贴')" onkeydown="getLastTextValue(this)" disabled="disabled"> </td>
    			</tr>
    			
    			
    			<%} %>	
    			
    			<tr>
    				
    				
    				<td class="td_field_title" colspan="5">
    					
    				费用小计
    				</td>
    				<td class="td_field_title"><input style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;" type="text" id="gasolineCost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("gasolineCost"))%>" >
    				</td>
    				<td class="td_field_title">
    					<input  style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;"   type="text"  id="trainCost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("trainCost"))%>" >
    			
    				</td>
    				<td class="td_field_title">
    					<input  style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;"  type="text" id="taxiCost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("taxiCost"))%>" >
    				
    				</td>
    				<td class="td_field_title">
    					<input style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;"  type="text" id="airplaneCost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("airplaneCost"))%>">
    				
    				</td>
    				<td class="td_field_title">
    					<input style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;" type="text" id="others" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("others"))%>" >
    				
    				</td>
    				<td class="td_field_title">
    					<input style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;" type="text"  id="hotelCost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("hotelCost"))%>" >
    				
    				</td>
    				<td class="td_field_title">
    					<input style="background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;"  type="text" id="meal_allowance_cost" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("meal_allowance_cost"))%>" >
    				
    				</td>
    			</tr>
    			<!-- <td  class="td_field_title"> 
    					费用小计</td>
    				<td class="td_field">
    						</td>
    				<td class="td_field">
    				</td>
    				<td class="td_field">
    					</td>
    				<td class="td_field">
    					</td>
    				<td class="td_field">
    					</td>
    				<td class="td_field">
    					</td>
    				<td class="td_field">
    					</td>
    			
    			
    			</tr>
   
    			 -->	
    			
    			
    			
    			
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
				     	TripExpenseShopCost shopCost =(TripExpenseShopCost) shopCostList.get(i);
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
						<input id="<%=2101+i%>-expenseAmout" type="text" value="<%=NumberUtil.formatFloatDecimal(2,shopCost.getExpenseAmout())%>" class="text_write_common" disabled="disabled">
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
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("BTESubjectTotalCost"))%>)
					</td>
					<td class="td_field_title" width="19.2%">
						备注
					</td>
				</tr>

				
				<%List subjectCostList = (List)request.getAttribute("BTESubjectCostList");
					
				 int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	TripExpenseSubjectCost subjectCost =(TripExpenseSubjectCost) subjectCostList.get(i);
				%>
				<tr id="<%=3101+i%>-tr">
					<td class="td_text_center">
						<input type="checkbox" id="<%=3101+i%>" id="<%=3101+i%>">
					</td>

					<td class="td_text_center">
						<select id="<%=3101+i%>-categoryCode"  disabled="disabled" style="width: 100%">
							
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
						
						<select  id="<%=3101+i%>-subjectCode" name="subjectCode"  style="width: 100%" disabled="disabled">
							</select>
					</td>



					<td class="td_text_center">
						<input id="<%=3101+i%>-accountCode" type="text"  class="text_write_common"  value="<%=subjectCost.getAccountCode() %> " disabled="disabled">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectAmout" type="text" class="text_write_common"  value="<%=NumberUtil.formatFloatDecimal(2,subjectCost.getSubjectAmout())%>" disabled="disabled">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-comment" type="text" class="text_write_common"  value="<%=subjectCost.getComment()%>" disabled="disabled">
					</td>
				</tr>
				
				<%} %>
				
				
			
				
			</table>
		</div>
    	
    	</div>	
    	
  </body>
</html>
