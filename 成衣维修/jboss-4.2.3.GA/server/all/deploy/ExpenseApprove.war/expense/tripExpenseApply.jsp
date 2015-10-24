<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.util.NumberUtil"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseDetail"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseSubjectCost"%>
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
	 var subjectMoneyIsRight = '0'; 
	
	function getLastTextValue(obj){
		var textID = $(obj).attr('id');
		if(textID!=thisTextID){
			thisTextID = textID;
			thisTextValue = $(obj).attr('value');
		}
		
	}
	
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
		var SN= $('#'+objIDs[0]+"-SN").attr('value');
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
		xmlhttp.send("action=addTripExpenseDetail&modifyFlag="+modifyFlag+"&mapKey="+objIDs[0]+"&field="+objIDs[1]+"&fieldValue="+value+"&SN="+SN);
		handleThread++;
	}
	
	
	function modifyExpenseSubject(modifyFlag,obj,desc){
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
				//var moneyObj = $('#'+$(obj).attr('id').split('-')[0]+'-subjectAmout');
				changeAllCost(objIDs[0],objIDs[1],obj);
				//changeSubjectTotalCost(moneyObj);
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入'+desc);
    			$(obj).attr('value','');
    			handleThread--;
    			return;
    		}
    	}	
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=addTripExpense&modifyFlag="+modifyFlag+"&mapKey="+objIDs[0]+"&field="+objIDs[1]+"&fieldValue="+value);
		handleThread++;
	}
	
	
	
	
	
	function addExpense(modifyFlag,tableID){
		var xmlhttp;
		var arrayTr = $('#'+tableID+' tr');
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
		xmlhttp.send("action=addTripExpense&modifyFlag="+modifyFlag+"&mapKey="+newSerial+'&SN='+newSN);
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
							
							if(thisTrID.substring(0,1)=='2'){
								var thisValue = $('#'+thisTrID+'-expenseAmout').attr('value')
								var totalValue = $('#hiddenShopTotalCost').attr('value');	
								if(thisValue==null || thisValue==''){
  									thisValue = '0';
  								}
								var sum = parseFloat(totalValue)-parseFloat(thisValue);
								sum = sum.toFixed(2);
								$('#hiddenShopTotalCost').attr('value',sum);
  								$('#shopTotalCost').html('金额('+sum+')'); 
  								
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
			xmlhttp.send("action=addTripExpense&modifyFlag="+modifyFlag+"&mapKey="+mapKeyString);
			handleThread++;
	}
	
	
	function validateNumber(obj){
		var r1= /^\d+$/;
		if(!r1.test($(obj).attr('value'))){
			$(obj).attr('value','');
			
			alert("输入数值必须是不小于0的整数！");
			return;
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
  			if($(obj).attr('id').substr(0,1)=='3'||$(obj).attr('id').substr(0,1)=='2'){
  				modifyExpenseSubject(modifyFlag,obj,desc);
  			}else{
  				modifyExpense(modifyFlag,obj,desc);
  			}
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
  		
  		if($('#tripName').attr('value')==null || $('#tripName').attr('value')==''){
  			alert('出差人姓名不能为空！');
  			return false;
  		}
  		
  		if($('#employeeID').attr('value')==null || $('#employeeID').attr('value')==''){
  			alert('职员编码不能为空！');
  			return false;
  		}
  		if($('#payComment').attr('value')==null || $('#payComment').attr('value')==''){
  			alert('付款说明不能为空！');
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
  		
  		var totalMoney = $('#totalMoney').attr('value')
  		if(parseFloat(totalMoney)<=0){
  			alert('报销金额必须大于零！');
  			return false;
  		}
  		
  		var hiddenPurposeTotalCost = $('#totalMoney').attr('value');
  		var hiddenShopTotalCost = $('#hiddenShopTotalCost').attr('value');
  		if(parseFloat(hiddenPurposeTotalCost)<parseFloat(hiddenShopTotalCost)){
  			alert('总金额不能小于店铺总金额！');
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
 					
 					/**
 					if(id.substr(0,1)=='1'){
 						if(ids[1]=='fromAdress'||ids[1]=='fromDate'||ids[1]=='toAdress'||ids[1]=='toDate'){
 							totalel++;
 							value = $(this).attr('value');
 							if(value!=''&&value!=null){
 								fillel++;
 							}else{
 								fieldName = $(this).attr('name');
 							}
 						}
 					}*/
 					
 					if($(this).attr('type')!='checkbox'&&$(this).attr('name')!='SN'&&$(this).attr('id').split('-')[1]!='comment'&&$(this).attr('id').split('-')[1]!='accountName'
 					&&$(this).attr('id').split('-')[1]!='subjectBudget'&&$(this).attr('id').split('-')[1]!='subjectUsedMoney'&&$(this).attr('id').split('-')[1]!='KM'&&$(this).attr('id').split('-')[1]!='gasolineCost'
 					&&$(this).attr('id').split('-')[1]!='trainCost'&&$(this).attr('id').split('-')[1]!='taxiCost'&&$(this).attr('id').split('-')[1]!='airplaneCost'&&$(this).attr('id').split('-')[1]!='others'
 					&&$(this).attr('id').split('-')[1]!='hotelCost'&&$(this).attr('id').split('-')[1]!='meal_allowance_cost'
 					){
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
  	
  	function waitDivHidden(){
  		$('#waitDiv').hide();
  		$('#mainDiv').show();
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
  		
  		if($('#result').attr('value')=='4'){
  			alert('驳回成功');
  			window.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';
  		}
  		
  		if($('#result').attr('value')=='-1'){
  			alert('流程找不到下个环节，请联系IT部流程配置人员');
  			return;
  		}
  		
  		gasolineCost = $('#gasolineCost').attr('value');
		trainCost = $('#trainCost').attr('value');
		taxiCost = $('#taxiCost').attr('value');
		airplaneCost = $('#airplaneCost').attr('value');
		others = $('#others').attr('value');
		hotelCost = $('#hotelCost').attr('value');
		meal_allowance_cost = $('#meal_allowance_cost').attr('value');
  	
  	}
  	
  function changeAllCost(id,name,obj){
  	if(id.substring(0,1)=='2'&&name=='expenseAmout'){
  		changeShopTotalCost(obj);
  	}else if(id.substring(0,1)=='3'&&name=='subjectAmout'){
  		changeSubjectTotalCost(obj);
  		
  	}
  }
  	
   function changeShopTotalCost(obj){
	  	
	 var field = $(obj).attr('id').split('-')[1];
	 var fieldSum = 0;
	  var total = 0;
	  $('#200').find('tr').each(function(){
	      
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
	
	$('#hiddenShopTotalCost').attr('value',fieldSum);
  	$('#shopTotalCost').html('金额('+fieldSum+')'); 
	  	
	 /*	var objValue = $(obj).attr('value');
	  	var totalValue = $('#hiddenShopTotalCost').attr('value');
  		var sum = parseFloat(objValue)+parseFloat(totalValue); 
  		sum = sum.toFixed(2);
  		$('#hiddenShopTotalCost').attr('value',sum);
 		$('#shopTotalCost').html('奖励金额('+sum+')');  	*/
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
  		var url = $('#webcontent').attr('value')+'/tripExpenseApply.do?action=getPrintData&expenseNo='+expenseNo;	
  		window.open(url,'现金付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');
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
					
					if(parseFloat(arrayRes[0])<parseFloat(arrayRes[1])+appSubjectMoney){
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
 
 function getShopNameByCS(obj){
		var id=$(obj).attr('id');
		var key = id.split('-')[0]
		var xmlhttp;
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				var res = xmlhttp.responseText;
				if(res!=''){
					
					var shopName = $('#'+key+'-shopName');
					shopName.attr('value',res);
					modifyExpenseSubject('1',shopName,'店铺名');
				}
				handleThread--;
			}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入'+desc);
    			$(obj).attr('value','');
    			handleThread--;
    			
    		}
		
		}
		
		var code = $(obj).attr('value');
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=getShopName&costCenter="+code);
		handleThread++;
	}
 
 
 </script>

  <body onload="initForm()">
    <input type="hidden" id="isBranchFinance" value="<%=request.getAttribute("isBranchFinance") %>" >
    <input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
	<input type="hidden" id="webcontent" value="<%=request.getContextPath() %>">
	<input type="hidden" id="hiddenSubjectTotalCost" value="<%=request.getAttribute("BTESubjectTotalCost")%>">
	<input type="hidden" id="hiddenShopTotalCost" value="<%=request.getAttribute("s_shopTotalCost")%>">
	
	 <div id="waitDiv" style="position:absolute;top: 0;width: 100%;height: 100;z-index: 3;display: none;">正在处理，请稍后......</div>
    	<div id="mainDiv" style="width: 95%">
    	<html:form action="/tripExpenseApply" styleId="tripExpenseApplyForm" method="post">
    		<html:hidden styleId="applyStateCode" property="applyStateCode"/>
			<html:hidden styleId="action" property="action"/>
			<html:hidden styleId="expenseInfoID" property="expenseInfoID"/>
			<html:hidden styleId="expenseNo" property="expenseNo"/>
			<html:hidden  styleId="printFlag" property="printFlag"/>
    		
    		<div id="refuseReasonDiv"  style="position:absolute; display: none;background-color: #F3F4F3;height: 500;width:100%;overflow: auto;border-color: gray;border-style: solid;border: 2;z-index: 2; text-align: center;">
				<font color="red">*</font>驳回理由：<br/>
				<html:textarea styleId="refuseReason" property="refuseReason" cols="80" rows="5"></html:textarea><br />
				<input type="button" onclick="refuse()" value="确定" style="width:60" >&nbsp;&nbsp;<input type="button" onclick="hiddenRefuseReason()" value="取消" style="width:60"> 
			</div>
    		
    		
    		<div>
			
			
			<%UserInfo userinfo = (UserInfo)request.getSession().getAttribute("user_info") ;%>
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
    		
    	<div style="position: relative; display: inline-block; width: 100%; height: 72px;">
			<img alt="" src="<%=path%>/img/img1.JPG"
				style="position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20">
			<font size="2">分公司差旅费申请</font>
    		
    		
    		<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#AFC7D6">
    			<tr>
    				<td class="td_field" width="20%" >申请单状态：
    					
    				</td>
    				
    				<td class="td_field" width="20%" >
    					
    					<html:text property="applyStateName" styleId="applyStateName" styleClass="text_read_red"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%" >申请单号：
    					
    				</td>
    				<td class="td_field" colspan="2">
    					<html:text property="expenseNo" styleId="expenseNo" styleClass="text_read_red"></html:text>
    				</td>
    				
    				
    				
    			</tr>
    			
    			<tr>
    				<td class="td_field" width="20%">出差人姓名
    					<br />
    					<html:text property="tripName" styleId="tripName" styleClass="text_write_common"></html:text>
    				</td>
    				<td class="td_field" width="20%">职员编码
    					<br />
    					<html:text property="employeeID" styleId="employeeID" styleClass="text_write_common"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%">成本中心代码
    					<br />
    					 <html:select styleId="branchCode" property="branchCode" onchange="changeBranchCode()" style="width: 100%">
							<html:optionsCollection name="branchList" value="value"  label="lable"/>
						</html:select>	
    				
    				</td>
    				
    				<td class="td_field" width="20%">部门
    					<br />
    					<html:text  property="branchName" styleId="branchName" styleClass="text_read_common"></html:text>
    				</td>
    				
    				<td class="td_field" width="20%">电话
    					<br />
    					<html:text property="telephone" styleId="telephone" styleClass="text_write_common"></html:text>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="td_field" >出差地点
    					<br />
    					<html:textarea rows="1" property="tripAddress" styleId="tripAddress" styleClass="text_write_common"></html:textarea>
    				</td>
    				<td class="td_field">出差事由
    					<br />
    					<html:textarea rows="1" property="tripPurposes" styleId="tripPurposes" styleClass="text_write_common"></html:textarea>
    				</td>
    				<td class="td_field">随同人员
    					<br />
    					<html:textarea rows="1" property="tripMenber" styleId="tripMenber" styleClass="text_write_common"></html:textarea>
    				</td>
    				<td class="td_field">日期
    					<br />
    					<html:text property="applyDate" styleId="applyDate"  readonly="true" styleClass="text_read_common"></html:text>
    				</td>
    				
    				<td class="td_field">
    					发票寄回日期
    					<br />
    					<html:text styleId="invoiceBackDate" property="invoiceBackDate" onclick="setday(this)" readonly="true"  styleClass="text_write_common"></html:text>
    				</td>
    			
    			</tr>
    			
    			<tr>
    				<td class="td_field">
    					总金额<br />
    					￥<html:text  property="totalMoney" value="<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("tripCost"))%>" styleId="totalMoney" styleClass="text_read_common"></html:text>
    					
    				</td>
    				
    				<td class="td_field">
    					预算金额<br />
    					<html:text property="budget" styleId="budget" styleClass="text_read_common"></html:text>
    				</td>
    				
    				<td class="td_field">
    					已用金额<br />
    					<html:text property="usedAmount" styleId="usedAmount" styleClass="text_read_common"></html:text>
    				</td>
    				
    				
    				
    				<td colspan="1" class="td_field">
    					   附件<br /> <html:text styleId="attachments" property="attachments" style="background-color:white;width:60;	font-size: 12;" onchange="validateNumber(this)"></html:text>P/张		
    					
    				</td>
    				
    				<td class="td_field" >收款人
    					<br />
    					<html:text property="receiveName" styleId="receiveName" styleClass="text_write_common"></html:text>
    				</td>
    			
    			</tr>
    			
    			<tr>
    				<td class="td_field" colspan="5">付款说明
    					<br />
    					<html:textarea property="payComment" styleId="payComment"  styleClass="text_write_common"></html:textarea>
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
    			   int SN = 0;
    			   if(detailList != null){
    			   	   detailListSize =  detailList.size();
    			   }
    			   int beginIndex = 1100;
    			   for(int i=0;i<detailListSize;i++){
    			   	 TripExpenseDetail detail = (TripExpenseDetail) detailList.get(i);
    			   	 beginIndex++;
    			   	 if(detail.getSN()!=null && !"".equals(detail.getSN())){
    			   	 	SN = Integer.parseInt(detail.getSN());
    				 }else{
    				 	SN++;
    				 }
    			%>
    			<tr  id="<%=beginIndex%>">
    				<td style="display: none"><input name="SN" id="<%=beginIndex%>-SN" value="<%=SN%>"> </td>
    				
    				<td  class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"   name="起点起点" id="<%=beginIndex%>-fromAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'出发')" value="<%=detail.getFromAdress()%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期"  onclick="setday(this)" id="<%=beginIndex%>-fromDate" readonly="readonly" class="text_write_noborder_trip"  onpropertychange="modifyExpense('1',this,'日期')" value="<%=detail.getFromDate()%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="终点" id="<%=beginIndex%>-toAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'终点')" value="<%=detail.getToAdress()%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期" onclick="setday(this)" id="<%=beginIndex%>-toDate" readonly="readonly"  class="text_write_noborder_trip" onpropertychange="modifyExpense('1',this,'日期')" value="<%=detail.getToDate()%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="公里" id="<%=beginIndex%>-KM" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'公里')" value="<%=detail.getKM()==null?"":detail.getKM()%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="汽油费" id="<%=beginIndex%>-gasolineCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'汽油费')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getGasolineCost()==null?"":detail.getGasolineCost())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="火车票" id="<%=beginIndex%>-trainCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'火车票')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getTrainCost()==null?"":detail.getTrainCost())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text" name="出租车" id="<%=beginIndex%>-taxiCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'出租车')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getTaxiCost()==null?"":detail.getTaxiCost())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="飞机票" id="<%=beginIndex%>-airplaneCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'飞机票')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getAirplaneCost()==null?"":detail.getAirplaneCost())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="其他交通" id="<%=beginIndex%>-others" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'其他交通')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getOthers()==null?"":detail.getOthers())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="住宿费" id="<%=beginIndex%>-hotelCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'住宿费')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getHotelCost()==null?"":detail.getHotelCost())%>"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="餐费和补贴" id="<%=beginIndex%>-meal_allowance_cost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'餐费和补贴')" value="<%=NumberUtil.formatFloatDecimal(2,detail.getMeal_allowance_cost()==null?"":detail.getMeal_allowance_cost())%>"> </td>
    			</tr>
    			
    			<% }%>
    			
    			<% 
    			int loopLen = 10-detailListSize;
    		     beginIndex = 1000;
    			for(int i=0;i<loopLen;i++){ 
    				beginIndex++; 
    				SN++;
    			%>
    			
    			<tr id="<%=beginIndex%>">
    				<td style="display: none"><input name="SN" id="<%=beginIndex%>-SN" value="<%=SN%>"> </td>
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"   name="起点起点" id="<%=beginIndex%>-fromAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'出发')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期"  onclick="setday(this)" id="<%=beginIndex%>-fromDate" readonly="readonly" class="text_write_noborder_trip"  onpropertychange="modifyExpense('1',this,'日期')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="终点" id="<%=beginIndex%>-toAdress" class="text_write_noborder_trip" onchange="modifyExpense('1',this,'终点')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="日期" onclick="setday(this)" id="<%=beginIndex%>-toDate" readonly="readonly" class="text_write_noborder_trip" onpropertychange="modifyExpense('1',this,'日期')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="公里" id="<%=beginIndex%>-KM" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'公里')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="汽油费" id="<%=beginIndex%>-gasolineCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'汽油费')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="火车票" id="<%=beginIndex%>-trainCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'火车票')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text" name="出租车" id="<%=beginIndex%>-taxiCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'出租车')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="飞机票" id="<%=beginIndex%>-airplaneCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'飞机票')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="其他交通" id="<%=beginIndex%>-others" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'其他交通')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="住宿费" id="<%=beginIndex%>-hotelCost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'住宿费')"> </td>
    				
    				<td class="td_field"><input style="background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;" type="text"  name="餐费和补贴" id="<%=beginIndex%>-meal_allowance_cost" class="text_write_noborder_trip" onchange="modifyExpenseNumber('1',this,'餐费和补贴')" onkeydown="getLastTextValue(this)"> </td>
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
		
		
		<div >
			<input type="button"  value="添加" class="btn_add" onmouseover="this.className='btn_add_on'" onmouseout="this.className='btn_add'"
				align="left" onclick="addExpense('0','200')">
			<input type="button" class="btn_delete" onmouseover="this.className='btn_delete_on'" onmouseout="this.className='btn_delete'" value="删除"
				align="right" onclick="deleteExpense('2','200')">
			<font color="red" size="2"> 注：输入店铺成本中心后一般会自动获取到店铺名，如果没有获取到，请手工输入！</font>


			<table id='200' width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">

				<tr>
					<td class="td_field_title" width="4%">
					</td>

					<td class="td_field_title" width="24%">
						店铺成本中心
					</td>
					
					
					<td class="td_field_title" width="24%">
						店铺名
					</td>
					
					<td id="shopTotalCost" class="td_field_title" width="24%">
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_shopTotalCost"))%>)
					</td>

					<td class="td_field_title" width="24%">
						备注
					</td>
				</tr>
				<tr id="2000-tr" style="display: none">
					<td style="display: none"><input name="SN" id="2000-SN" value="-1"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="2000" value="2000">
					</td>
					
					<td class="td_text_center">
						<input id="2000-shopCostCenterCode" name="店铺成本中心" type="text" value="" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)">
					</td>
					
					<td class="td_text_center">
						<input id="2000-shopName" name="店铺名"  type="text" value="" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺名')">
					</td>
				


					<td class="td_text_center">
						<input id="2000-expenseAmout" name="金额"  type="text" value="" class="text_write_common" onchange="modifyExpenseNumber('1',this,'奖励金额')">
					</td>



					<td class="td_text_center">
						<input id="2001-comment" name="备注" type="text" 	class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注')">
					</td>
				</tr>
				
				<%List shopCostList = (List)request.getAttribute("shopCostList");
				 int shopCostListSize = 0;
				 SN=0;
				 if(shopCostList!=null){
				 	 shopCostListSize = shopCostList.size();
				 }
					
				 for (int i = 0; i < shopCostListSize; i++) {
				     	TripExpenseShopCost shopCost =(TripExpenseShopCost) shopCostList.get(i);
						if(shopCost.getSN()!=null && !shopCost.getSN().equals("")){
							SN = Integer.parseInt(shopCost.getSN());
						}else{
							SN++;
						}
				
				%>
				<tr id="<%=2101+i%>-tr">
					<td style="display: none"><input name="SN" id="<%=2101+i%>-SN" value="<%=SN%>"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="<%=2101+i%>" value="2001">
					</td>
					
					<td class="td_text_center">
						<input id="<%=2101+i%>-shopCostCenterCode" name="店铺成本中心" type="text" value="<%=shopCost.getShopCostCenterCode()%>" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)">
					</td>
					
					<td class="td_text_center">
						<input id="<%=2101+i%>-shopName" type="text" name="店铺名" value="<%=shopCost.getShopName()%>" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺名')">
					</td>
					


					<td class="td_text_center">
						<input id="<%=2101+i%>-expenseAmout" name="金额" type="text" value="<%=NumberUtil.formatFloatDecimal(2,(String)shopCost.getExpenseAmout())%>" class="text_write_common" onchange="modifyExpenseNumber('1',this,'奖励金额')">
					</td>



					<td class="td_text_center">
						<input id="<%=2101+i%>-comment" type="text" name="备注"  value="<%=shopCost.getComment()%>"	class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注')">
					</td>
				</tr>
				
				
				<%}%>
				
				<%if(request.getAttribute("isInit")!=null && request.getAttribute("isInit").equals("1")) {%>
				
				<tr id="2001-tr">
					<td style="display: none"><input name="SN" id="2001-SN" value="<%=++SN%>"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="2001" value="2001">
					</td>
					
					<td class="td_text_center">
						<input id="2001-shopCostCenterCode" name="店铺成本中心" type="text" value="" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)">
					</td>
					
					
					<td class="td_text_center">
						<input id="2001-shopName" name="店铺名"  type="text" value="" class="text_write_common" onchange="modifyExpenseSubject('1',this,'店铺名')">
					</td>
					

					<td class="td_text_center">
						<input id="2001-expenseAmout" name="金额"  type="text" value="" class="text_write_common" onchange="modifyExpenseNumber('1',this,'奖励金额')">
					</td>



					<td class="td_text_center">
						<input id="2001-comment" name="备注" type="text" 	class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注')">
					</td>
				</tr>
				<%} %>
			</table>

		</div>


		<br />
    		
    		<br />
		<div>
			<input type="button" class="btn_add" onmouseover="this.className='btn_add_on'" onmouseout="this.className='btn_add'" value="添加"
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
						金额(<%=NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("BTESubjectTotalCost"))%>)
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
					
					<td style="display: none"><input name="SN" id="3000-SN" value="-1"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="3000" value="3000">
					</td>

					<td class="td_text_center">
						<select id="3000-categoryCode" onchange="getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');" style="width: 100%">
							
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
						
						<select  id="3000-subjectCode"  onchange="getAccountCode(this);" style="width: 100%">
							</select>
					</td>



					<td class="td_text_center">
						<input id="3000-accountCode" name="科目代码" type="text" readonly="readonly" class="text_write_common" onpropertychange="modifyExpenseSubject('1',this,'科目代码');">
					</td>

					<td class="td_text_center">
						<input id="3000-subjectAmout" name="金额" type="text" class="text_write_common" onchange="modifyExpenseNumber('1',this,'科目金额')">
					</td>

					<td class="td_text_center">
						<input id="3000-comment" name="备注" type="text" class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注');">
					</td>
					
					<td class="td_text_center">
						<input id="3000-subjectBudget"  type="text" class="text_read_common" >
					</td>

					<td class="td_text_center">
						<input id="3000-subjectUsedMoney"  type="text" class="text_read_common" >
					</td>
				
				</tr>
				
				<%List subjectCostList = (List)request.getAttribute("BTESubjectCostList");
				 SN = 0;	
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	TripExpenseSubjectCost subjectCost =(TripExpenseSubjectCost) subjectCostList.get(i);
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
						<select id="<%=3101+i%>-categoryCode" onchange="getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');" style="width: 100%">
							
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
						<input id="<%=3101+i%>-accountName"  type="text" class="text_write_common" readonly="readonly" value="<%=subjectCost.getAccountName()%>" onclick="getaccountListBySuper(this)">
					
					</td>
					
					<td id="<%=3101+i%>-subjectCodeTD" class="td_text_center_nodisplay">
						
						<select  id="<%=3101+i%>-subjectCode"  onchange="getAccountCode(this);" style="width: 100%">
							</select>
					</td>



					<td class="td_text_center">
						<input id="<%=3101+i%>-accountCode" name="科目代码"  type="text" readonly="readonly" class="text_write_common" onpropertychange="modifyExpenseSubject('1',this,'科目代码');" value="<%=subjectCost.getAccountCode() %> ">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-subjectAmout" name="金额" type="text" class="text_write_common" onchange="modifyExpenseNumber('1',this,'科目金额')" value="<%=NumberUtil.formatFloatDecimal(2,(String)subjectCost.getSubjectAmout())%>">
					</td>

					<td class="td_text_center">
						<input id="<%=3101+i%>-comment" name="备注"  type="text" class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注');" value="<%=subjectCost.getComment()%>">
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
					
					<td style="display: none"><input name="SN" id="3001-SN" value="<%=++SN%>"> </td>
					<td class="td_text_center">
						<input type="checkbox" id="3001" value="3001">
					</td>

					<td class="td_text_center">
						<select id="3001-categoryCode" onchange="getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');" style="width: 100%">
							
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
						
						<select  id="3001-subjectCode"  onchange="getAccountCode(this);" style="width: 100%">
							</select>
					</td>



					<td class="td_text_center">
						<input id="3001-accountCode" name="科目代码" type="text" readonly="readonly" class="text_write_common" onpropertychange="modifyExpenseSubject('1',this,'科目代码');">
					</td>

					<td class="td_text_center">
						<input id="3001-subjectAmout" name="金额" type="text" class="text_write_common" onchange="modifyExpenseNumber('1',this,'科目金额')">
					</td>

					<td class="td_text_center">
						<input id="3001-comment" name="备注" type="text" class="text_write_common" onchange="modifyExpenseSubject('1',this,'备注');">
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
    	
  </body>
</html>
