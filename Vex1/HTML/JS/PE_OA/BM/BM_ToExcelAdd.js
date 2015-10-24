
/***********************************************************************
 *  数据写成excel格式，然后导出
 *  DLY  3, 3C, 4 
 */
function dataExpotToFile(type, rows, dllist, xllist, type1) {
    if (type1 == undefined) {
        type1 = '';
    }
    var outstr = '';
    var filename = '';
    if (type == '1') {
        
    } else if (type == '2') {  
        
    } else if (type == '3') {
        filename = '部门预算明细查询';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门名称' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg8_year + '\t' + rows[i].bg8_brand + '\t' + rows[i].bg8_com + '\t"'
                   + rows[i].bg8_centercode + '"\t' + rows[i].bg8_deptname + '\t="' + rows[i].bg8_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg8_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg8_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg8_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg8_xlcode + '"\t="'
                   + rows[i].bg8_remark1 + '"\t' + basedata_AtoB(rows[i].bg8_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '3C') { //带主题和状态
        filename = '部门预算明细查询3C';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门名称' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t'
               + '主题' + '\t' + '状态' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg8_year + '\t' + rows[i].bg8_brand + '\t' + rows[i].bg8_com + '\t"'
                   + rows[i].bg8_centercode + '"\t' + rows[i].bg8_deptname + '\t="' + rows[i].bg8_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg8_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg8_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg8_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg8_xlcode + '"\t="'
                   + rows[i].bg8_remark1 + '"\t' + basedata_AtoB(rows[i].bg8_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg8_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg8_m12, 0, '') + '\t'
                   + rows[i].bg7_subject + '\t' + rows[i].bg7_state + '\t' + '\r\n';
        }
    } else if (type == '3C_1') { //带主题和状态
        filename = '部门预算明细查询3C_1';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门名称' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t'
               + '主题' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t' + rows[i].bg3_com + '\t"'
                   + rows[i].bg3_centercode + '"\t' + rows[i].bg3_deptname + '\t="' + rows[i].bg3_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t="'
                   + rows[i].bg3_remark1 + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t'
                   + rows[i].bg4_subject + '\t' + '\r\n';
        }
    } else if (type == '3A') {
        filename = '部门预算科目汇总查询3A';
        outstr = '年份' + '\t' + '品牌' + '\t'
               + '部门名称' + '\t' + '成本中心' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t"'
                   + rows[i].bg3_deptname + '"\t="' + rows[i].bg3_centercode + '"\t="' + rows[i].bg3_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        } 
    } else if (type == '3B') {
        filename = '部门预算科目汇总查询3B';
        outstr = '年份' + '\t' + '品牌' + '\t' 
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t"' 
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '4') {
        filename = '部门预算编制Excel模板';
        outstr = '公司' + '\t' + '成本中心' + '\t'
               + '说明' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        outstr = outstr + '雅莹' + '\t' + 'YY9050' + '\t'
               + '说明......' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t' + '本行止\r\n'; 
    } else if (type == '5') {
        filename = '统一费用预算编制Excel模板';
        outstr = '公司' + '\t' + '成本中心' + '\t'
                + '部门代码' + '\t' + '部门名称' + '\t'
               + '说明' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        outstr = outstr + '雅莹' + '\t' + 'YY9052' + '\t'
               + '492453' + '\t' + '财务部' + '\t'
               + '说明......' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t' + '本行止\r\n';
    } else if (type == '6') {
         
    } else if (type == '7') {
         
    } else if (type == '8') {
         
    } else if (type == '9') { 
         
    } else if (type == '10') { 
        
    }
    if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
        doFileExport(filename + dateUtil_dateFomaterB(new Date(),'')+ ".xls", outstr);
    } else { 
        $('#toExceltext').val(outstr);
        $('#toEXCELdlg').dialog('open');
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