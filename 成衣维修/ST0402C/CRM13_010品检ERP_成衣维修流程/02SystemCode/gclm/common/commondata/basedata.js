/***********************************************************************
 *  ��ȡ��������Ϣ
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
 *  ͳһ�ַ����ۼ�
 *  ����˵��
 *       str �ַ���
 *       n  ����
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
 *  ��ȡurl����
 *  ����˵��
 *       name  ������
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
 *  ajax�ύ - �Ự����У��
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
  			alert(url+"ִ��ʧ��!");
  			result1 = 'error';
  		}
  	}); 
	//alert(result1);
	if(result1=='no session' ){
		alert("�Ự����,�����µ�½!");
		top.location.href = '/gclm/cm/login.jsp';
		return result1;
		
	}
	return result1;
}
 


/***********************************************************************
 * ������Ự����У��
 *  DLY
 *  2013-08-16
 */ 
function   resultCheck(result)   { 
	if(result=='no session'){
	alert("�Ự����,�����µ�½!");
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
 * ��ȡ��������ѡ��
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
 * ��ȡ��������
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



