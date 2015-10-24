/**
 * 获取预算金额
 * @param cbzx
 * @param year
 * @param month
 * @param accountCode
 */
function GetYSJE(type,cbzx,date,accountCode){
	if(type != '0') {
		return 0;
	}
	var YSJE="0.00";
	$.ajax({
 	    url:'/expenseServer/resteasy/ws/budget/GetYSJEService?cbzx='+cbzx+'&year='+(date.substring(0,4)-1)+
 	    '&month='+(date.substring(5,7))+'&accountCode='+accountCode+'&s='+new Date().getTime(),
 	    type: 'GET',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=utf-8', 
 	    success: function(result) {
 	    	YSJE =  result;
 	    	//alert(YSJE);
 	    }
 	}); 
	return YSJE;
}

/**
 * 获取已分配金额
 * @param cbzx
 * @param date
 * @param fAccAttr1
 * @param fAccAttr2
 */
function GetYFPJE(type,cbzx,date,fAccAttr1,fAccAttr2){
	if(type != '0') {
		return 0;
	}
	var YFPJE="0.00";
	$.ajax({
 	    url:'/expenseServer/resteasy/ws/budget/GetYFPJEService?cbzx='+cbzx+'&year='+date.substring(0,4)+'&fAccAttr1='+fAccAttr1+'&fAccAttr2='+fAccAttr2,
 	    type: 'GET',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=utf-8', 
 	    success: function(result) {
 	    	YFPJE = result;
 	    }
 	}); 
	return YFPJE;
}

/**
 * 获取已用金额
 * @param cbzx
 * @param date
 * @param fAccAttr1
 * @param fAccAttr2
 */
function GetYYJE(type,cbzx,date,fAccAttr1,fAccAttr2){
	if(type != '0') {
		return 0;
	}
	var YYJE = "0.00";
	$.ajax({
 	    url:'/expenseServer/resteasy/ws/budget/GetYYJEService?cbzx='+cbzx+'&year='+date.substring(0,4)+'&fAccAttr1='+fAccAttr1+'&fAccAttr2='+fAccAttr2,
 	    type: 'GET',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=utf-8', 
 	    success: function(result) {
 	    	YYJE =  result;
 	    }
 	}); 
	return YYJE;
}


function getComId(){
	var url = '/expenseServer/resteasy/login/getSessionUserAccount';
	$.ajax({
		url: url,
 	    type: 'GET',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=utf-8', 
 	    success: function(result) {
 	    		$('#ledger').combotree('setValue', result.comId);
 	    		}
 	    	}
 	    );
}
