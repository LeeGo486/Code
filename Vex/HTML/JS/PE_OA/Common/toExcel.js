
/***********************************************************************
 *  数据写成excel格式，然后导出
 *  DLY 
 */
function dataExpotToFile(type, rows, states, types1, types2) {
    var outstr = '';
    var filename = '';
    if (type == '1') {
        filename = '固定资产申购单查询';
        outstr = '申购单号' + '\t' + '所属公司' + '\t' + '状态' + '\t' 
               + '申请人' + '\t' + '员工号' + '\t' + '申请日期' + '\t' 
               + '部门名称' + '\t' + '成本中心' + '\t' + '申请总金额' + '\t' + '确认总金额' + '\t'
               + '资产类别' + '\t' + '预算类别' + '\t' + '项目代码' + '\t' + '高薪代码' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {  
            outstr = outstr + rows[i].fa1_poapplycode + '\t' + rows[i].fa1_genuscompanyname + '\t' 
                   + basedata_getCodename(states, rows[i].fa1_state) + '\t'
                   + rows[i].fa1_applyuser + '\t' + rows[i].fa1_employeeid + '\t="' 
                   + rows[i].fa1_applydt + '"\t="' + rows[i].fa1_deptname + '"\t="'
                   + rows[i].fa1_centercode + '"\t="' + rows[i].fa1_applyamount + '"\t="'
                   + rows[i].fa1_confirmamount + '"\t' 
                   + basedata_getCodename(types1, rows[i].fa1_assetstype) + '\t'
                   + basedata_getCodename(types2, rows[i].fa1_budgettype) + '\t'
                   + rows[i].fa1_projectcode + '\t' + rows[i].fa1_advancedcode + '\t' + '\r\n';
        } 
    } else if (type == '2') {
        filename = '低值易耗品申购单查询';
        outstr = '申购单号' + '\t' + '所属公司' + '\t' + '状态' + '\t'
               + '申请人' + '\t' + '员工号' + '\t' + '申请日期' + '\t'
               + '部门名称' + '\t' + '成本中心' + '\t' + '申请总金额' + '\t' + '确认总金额' + '\t'
               + '资产类别' + '\t' + '项目代码' + '\t' + '高薪代码' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].lv1_poapplycode + '\t' + rows[i].lv1_genuscompanyname + '\t'
                   + basedata_getCodename(states, rows[i].lv1_state) + '\t'
                   + rows[i].lv1_applyuser + '\t' + rows[i].lv1_employeeid + '\t="'
                   + dateUtil_dateFomaterB(new Date(rows[i].lv1_applydt), '-') + '"\t="' + rows[i].lv1_deptname + '"\t="'
                   + rows[i].lv1_centercode + '"\t="' + rows[i].lv1_applyamount + '"\t="'
                   + rows[i].lv1_confirmamount + '"\t'
                   + basedata_getCodename(types1, rows[i].lv1_assetstype) + '\t' 
                   + rows[i].lv1_projectcode + '\t' + rows[i].lv1_advancedcode + '\t' + '\r\n';
        }
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