/***********************************************************************
  * json对象转字符串
  *  参数：jsonObject
  *  返回值：jsonStr
  *  DLY
  *  2013-04-22
  */ 
 function jsonUtil_jsonToStr(jsonObject)   
 {   
 	 var jsonStr = '';
 	 var arr = [];
 	 var fmt = function(s) {
         if (typeof s == 'object' && s != null)
         {
        	 return jsonUtil_jsonToStr(s);  //递归
         }
         //如果是数字或string
         return /^(string|number)$/.test(typeof s) ? "\"" + s + "\"" : s;
     };
     
     if(jsonObject.constructor === Array ){//数组

         for ( var i in jsonObject) {

             arr.push(fmt(jsonObject[i]));

         }

         jsonStr = '[' + arr.join(',') + ']';

      }
      else{//普通JSON对象
    	  for (var i in jsonObject) {
    	 		 arr.push("\"" + i + "\":" + fmt(jsonObject[i])); 
    	 	 } 
    	 	 jsonStr = '{' + arr.join(',') + '}'; 

      } 
      
 	  return jsonStr; 
 } 
 
 
 
 /***********************************************************************
  *  字符串转json对象
  *  参数：jsonStr
  *  返回值：jsonObj
  *  DLY
  *  2013-04-18
  */ 
 function jsonUtil_strToJson(jsonStr)   
 {  
     var jsonObj = null;
     eval('jsonObj={' + txt + '}');
     return jsonObj;
 	 
 } 
 
 
 /***********************************************************************
  * json对象转字符串
  *  参数：jsonObject
  *  返回值：jsonStr
  *  DLY
  *  2013-04-22
  */ 
 function jsonUtil_jsonToStr1(jsonObject)   
 {   
 	 var jsonStr = '';
 	 var arr = [];
 	 var fmt = function(s) {
         if (typeof s == 'object' && s != null)
         {
        	 return jsonUtil_jsonToStr1(s);  //递归
         }
         //如果是数字或string
         return /^(string|number)$/.test(typeof s) ? "\"" + s + "\"" : s;
     };
     
      //普通JSON对象
	  for (var i in jsonObject) {
	 		 arr.push("\"" + i + "\":" + fmt(jsonObject[i])); 
	 	 } 
	  
	  jsonStr = '{' + arr.join(',') + '}'; 

      
 	  return jsonStr; 
 } 
 
 
 /***********************************************************************
  * form对象转json字符串
  *  参数：form
  *  返回值：txt
  *  DLY
  *  2013-05-09
  */ 
 function jsonUtil_form2json(form) { 
     var txt = ''; 
     //input text
     $(form).find('input[type="text"]').each(function () {
        //alert($(this).attr('type')); 
        if ($(this).attr('name')) {
            // alert($(this).attr('name'));
            // alert($(this).attr('value'));
            txt += '"' + $(this).attr('name') + '":"' + serialize($(this).val()) + '",';
        } 
     });
     //input hidden
     $(form).find('input[type="hidden"]').each(function () {
         if ($(this).attr('name')) { 
             txt += '"' + $(this).attr('name') + '":"' + serialize($(this).val()) + '",';
         }
     });
      
     //input radio
     var rdnames = '';
     $(form).find('input[type="radio"]').each(function () {
         if (this.name) {
             if (this.checked) {
                 if (rdnames.toUpperCase().indexOf(this.name.toUpperCase()) >= 0) {
                     var reg = new RegExp('"' + this.name + '":' + '"(.+?)",', 'i');
                     txt = txt.replace(reg, '"' + this.name + '":' + '"' + this.value + '",');
                 } else {
                     rdnames += this.name + ',';
                     txt += '"' + this.name + '":"' + this.value + '",';
                 }
             }
         }
     }); 
      
     //input checkbox
	 var chknames='';
	 $(form).find('input[type="checkbox"]').each(function () {
		  if(this.name){
			   if(this.checked){
				    if(chknames.toUpperCase().indexOf(this.name.toUpperCase())>=0){
				     var reg=new RegExp('"'+this.name+'":'+'"(.+?)",','i');
				     txt=txt.replace(reg,'"'+this.name+'":'+'"$1,'+this.value+'",');
				    }else{
				     chknames+=this.name+',';
				     txt+='"'+this.name+'":"'+this.value+'",';
				    }
				}
		  }
	 });
      
	 //textArea
	 $(form).find('textArea').each(function () {
		  if($(this).attr('name')){ 
		      var value = encodeURIComponent($(this).val());
		      txt+='"'+$(this).attr('name')+'":"'+serialize(value)+'",';  
		  }
	 });
	 
	 //select
	 $(form).find('select').each(function () {
	  if($(this).attr('name')){
	      txt+='"'+$(this).attr('name')+'":"'+serialize($(this).val())+'",';
	  }
	 });  
	 
     //txt = txt.replace(/\\/g, "\\/"); 
	 txt = txt.replace(/,$/, ''); // 去除最后一个","号
	 return  txt ;
	 //var xobj=null;
	 //eval('xobj={'+txt+'}');
	 //return xobj;
	
	 function serialize(text) {
	    text = text.replace(/\\/g, "\\\\");
	    text=text.replace(/(")/g,"\\\"");
	    return text;
	}
 }
 


 /***********************************************************************
  * form对象转json字符串 -textarea加密
  *  参数：form
  *  返回值：txt
  *  DLY 
  */
 function jsonUtil_form2json1(form) {
     var txt = '';
     //input text
     $(form).find('input[type="text"]').each(function () {
         //alert($(this).attr('type')); 
         if ($(this).attr('name')) {
             // alert($(this).attr('name'));
             // alert($(this).attr('value'));
             txt += '"' + $(this).attr('name') + '":"' + jsonUtil_serialize($(this).val()) + '",';
         }
     });
     //input hidden
     $(form).find('input[type="hidden"]').each(function () {
         if ($(this).attr('name')) {
             txt += '"' + $(this).attr('name') + '":"' + jsonUtil_serialize($(this).val()) + '",';
         }
     });

     //input radio
     var rdnames = '';
     $(form).find('input[type="radio"]').each(function () {
         if (this.name) {
             if (this.checked) {
                 if (rdnames.toUpperCase().indexOf(this.name.toUpperCase()) >= 0) {
                     var reg = new RegExp('"' + this.name + '":' + '"(.+?)",', 'i');
                     txt = txt.replace(reg, '"' + this.name + '":' + '"' + this.value + '",');
                 } else {
                     rdnames += this.name + ',';
                     txt += '"' + this.name + '":"' + this.value + '",';
                 }
             }
         }
     });

     //input checkbox
     var chknames = '';
     $(form).find('input[type="checkbox"]').each(function () {
         if (this.name) {
             if (this.checked) {
                 if (chknames.toUpperCase().indexOf(this.name.toUpperCase()) >= 0) {
                     var reg = new RegExp('"' + this.name + '":' + '"(.+?)",', 'i');
                     txt = txt.replace(reg, '"' + this.name + '":' + '"$1,' + this.value + '",');
                 } else {
                     chknames += this.name + ',';
                     txt += '"' + this.name + '":"' + this.value + '",';
                 }
             }
         }
     });

     //textArea
     $(form).find('textArea').each(function () {
         if ($(this).attr('name')) {
             var value = $(this).val();
             txt += '"' + $(this).attr('name') + '":"' + jsonUtil_serialize(value) + '",';
         }
     });

     //select
     $(form).find('select').each(function () {
         if ($(this).attr('name')) {
             txt += '"' + $(this).attr('name') + '":"' + jsonUtil_serialize($(this).val()) + '",';
         }
     });


     txt = txt.replace(/,$/, ''); // 去除最后一个","号
     return txt;
     //var xobj=null;
     //eval('xobj={'+txt+'}');
     //return xobj;

     
 }


/***********************************************************************
*  字符串序列号  
*  参数：s（字符串），type（类别）
*  返回值：txt
*  DLY 
*/
 function jsonUtil_serialize(s) {
     if (s == null) {
         return "";
     } 
     var newstr = "";
     for (var i = 0; i < s.length; i++) {
        c = s.charAt(i);
        switch (c) {
            case '\"':
                newstr += "\\\"";
                break;
            case '\\':
                newstr += "\\\\";
                break;
            case '/':
                newstr += "\\/";
                break;
            case '\b':
                newstr += "\\b";
                break;
            case '\f':
                newstr += "\\f";
                break;
            case '\n':
                newstr += "《br》";
                break;
            case '\r':
                newstr += "\\r";
                break;
            case '\t':
                newstr += "\\t";
                break;
            case '"':
                newstr += "\"";
                break;
            case ':':
                newstr += "\:";
                break;
            case '{':
                newstr += "\{";
                break;
            case '}':
                newstr += "\}";
                break;
            case '[':
                newstr += "\[";
                break;
            case ']':
                newstr += "\]";
                break;
            default:
                newstr += c;
        }
     } 
     return newstr;
 }

