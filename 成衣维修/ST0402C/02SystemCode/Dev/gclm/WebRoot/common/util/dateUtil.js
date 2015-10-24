 
 
/***********************************************************************
  * 判断一个字符串是否为合法的日期格式：YYYY-MM-DD HH:MM:SS
  * 或 YYYY-MM-DD 或 HH:MM:SS
  *  参数：ds 
  *  返回值：Boolean类型
  *  DLY
  *  2013-04-18
  */
 function dateUtil_isDateStr(ds){
   switch(parts.length){
     case 2:
       if(isDatePart( parts[0] ) == true && isTimePart( parts[1] )){
         return true;
       }else{
         return false;
       }
     case 1:
       aPart = parts[0];
       if(aPart.indexOf(':') > 0 ){
         return isTimePart(aPart);
       }else{
         return isDatePart(aPart);
       }
     default:
       return false;
   }
} 

/***********************************************************************
  * 判断一个字符串是否为合法的日期格式：YYYY-MM-DD or YYYY/MM/DD 
  *  参数：dateStr:日期字符串
  *  参数：ssplit:间隔符（- or /）
  *  返回值：Boolean类型
  *  DLY
  *  2013-04-18
  */
 function dateUtil_isDatePart(dateStr,ssplit){  
	 var parts;   
	 if(dateStr.length != 10){
		 //alert('字符串长度不足10');
		 return false;
	 }
	 if(dateStr.indexOf(ssplit) > -1){
		 parts = dateStr.split(ssplit);
	 }else{
		 //alert('字符串未找到分隔符');
		 return false;
	 }
     
	 if(parts.length < 3){
		 //日期部分不允许缺少年、月、日中的任何一项
		 // alert('日期部分不允许缺少年、月、日中的任何一项');
		 return false;
	 }
    
	 for(i = 0 ;i < 3; i ++){
		 //如果构成日期的某个部分不是数字，则返回false
		 // alert('构成日期的某个部分不是数字');
		 if(isNaN(parts[i])){
			 return false;
		 }
	 } 
	var y = parts[0]*1;//年
	var m = parts[1]*1;//月
	var d = parts[2]*1;//日 
	
	 if(y > 3000){
		 return false;
	 } 
	 if(m < 1 || m > 12){
		 return false;
	 } 
	 if(d < 1 || d > 31){
	     return false;
	 }   
	 switch(d){
	     case 29:
	       if(m == 2){
	         //如果是2月份
	         if( (y / 100) * 100 == y && (y / 400) * 400 != y){
	           //如果年份能被100整除但不能被400整除 (即闰年)
	         }else{
	           return false;
	         }
	       }
	       break;
	     case 30:
	       if(m == 2){
	       //2月没有30日
	         return false;
	       }
	       break;
	     case 31: 
	       if(m == 2 || m == 4 || m == 6 || m == 9 || m == 11){
	       //2、4、6、9、11月没有31日
	         return false;
	       }
	       break;
	     default: 
	 }  
	 return true;
} 

 
/***********************************************************************
  * 判断一个字符串是否为合法的时间格式：HH:MM:SS
  *  参数：timeStr 
  *  返回值：Boolean类型
  *  DLY
  *  2013-04-18
  */
 function dateUtil_isTimePart(timeStr){
   var parts;
 
  parts = timeStr.split(':');
 
  if(parts.length < 2){
   //日期部分不允许缺少小时、分钟中的任何一项
     return false;
   }
 
  for(i = 0 ;i < parts.length; i ++){
   //如果构成时间的某个部分不是数字，则返回false
     if(isNaN(parts[i])){
       return false;
 
     }
 
     h = parts[0];//年
     m = parts[1];//月
 
     if( h < 0 || h > 23){
    	 //限制小时的范围
    	 return false;
     }
     if( m < 0 || m > 59){
    	 //限制分钟的范围
    	 return false;
     }
 
     if(parts.length > 2){
    	 s = parts[2];//日
 
    	 if( s < 0 || s > 59){
    		 //限制秒的范围
    		 return false;
 
    	 }
 
    	 return true;
     }
  } 
}
 

 
 
 /***********************************************************************
  *  日期格式化：YYYY-MM-DD HH:MM:SS or YYYY/MM/DD HH:MM:SS
  *  参数：date：日期
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
 function dateUtil_dateFomaterA(date,ssplit)   
 {  
 	if(date){
 		 var y = date.getFullYear();  
 	     var m = date.getMonth()+1;  
 	     var d = date.getDate();     
 	     var h = date.getHours();  
 	     var M = date.getMinutes();  
 	     var s = date.getSeconds();  
 	     function formatNumber(value){  
 	    	 return (value < 10 ? '0' : '') + value;  
 	     } 
 	     
 	     return y+ssplit+formatNumber(m)+ssplit+formatNumber(d)+' '+ formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s);  
 	     
 	}  
 	 
 } 
 
 
 /***********************************************************************
  *  日期时间格式化：YYYY-MM-DD or YYYY/MM/DD
  *  参数：date：日期
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
 function dateUtil_dateFomaterB(date,ssplit)   
 {   
 	if(date){
 		 var y = date.getFullYear();  
 	     var m = date.getMonth()+1;  
 	     var d = date.getDate();     
 	     function formatNumber(value){  
 	    	 return (value < 10 ? '0' : '') + value;  
 	     }    
 	     //return y+'-'+m+'-'+d+' '+ formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s);  
 	     return y+ssplit+formatNumber(m)+ssplit+formatNumber(d); 
 	}  
 	 
 } 
 
 
 /***********************************************************************
  *  日期格式化：YYYY-MM-DD'T'HH:MM:SS.000+'Z' or YYYY/MM/DD'T'HH:MM:SS.000+'Z'
  *  参数：date：日期
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
 function dateUtil_dateFomaterC(date,ssplit)   
 {  
 	if(date){
 		 var y = date.getFullYear();  
 	     var m = date.getMonth()+1;  
 	     var d = date.getDate();     
 	     var h = date.getHours();  
 	     var M = date.getMinutes();  
 	     var s = date.getSeconds();   
 	     var ss = date.getMilliseconds();
 	     function formatNumber(value){  
 	    	 return (value < 10 ? '0' : '') + value;  
 	     }    
 	    function formatNumber1(value){  
	    	 if (value < 10) {
	    		return '00'+value;
	    	 } else if (value < 100) {
	    		return '0'+value;
	    	 } else {
	    		return value;
	    	 } 
	     } 
 	     return y+ssplit+formatNumber(m)+ssplit+formatNumber(d)+'T'+formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s)+'.'+formatNumber1(ss)+'+0800';  
 	     
 	}  
 	 
 } 
 
 /***********************************************************************
  *  日期格式化：YYYY-MM-DD'T'HH:MM:SS.000+'Z' or YYYY/MM/DD  HH:MM:SS
  *  参数：date：日期
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
 function dateUtil_dateFomaterD(date,ssplit)   
 {  
 	if(date){
 		 var y = date.getFullYear();  
 	     var m = date.getMonth()+1;  
 	     var d = date.getDate();     
 	     var h = date.getHours();  
 	     var M = date.getMinutes();  
 	     var s = date.getSeconds();   
 	     var ss = date.getMilliseconds();
 	     function formatNumber(value){  
 	    	 return (value < 10 ? '0' : '') + value;  
 	     }    
 	    function formatNumber1(value){  
	    	 if (value < 10) {
	    		return '00'+value;
	    	 } else if (value < 100) {
	    		return '0'+value;
	    	 } else {
	    		return value;
	    	 } 
	     } 
 	     return y+ssplit+formatNumber(m)+ssplit+formatNumber(d)+' '+formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s)+'.'+formatNumber1(ss);  
 	     
 	}  
 	 
 } 

 
 /***********************************************************************
  *  日期空间格式化：YYYY-MM-DD 
  *  参数：dateboxID   控件id
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
function dateUtil_griddateboxFomater()   {
	
}
 
 /***********************************************************************
  *  重定义editor的datebox，设置日期格式
  *  DLY
  *  2013-04-18
  */  
 $.extend($.fn.datagrid.defaults.editors, { 
 	datebox: {
 		//datebox就是你要自定义editor的名称
 		init: function(container, options){ 
 			var input = $('<input type="text" class="easyui-datebox"> ').appendTo(container); 
 			return input.datebox({ 
 				closeText:'关闭',  
 				formatter:function(date){  
 				   var y = date.getFullYear();  
 				   var m = date.getMonth()+1;  
 				   var d = date.getDate();  
 				   var h = date.getHours();  
 				   var M = date.getMinutes();  
 				   var s = date.getSeconds();  
 				   function formatNumber(value){  
 				    return (value < 10 ? '0' : '') + value;  
 				   }    
 				   //return y+'-'+m+'-'+d+' '+ formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s); 
 				   return y+'-'+formatNumber(m)+'-'+formatNumber(d);  
 				},  
 			    parser:function(s){  
 				    var t = Date.parse(s);  
 				   if (!isNaN(t)){  
 				    return new Date(t);  
 				   } else {  
 				    return new Date();  
 				   }  
 				}   
 			    
 			}); 
 		}, 
         destroy: function(target){
             $(target).datebox('destroy');
         },		
         getValue: function(target){
             return $(target).datebox('getValue');
         },
         setValue: function(target, value){
             $(target).datebox('setValue', value);
         },
         resize: function(target, width){
             $(target).datebox('resize', width);
         }
    } 
 });
 

 /***********************************************************************
  *  日期空间格式化：YYYY-MM-DD 
  *  参数：dateboxID   控件id
  *  参数：ssplit:间隔符（- or /）
  *  返回值：日期字符串
  *  DLY
  *  2013-04-18
  */ 
