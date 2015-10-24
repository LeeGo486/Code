

/***********************************************************************
 *  金额大写转换函数
 *  参数：n：金额
 *  参数： 
 *  返回值：大写字符串
 *  DLY
 *  2013-04-18
 */
function dataUtil_getCHDX(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
        return "数据非法";
    var unit = "千百拾亿千百拾万千百拾元角分", str = "";
    n += "00";
    var p = n.indexOf('.');
    if (p >= 0)
        n = n.substring(0, p) + n.substr(p + 1, 2);
    unit = unit.substr(unit.length - n.length);
    for (var i = 0; i < n.length; i++)
        str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
    return str.replace(/零(千|百|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
}

/***********************************************************************
 *  四舍五入 取指定位数的小数
 *  参数：n：数字
 *  参数：n：小数位数 
 *  返回值：大写字符串
 *  DLY
 *  2013-04-18
 */
function dataUtil_toFixed(num, n) {
    var num1 = new Number(num);
    return num1.toFixed(n);
}


/**
 * 数字加千分号
 */
function dataUtil_formatNum(s) {
    if (s == undefined || s == null || s == '') {
        return '0.00';
    } else {
        s = s + '';
    }
    var j = 0;
    var str1 = '';
    if (s.substr(0, 1) == '-') {  // 截取负号
        s = s.substr(1, s.length - 1);
        str1 = '-';
    }
    var str = s.split('.');
    var value = '';
    for (var i = str[0].length - 1; i >= 0; i--) {
        if (j >= 3) {
            value = str[0].substr(i, 1) + ',' + value;
            j = 0;
        }
        else {
            value = str[0].substr(i, 1) + value;
        }
        j++;
    }
    if (str[1] != undefined) {
        value = value + '.' + str[1];
    } else {
        value = value + '.00';
    }
    return str1 + value;
}


/**
 * 数字加千分号 
 * 0或无返回 '' 
 * 小数末位0的不要
 */
function dataUtil_formatNum1(s, s1) {
    if (s1 == undefined) {
        s1 = '';
    }
    if (s == undefined || s == null || s == '' || s * 1 == 0) {
        return s1;
    } else {
        s = s + '';
    }
    var j = 0;
    var str1 = '';
    if (s.substr(0, 1) == '-') { // 截取负号
        s = s.substr(1, s.length - 1);
        str1 = '-';
    }
    var str = s.split('.');
    var value = '';
    for (var i = str[0].length - 1; i >= 0; i--) {
        if (j >= 3) {
            value = str[0].substr(i, 1) + ',' + value;
            j = 0;
        }
        else {
            value = str[0].substr(i, 1) + value;
        }
        j++;
    }
    if (str[1] != undefined) {
        var len = str[1].length;
        var v1 = '';
        for (var i = str[1].length - 1; i >= 0; i--) {
            if (str[1].substr(i, 1) > 0) {
                v1 = str[1].substr(0, i + 1);
                break;
            }
        }
        if (v1 != '') {
            value = value + '.' + v1;
        }
    }
    return str1 + value;
}



/**
 * 去空格
 */
function dataUtil_trim(s) {
    s = dataUtil_ltrim(s);
    s = dataUtil_rtrim(s);
    return s;
}



/**
 * 去左空格
 */
function dataUtil_ltrim(s) {
    s = dataUtil_undefinedOrNull(s, "");
    while (s.length > 0 && s.charAt(0)) {
        if (s.charAt(0) == " ")
            s = s.substring(1, s.length);
        else
            break;
    }
    return s;
}

/**
 * 去右空格
 */
function dataUtil_rtrim(s) {
    s = dataUtil_undefinedOrNull(s, "");
    while (s.length > 0 && s.charAt(0)) {
        if (s.charAt(s.length - 1) == " ")
            s = s.substring(0, s.length - 1);
        else
            break;
    }
    return s;
}


/***********************************************************************
 *  undefined 或 null  转换成 制定值
 *  DLY
 *  2013-04-18
 */
function dataUtil_undefinedOrNull(obj, value) {
    if (obj == undefined || obj == null || obj == '') {
        return value;
    } else {
        return obj;
    }
}



/***********************************************************************
 *  统一字符串累加
 *  参数说明
 *       str 字符串
 *       n  个数
 *  DLY
 *  2013-05-17
 */
function dataUtil_actSetNStr(str, n) {
    var s = '';
    for (i = 1; i <= n; i++) {
        s = s + str;
    }
    return s;
}



/***********************************************************************
*  统一字符串累加
*  参数说明
*       str 字符串
*       n  个数
*  DLY
*  2013-05-17
*/
function S4() {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}
function dataUtil_NewGuid() {
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}