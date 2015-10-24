   

/***********************************************************************
 *  任务记录拆分付款说明信息 
 *  DLY
 *  2013-08-17
 */ 
function fc_setTaskInfo(taskinfo){
	var obj = new Object();
	obj = taskinfo;
	obj.bankName = '';
	obj.bankAccount = '';
	obj.bankInstruction = '';
	obj.payTo = '';
	obj.paymentMode = '';
	obj.paymentBank = '';
	protimesBZ = basedate_getBZ(taskinfo.comId); 
	if(taskinfo.payInfo != undefined && taskinfo.payInfo != null && taskinfo.payInfo != '' ){ 
		var paylist = taskinfo.payInfo.split('|'); 
		obj.bankName = undefinedOrNull(paylist[0]);
		obj.bankAccount = undefinedOrNull(paylist[1]);
		obj.bankInstruction = decodeURIComponent(undefinedOrNull(paylist[2]));
		obj.payTo = undefinedOrNull(paylist[3]);
		obj.paymentMode = undefinedOrNull(paylist[4]);
		obj.paymentBank = undefinedOrNull(paylist[5]); 
		obj.currencyName = undefinedOrNull(paylist[6]);  
		for(var i=0; i<protimesBZ.length; i++){
			if(undefinedOrNull(paylist[6]) == protimesBZ[i].typeCode){
				obj.currencyName = protimesBZ[i].typeName;
				break;  
			}
		}  
		 
	} 
	return obj;
}
 

/***********************************************************************
 *  查看单据费用明细摘要 B帐
 *  DLY
 *  2013-09-02
 */ 
function   fc_getExpenseInfoB1(taskInfo)   {   
	var expenseinfo = ''; 
	var curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/BudgetList1/inPage?startPage=1&numPage=20'
		     + '&orderBy=lineID_asc&filter=billCode_S_'+taskInfo.billCode
		     +'_EQ__,billType_S_'+taskInfo.billType+'_EQ__'
		     +'&s='+new Date().getTime(); 
	 
    //alert(curl);   
	$.ajax({
	    url: curl,
	    type: 'GET',
	    async: false, 
	    dateType:'json',
	    contentType:'application/json;charset=UTF-8', 
	    success: function(result) { 
	    	resultCheck(result);  
	    	if(taskInfo.billType=='EA' || taskInfo.billType=='EAP'|| taskInfo.billType=='EAE'){
	    		for(var i=0; i<result.length; i++){    
		    		if(taskInfo.shareFlag == '1'){
		    			expenseinfo = expenseinfo + undefinedOrNull(result[i].costUse) +'——费用分摊';
		    			break;
		    		}else{
		    			expenseinfo = expenseinfo +  undefinedOrNull(result[i].costUse)+'  金额('
		    			+ undefinedOrNull(result[i].amount) + ')  ;  ';
		    		}
		    	} 
	    	}else if(taskInfo.billType=='EAC'){ //差旅费只取一条的费用用途
	    		for(var i=0; i<result.length; i++){    
	    			expenseinfo = expenseinfo +  undefinedOrNull(result[i].costUse);
		    		break;
		    	}  
	    	} 
    		
	    }
	});   
	return expenseinfo;
} 
 

/***********************************************************************
 *  查看单据费用明细摘要 A帐
 *  DLY
 *  2013-09-02
 */ 
