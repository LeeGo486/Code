   
/***********************************************************************
 *  预算信息获取 
 *  DLY 
 */
function basedatalv_getYSInfo(centercode, date, billcode, type) {
    var res = [];
    if (dataUtil_undefinedOrNull(centercode, '') == '') {
        alert('成本中心不能为空！');
        return res;
    }
    if (dataUtil_undefinedOrNull(date, '') == '') {
        date = dateUtil_dateFomaterA(new Date(), '-');
    }
    if (dataUtil_undefinedOrNull(type, '') != 'lvapp') {
        $('#spankyje').html(0);
        $('#spanysje').html(0);
        var curyear = new Date().getFullYear(); 
        if (curyear > date) {
            date = curyear * 1 - 1 + '-12-12'; // 跨年取上一年
        } else {
            date = dateUtil_dateFomaterB(new Date(), '-');// 同年取当前
        }
    }
    billcode = dataUtil_undefinedOrNull(billcode, '');
    //date = '2015-11-17';//测试
    var cons  = '<CONO></CONO><DIVI></DIVI>'
               + '<CenterCode>' + centercode + '</CenterCode>'
               + '<Date>' + date + '</Date>'
               + '<BillCode>' + billcode + '</BillCode>'; 
    cXML = basedata_addROOT(cons);
    var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetYSInfo&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].flag, '') != '') {
                    if (data.rows[0].flag == '0') {
                        alert(data.rows[0].message);
                    } else if (data.rows[0].flag == '1') {
                        res = data.rows;
                        if (dataUtil_undefinedOrNull(type, '') == 'lvapp') {
                            $('#spankyje').html(dataUtil_formatNum(res[0].kyje));
                            $('#spanysje').html(dataUtil_formatNum(res[0].ysje));
                        }
                    }
                }
            }
        }
    }); 
    return res;
}

 