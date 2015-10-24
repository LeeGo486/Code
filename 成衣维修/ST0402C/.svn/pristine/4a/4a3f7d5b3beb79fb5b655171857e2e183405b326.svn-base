/***********************************************************************
 *  获取操作人信息
 *  DLY
 *  2013-06-14
 */ 
function   basedate_getUserInfo()   { 
	var userInfo = ''; 
  	var curl = '/gclm/rest/login/getSessionUserAccount?s='+new Date().getTime();
  	userInfo = ajaxMethd(curl,'GET',false);
  	return userInfo;
}

/***********************************************************************
 *  统一字符串累加
 *  参数说明
 *       str 字符串
 *       n  个数
 *  DLY
 *  2013-05-17
 */ 
function   basedate_actSetNStr(str,n)   { 
	 var s= '';
	 for(var i=1;i<=n;i++){
		 s=s+str;
	 } 
	 return s;
}
 
/***********************************************************************
 *  获取url参数
 *  参数说明
 *       name  参数名
 *  DLY
 *  2013-05-27
 */ 
function basedate_getUrlParam(name)
{
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]); return "";
} 
 

 


 

  

/***********************************************************************
 *  ajax提交 - 会话过期校验
 *  ZKJ
 *  2013-08-14
 */ 
function ajaxMethd(url,type,async){
	//alert(url);
	var result1;
	$.ajax({
  	    url: url,
  	    type: type,
  	    async: async,
  	    dateType:'text',
  	    contentType:'application/json;charset=GBK', 
  	    success: function(result) { 
  	    	result1=eval("(" + result + ")"); 
  	    },
  		error:function(){
  			alert(url+"执行失败!");
  			result1 = 'error';
  		}
  	}); 
	//alert(result1);
	if(result1=='no session' ){
		alert("会话过期,请重新登陆!");
		top.location.href = '/gclm/cm/login.jsp';
		return result1;
		
	}
	return result1;
}
 


/***********************************************************************
 * 结果集会话过期校验
 *  DLY
 *  2013-08-16
 */ 
function   resultCheck(result)   { 
	if(result=='no session'){
	alert("会话过期,请重新登陆!");
	var cookloginurl = GetCookieloginurl();
	var userinfologinurl = parent.userinfo.loginurl;
	if(cookloginurl==undefined){
		top.location.href = '/Expense/expense/Login/'+userinfologinurl;
	}else if(userinfologinurl==undefined){
		top.location.href = '/Expense/expense/Login/'+cookloginurl;
	}
		return false;
	} 
}
  

/**
 * 获取基础类型选项
 * zkj
 * @returns {Array}
 */
function basedate_getJCSJ(type)   {
 	var protimesJCSJ = [];
 	var curl = '';
 	/*curl = '/gclm/rest/Typzb/queryTypes?type='
	 		+type
	 		+'&s='+new Date().getTime();*/
 	curl = '/gclm/rest/Tybmb/queryTypes?type='
 		+type
 		+'&s='+new Date().getTime();
 
 	protimesJCSJ = ajaxMethd(curl,'GET',false);
  	return protimesJCSJ;
}

/**
 * 获取基础数据
 * zkj
 * @returns {Array}
 */
function basedate_getJCSJinfo(type)   {
 	var protimesJCSJ = [];
 	var curl = '';
 	/*curl = '/gclm/rest/Typzb/queryEntities?type='
	 		+type
	 		+'&s='+new Date().getTime();*/
 	curl = '/gclm/rest/Tybmb/queryEntities?type='
 		+type
 		+'&s='+new Date().getTime();
 
 	protimesJCSJ = ajaxMethd(curl,'GET',false);
 	return protimesJCSJ;
} 



