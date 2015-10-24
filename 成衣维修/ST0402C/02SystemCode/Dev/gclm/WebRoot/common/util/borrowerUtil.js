
/******************************************************
 * 获取K3凭证	借款初始化
 * liuwei	2013-05-18
 * @param branch
 * @param company
 * @param borrowerName
 */
function getVoucher(branch,costCenter,company,borrowerName){ 
	var K3result;
	if(company==null || company==""){
		//$.messager.alert('提示',"请选择所属公司!");
		$('input:radio[name="isTakeOut"]:eq(1)').attr("checked",'checked');
		return;
	}
	if(costCenter==null || costCenter==""){
		//$.messager.alert('提示',"请选择成本中心!");
		$('input:radio[name="isTakeOut"]:eq(1)').attr("checked",'checked');
		return;
	}
	if(borrowerName==null||borrowerName==""){
		//$.messager.alert('提示',"请选填写申请人");
		$('input:radio[name="isTakeOut"]:eq(1)').attr("checked",'checked');
		return;
	} 
	var url = "/expenseServer/resteasy/entity/voucher/borrowings/PubWS?branch="+branch+"&costCenter="+costCenter+"&company="+company+"&accountFlag=1&borrowerName="+borrowerName;
	//$.messager.alert('提示',url);
	$.ajax({
	    url: url,
	    type: 'GET',
	    async: false,
	    dateType:'json',
	    contentType:'application/json;charset=UTF-8',
	    success: function(result) {
	    	//alert(result);
	        if(result=='NODB'){
	        	$.messager.alert('提示',"获取借款金额失败!");
	        	return;
	        } 
	         K3result=10000;
	         
	        var totalAmount=$('#fTotalAmount').numberbox('getValue');
	        var JKDCJE = GetJKDCJEService(borrowerName,costCenter);
	        //alert(JKDCJE);
	        K3result = K3result*1 - JKDCJE*1;
	        //比较总金额和借款余额  然后去最小 赋值给 抵充借款 
	        Borrowing_inti(K3result,totalAmount); 
	        $('#jiekuanren').attr('value',borrowerName);
	    },
	    error: function(result) {
	    	$.messager.alert('提示',"获取借款信息失败！");
			$('input:radio[name="isTakeOut"]:eq(1)').attr("checked",'checked');
	    }
	    
	});	
}

/**
 * 获取本地抵充金额
 */
function GetJKDCJEService(empname,cbzx){
	var JKDCJE="0.00";
	$.ajax({
 	    url:'/expenseServer/resteasy/ws/budget/GetJKDCJEService?cbzx='+cbzx
 	    	+'&empname='+empname+'&s='+new Date().getTime(),
 	    type: 'GET',
 	    async: false,
 	    dateType:'json',
 	    contentType:'application/json;charset=utf-8', 
 	    success: function(result) {
 	    	JKDCJE =  result;
 	    }
 	}); 
	return JKDCJE;
}


/*********************************************
 * 借款抵扣  否   清空K3凭证信息
 */
function clearVoucher(){
	//$('#cashform2').form('clear');
	$('input:radio[name="isTakeOut"]:eq(1)').attr("checked",'checked');
	 $('#fTakeOutAmount').numberbox('setValue',0);
	 $('#fTakeOutAmount0').numberbox('setValue',0);//可见但不操作
	 $('#jine').numberbox('setValue',0);
	 $('#jiekuanyue').numberbox('setValue',0);
	 $('#jiekuanren').attr('value','');
	 $('#fFactAmount').numberbox('setValue',$('#fTotalAmount').numberbox('getValue'));
	 $('#fFactAmount0').numberbox('setValue',$('#fTotalAmount').numberbox('getValue'));//可见但不操作
	
}
/*****************************************
 * 	抵充借款初始化	比较总金额和借款余额然后取最小赋值给抵充借款
 *  2013-05-17
 *  liuwei 
 */
function Borrowing_inti(result,totalAmount){ 
	var takeOutAmount ;
	if(totalAmount==null||totalAmount==""){
		totalAmount=0.00;
	}
	if(result==null||result==""){
		result=0.00;
	}
	if(totalAmount==null||totalAmount==""){
		totalAmount=0.00;
	}
	
	
	if(result<=totalAmount){
		takeOutAmount = result;
	}else{
		takeOutAmount = totalAmount;
	}
	$('#fTakeOutAmount').numberbox('setValue',takeOutAmount);
	$('#fTakeOutAmount0').numberbox('setValue',takeOutAmount);//可见但不操作
	//借款余额   =  K3余额 - 抵扣借款
	$('#jiekuanyue').numberbox('setValue', 
			result*1-$('#fTakeOutAmount').numberbox('getValue')*1 
			);
	
	$('#jine').numberbox('setValue',result);
	//实际支付金额 = 总金额 - 抵扣借款
	var sjzfje = $('#fTotalAmount').numberbox('getValue')*1-$('#fTakeOutAmount').numberbox('getValue')*1;
	$('#fFactAmount').numberbox('setValue', sjzfje);
	$('#fFactAmount0').numberbox('setValue', sjzfje);//可见但不操作
}


/*************************************
 * 借款抵充  算出  借款余额 = K3余额-抵充金额 ；实际支付金额=总金额-抵充金额**
 *  liuwei	2013-05-17
 *  
 *  */
function Borrowing_deduction(value){
	if(($('#jine').numberbox('getValue') -value)<0||($('#fTotalAmount').numberbox('getValue') -value)<0){
		$.messager.alert('提示','抵充金额不能大于总金额和借款余额。');
		   $('#fTakeOutAmount').numberbox('setValue',0);
		   $('#fTakeOutAmount0').numberbox('setValue',0);//可见但不操作
		   value=0;
		  
	}
	$('#jiekuanyue').numberbox('setValue'
			,($('#jine').attr('value') -value)<=0?0:$('#jine').numberbox('getValue') -value); 
	
	 $('#fFactAmount').numberbox('setValue',($('#fTotalAmount').numberbox('getValue') -value)<=0?0:$('#fTotalAmount').numberbox('getValue') -value); 
	 $('#fFactAmount0').numberbox('setValue',($('#fTotalAmount').numberbox('getValue') -value)<=0?0:$('#fTotalAmount').numberbox('getValue') -value); //可见但不操作	
}


//去重复 Array.prototype.unique = 
function unique(array){
		array.sort();	//先排序
		var res = [array[0]];
		for(var i = 1; i < array.length; i++){
			if(array[i] !== res[res.length - 1]){
				res.push(array[i]);
			}
		}
		return res;
	};