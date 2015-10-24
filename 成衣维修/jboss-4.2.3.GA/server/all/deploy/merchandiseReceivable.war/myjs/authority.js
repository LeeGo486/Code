function validateMenuAccessAuthority(menuid,ssoSessionID){
	  var authority=false;
	 /* $.ajax({
	    type:"GET",
	    async:false,
	    dataType:'json',
	    url:"http://192.168.0.89:8001/CheckUserAuthorization.aspx?SessionID="+ssoSessionID+"&MenuID="+menuid,
	    //url:'http://www.163.com',
	    success:function(msg){
	    	alert(msg);
	    	if(msg=='OK'){
	    		authority = true;
	    	}else{
	    		alert("对不起，您没有权限执行该功能！");
	    	}
	    }
	  });
	  */
	  
	 /* $.ajax({  

		       type : "get",  

		       async:false,  

		       url : "http://192.168.0.89:8001/CheckUserAuthorization.aspx?SessionID="+ssoSessionID+"&MenuID="+menuid,  

		       dataType : "jsonp",  

		       jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数  

		       jsonpCallback:"success_jsonpCallback",//callback的function名称  

		       success : function(json){  

		           alert(json);  

		          // alert(json[0].name);  

		       },  

		       error:function(){  

		           alert('fail');  

		       }  

		   }); 

	 */
	  
	  $.ajaxSetup({ async: false });
	  
	  
	  $.getScript('http://192.168.0.89:8001/CheckUserAuthorization.aspx?SessionID='+ssoSessionID+'&MenuID=28'+menuid, function ()
              {
                  if (msg)
                  {
                      alert(msg);
                  }
              });
	  alert('222');
	  return authority;
}