

$.ajaxWebService = function (url, dataMap, fnSuccess) {  //自定义webservices 方法
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: dataMap,
        async: false,
        dataType: "json",
        success: fnSuccess,
        error: function (XMLHttpRequest, textStatus, errorThrown) { alert("出现错误，请稍后！"); }
    });
}

DateFormat = (function () {
    var SIGN_REGEXP = /([yMdhsm])(\1*)/g;
    var DEFAULT_PATTERN = 'yyyy-MM-dd';
    function padding(s, len) {
        var lentmp = len - (s + '').length;
        for (var i = 0; i < lentmp; i++) { s = '0' + s; }
        return s;
    };
    return ({
        format: function (date, pattern) {
            pattern = pattern || DEFAULT_PATTERN;
            return pattern.replace(SIGN_REGEXP, function ($0) {
                switch ($0.charAt(0)) {
                    case 'y': return padding(date.getFullYear(), $0.length);
                    case 'M': return padding(date.getMonth() + 1, $0.length);
                    case 'd': return padding(date.getDate(), $0.length);
                    case 'w': return date.getDay() + 1;
                    case 'h': return padding(date.getHours(), $0.length);
                    case 'm': return padding(date.getMinutes(), $0.length);
                    case 's': return padding(date.getSeconds(), $0.length);
                }
            });
        },
        parse: function (dateString, pattern) {
            var matchs1 = pattern.match(SIGN_REGEXP);
            var matchs2 = dateString.match(/(\d)+/g);
            if (matchs1.length == matchs2.length) {
                var _date = new Date(1970, 0, 1);
                for (var i = 0; i < matchs1.length; i++) {
                    var _int = parseInt(matchs2[i],10);
                    var sign = matchs1[i];
                    switch (sign.charAt(0)) {
                        case 'y': _date.setFullYear(_int); break;
                        case 'M': _date.setMonth(_int - 1); break;
                        case 'd': _date.setDate(_int); break;
                        case 'h': _date.setHours(_int); break;
                        case 'm': _date.setMinutes(_int); break;
                        case 's': _date.setSeconds(_int); break;
                    }
                }
                return _date;
            }
            return null;
        }
    });
})();

function banBackSpace(e) {
    var ev = e || window.event; //获取event对象      
    var obj = ev.target || ev.srcElement; //获取事件源      

    var t = obj.type || obj.getAttribute('type'); //获取事件源类型     

    //获取作为判断条件的事件类型   
    var vReadOnly = obj.getAttribute('readonly');
    var vEnabled = obj.getAttribute('enabled');
    //处理null值情况   
    vReadOnly = (vReadOnly == null) ? false : vReadOnly;
    vEnabled = (vEnabled == null) ? true : vEnabled;

    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，   
    //并且readonly属性为true或enabled属性为false的，则退格键失效   
    var flag1 = (ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea")
                && (vReadOnly == 'readonly' || vReadOnly == true || vEnabled != true)) ? true : false;

    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效   
    var flag2 = (ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")
               ? true : false;

    //判断   
    if (flag2) {
        return false;
    }
    if (flag1) {
        return false;
    }
}   
document.onkeydown=banBackSpace;

function isNumber(e) {
    if ($.browser.msie) {
        if (((event.keyCode > 47) && (event.keyCode < 58)) ||
           (event.keyCode == 8)) {
            return true;
        } else {
            return false;
        }
    } else {
        if (((e.which > 47) && (e.which < 58)) ||
              (e.which == 8)) {
            return true;
        } else {
            return false;
        }
    }
}

function isDot(e) {
    if ($.browser.msie) {
        if (event.keyCode == 46) {
            return true;
        } else {
            return false;
        }
    }
    else {
        return false;
    }
}

String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/, '');
}

