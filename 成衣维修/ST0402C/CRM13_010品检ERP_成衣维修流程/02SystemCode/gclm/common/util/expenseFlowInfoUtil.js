
/**
 * 第一次发起流程
 * @param expenseFlowInfoJson
 * @returns
 */
function applyExpense(expenseFlowInfoJson){
	var expenseFlowInfoJson1; 
    $.ajax({
 	    url:'/expenseServer/resteasy/entity/ExpenseFlowInfo/applyExpense',
 	    data:expenseFlowInfoJson,
 	    type: 'POST',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	expenseFlowInfoJson1 = result;
 	    	//$('#ExpenseFlowInfoId').attr('value',result.id);
 	    	//result.comment='';//bug, json 数据
 	    	//$.messager.alert("提示result", jsonUtil_jsonToStr(result));
 	    	//approveExpense(jsonUtil_jsonToStr(result));
 	    },
 	    error:function(){
 	    	//alert('第一次发起流程error');
 	    	expenseFlowInfoJson.saveFlag=0;
 	    	expenseFlowInfoJson1 = expenseFlowInfoJson;
 	    }
 	});
	return expenseFlowInfoJson1;
}

/**
 * 提交/审批（申请单驳回后重新提交也是调用此流程）
 * @param expenseFlowInfoJson
 */
function approveExpense(expenseFlowInfoJson){
	var expenseFlowInfoJson1;
	$.ajax({
 	    url:'/expenseServer/resteasy/entity/ExpenseFlowInfo/approveExpense',
 	    data:expenseFlowInfoJson,
 	    type: 'POST',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	expenseFlowInfoJson1 = result;
 	    	//alert(jsonUtil_jsonToStr(result));
 	    	//$.messager.alert("提示", "提交成功！");
 	    },
 	    error:function(){
 	    	//alert('提交/审批error');
 	    	expenseFlowInfoJson.saveFlag=0;
 	    	expenseFlowInfoJson1 = expenseFlowInfoJson;
 	    }
 	}); 
	return expenseFlowInfoJson1;
}

/**
 * 驳回以及申请人终止
 * @param expenseFlowInfoJson
 */
function refuseExpense(expenseFlowInfoJson){
	var expenseFlowInfoJson1;
	$.ajax({
 	    url:'/expenseServer/resteasy/entity/ExpenseFlowInfo/refuseExpense',
 	    data:expenseFlowInfoJson,
 	    type: 'PUT',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	expenseFlowInfoJson1 = result;
 	    	//alert(jsonUtil_jsonToStr(result));
 	    },
 	    error:function(){
 	    	//alert('驳回以及申请人终止error');
 	    	expenseFlowInfoJson.saveFlag=0;
 	    	expenseFlowInfoJson1 = expenseFlowInfoJson;
 	    }
 	}); 
	return expenseFlowInfoJson1;
}

/**
 * 获取流程信息
 * @param id
 */
function getExpenseFlowInfoJsonById(id){
	var expenseFlowInfoJson;
	$.ajax({
 	    url:'/expenseServer/resteasy/entity/ExpenseFlowInfo/'+id,
 	    type: 'GET',
 	    async: false,//同步
 	    dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	expenseFlowInfoJson = result;
 	    },
 	    error:function(){
 	    	alert('获取流程信息error');
 	    }
 	}); 
	return expenseFlowInfoJson;
}

/**
 * 保存/更新 流程信息
 * @param expenseFlowInfoJson
 * @returns
 */
function saveExpense(expenseFlowInfoJson){
	var expenseFlowInfoJson1; 
	var expenseFlowInfoJson2 = jsonUtil_jsonToStr(expenseFlowInfoJson);
	alert(expenseFlowInfoJson2);
    $.ajax({
 	    url:'/expenseServer/resteasy/entity/ExpenseFlowInfo/'+expenseFlowInfoJson.id,
 	    data:expenseFlowInfoJson2,
 	    type: 'PUT',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	expenseFlowInfoJson1 = result;
 	    	//$('#ExpenseFlowInfoId').attr('value',result.id);
 	    	//result.comment='';//bug, json 数据
 	    	//$.messager.alert("提示result", jsonUtil_jsonToStr(result));
 	    	//approveExpense(jsonUtil_jsonToStr(result));
 	    },
 	    error:function(){
 	    	alert('保存/更新 流程信息error');
 	    }
 	});
	return expenseFlowInfoJson1;
}
