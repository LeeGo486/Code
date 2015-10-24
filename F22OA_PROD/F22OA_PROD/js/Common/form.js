// JScript 文件

document.addLoadEvent = function (func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

function InitFormBase(){
    var oIfrm = window.document.createElement( "<iframe name='hiddenBase'>" );
    oIfrm.style.display='none';
    document.body.insertAdjacentElement( "beforeEnd" , oIfrm);
    var oForm = window.document.createElement( "form" );
    oForm.id='FormBase';
    oForm.method='post';
    oForm.target='hiddenBase';
    document.body.insertAdjacentElement( "beforeEnd" , oForm);
    var oHd = window.document.createElement( "<input type='hidden' name='IDBase'>" );
    oForm.insertAdjacentElement( "beforeEnd" , oHd);
    var oHd = window.document.createElement( "<input type='hidden' name='ActionBase'>" );
    oForm.insertAdjacentElement( "beforeEnd" , oHd);
    var oHd = window.document.createElement( "<input type='hidden' name='__ParamName'>" );
    oForm.insertAdjacentElement( "beforeEnd" , oHd);
    var oHd = window.document.createElement( "<input type='hidden' name='__ParamValue'>" );
    oForm.insertAdjacentElement( "beforeEnd" , oHd);
}

function PostForm(methodName){
    var __Name = '';
    var __Value = '';
    FormBase.__ParamName.value='';
    FormBase.__ParamValue.value = '';
    for (var i=1; i<arguments.length;i++) {

        if(typeof(arguments[i])=='string'){
            var arrForm = document.getElementsByTagName('form');
            var oForm=arrForm[0];
//            var oForm = event.srcElement;
//            while(oForm.tagName!='FORM'){
//                oForm = oForm.parentElement;
//            }
            var tmpValue = '';
            for(var j=0;j<oForm.elements.length;j++){
                if(oForm.elements[j].group==arguments[i]||oForm.elements[j].name==arguments[i]){
                    tmpValue += oForm.elements[j].value;
                    if(j<(oForm.elements.length-1)){
                        tmpValue += '♂';
                    }
                }
            }
            tmpName = arguments[i];
            tmpValue = tmpValue.substr(0,(tmpValue.length-1));
            __Name += tmpName + '♀';
            __Value += tmpValue + '♀';
        }
        else if(arguments[i].tagName!=undefined){    //为单个控件时
            switch(arguments[i].tagName){
                case "SELECT":
                    if(arguments[i].PostText == 'true'){
                        __Name += arguments[i].name + '♀';
                        __Value += arguments[i].value + '_' + arguments[i].options[arguments[i].selectedIndex].text + '♀';
                    }
                    else{
                        __Name += arguments[i].name + '♀';
                        __Value += arguments[i].value + '♀';
                    }
                    break;
                case "INPUT":
                    switch(arguments[i].type.toLowerCase()){
                        case "radio":
                            __Name += arguments[i].name + '♀';
                            if(arguments[i].checked==true){
                                __Value += arguments[i].value + '♀';
                            }
                            else{
                                __Value += '♀';
                            }
                            break;
                        case "checkbox":
                            __Name += arguments[i].name + '♀';
                            if(arguments[i].checked==true){
                                __Value += arguments[i].value + '♀';
                            }
                            else{
                                __Value += '♀';
                            }
                            break;
                        default:
                            __Name += arguments[i].name + '♀';
                            __Value += arguments[i].value + '♀';
                        break;
                    }
                    break;
                case "TEXTAREA":
                    __Name += arguments[i].name + '♀';
                    __Value += arguments[i].value.replace(/\r\n/g, '\\r\\n') + '♀';
                    break;
                default:
                    __Name += arguments[i].name + '♀';
                    __Value += arguments[i].value + '♀';
                    break;
            }
        }
        else{   //为控件组时
            if(arguments[i].length!=undefined){
                switch(arguments[i][0].tagName){
                    case "INPUT":
                        switch(arguments[i][0].type.toLowerCase()){
                            case "radio":
                                __Name += arguments[i][0].name + '♀';
                                __Value += GetGroupRadioValueStr(arguments[i]) + '♀';
                                break;
                            case "checkbox":
                                __Name += arguments[i][0].name + '♀';
                                __Value += GetGroupCheckBoxValueStr(arguments[i]) + '♀';
                            break;
                            default:
                                __Name += arguments[i][0].name + '♀';
                                __Value += GetObjArrayValueStr(arguments[i]) + '♀';
                            break;
                        }
                        break;
                }
            }
            else{
                alert('error');
            }
        }
    }
    FormBase.__ParamName.value = __Name.substr(0,(__Name.length-1));
    FormBase.__ParamValue.value = __Value.substr(0,(__Value.length-1));
    FormBase.ActionBase.value = methodName;
    FormBase.submit();
    FormBase.ActionBase.value='';
}

function GetGroupRadioValueStr(objs){
    var v = '';
    for(var i=0;i<objs.length;i++){
        if(objs[i].checked==true){
            v = objs[i].value;
            break;
        }
    }
    return v;
}

function GetGroupCheckBoxValueStr(objs){
    var v = '';
    for(var i=0;i<objs.length;i++){
        if(objs[i].checked==true){
            v += objs[i].value +',';
        }
        else{
            v += ',';
        }
    }
    v = v.substr(0,(v.length-1));
    return v;
}

function GetObjArrayValueStr(objs){
    var v = '';
    for(var i=0;i<objs.length;i++){
        v += objs[i].value +',';
    }
    v = v.substr(0,(v.length-1));
    return v;
}

//隐藏页面上的某个标记
function HideTags(tagName,oParent){
    if(oParent==undefined){
        oParent=document;
    }
    var oSe = oParent.getElementsByTagName(tagName);
    for(var i=0;i<oSe.length;i++){
        oSe[i].style.display='none';
    }
}
//显示页面上的某个标记
function ShowTags(tagName,oParent){
    if(oParent==undefined){
        oParent=document;
    }
    var oSe = oParent.getElementsByTagName(tagName);
    for(var i=0;i<oSe.length;i++){
        oSe[i].style.display='';
    }
}

function ExpandDiv(){
    for (i = 0; i < arguments.length; i++){ 
        if (arguments[i].style.display=='none'){
            arguments[i].style.display='';
            event.srcElement.style.color ='#000000';
        }
        else{
            arguments[i].style.display='none';
            event.srcElement.style.color ='#aaaaaa';
        }
    }
}

//去除字符串两端空格
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
// 检查是否存在单引号 songzhiwei 080730
function isSign(obj){
     if(obj.value.indexOf('\'')>-1){  
         var vwarning="'"+obj.previousSibling.nodeValue+ "'输入框中存在单引号 !"; 
         alert(vwarning);         
         return false; 
     }
     else{
        return true;
     }
}
