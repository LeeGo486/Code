function XmlHttp(oForm){
	var xmlHttp;
	try{
//		Internet Explorer
		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (e){
		try{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch (e){
			try{
				// Firefox, Opera 8.0+, Safari
				xmlHttp=new XMLHttpRequest();
			}
			catch (e){
				alert("您的浏览器不支持AJAX！");
				return false;
			}		
		}
	}
	this.xmlHttpObj = xmlHttp;
	this.OnResponse;
	this.URL = window.location;
	//默认返回json对象
	this.ResponseType = 'json';
	
	this.PostForm = PostForm;
	
	_parent = this;
	
	this.xmlHttpObj.onreadystatechange = function(){
		if(_parent.xmlHttpObj.readyState==4){
			if(_parent.OnResponse != undefined){
				switch(_parent.ResponseType){
				    case "xml":
				        _parent.OnResponse(_parent.xmlHttpObj.responseXML);
				        break;
				    case "text":
				        _parent.OnResponse(_parent.xmlHttpObj.responseText);
				        break;
				    case "json":
				        _parent.OnResponse(ParseJsonData(_parent.xmlHttpObj.responseText));
				        break;
				}
			}
		}
	}
	
	if(oForm != undefined){
		this.URL = oForm.action;
	}
	
	this.ParseData = ParseJsonData;
	this.AlertError = ShowErrorMessage;
}

function PostForm1(p){
	this.xmlHttpObj.open("POST" ,this.URL ,true);
    this.xmlHttpObj.send('tt');

}


function PostForm(methodName){
    var __Name = '';
    var __Value = '';
    for (var i=1; i<arguments.length;i++) {
        if(typeof(arguments[i])=='string'){
            var arrForm = document.getElementsByTagName('form');
            var oForm=arrForm[0];
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
        else if(arguments[i].tagName!=undefined){
        //为单个控件时
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
        else{
         //为控件组时
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
        
    this.xmlHttpObj.open("POST" ,this.URL ,true);
    this.xmlHttpObj.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    this.xmlHttpObj.send('ActionBase=' + methodName + '&__ParamName=' + __Name + '&__ParamValue=' + __Value);
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

function ParseJsonData(v){
    var json;
    try{
        if(v!=''){
            json = eval('(' + v + ')');
            if(json.type=='error'){
                ShowErrorMessage(json.message);
            }
            else{
                return json;
            }
        }
    }
    catch(e){
        ShowErrorMessage(e.message);
    }
}

function ShowErrorMessage(msg){
    alert('发生错误！\r\n' + msg.Decode64());
}

//去除字符串两端空格
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}