function   fc_getExpenseInfoA1(taskInfo)   { 
	var expenseinfo = ''; 
	var curl = '';
	if(taskInfo.billType=='EA' || taskInfo.billType=='EAP'|| taskInfo.billType=='EAE'){
		curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/BillAccountList1/inPage?startPage=1&numPage=20'
		     + '&orderBy=lineID_asc&filter=billCode_S_'+taskInfo.billCode
		     +'_EQ__,billType_S_'+taskInfo.billType+'_EQ__'
		     +'&s='+new Date().getTime(); 
	}else if(taskInfo.billType=='EAC'){
		curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/TBillTravel/getBillInfo?billCode=' 
			 +taskInfo.billCode +'&s='+new Date().getTime();  
	} 
    //alert(curl);   
	$.ajax({
	    url: curl,
	    type: 'GET',
	    async: false, 
	    dateType:'json',
	    contentType:'application/json;charset=UTF-8', 
	    success: function(result) { 
	    	resultCheck(result);  
	    	if(taskInfo.billType=='EA' || taskInfo.billType=='EAP' || taskInfo.billType=='EAE'){
	    		for(var i=0; i<result.length; i++){
	    			expenseinfo = expenseinfo + undefinedOrNull(result[i].remark);
	    			if(taskInfo.shareFlag == '1'){
	    				expenseinfo = expenseinfo + '——费用分摊';
	    				break;
	    			}else{
	    				expenseinfo = expenseinfo +' 金额('
		    				+ undefinedOrNull(result[i].accountAmount) + ')';
	    			}
		    	}
	    	}else  if(taskInfo.billType=='EAC'){
	    		expenseinfo = expenseinfo + undefinedOrNull(result.tripPlace)
	    			+'  ' + undefinedOrNull(result.accompanyBy) 
	    			+'  ' + undefinedOrNull(decodeURIComponent(result.tripPurPoses));  
	    		if(taskInfo.shareFlag == '1'){
    				expenseinfo = expenseinfo + '——费用分摊';
    			}else{
    				expenseinfo = expenseinfo +' 金额('
	    				+ undefinedOrNull(result.tatolAmount) + ')  ; ';
    			}
	    	}  
	    }
	});   
	return expenseinfo;
} 


/***********************************************************************
 *  查看单据费用明细摘要 B帐
 *  DLY
 *  2013-08-20
 */ 
function   fc_getExpenseInfoB(billType,billCode)   {   
	var expenseinfo = ''; 
	var curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/BudgetList1/inPage?startPage=1&numPage=1'
		     + '&orderBy=lineID_asc&filter=billCode_S_'+billCode+'_EQ__,billType_S_'+billType+'_EQ__'
		     +'&s='+new Date().getTime(); 
	 
    //alert(curl);   
	$.ajax({
	    url: curl,
	    type: 'GET',
	    async: false, 
	    dateType:'json',
	    contentType:'application/json;charset=UTF-8', 
	    success: function(result) { 
	    	resultCheck(result);  
    		for(var i=0; i<result.length; i++){   
	    		expenseinfo = expenseinfo + undefinedOrNull(result[i].accAttr1)+' ('
	    			+ undefinedOrNull(result[i].costUse)+') 金额('
	    			+ undefinedOrNull(result[i].amount) + ') ;  ';
	    	} 
	    }
	});   
	return expenseinfo;
} 


/***********************************************************************
 *  查看单据费用明细摘要 A帐
 *  DLY
 *  2013-08-20
 */ 
function   fc_getExpenseInfo(billType,billCode)   {   
	var expenseinfo = ''; 
	var curl = '';
	if(billType=='EA' || billType=='EAP' || billType=='EAE'){
		curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/BillAccountList1/inPage?startPage=1&numPage=20'
		     + '&orderBy=lineID_asc&filter=billCode_S_'+billCode+'_EQ__,billType_S_'+billType+'_EQ__'
		     +'&s='+new Date().getTime(); 
	}else  if(billType=='EAC'){
		curl = '/'+basedate_getexpenseServer()+'/resteasy/entity/TBillTravel/getBillInfo?billCode=' 
			 +billCode +'&s='+new Date().getTime(); 
	} 
    //alert(curl);   
	$.ajax({
	    url: curl,
	    type: 'GET',
	    async: false, 
	    dateType:'json',
	    contentType:'application/json;charset=UTF-8', 
	    success: function(result) { 
	    	resultCheck(result); 
	    	if(billType=='EA' || billType=='EAP'){
	    		for(var i=0; i<result.length; i++){   
		    		expenseinfo = expenseinfo + undefinedOrNull(result[i].accAttr1)+' ('
		    			+ undefinedOrNull(result[i].remark)+') 金额('
		    			+ undefinedOrNull(result[i].accountAmount) + ') ;  ';
		    	}
	    	}else  if(billType=='EAC'){
	    		expenseinfo = expenseinfo + '地点(' + undefinedOrNull(result.tripPlace)
	    			+') 出差人(' + undefinedOrNull(result.accompanyBy) 
	    			+')  事由(' + undefinedOrNull(decodeURIComponent(result.tripPurPoses)) 
	    			+')  金额(' + undefinedOrNull(result.tatolAmount) + ')  ;  ';
	    	}  
	    }
	});   
	return expenseinfo;
} 
