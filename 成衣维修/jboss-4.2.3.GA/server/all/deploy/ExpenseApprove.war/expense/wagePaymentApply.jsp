<%@page import="ep.org.util.NumberUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.WagePaymentPurposeCost"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.WagePaymentSubjectCost"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
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
    
    <title>工资付款申请</title>
    
		<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
		<script type="text/javascript" src="<%= path%>/myjs/myTime.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
	</head>

  <script type="text/javascript">
 var handleThread=0;
 var subjectMoneyIsRight = '0';	
  	
  	
  	
	

	function getAccountCode(obj){
		var code = $(obj).attr('value');
 		var id=$(obj).attr('id');
    	var newid=id.split('-')[0]+'-accountCode';
    	$("#"+newid).attr('value',code);
  	}
	function getaccountListBySuper(obj){
		var id = $(obj).attr('id');
		var superID = id.split('-')[0]+'-categoryCode';
		var superObj = $('#'+superID);
		getaccountList(superObj,'大类');
		$('#'+id.split('-')[0]+'-accountNameTD').attr('className','td_text_center_nodisplay');
		$('#'+id.split('-')[0]+'-subjectCodeTD').attr('className','td_text_center');
		
	}
	
	function getaccountList(obj,desc){
		var xmlhttp;
		var id=$(obj).attr('id');
    	$('#'+id.split('-')[0]+'-accountNameTD').attr('className','td_text_center_nodisplay');
		$('#'+id.split('-')[0]+'-subjectCodeTD').attr('className','td_text_center');
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
    			
    			//var id=$(obj).attr('id');
    			var newid=id.split('-')[0]+'-subjectCode';
    			
    			document.getElementById(newid).options.length=0;
    			var jsonObj = eval("(" + xmlhttp.responseText + ")"); 
    			if(jsonObj.length<2){
    				
    				$('#'+id.split('-')[0]+'-accountCode').attr('value',$(obj).attr('value'));
    				handleThread--;
    				return;
    			}
    			$('#'+id.split('-')[0]+'-accountCode').attr('value','');
    			var options = document.getElementById(newid).options;
    			if(jsonObj!=null && jsonObj!=''){
					
			
					for(var item in jsonObj){
				
				
				
						if(jsonObj[item].value!=null && jsonObj[item].value != ''){
					
							var objOption = new Option(jsonObj[item].lable,jsonObj[item].value); 
							options[item]=objOption;
						}
					}
				
    			}
    			handleThread--;	
    		}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入'+desc);
    			$(obj).attr('value','');
    			handleThread--;
    		}
 		}
 		//var field = $(obj).attr('id');
 		var code = $(obj).attr('value');
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=getCategoryList&code="+code);
		handleThread++;
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
					handleThread--;
					return;
				}
				handleThread--;
				changeAllCost(objIDs[0],objIDs[1],obj)
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入'+desc);
    			$(obj).attr('value','');
    			handleThread--;
    			return;
    		}
    	}	
		
		
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=addWagePaymentDetail&modifyFlag="+modifyFlag+"&mapKey="+objIDs[0]+"&field="+objIDs[1]+"&fieldValue="+value);
		handleThread++;
	}
	
	
	
	
	
	function changeAllCost(id,name,obj){
  	if(id.substring(0,1)=='1'&&name=='expenseAmout'){
  		 changePurposeTotalCost(obj);
  		
  	}else if(id.substring(0,1)=='2'&&name=='expenseAmout'){
  		return ;
  	}else if(id.substring(0,1)=='3'&&name=='subjectAmout'){
  		changeSubjectTotalCost(obj);
  		
  	}
  }
	
	
	function modifyExpenseNumber(modifyFlag,obj,desc){
  		var objValue = $(obj).attr('value');
  		if(isNaN(objValue)){
  			$(obj).attr('value','');
  			alert('只允许输入数值!');
  			return;
  		/**}else if(parseFloat(objValue)<0){
  			alert('输入金额不能小于零!');
  			$(obj).attr('value','');
  			return;*/
  		}else{
  			modifyExpense(modifyFlag,obj,desc);
  		}
  	}
	
	function addExpense(modifyFlag,tableID){
		var xmlhttp;
		var arrayTr = $('#'+tableID+' tr');
		if(tableID=='100'&&arrayTr.length==8){
			alert('费用用途最多只允许填写6条记录，如果超过请再申请！');
			return;
		}
		var lastTr = arrayTr[arrayTr.length-1];
		var lastTrID =  $(lastTr).attr('id');
		var lastTrIDs = lastTrID.split('-'); 
		var newSerial = parseInt(lastTrIDs[0])+1;
		if(lastTrID.substring(1,2)=='1'){
			newSerial = lastTrID.substring(0,1)+'001';
		}
		
		var lastSN = $('#'+lastTrIDs[0]+'-SN').attr('value');
		var newSN = parseInt(lastSN)+1;
		
		var tr = $('#'+tableID+' tr').eq(1).clone(); 
  		tr.appendTo('#'+tableID);
  		
  		$(tr).css("display","block");
  		
  		$(tr).attr('id',newSerial+'-tr');
  		
  		$(tr).find('textarea').each(function(){
 			var textareaID = $(this).attr('id');
 			var newTextareaID = newSerial+'-'+textareaID.split('-')[1];
 			$(this).attr('id',newTextareaID);
 			$(this).attr('value','');
 			
		});
		
		$(tr).find('select').each(function(){
 			var textareaID = $(this).attr('id');
 			var newTextareaID = newSerial+'-'+textareaID.split('-')[1];
 			$(this).attr('id',newTextareaID);
 			$(this).attr('value','');
		});
		
		$(tr).find('input').each(function(){
 			if($(this).attr('type')=='checkbox'){
 				$(this).attr('id',newSerial);
 				$(this).attr('checked',false);
 				$(this).attr('value',newSerial);
 			}else{
 				var textareaID = $(this).attr('id');
 				var newTextareaID = newSerial+'-'+textareaID.split('-')[1];
 				$(this).attr('id',newTextareaID);
 				$(this).attr('value','');
 			}
		});
		
		$('#'+newSerial+'-SN').attr('value',newSN);
		
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				var rs = xmlhttp.responseText;
				if(rs=='0'){
					alert('增加失败，请重新点击增加'+desc);
    				tr.remove();
				}
				handleThread--;
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新点击增加');
    			tr.remove();
    			handleThread--;
    		}
		
		}
		
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=addWagePaymentDetail&modifyFlag="+modifyFlag+"&mapKey="+newSerial+'&SN='+newSN);
		handleThread++;
	
	}
	
	
	function deleteExpense(modifyFlag,tableID){
		var xmlhttp;
		var arrayTr = $('#'+tableID+' tr');
		var mapKeyString = '';
		for(var i=0;i<arrayTr.length;i++ ){
			var thisTr = arrayTr[i];
			if($(thisTr).find('input').eq(1).attr('checked')){
				mapKeyString=mapKeyString+','+$(thisTr).attr('id').split('-')[0];
			}
		}
		
		mapKeyString = mapKeyString.substring(1,mapKeyString.length);
		
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				var rs = xmlhttp.responseText;
				if(rs=='0'){
					alert('删除失败，请重新删除');
				}
				if(rs=='1'){
					
					for(var i=0;i<arrayTr.length;i++ ){
						var thisTr = arrayTr[i];
						if($(thisTr).find('input').eq(1).attr('checked')){
							var thisTrID = $(thisTr).attr('id').split('-')[0];
							mapKeyString=mapKeyString+','+thisTrID;
							if(thisTrID.substring(0,1)=='1'){
								var purposeValue = $('#'+thisTrID+'-expenseAmout').attr('value')
								var totalValue = $('#hiddenPurposeTotalCost').attr('value');
  								if(purposeValue==null || purposeValue==''){
  									purposeValue = '0';
  								}
  								
  								var sum = parseFloat(totalValue)-parseFloat(purposeValue);
  								sum = sum.toFixed(2);
  								$('#hiddenPurposeTotalCost').attr('value',sum);
  								$('#purposeTotalCost').html('金额('+sum+')'); 
								$('#applyAmount').attr('value',sum);
							}else{
								var thisValue = $('#'+thisTrID+'-subjectAmout').attr('value')
								var totalValue = $('#hiddenSubjectTotalCost').attr('value');	
								if(thisValue==null || thisValue==''){
  									thisValue = '0';
  								}
								var sum = parseFloat(totalValue)-parseFloat(thisValue);
								sum = sum.toFixed(2);
								$('#hiddenSubjectTotalCost').attr('value',sum);
  								$('#subjectTotalCost').html('金额('+sum+')'); 
							}
							
							$(arrayTr[i]).remove();
							
						}
						
						
					
					}
				}
				handleThread--;
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新删除');
    			
    			handleThread--;
    		
    		}
		
			}
		
			xmlhttp.open("post","ajax.ajaxServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("action=addWagePaymentDetail&modifyFlag="+modifyFlag+"&mapKey="+mapKeyString);
			
			handleThread++;
		
	
	
	}
  
  	
  	function validateBankCode(){
  		var flag = true;
  		var bankAccount = $('#paymentComment').attr('value');
  		if(bankAccount.length!=16 && bankAccount.length!=19){
  			alert('银行帐号不正确，请重新输入！');
  			flag = false;
  		}
  		
  		return flag;
  	}
  	
  	
  	function changeBranchCode(){
  		var selecttext = $("#branchCode").find("option:selected").text(); 
  		var branchName = selecttext.split('|')[1];
  		$("#branchName").attr("value",branchName);
  	}
  	
  	
  	
  	function checkMustFill(){
  		var flag = true;
  		var fieldName = '';
  		
  		if(!validateBankCode()){
  			return false;
  		}
  		
  		if($('#sendInvoiceDate').attr('value')==null || $('#sendInvoiceDate').attr('value')==''){
  			alert('发票寄回日期不能为空！');
  			return false;
  		}
  		if($('#paymentComment').attr('value')==null || $('#paymentComment').attr('value')==''){
  			alert('银行帐号不能为空！');
  			return false;
  		}
  		if($('#applyUserName').attr('value')==null || $('#applyUserName').attr('value')==''){
  			alert('申请人不能为空！');
  			return false;
  		}
  		
  		var arrayTr = $('#100'+' tr');
		
		if(arrayTr.length<=2){
			alert('费用用途至少有一条记录！');
			return false;
		}
		
		if($('#applyAmount').attr('value')=='0.0000'){
			alert('申请金额不能为0！');
			return false;
		}
		
		if($('#isBranchFinance').attr('value')=='1'){
				var arrayTr_Subject = $('#300'+' tr');
				if(arrayTr_Subject.length<=2){
					alert('费用科目至少有一条记录！');
					return false;
				}
				
				var count = 0;
				
				for(var k=2;k<arrayTr_Subject.length;k++){
					
					if($(arrayTr_Subject[k]).find('input').eq(2).attr('value')!='' || $(arrayTr_Subject[k]).find('input').eq(3).attr('value')!=''){
						
						count++;
						
					}		
				}
				
				if(count==0){
					alert('费用科目至少有一条记录！');
					return false;
				}
		
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
 			/*
 			$(this).find('select').each(function(){
 				totalel++;
 				value = $(this).attr('value');
 				if(value!=''&&value!=null){
 					fillel++;
 				}
 			});*/
 			
 			$(this).find('input').each(function(){
 				if($(this).attr('type')!='checkbox'&&$(this).attr('name')!='SN'&&$(this).attr('id').split('-')[1]!='comment'&&$(this).attr('id').split('-')[1]!='accountName'
 					&&$(this).attr('id').split('-')[1]!='subjectBudget'&&$(this).attr('id').split('-')[1]!='subjectUsedMoney'
 				){
 					totalel++;
 					value = $(this).attr('value');
 					if(value!=''&&value!=null){
 						fillel++;
 					}else{
 						fieldName = $(this).attr('name');
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
  		if(handleThread!=0){
  			alert('后台数据还未处理完成，请稍后再保存！');
  			return;
  		}
  		if(checkMustFill()){
  			$('#action').attr('value','save');
  			document.forms[0].submit();
  		}
  	}
  	
  	
  	function isExistsActivtyThread(){
  		if(handleThread==0){
  			do_submitActvity();
  		}else{
  			setTimeout('isExistsActivtyThread()',10);
  		}
  	}
  	
  	function waitDiv(){
  		$('#waitDiv').show();
  		$('#mainDiv').hide();
  	}
  	
  	function waitDivHidden(){
  		$('#waitDiv').hide();
  		$('#mainDiv').show();
  	}
  	
  	function do_submitActvity(){
  		if(subjectMoneyIsRight=='1'){
  			alert('所填科目金额超出该科目的可用预算金额!');
  			subjectMoneyIsRight = '0';
  			return;
  		}
  		if(subjectMoneyIsRight=='2'){
  			alert('后台未取到该科目预算，请联系IT运维！');
  			subjectMoneyIsRight = '0';
  			return;
  		}
  		if(subjectMoneyIsRight=='3'){
  			alert('网络错误，请重新提交!');
  			subjectMoneyIsRight = '0';
  			return;
  		}
  		
  		 //if(handleThread!=0){
  			//alert('后台数据还未处理完成，请稍后再提交！');
  			//return;
  		 //}
  		 if(checkMustFill()){
  		 	if(confirm('确定提交？')){
  				$('#action').attr('value','send');
  				document.forms[0].submit();
  			}else{
  				waitDivHidden();
  			}
  		}else{
  			waitDivHidden();
  		}
  	}
  	
  	function do_submit(){
  		 var arrayTr = $('#300 tr');
  		 for(var i=2;i<arrayTr.length;i++){
  			 if($(arrayTr[i]).find('input').eq(3).attr('id').split('-')[1]=='subjectAmout'){
  			 	 if($(arrayTr[i]).find('input').eq(3).attr('value')!=''){
  			 	 	validateSubjectBal($(arrayTr[i]).find('input').eq(2));
  			 	}
  			 }else{
  			 	
  			 	 if($(arrayTr[i]).find('input').eq(4).attr('value')!=''){
  					validateSubjectBal($(arrayTr[i]).find('input').eq(3));
  			 	}
  			 }
  		 }
  		 
  		waitDiv();
  		isExistsActivtyThread();
  		
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
  	
  	
  	
  	function initForm(){
  		$('#applytitle', parent.document).html('工资付款申请');
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
  		
  		if($('#result').attr('value')=='4'){
  			alert('驳回成功');
  			window.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';
  		}
  		if($('#result').attr('value')=='-1'){
  			alert('流程找不到下个环节，请联系IT部流程配置人员');
  			return;
  		}
  	}
  	
  function changePurposeTotalCost(obj){
  	  var field = $(obj).attr('id').split('-')[1];
	  var fieldSum = 0;
	  var total = 0;
	  $('#100').find('tr').each(function(){
	      
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
	  
	fieldSum = fieldSum.toFixed(2);
  	$('#hiddenPurposeTotalCost').attr('value',fieldSum);
  	$('#purposeTotalCost').html('金额('+fieldSum+')'); 
  	 $('#applyAmount').attr('value',fieldSum);
  	
  	//chargeTotalCostByPurpose(obj); 	
  }
  

  
  function changeSubjectTotalCost(obj){
  	  var field = $(obj).attr('id').split('-')[1];
	  var fieldSum = 0;
	  var total = 0;
	  $('#300').find('tr').each(function(){
	      
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
	  
		fieldSum = fieldSum.toFixed(2);
  		$('#hiddenSubjectTotalCost').attr('value',fieldSum);
  		$('#subjectTotalCost').html('金额('+fieldSum+')');  	
  }		
  	
  /*function chargeTotalCostByPurpose(obj){
	  var objValue = $(obj).attr('value');
	  var totalValue = $('#applyAmount').attr('value');
  	  var sum = parseFloat(objValue)+parseFloat(totalValue); 
  	  sum = sum.toFixed(2);
  	  $('#applyAmount').attr('value',sum);
  }*/
  
  function print(){
  	var stateCode = $('#applyStateCode').attr('value');
  	var expenseNo = $('#expenseNo').attr('value');
  	if(stateCode=="100"){
  		 
  		 if(handleThread!=0){
  			alert('后台数据还未处理完成，请稍后再打印！');
  			return;
  		}
  		 $('#printFlag').attr('value','1');
  		 save();
  		
  		 
  	}else{
  		var url = $('#webcontent').attr('value')+'/wagePaymentApply.do?action=getPrintData&expenseNo='+expenseNo;	
  		window.open(url,'工资付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');
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
 
 function validateSubjectBal(obj){
 	var costCenter = $('#branchCode').attr('value');
 	var acctCode = $(obj).attr('value');
 	var objID = $(obj).attr('id');
	var serial = objID.split('-')[0];
	var subjectBuggdetID = serial+'-subjectBudget';
	var subjectUsedID = serial+'-subjectUsedMoney';
	var money = serial+'-subjectAmout';
 	var xmlhttp;
 		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				var res = xmlhttp.responseText;
				var arrayRes = res.split(',');
				
				if(arrayRes[0]=='null'){
					//alert('后台未取到该科目预算，请联系IT运维！');
					$('#'+money).attr('value','');
					subjectMoneyIsRight = '2';
					handleThread--;
					waitDivHidden();
					changeSubjectTotalCost($('#'+money));
					return false;		
				}else{//+parseFloat($('#'+money).attr('value'))
					var appSubjectMoney = parseFloat($('#'+money).attr('value'));
					var arrayTr = $('#300 tr');
					for(var i=2;i<arrayTr.length;i++){
  					
  			 			if($(arrayTr[i]).find('input').eq(3).attr('id').split('-')[1]=='subjectAmout'){
  			 	 			if($(arrayTr[i]).find('input').eq(2).attr('value')==acctCode&&$(arrayTr[i]).find('input').eq(2).attr('id').split('-')[0]!=serial){
  			 	 				if($(arrayTr[i]).find('input').eq(3).attr('value')!=''){
  			 	 					appSubjectMoney = appSubjectMoney+parseFloat($(arrayTr[i]).find('input').eq(3).attr('value'));
  			 					}
  			 	 			}
  			 	 			
  			 			}
  			 			
  			 			else{
  			 				if($(arrayTr[i]).find('input').eq(3).attr('value')==acctCode&&$(arrayTr[i]).find('input').eq(3).attr('id').split('-')[0]!=serial){
  			 			 		if($(arrayTr[i]).find('input').eq(4).attr('value')!=''){
  									appSubjectMoney = appSubjectMoney+parseFloat($(arrayTr[i]).find('input').eq(4).attr('value'));
  			 					}
  			 				}
  			 			}
  			 
  			
  					}
					if( parseFloat(arrayRes[0])<parseFloat(arrayRes[1])+appSubjectMoney){
						//alert('所填科目金额超出该科目的可用预算金额');
						$('#'+money).attr('value','');
						$('#'+subjectBuggdetID).attr('value',parseFloat(arrayRes[0]).toFixed(2));
						$('#'+subjectUsedID).attr('value',parseFloat(arrayRes[1]).toFixed(2));
						subjectMoneyIsRight = '1';
						handleThread--;
						waitDivHidden();
						changeSubjectTotalCost($('#'+money));
						return false;		
					}
				}
				
				
				$('#'+subjectBuggdetID).attr('value',parseFloat(arrayRes[0]).toFixed(2));
				$('#'+subjectUsedID).attr('value',parseFloat(arrayRes[1]).toFixed(2));
				handleThread--;
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			//alert('网络错误，请重新提交');
    			$('#'+money).attr('value','');
    			subjectMoneyIsRight = '3';
    			handleThread--;
    			waitDivHidden();
    			changeSubjectTotalCost($('#'+money));
    			return false;
    		}
		
		}
		
		var code = $(obj).attr('value');
		var expenseNo = $('#expenseNo').attr('value');
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=getBudgetAndMoneyByAcctCode&costCenter="+costCenter+"&acctCode="+acctCode+"&expenseNo="+expenseNo);
		handleThread++;
 }
 
 function showBudgt(){
 	var costCenter = $('#branchCode').attr('value');
 	var expenseNo = $('#expenseNo').attr('value');
 	var url = $('#webcontent').attr('value')+'/budgetQuery.do?action=init&costCenter='+costCenter+"&expenseNo="+expenseNo;
 	window.open(url,'科目预算查询',"scrollbars=yes,width=800px,height=600px,resizable=yes,menubar=no,status=no,location=no") 
 }
 
</script>



<body onload="initForm()">
	
	<input type="hidden" id="isBranchFinance" value="<%=request.getAttribute("isBranchFinance") %>" >
	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
	<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
	<input type="hidden" id="hiddenPurposeTotalCost"  value="<%=request.getAttribute("WPPurposeTotalCost")%>">
	<input type="hidden" id="hiddenSubjectTotalCost" value="<%=request.getAttribute("WPSubjectTotalCost")%>">
	<div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 3;display: none;">正在处理，请稍后......</div>
	<div id="mainDiv" style="width: 95%">
		
		
	
	
	<html:form action="/wagePaymentApply" styleId="wagePaymentApplyForm" method="post">
		<html:hidden styleId="applyStateCode" property="applyStateCode"/>
		<html:hidden styleId="action" property="action"/>
		<html:hidden styleId="expenseInfoID" property="expenseInfoID"/>
		<html:hidden  styleId="printFlag" property="printFlag"/>
		<html:hidden styleId="branchName" property="branchName"/>
		<div id="refuseReasonDiv"  style="position:absolute; display: none;background-color: #F3F4F3;height: 500;width:100%;overflow: auto;border-color: gray;border-style: solid;border: 2;z-index: 2; text-align: center;">
				<font color="red">*</font>驳回理由：<br/>
				<html:textarea styleId="refuseReason" property="refuseReason" cols="80" rows="5"></html:textarea><br />
				<input type="button" onclick="refuse()" value="确定" style="width:60" >&nbsp;&nbsp;<input type="button" onclick="hiddenRefuseReason()" value="取消" style="width:60"> 
		</div>
	
	
	
	<div>
			
			
			<%UserInfo userinfo = (UserInfo)request.getSession().getAttribute("user_info") ;
			
			%>
			<input type="button" value="保存" onclick="save()" class="btn_save" onmouseover="this.className='btn_save_on'" onmouseout="this.className='btn_save'"  >
			 &nbsp;&nbsp;
			<%if(ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())){ %>
			<input type="button" value="提交" onclick="do_submit()" class="btn_submit" onmouseover="this.className='btn_submit_on'" onmouseout="this.className='btn_submit'" >
			<%} else{%>
				<input type="button" value="审核" onclick="do_submit()" class="btn_submit" onmouseover="this.className='btn_submit_on'" onmouseout="this.className='btn_submit'" >
			
			<%} %><%if(!ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())){ %>
			&nbsp;&nbsp;
			<input type="button" value="驳回" onclick="showRefuseReason()" class="btn_back" onmouseover="this.className='btn_back_on'" onmouseout="this.className='btn_back'" >
			<%} %>
			
			&nbsp;&nbsp;
			<button onclick="print()" class="btn_print" onmouseover="this.className='btn_print_on'" onmouseout="this.className='btn_print'" >打印</button>
			&nbsp;&nbsp;
			<button onclick="viewRefuseReCord()" class="btn_refuse" onmouseover="this.className='btn_refuse_on'" onmouseout="this.className='btn_refuse'" >驳回记录</button>
			
			
			</div>
			
		<br />
		<%if("1".equals(request.getAttribute("showRefuseReason"))){ %>
			<div>
				<font color="red" size="2">驳回原因： <%=request.getAttribute("refuseReason") %></font> 
			</div>
		
		<% }%>
		
		<div
			style="position: relative; display: inline-block; width: 100%; height: 72px;">
			<img alt="" src="<%=path %>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">分公司工资付款申请单：</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field" width="16%">
						单据状态：
					</td>
					<td class="td_text" width="32%" colspan="2">
						<html:text styleId="applyStateName" property="applyStateName" styleClass="text_read_red"></html:text>
					</td>

					<td class="td_field" width="16%">
						单号：
					</td>
					
					<td class="td_text" width="32%" colspan="2">						
						<html:text styleId="expenseNo" property="expenseNo" styleClass="text_read_red"></html:text>					
					</td>

				</tr>
				
				<tr >
					<td class="td_field" width="16%">
						分公司代码：
					</td>
					<td class="td_text" width="16%">
							<html:select styleId="branchCode" property="branchCode" onchange="changeBranchCode()" style="width:95%">
								<html:optionsCollection name="branchList" value="value" label="lable"/>
						</html:select>	
				
					</td>
					
				<!-- 	<td class="td_field" width="16.5%">
						分公司名称：
					</td>
					<td class="td_text" width="16.5%">
						<html:text styleId="branchName" property="branchName" styleClass="text_read_common"></html:text>
				
					</td> -->
					
					<td class="td_field" width="16%">
						<font color="red">*</font>员工编号：
					</td>
					<td class="td_text" width="16%">
						<html:text styleId="applyUserID" property="applyUserID" styleClass="text_write_common"></html:text>	
					</td>
					
					<td class="td_field" width="16%">
						<font color="red">*</font>申请人：
					</td>
					<td class="td_text" width="16%">
						<html:text styleId="applyUserName" property="applyUserName" styleClass="text_write_common"></html:text>	
					</td>
					
				</tr>
				
				<tr >
					<td class="td_field" width="16%">
						电话号码：
					</td>
					<td class="td_text" width="16%">
						<html:text property="telephone" styleClass="text_write_common"></html:text>
							
					</td>
					<td class="td_field" width="16%">
						移动电话号码：
					</td>
					<td class="td_text" width="16%">
						<html:text property="mobilephone" styleClass="text_write_common"></html:text>
					</td>
					<td class="td_field" width="16%">
						<font color="red">*</font>登记日期：
					</td>
					<td class="td_text" width="16%">						
						<html:text styleId="applyDate"  property="applyDate"  styleClass="text_read_common" readonly="true"></html:text>
					</td>
					
					
				
				</tr>


			</table>

		</div>



		<div
			style="position: relative; display: inline-block; width: 100%; height: 40px;">
			<img alt="" src="<%=path %>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">费用信息：</font>
			<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field" width="16.5%">
						<font color="red">*</font>银行帐号
					</td>
					
					<td class="td_text" colspan="3">
						<html:text styleId="paymentComment" property="paymentComment" styleClass="text_write_common" onchange="validateBankCode()"></html:text>
					</td>
					
				

					<td class="td_field" width="16.5%">
						<font color="red">*</font>发票寄回日期：
					</td>
					<td class="td_text" width="16.5%">
						<html:text styleId="sendInvoiceDate" property="sendInvoiceDate" onclick="setday(this)" readonly="true" styleClass="text_write_common"></html:text>
					</td>


				</tr>
				<tr>

					<td class="td_field" width="16.5%">
						<font color="red">*</font>金额：
					</td>
					<td class="td_text" width="16.5%">
						￥<html:text styleId="applyAmount" property="applyAmount" styleClass="text_read_common"></html:text>
						
					</td>

					<td class="td_field" width="16.5%">
						预算总额：
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="budget" styleClass="text_read_common"></html:text>
					</td>

					<td class="td_field" width="16.5%">
					&nbsp;&nbsp;已用费用： 
					</td>
					<td class="td_text" width="16.5%">
						<html:text property="usedAmount" styleClass="text_read_common"></html:text>
					</td>

				</tr>
				
			</table>

		</div>
		
		</html:form>

		<br />
		
		<div id="topDiv">
		<div>
			<input type="button"  class="btn_add" onmouseover="this.className='btn_add_on'" onmouseout="this.className='btn_add'" value="添加"
				align="left" onclick="addExpense('0','100')">
			<input type="button" class="btn_delete" onmouseover="this.className='btn_delete_on'" onmouseout="this.className='btn_delete'"  value="删除"
				align="right" onclick="deleteExpense('2','100')">
			<table id='100' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field_title" width="4%">
					</td>

					<td class="td_field_title" width="66%">
						费用用途
					</td>



					<td class="td_field_title" width="15%" id="purposeTotalCost">
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("WPPurposeTotalCost"))%>)
					</td>

					<td class="td_field_title" width="15%">
						使用日期
					</td>

				</tr>
				
				<tr id="1000-tr" style="display: none">
					<td style="display: none"><input name="SN" id="1000-SN" value="-1"> </td>
					<td class="td_text_center" align="center">
						<input type="checkbox" id="1000" value="1000" >
					</td>
					<td class="td_text_center">
						<textarea id="1000-expensePurpose" name="费用用途" rows="1" class="text_write_common"  cols="120" onchange="modifyExpense('1',this,'费用用途')"></textarea>
					</td>

					<td class="td_text_center">
						<input id="1000-expenseAmout" name="金额" type="text" class="text_write_common"  onchange="if(modifyExpenseNumber('1',this,'金额')){changePurposeTotalCost(this);}">
					</td>

					<td class="td_text_center">
						<input id="1000-expenseDate" name="使用日期" type="text" class="text_write_common"  onclick="setday(this)" readonly="readonly" onpropertychange="modifyExpense('1',this,'使用日期')">
					</td>
				</tr>
				
				<%List purposeCostList = (List)request.getAttribute("WPPurposeCostList");
				 int SN = 0;
				 int purposeCostListSize = 0;
				 if(purposeCostList!=null){
				 	 purposeCostListSize = purposeCostList.size();
				 }
				
				 for (int i = 0; i < purposeCostListSize; i++) {
				     	WagePaymentPurposeCost purposeCost =(WagePaymentPurposeCost) purposeCostList.get(i);
						if(purposeCost.getSN()!=null && !purposeCost.getSN().equals("")){
							SN = Integer.parseInt(purposeCost.getSN());
						}else{
							SN++;
						}
				%>
				<tr id="<%=1101+i%>-tr" >
					<td style="display: none"><input name="SN" id="<%=1101+i%>-SN" value="<%=SN%>"> </td>
					<td class="td_text_center" align="center">
						<input type="checkbox" id="<%=1101+i%>" value="<%=1101+i%>">
					</td>
					
					<td class="td_text_center">
						<textarea id="<%=1101+i %>-expensePurpose" name="费用用途" class="text_write_common"   rows="1"  onchange="modifyExpense('1',this,'费用用途')"><%=purposeCost.getExpensePurpose()%> </textarea>
					</td>
					
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseAmout" name="金额" type="text" class="text_write_common"  value="<%=NumberUtil.formatFloatDecimal(2,purposeCost.getExpenseAmout())%>" onchange="if(modifyExpenseNumber('1',this,'金额')){changePurposeTotalCost(this);}">
					</td>
					
					<td class="td_text_center">
						<input id="<%=1101+i%>-expenseDate" name="使用日期" type="text" class="text_write_common"  value="<%=purposeCost.getExpenseDate() %>" onclick="setday(this)" readonly="readonly"  onpropertychange="modifyExpense('1',this,'使用日期')">
					</td>
					
					
					
					
				</tr>
				
				<%} %>
				
				
				<%if(request.getAttribute("isInit")!=null && request.getAttribute("isInit").equals("1")) {%>
				
				<tr id="1001-tr">
					<td style="display: none"><input name="SN" id="1001-SN" value="<%=++SN%>"> </td>
					<td class="td_text_center" align="center">
						<input type="checkbox" id="1001" value="1001" >
					</td>
					<td class="td_text_center">
						<textarea id="1001-expensePurpose" name="费用用途" rows="1" class="text_write_common"  cols="120" onchange="modifyExpense('1',this,'费用用途')"></textarea>
					</td>

					<td class="td_text_center">
						<input id="1001-expenseAmout" name="金额" type="text" class="text_write_common"  onchange="if(modifyExpenseNumber('1',this,'金额')){changePurposeTotalCost(this);}">
					</td>

					<td class="td_text_center">
						<input id="1001-expenseDate" name="使用日期" type="text" class="text_write_common"  onclick="setday(this)" readonly="readonly" onpropertychange="modifyExpense('1',this,'使用日期')">
					</td>
				</tr>
				<%} %>
			</table>
		</div>


	


		<br />
		<div>
			<input type="button"  class="btn_add" onmouseover="this.className='btn_add_on'" onmouseout="this.className='btn_add'" value="添加"
				align="left" onclick="addExpense('0','300')">
			<input type="button" class="btn_delete" onmouseover="this.className='btn_delete_on'" onmouseout="this.className='btn_delete'"  value="删除"
				align="right" onclick="deleteExpense('2','300')">
			<input type="button" class="btn_delete" onmouseover="this.className='btn_delete_on'" onmouseout="this.className='btn_delete'" value="预算"
				align="right" onclick="showBudgt()">
			<table id='300' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
				<tr>
					<td class="td_field_title" width="4%">
					</td>

					<td class="td_field_title" width="19.2%">
						大类
					</td>
					<td class="td_field_title" width="12.2%">
						所属科目
					</td>
					<td class="td_field_title" width="10.2%">
						科目代码
					</td>
					<td id="subjectTotalCost" class="td_field_title" width="12.2%">
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("WPSubjectTotalCost"))%>)
					</td>
					<td class="td_field_title" width="19.2%">
						备注
					</td>
					
					
					<td class="td_field_title" width="12%">
						科目预算金额
					</td>
					<td class="td_field_title" width="12%">
						科目已用金额
					</td>
				</tr>
				
				<tr id="3000-tr" style="display: none">
					<td style="display: none"><input name="SN"  id="3000-SN" value="-1"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="3000" value="3000">
					</td>

					<td class="td_text_center">
						<select id="3000-categoryCode" name="大类" class="text_write_common"  onchange="getaccountList(this,'大类');modifyExpense('1',this,'大类');" style="width: 100%">
							
							<%List categoryList = (List)request.getAttribute("categoryList");  
								 int categoryListSize = 0;
							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
							%>
							
								<option value="<%=selectOptionObj.getValue() %>"><%=selectOptionObj.getLable()%></option>
							
							<%} %>
						</select>	
					
					</td>

					<td class="td_text_center">
						
						<select  id="3000-subjectCode" name="所属科目"  class="text_write_common"  onchange="getAccountCode(this);" >
							</select>
					</td>



					<td class="td_text_center">
						<input id="3000-accountCode" name="科目代码" type="text"  class="text_write_common" readonly="readonly" onpropertychange="modifyExpense('1',this,'科目代码');">
					</td>

					<td class="td_text_center">
						<input id="3000-subjectAmout" name="金额" type="text" class="text_write_common" onchange="if(modifyExpenseNumber('1',this,'金额')){changeSubjectTotalCost(this);}">
					</td>

					<td class="td_text_center">
						<input id="3000-comment" name="备注" type="text" class="text_write_common" onchange="modifyExpense('1',this,'备注');">
					</td>
					
					<td class="td_text_center">
						<input id="3000-subjectBudget"  type="text" class="text_read_common" >
					</td>

					<td class="td_text_center">
						<input id="3000-subjectUsedMoney"  type="text" class="text_read_common" >
					</td>
				
				</tr>
				
				<%List subjectCostList = (List)request.getAttribute("WPSubjectCostList");
				  SN = 0;	
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	WagePaymentSubjectCost subjectCost =(WagePaymentSubjectCost) subjectCostList.get(i);
						if(subjectCost.getSN()!=null && !subjectCost.getSN().equals("")){
							SN = Integer.parseInt(subjectCost.getSN());
						}else{
							SN++;
						}
				%>
				<tr id="<%=3101+i%>-tr">
					<td style="display: none"><input name="SN" id="<%=3101+i%>-SN" value="<%=SN%>"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="<%=3101+i%>" id="<%=3101+i%>">
					</td>

					<td class="td_text_center">
						<select id="<%=3101+i%>-categoryCode" name="大类" class="text_write_common"  onchange="getaccountList(this,'大类');modifyExpense('1',this,'大类');" style="width: 100%">
							
							<%
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
						<input id="<%=3101+i%>-accountName"  type="text" class="text_write_common" readonly="readonly" value="<%=subjectCost.getAccountName() %>" onclick="getaccountListBySuper(this)">
					
					</td>
					
					<td id="<%=3101+i%>-subjectCodeTD" class="td_text_center_nodisplay">
						
						<select  id="<%=3101+i%>-subjectCode" class="text_write_common"  name="所属科目" onchange="getAccountCode(this);" >
							</select>
					</td>



					<td class="td_text_center">
						<input id="<%=3101+i%>-accountCode" type="text"  class="text_write_common" name="科目代码" readonly="readonly" onpropertychange="modifyExpense('1',this,'科目代码');" value="<%=subjectCost.getAccountCode() %> ">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectAmout" type="text" class="text_write_common" name="金额" onchange="if(modifyExpenseNumber('1',this,'金额')){changeSubjectTotalCost(this);}" value="<%=NumberUtil.formatFloatDecimal(2,subjectCost.getSubjectAmout())%>">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-comment" type="text" class="text_write_common" name="备注" onchange="modifyExpense('1',this,'备注');" value="<%=subjectCost.getComment()%>">
					</td>
					
					 <td class="td_text_center">
						<input id="<%=3101+i%>-subjectBudget"  type="text" class="text_read_common" >
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectUsedMoney"  type="text" class="text_read_common" >
					</td>
				
				
				</tr>
				
				<%} %>
				
				
				<%if(request.getAttribute("isInit")!=null && request.getAttribute("isInit").equals("1")) {%>
				
				
				<tr id="3001-tr">
					<td style="display: none"><input name="SN"  id="3001-SN" value="<%=++SN%>"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="3001" value="3001">
					</td>

					<td class="td_text_center">
						<select id="3001-categoryCode" name="大类" class="text_write_common"  onchange="getaccountList(this,'大类');modifyExpense('1',this,'大类');" style="width: 100%">
							
							<%
							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
							%>
							
								<option value="<%=selectOptionObj.getValue() %>"><%=selectOptionObj.getLable()%></option>
							
							<%} %>
						</select>	
					
					</td>

					<td class="td_text_center">
						
						<select  id="3001-subjectCode" name="所属科目"  class="text_write_common"  onchange="getAccountCode(this);" >
							</select>
					</td>



					<td class="td_text_center">
						<input id="3001-accountCode" name="科目代码" type="text"  class="text_write_common" readonly="readonly" onpropertychange="modifyExpense('1',this,'科目代码');">
					</td>

					<td class="td_text_center">
						<input id="3001-subjectAmout" name="金额" type="text" class="text_write_common" onchange="if(modifyExpenseNumber('1',this,'金额')){changeSubjectTotalCost(this);}">
					</td>

					<td class="td_text_center">
						<input id="3001-comment" name="备注" type="text" class="text_write_common" onchange="modifyExpense('1',this,'备注');">
					</td>
					
					 <td class="td_text_center">
						<input id="3001-subjectBudget"  type="text" class="text_read_common" >
					</td>

					<td class="td_text_center">
						<input id="3001-subjectUsedMoney"  type="text" class="text_read_common" >
					</td>
				</tr>
				<%} %>
			</table>
		</div>
	
		
		</div>
		</div>
	</body>
</html>