function pagerpagination(pagerid, total, pi, fn) {
    $("#" + pagerid).pagination(total, {
        callback: fn,
        prev_text: '< 上一页',
        next_text: '下一页 >',
        items_per_page: 20 ,
        num_display_entries: 6,
        current_page: pi,
        num_edge_entries: 1
    });
    var prev = $("#" + pagerid).find(".prev");
    var next = $("#" + pagerid).find(".next");
    if (prev.next(".current").length == 0) {
        prev.removeClass("prev");
    }
    if (next.prev(".current").length == 0) {
        next.removeClass("next");
    }
}

String.prototype.replaceAll  = function(s1,s2){   
    return this.replace(new RegExp(s1,"gm"),s2);
}


function roundFun(numberRound, roundDigit) {
    with (Math) {
        return  round(numberRound * pow(10, roundDigit)) / pow(10, roundDigit).toString();
    }
}

function roundFunDouble(numberRound, roundDigit) {
    var tmp = "";
    with (Math) {
        tmp = round(numberRound * pow(10, roundDigit)) / pow(10, roundDigit).toString();
    }
    var arr = tmp.toString().split(".");
    if (arr.length > 1) {
        for (var i = 0; i < roundDigit - arr[1].length; ) {
            arr[1] += "0";
        }
        return arr[0] + "." + arr[1];
    }
    else {
        return arr[0] + ".0000";
    }
    //tmp = tmp.toString().indexOf(".") > 0 ? tmp : (tmp + ".00");
  //  return tmp;

}

function wy_zx() {
    $.ajaxWebService("login.aspx/cancell", "{}", function (result) {
        var obj = eval("(" + result.d.toString() + ")");
        if (obj.flag == "true") {
            window.parent.location.href = "/login.aspx";
        }
        else {
            alert("注销失败！");
        }
    });
}



var hkey_root,hkey_path,hkey_key;
hkey_root="HKEY_CURRENT_USER";
hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";


//设置页眉页脚为空   
function PageSetup_Null()
{   
    try{
        var RegWsh = new ActiveXObject("WScript.Shell");   
         hkey_key1="header";
         hkey_key2="footer";  
         RegWsh.RegWrite(hkey_root+hkey_path+hkey_key1,"");
         RegWsh.RegWrite(hkey_root+hkey_path+hkey_key2,"");
     }catch(e){}   
}

//设置页眉页脚为默认值   
function PageSetup_Default()   
{   
    try{   
        var RegWsh = new ActiveXObject("WScript.Shell") ;   
         hkey_key1="header";   
         hkey_key2="footer";   
         RegWsh.RegWrite(hkey_root+hkey_path+hkey_key1,"&w&b页码，&p/&P");   
         RegWsh.RegWrite(hkey_root+hkey_path+hkey_key2,"&u&b&d");   
     }catch(e){}   
}  

function printReport(){
　　 //PageSetup_Null();//设置页眉页脚为空
　　 //window.print();//打印页面
    //PageSetup_Default();//设置页眉页脚为默认值
    try {
        var strHtml1 = "";

        if (document.all.eprint == undefined || document.all.eprint.defaultPrinterName==undefined || document.all.eprint.defaultPrinterName.length == 0) {
            strHtml1 = "<font color='#FF00FF'>打印控件未安装!点击这里<a href='/dygs/webprint.exe'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
            parent.document.all.print_frame.height = "30px" ;
            parent.document.all.print_frame.width = "400px" ;
            document.body.innerHTML = "Error:" + strHtml1;
            return;
        }
        eprint.InitPrint();
        eprint.header = "";
        eprint.footer = "";
        eprint.SetMarginMeasure(2);  // measure margins in inches
        eprint.paperSize = "A4";
        // -- basic features
        eprint.portrait = false;
        eprint.leftMargin = 1.0;
        eprint.topMargin = 1.0;
        eprint.rightMargin = 1.0;
        eprint.bottomMargin = 1.0;
        //eprint.Print();
        eprint.Preview();
        //document.all.eprint.Print(true);//不弹出打印对话框直接打印
    } catch (e) {
    }
}



