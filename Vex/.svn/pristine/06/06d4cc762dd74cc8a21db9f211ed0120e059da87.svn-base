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
             + '<Cons>' + 'AND fa3_id=\'' + basedata_getUrlParam("v0") + '\'</Cons><OrderBy>fa3_rgdt DESC</OrderBy>'
    cXML = basedata_addROOT(cXML); 
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(6)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //data: cxmlsJson,
        dataType: "json",
        success: function (result) {
            try {
                //alert(result);  
                if (result.Error) {
                    $.messager.alert("系统错误", result.Error, 'error');
                } else if (result.rows.length > 0 && result.rows[0].result == "False") {
                    $.messager.alert("提示", result.rows[0].message, 'error');
                } else { 
                    //回写单据信息
                    if (result.rows && result.rows.length > 0) {
                        row = result.rows[0];  
                        $('#fa3_department').attr('value', row.fa3_department);
                        $('#fa3_name').attr('value', row.fa3_name);
                        $('#fa3_deviceno').attr('value', row.fa3_deviceno);
                        $('#fa3_assetsno').attr('value', row.fa3_assetsno);
                        $('#fa3_filldate').attr('value', row.fa3_filldate);//鉴定日期-当前日期
                        $('#fa3_faultphenomenon').attr('value', decodeURIComponent(row.fa3_faultphenomenon));
                        $('#fa3_diagnosisresults').attr('value', decodeURIComponent(row.fa3_diagnosisresults));
                        $('#fa3_solution').attr('value', decodeURIComponent(row.fa3_solution)); 
                        $('#fa3_no1').text(row.fa3_no1);
                        $('#fa3_brandmodel1').text(row.fa3_brandmodel1);
                        $('#fa3_num1').text(row.fa3_num1);
                        $('#fa3_remarks1').text(row.fa3_remarks1);
                        $('#fa3_no2').text(row.fa3_no2);
                        $('#fa3_brandmodel2').text(row.fa3_brandmodel2);
                        $('#fa3_num2').text(row.fa3_num2);
                        $('#fa3_remarks2').text(row.fa3_remarks2);
                        $('#fa3_no3').text(row.fa3_no3);
                        $('#fa3_brandmodel3').text(row.fa3_brandmodel3);
                        $('#fa3_num3').text(row.fa3_num3);
                        $('#fa3_remarks3').text(row.fa3_remarks3);
                        $('#fa3_diagnosisdept').text(row.fa3_diagnosisdept);
                        $('#fa3_diagnosispeople').text(row.fa3_diagnosispeople);
                        $('#fa3_audit').text(row.fa3_audit);
                        $('#fa3_auditdate').text(row.fa3_auditdate);
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
   