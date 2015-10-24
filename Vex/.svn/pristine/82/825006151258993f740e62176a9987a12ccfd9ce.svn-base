
/***********************************************************************
 *  数据写成excel格式，然后导出
 *  DLY 
 */
function dataExpotToFile(type, rows) {
    if (type == undefined) {
        type = '';
    }
    if (rows.length == 0) {
        alert('无数据可导出！');
        return '';
    }
    var outstr = '';
    var filename = '';
    if (type == '1') {
        filename = '加班申请汇总' + rows[0].hr1_otmonth;
        outstr = '月份' + '\t' + '店铺名称' + '\t' + '姓名' + '\t'
               + '员工号' + '\t' + '加班(小时)' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + '="' + rows[i].hr1_otmonth + '"\t="' + rows[i].shopname
                   + '"\t="' + rows[i].hr2_empname + '"\t="'
                   + rows[i].hr2_empcode + '"\t="' + rows[i].hr2_othours + '"\t' + '\r\n';
        }
    } 
    if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
        doFileExport(filename  + ".xls", outstr);
    } else {
        alert('请在IE兼容模式下导出，或者将汇总页面数据选中复制到EXCEL！');
    }
    return outstr;
}




/***********************************************************************
 *  文件导出方法 
 *  DLY 
 */
function doFileExport(inName, inStr) {
    var xlsWin = null;
    var openPara = "left=200 ,top=200, Toolbar=no,Location=no,"
    			+ "Direction=no,Resizeable=no,width=100,height=100";
    xlsWin = window.open("", "_blank", openPara);
    //xlsWin = window.showModalDialog("",window,"dialogHeight:100px; dialogWidth: 100px; dialogTop: 100px; dialogLeft: 100px; resizable: no; status: no;scroll:no");
    xlsWin.document.write(inStr);
    xlsWin.document.close();
    xlsWin.document.execCommand('Saveas', false, inName);
    xlsWin.focus();
    xlsWin.close();
}