function dateUtil_dateboxFomater(dateboxID)   
{   
	 $('#'+dateboxID).datebox({  
	 	  closeText:'关闭',  
	 	  editable:false, 
	 	  formatter:function(date){  
	 	   var y = date.getFullYear();  
	 	   var m = date.getMonth()+1;  
	 	   var d = date.getDate();  
	 	   var h = date.getHours();  
	 	   var M = date.getMinutes();  
	 	   var s = date.getSeconds();  
	 	   function formatNumber(value){  
	 	    return (value < 10 ? '0' : '') + value;  
	 	   }    
	 	   return y+'-'+formatNumber(m)+'-'+formatNumber(d);  
	 	  },  
	 	  parser:function(s){  
	 	    var t = Date.parse(s);  
	 	   if (!isNaN(t)){  
	 	    return new Date(t);  
	 	   } else {  
	 	    return new Date();  
	 	   }  
	 	 } 
	 }); 
}


/***********************************************************************
 * 自定义确认框按钮
 */ 
$.extend($.messager.defaults,{  
    ok:"确定",  
    cancel:"取消"  
});



/***********************************************************************
 * EasyUI中datagrid的扩展,动态添加和删除按钮
 */
$.extend($.fn.datagrid.methods, {
	addToolbarItem : function (jq, items) {
		return jq.each(function () {
			var dpanel = $(this).datagrid('getPanel');
			var toolbar = dpanel.children("div.datagrid-toolbar");
			if (!toolbar.length) {
				toolbar = $("<div class=\"datagrid-toolbar\"><table cellspacing=\"0\" cellpadding=\"0\"><tr></tr></table></div>").prependTo(dpanel);
				$(this).datagrid('resize');
			}
			var tr = toolbar.find("tr");
			for (var i = 0; i < items.length; i++) {
				var btn = items[i];
				if (btn == "-") {
					$("<td><div class=\"datagrid-btn-separator\"></div></td>").appendTo(tr);
				} else {
					var td = $("<td></td>").appendTo(tr);
					var b = $("<a href=\"javascript:void(0)\"></a>").appendTo(td);
					b[0].onclick = eval(btn.handler || function () {});
					b.linkbutton($.extend({}, btn, {
							plain : true
						}));
				}
			}
		});
	},
	removeToolbarItem : function (jq, param) { 
		return jq.each(function () {
			var dpanel = $(this).datagrid('getPanel');
			var toolbar = dpanel.children("div.datagrid-toolbar");
			var cbtn = null;
			if (typeof param == "number") {
				cbtn = toolbar.find("td").eq(param).find('span.l-btn-text');
			} else if (typeof param == "string") {
				cbtn = toolbar.find("span.l-btn-text:contains('" + param + "')");
			}
			if (cbtn && cbtn.length > 0) { 
				cbtn.closest('td').remove();
				cbtn = null;
			}
		});
	},
	removeToolbarItem1 : function (jq, param) { 
		return jq.each(function () {
			var dpanel = $(this).datagrid('getPanel');
			var toolbar = dpanel.children("div.datagrid-toolbar");
			var cbtn = null;
			if (typeof param == "number") {
				cbtn = toolbar.find("td").eq(param).find('span.l-btn-text');
			} else if (typeof param == "string") {
				cbtn = toolbar.find("span.l-btn-text:contains('" + param + "')");
			}
			if (cbtn && cbtn.length > 0) {
				cbtn.closest('td').html(basedate_actSetNStr('&nbsp;',20)); 
				cbtn = null;
			}
		});
	}
});
 