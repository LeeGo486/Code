 
 
/***********************************************************************
 *  金额大写转换函数
 *  参数：n：金额
 *  参数： 
 *  返回值：大写字符串
 *  DLY
 *  2013-04-18
 */  
function numberUtil_getCHDX(n) {  
	if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
	return "数据非法";
	var unit = "千百拾亿千百拾万千百拾元角分", str = "";
	n += "00";
	var p = n.indexOf('.');
	if (p >= 0)
	n = n.substring(0, p) + n.substr(p+1, 2);
	unit = unit.substr(unit.length - n.length);
	for (var i=0; i < n.length; i++)
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
function numberUtil_toFixed(num,n) {  
	var num1 = new Number(num);
	return num1.toFixed(n);
}
 
 
/**
 * 数字加千分号
 */
function numberUtil_formatNum(s){
	if(s==undefined || s==null || s==''){
		return '0.00';
	}else{
		s=s+'';
	}
    var j = 0;
    var str = s.split('.');
    var value = '';
    for (var i = str[0].length - 1; i >= 0; i--) {
        if (j >= 3) {
            value = str[0].substr(i,1) + ',' + value;
            j = 0;
        }
        else {
            value = str[0].substr(i,1) + value;
        }
        j++;
    }
    if (str[1] != undefined) {
        value = value + '.';
        j = 0;
        for (var i = 0; i < str[1].length; i++) {
            if (j >= 3) {
                value =value+','+ str[1][i] ;
                j = 0;
            }
            else {
                value = value + str[1][i];
            }
            j++;
        }
    }
    return value;
}

