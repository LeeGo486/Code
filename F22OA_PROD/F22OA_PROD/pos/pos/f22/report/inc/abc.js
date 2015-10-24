//判断字符串是否为空
function isEmpty(str){
	if(str==null || trim(str)==""){
		return true;
	}
	else{
		return false;
	}
}

//判断是否为正整数
function isDigital(str){
    return /^\d+$/.test(str);
}

//本函数用于限制文本输入框中只能输入数字"0"到"9",".","-",也即可以输入数值,包括负值
function isNumberText(){
 if ( !(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) 
 || (window.event.keyCode == 13) || (window.event.keyCode == 46) 
 || (window.event.keyCode == 45)))
    return false;
 else
    return true;
}

//去掉字串左边的空格 
function lTrim(str) { 
  if (str.charAt(0) == " ") { 
  //如果字串左边第一个字符为空格 
  str = str.slice(1);//将空格从字串中去掉 
  //这一句也可改成 str = str.substring(1, str.length); 
  str = lTrim(str); //递归调用 
  } 
  return str; 
} 

//去掉字串右边的空格 
function rTrim(str) { 
  var iLength; 

  iLength = str.length; 
  if (str.charAt(iLength - 1) == " ") { 
    //如果字串右边第一个字符为空格 
    str = str.slice(0, iLength - 1);//将空格从字串中去掉 
    //这一句也可改成 str = str.substring(0, iLength - 1); 
    str = rTrim(str); //递归调用 
  } 
  return str; 
} 

//去掉字串两边的空格 
function trim(str) { 
  return lTrim(rTrim(str)); 
} 


