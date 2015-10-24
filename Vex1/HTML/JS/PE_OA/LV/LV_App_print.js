//下拉数组 
var m_AssetsType = [];//资产类别  


/*********************************/
/**
 * 设置打印页面数据
 * @param formId
 */
function setValues() { 
    var billInfo ='';
    if (basedata_getUrlParam("v0") == undefined || basedata_getUrlParam("v0") == '') {
        alert('申购单号无效！');
        return false;

    }
    var cPOApplyCode = basedata_getUrlParam("v0");

    var cxml = '';
     

    //基础数据
    var AssetsTypeid = peoa_GetBDFID(5); 
    var cons = ' AND CT1_FatherID in (' 
             + '\'' + AssetsTypeid  + '\'' 
             + ')'; 
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == AssetsTypeid.toUpperCase()) {
            m_AssetsType.push(res[i]);
        } 
    }
    


    var billInfo = '';
    //获取主表信息
    var cXML = '<Page>1</Page><Num>1</Num>'
              + '<Cons> AND LV1_POApplyCode = \'' + cPOApplyCode + '\'</Cons><OrderBy></OrderBy>'
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetHs&XML=" + encodeURIComponent(cXML); //拼接url

    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                billInfo = data.rows[0];
                var cdata = data.rows[0];
                $('#POApplyCode').attr('value', cdata.lv1_poapplycode);
                $('#ApplyDt').attr('value', dateUtil_dateFomaterB(new Date(cdata.lv1_applydt), '-'));
                $('#ApplyUser').attr('value', cdata.lv1_applyuser);
                $('#EmployeeId').attr('value', cdata.lv1_employeeid);
                $('#DeptName').attr('value', cdata.lv1_deptname);
                $('#CenterCode').attr('value', cdata.lv1_centercode);
                $('#AssetsType').attr('value', basedata_getCodename(m_AssetsType, cdata.lv1_assetstype,'ct1_code','ct1_codename'));
                $('#ConfirmAmount').text(dataUtil_formatNum(cdata.lv1_confirmamount));
                $('#Comment').text(decodeURIComponent(cdata.lv1_comment));
            } 
        }
    }) 

    if($('#POApplyCode').attr('value')==''){
        return false;
    }

    //获取从表信息 
    var cXML1 = '<Page>1</Page><Num>100</Num>'
              + '<Cons> AND LV2_POApplyCode = \'' + cPOApplyCode + '\'</Cons><OrderBy></OrderBy>'
    cXML1 = basedata_addROOT(cXML1);
    var curl1 = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetDs&XML=" + encodeURIComponent(cXML1); //拼接url
    $.ajax({
        url: curl1,
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));   
            if (data && data.rows) {
                var cdata = data.rows;
                for (var i = 0; i < cdata.length; i++) {
                    if (i < 10) {
                        $('#spantd' + i + '1').text(cdata[i].lv2_assetsname);
                        $('#spantd' + i + '2').text(cdata[i].lv2_brandcode);
                        $('#spantd' + i + '3').text(cdata[i].lv2_model);
                        $('#spantd' + i + '4').text(cdata[i].lv2_number);
                        $('#spantd' + i + '5').text(dataUtil_formatNum(cdata[i].lv2_applyprice));
                        $('#spantd' + i + '6').text(dataUtil_formatNum(cdata[i].lv2_sureprice));
                        $('#spantd' + i + '7').text(dataUtil_formatNum(cdata[i].lv2_number * cdata[i].lv2_sureprice));
                        $('#spantd' + i + '8').text(cdata[i].lv2_username);
                    }
                }
            }
        }
    })


    //设置打印签字信息begin
    var imgt = '<img height="40" border="0" '
         + 'oncontextmenu="return false" ondragstart="return false" '
        + 'onselectstart ="return false" onselect="return false" oncopy="return false" '
        + 'onbeforecopy="return false" onmouseup="return false" '
        + 'src=>';

    //获取审批信息
    var spInfo = new Object()
    spInfo.bmzname = getSignNameAndDate(billInfo.lv1_departmentdirector,1);
    spInfo.bmzdate = getSignNameAndDate(billInfo.lv1_departmentdirector,2);
    spInfo.sybjlname = getSignNameAndDate(billInfo.lv1_divisionmanager, 1);
    spInfo.sybjldate = getSignNameAndDate(billInfo.lv1_divisionmanager, 2);
    spInfo.xxzjname = getSignNameAndDate(billInfo.lv1_itdirector, 1);
    spInfo.xxzjdate = getSignNameAndDate(billInfo.lv1_itdirector, 2);
    spInfo.cgjlname = getSignNameAndDate(billInfo.lv1_purchasemanager, 1);
    spInfo.cgjldate = getSignNameAndDate(billInfo.lv1_purchasemanager, 2);
    spInfo.xzzjname = getSignNameAndDate(billInfo.lv1_shareservicecenterdirector, 1);
    spInfo.xzzjdate = getSignNameAndDate(billInfo.lv1_shareservicecenterdirector, 2);
    spInfo.cwjlname = getSignNameAndDate(billInfo.lv1_financedirector, 1);
    spInfo.cwjldate = getSignNameAndDate(billInfo.lv1_financedirector, 2);  
 
   
    //获取相关签名信息
    var cons = ' AND CT1_FatherID = \'' + peoa_GetBDFID(10) + '\'';
    var pers = '\'' + spInfo.bmzname + '\',' + '\'' + spInfo.sybjlname + '\',' 
             + '\'' + spInfo.xxzjname + '\',' + '\'' + spInfo.cgjlname + '\',' 
             + '\'' + spInfo.xzzjname + '\',' + '\'' + spInfo.cwjlname + '\','
             + '\'A\'';
             cons = cons + 'AND CT1_Code IN (' + pers + ')'; 
    var signs = basedata_getBDCommon('gbd12', cons);  
 

    //部门长
    if (spInfo.bmzname != '') {
        $('#sign_bmz').html(spInfo.bmzname);
        for (var i = 0; i < signs.length; i++) { 
            if (signs[i].ct1_code == spInfo.bmzname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_bmz').html(imgs);
                //$('#sign_bmz').html(imgs + '<br><font size=1>' + spInfo.bmzdate + '</font>');
                break;
            }
        }
    }  

    //事业部经理
    if (spInfo.sybjlname != '') {
        $('#sign_sybjl').html(spInfo.sybjlname);
        for (var i = 0; i < signs.length; i++) {
            if (signs[i].ct1_code == spInfo.sybjlname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_sybjl').html(imgs);
                break;
            }
        }
    }

    //信息总监
    if (spInfo.xxzjname != '') {
        $('#sign_xxzj').html(spInfo.xxzjname);
        for (var i = 0; i < signs.length; i++) {
            if (signs[i].ct1_code == spInfo.xxzjname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_xxzj').html(imgs);
                break;
            }
        }
    }

    //采购经理
    if (spInfo.cgjlname != '') {
        $('#sign_cgjl').html(spInfo.cgjlname);
        for (var i = 0; i < signs.length; i++) {
            if (signs[i].ct1_code == spInfo.cgjlname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_cgjl').html(imgs);
                break;
            }
        }
    }

    //行政总监
    if (spInfo.xzzjname != '') {
        $('#sign_xzzj').html(spInfo.xzzjname);
        for (var i = 0; i < signs.length; i++) {
            if (signs[i].ct1_code == spInfo.xzzjname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_xzzj').html(imgs);
                break;
            }
        }
    }

    /* 
    //财务经理
    if (spInfo.cwjlname != '') {
        $('#sign_cwjl').html(spInfo.cwjlname);
        for (var i = 0; i < signs.length; i++) {
            if (signs[i].ct1_code == spInfo.cwjlname && signs[i].ct1_fieldvalues1 == '图片') {
                var isrc = basedata_random(signs[i].ct1_fieldvalues3, signs[i].ct1_fieldvalues4, signs[i].ct1_fieldvalues5);
                var imgs = imgt.replace('src=', 'src="' + isrc + '"');
                $('#sign_cwjl').html(imgs);
                break;
            }
        }
    }
    */
    
    //设置打印签字信息end
    
    
  /*
  $('#printTT').text(basedate_getPrintTT(billInfo.comID,billInfo.companyCode));  
   window.print(); 
  */
  
  // 设置表单编号条形码 
    var srcstr = 'http://192.168.0.43/barcode.bracodeServlet?image=1&type=21&data=' + cPOApplyCode + '&height=50';
  $('#billcodetxm').attr('src',srcstr);
  
 
  
}


/***********************************************************************
 *  undefined 或 null  转换成 '' 
 *  DLY 
 */ 
function undefinedOrNull(obj){ 
	 if(obj == undefined || obj == null){
		 return '';
	 }else{
		 return obj;
	 }
}
  
/***********************************************************************
 *  分割审批信息
 *  DLY 
 */
function getSignNameAndDate(s, type) {
    res = '';
    if (undefinedOrNull(s) != '' && s.length > 11 && s.indexOf('驳回') == -1 ) {
        if (type == 1) {
            res = dataUtil_trim(s.substring(0, s.length - 10));
        } else if (type == 2) {
            res = dataUtil_trim(s.substring(s.length - 10, s.length));
        }
    }
    return res;
}