/*********************************/
/**
 * 设置打印页面数据
 * @param formId
 */
function setValues() {   
    if (basedata_getUrlParam("v0") == undefined || basedata_getUrlParam("v0") == '') {
        alert('报告单ID无效！');
        return false;

    }
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + 'AND fa4_id=\'' + basedata_getUrlParam("v0") + '\'</Cons><OrderBy>fa4_rgdt DESC</OrderBy>'
    cXML = basedata_addROOT(cXML); 
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(10)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //data: cxmlsJson,
        dataType: "json",
        success: function (result) {
            try { 
                if (result.Error) {
                    $.messager.alert("系统错误", result.Error, 'error');
                } else if (result.rows.length > 0 && result.rows[0].result == "False") {
                    $.messager.alert("提示", result.rows[0].message, 'error');
                } else { 
                    //回写单据信息
                    if (result.rows && result.rows.length > 0) {
                        row = result.rows[0];
                        var reg = new RegExp("《br》", "g");  
                        $('#fa4_id').attr('value', row.fa4_id);
                        $('#fa4_cono').attr('value', row.fa4_cono);
                        $('#fa4_divi').attr('value', row.fa4_divi);
                        $('#fa4_rguser').attr('value', row.fa4_rguser);
                        $('#fa4_uptno').attr('value', row.fa4_uptno);
                        $('#fa4_rgdt').attr('value', row.fa4_rgdt);
                        $('#fa4_state').attr('value', row.fa4_state);
                        $('#fa4_department').attr('value', row.fa4_department);
                        $('#fa4_name').attr('value', row.fa4_name);
                        $('#fa4_diagnosispeople').attr('value', row.fa4_diagnosispeople);
                        $('#fa4_filldate').attr('value', row.fa4_filldate);//鉴定日期-当前日期 

                        $('#fa4_notebook').attr('value', row.fa4_notebook.replace(reg, '\n'));
                        $('#fa4_computer').attr('value', row.fa4_computer.replace(reg, '\n'));
                        $('#fa4_deviceno').attr('value', row.fa4_deviceno.replace(reg, '\n'));
                        $('#fa4_cpu').attr('value', row.fa4_cpu.replace(reg, '\n'));
                        $('#fa4_mem').attr('value', row.fa4_mem.replace(reg, '\n'));
                        $('#fa4_hd').attr('value', row.fa4_hd.replace(reg, '\n'));
                        $('#fa4_buydate').attr('value', row.fa4_buydate.replace(reg, '\n'));
                        $('#fa4_omoney').attr('value', row.fa4_omoney.replace(reg, '\n'));
                        $('#fa4_rmoney').attr('value', row.fa4_rmoney.replace(reg, '\n'));
                        $('#fa4_officewarebef1').attr('value', row.fa4_officewarebef1.replace(reg, '\n'));
                        $('#fa4_officewarebef2').attr('value', row.fa4_officewarebef2.replace(reg, '\n'));
                        $('#fa4_officewarebef3').attr('value', row.fa4_officewarebef3.replace(reg, '\n'));
                        $('#fa4_officewarebef4').attr('value', row.fa4_officewarebef4.replace(reg, '\n'));
                        $('#fa4_officewarebef5').attr('value', row.fa4_officewarebef5.replace(reg, '\n'));
                        $('#fa4_officewarebef6').attr('value', row.fa4_officewarebef6.replace(reg, '\n'));
                        $('#fa4_officewarebef7').attr('value', row.fa4_officewarebef7.replace(reg, '\n'));
                        $('#fa4_officewarebef8').attr('value', row.fa4_officewarebef8.replace(reg, '\n'));
                        $('#fa4_unofficewarebef1').attr('value', row.fa4_unofficewarebef1.replace(reg, '\n'));
                        $('#fa4_unofficewarebef2').attr('value', row.fa4_unofficewarebef2.replace(reg, '\n'));
                        $('#fa4_unofficewarebef3').attr('value', row.fa4_unofficewarebef3.replace(reg, '\n'));
                        $('#fa4_unofficewarebef4').attr('value', row.fa4_unofficewarebef4.replace(reg, '\n'));
                        $('#fa4_unofficewarebef5').attr('value', row.fa4_unofficewarebef5.replace(reg, '\n'));
                        $('#fa4_unofficewarebef6').attr('value', row.fa4_unofficewarebef6.replace(reg, '\n'));
                        $('#fa4_unofficewarebef7').attr('value', row.fa4_unofficewarebef7.replace(reg, '\n'));
                        $('#fa4_unofficewarebef8').attr('value', row.fa4_unofficewarebef8.replace(reg, '\n'));
                        $('#fa4_opentimebef1').attr('value', row.fa4_opentimebef1);
                        $('#fa4_opentimebef2').attr('value', row.fa4_opentimebef2);
                        $('#fa4_opentimebef3').attr('value', row.fa4_opentimebef3);
                        $('#fa4_opentimebef4').attr('value', row.fa4_opentimebef4);
                        $('#fa4_officewareaft1').attr('value', row.fa4_officewareaft1.replace(reg, '\n'));
                        $('#fa4_officewareaft2').attr('value', row.fa4_officewareaft2.replace(reg, '\n'));
                        $('#fa4_officewareaft3').attr('value', row.fa4_officewareaft3.replace(reg, '\n'));
                        $('#fa4_officewareaft4').attr('value', row.fa4_officewareaft4.replace(reg, '\n'));
                        $('#fa4_officewareaft5').attr('value', row.fa4_officewareaft5.replace(reg, '\n'));
                        $('#fa4_officewareaft6').attr('value', row.fa4_officewareaft6.replace(reg, '\n'));
                        $('#fa4_officewareaft7').attr('value', row.fa4_officewareaft7.replace(reg, '\n'));
                        $('#fa4_officewareaft8').attr('value', row.fa4_officewareaft8.replace(reg, '\n'));
                        $('#fa4_unofficewareaft1').attr('value', row.fa4_unofficewareaft1.replace(reg, '\n'));
                        $('#fa4_unofficewareaft2').attr('value', row.fa4_unofficewareaft2.replace(reg, '\n'));
                        $('#fa4_unofficewareaft3').attr('value', row.fa4_unofficewareaft3.replace(reg, '\n'));
                        $('#fa4_unofficewareaft4').attr('value', row.fa4_unofficewareaft4.replace(reg, '\n'));
                        $('#fa4_unofficewareaft5').attr('value', row.fa4_unofficewareaft5.replace(reg, '\n'));
                        $('#fa4_unofficewareaft6').attr('value', row.fa4_unofficewareaft6.replace(reg, '\n'));
                        $('#fa4_unofficewareaft7').attr('value', row.fa4_unofficewareaft7.replace(reg, '\n'));
                        $('#fa4_unofficewareaft8').attr('value', row.fa4_unofficewareaft8.replace(reg, '\n'));
                        $('#fa4_opentimeaft1').attr('value', row.fa4_opentimeaft1);
                        $('#fa4_opentimeaft2').attr('value', row.fa4_opentimeaft2);
                        $('#fa4_opentimeaft3').attr('value', row.fa4_opentimeaft3);
                        $('#fa4_opentimeaft4').attr('value', row.fa4_opentimeaft4);
                        $('#fa4_compreheevaluation').attr('value', row.fa4_compreheevaluation.replace(reg, '\n'));
                        $('#fa4_specificrequire').attr('value', row.fa4_specificrequire.replace(reg, '\n'));
                        $('#fa4_suggest').attr('value', row.fa4_suggest.replace(reg, '\n'));
                        $('#fa4_audit').attr('value', row.fa4_audit);
                        $('#fa4_auditdate').attr('value', row.fa4_auditdate);
                        //window.print();
                    }   
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "查询错误！", 'error');
        }
    }) 
    
    
}


/***********************************************************************
 *  undefined 或 null  转换成 '' 
 *  DLY
 *  2013-04-18
 */ 
function undefinedOrNull(obj){ 
	 if(obj == undefined || obj == null){
		 return '';
	 }else{
		 return obj;
	 }
}
   