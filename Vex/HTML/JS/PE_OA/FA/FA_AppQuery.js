var m_SGMXdgId = '#sgmxlb'; //费用明细列表ID
var m_LastIndex = undefined;  //费用明细列表最后一次选中行下标   




//相关选项
var m_YesOrNo = [];
var m_AssetsType = [];
var m_BudgetType = [];
var m_APPState = [];

//用户信息
var m_UserInfo = '';



;
/***********************************************************************
 *  初始化设置
 *  DLY
 *  2014-05-07
 */
$(function () {

    var cxml = '';

    /*
    //资产类别 
    m_AssetsType = basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
       , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'AssetsType', '', '');

    //预算内外 
    m_BudgetType = basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
       , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'BudgetType', '', '');

    //单据状态 
    m_APPState = basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
       , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'FA_APPState', '', '');
    */


    //基础数据
    var AssetsTypeid = peoa_GetBDFID(5);//资产类别 
    var BudgetTypeid = peoa_GetBDFID(12); //预算内外 
    var APPStateid = peoa_GetBDFID(11);//单据状态 
    var cons = ' AND CT1_FatherID in ('
             + '\'' + AssetsTypeid + '\','
             + '\'' + APPStateid + '\','
             + '\'' + BudgetTypeid + '\''
             + ')';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == AssetsTypeid.toUpperCase()) {
            m_AssetsType.push(res[i]); 
        } else if (f1 == BudgetTypeid.toUpperCase()) {
            m_BudgetType.push(res[i]);
        } else if (f1 == APPStateid.toUpperCase()) {
            m_APPState.push(res[i]);
        }
    }

    actsgmxlbcsh(); //初始化设置申购明细列表 

    //根据URL参数初始化表单数据
    setbillInfoByURL();
});

/***********************************************************************
 *  申购明细列表初始化
 *  DLY
 *  2014-04-28
 */
function actsgmxlbcsh() {
    $(m_SGMXdgId).datagrid({
        //title:'申购明细列表', 
        width: 900,
        height: 240,
        nowrap: true,
        striped: true,
        collapsible: true,
        sortName: 'fa2_id',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'fa2_id',
        iconCls: 'icon-tip',
        loadMsg: '数据加载中请稍后……',
        frozenColumns: [[

        ]],
        columns: [[
			{ field: 'fa2_id', title: 'FID', width: 100, hidden: true },
            { field: 'fa2_cono', title: 'cono', width: 100, hidden: true },
            { field: 'fa2_divi', title: 'divi', width: 100, hidden: true },
            { field: 'fa2_poapplycode', title: '单据编号', width: 100, hidden: true },
			{ field: 'fa2_largeclassname', title: '资产大类', width: 100 },
			{ field: 'fa2_largeclasscode', title: '大类编码', width: 100 },
			{ field: 'fa2_smallclassname', title: '资产小类', width: 100 },
			{ field: 'fa2_smallclasscode', title: '小类编码', width: 100 },
			{ field: 'fa2_assetsname', title: '资产名称', width: 100 },
			{ field: 'fa2_brandcode', title: '品牌', width: 100 },
			{ field: 'fa2_model', title: '规格/型号', width: 100 },
			{ field: 'fa2_number', title: '数量', width: 35 },
			{
			    field: 'fa2_applyprice', title: '申请单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{
			    field: 'fa2_sureprice', title: '确认单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'fa2_username', title: '使用人', width: 70 },
			{ field: 'fa2_usercode', title: '员工号', width: 70 },
			{ field: 'fa2_isadjust', title: '是否调配', width: 70 },
		    { field: 'fa2_planuse', title: '行动计划', width: 100 },
			{
			    field: 'fa2_ccasfid', title: '附件ID', width: 100
                , formatter: function (val) {
			        if (val == undefined || val == null) {
			            return val;
			        }
			        var vals = val.split(',');
			        if (val && vals.length == 2) {
			            if (vals[0] == 1) {
			                var curl = '../../../WEB/PE_OA/FA/FA_CCAS_print.html?v0=' + vals[1];
			                return '&nbsp;&nbsp;&nbsp;' + '<a href="#" style="background-color:#FFBBFF" onclick=\'javascript:window.open("' + curl + '")\'>查看鉴定单</a>';
			            } else if (vals[0] == 2) {
			                var curl = '../../../WEB/PE_OA/FA/FA_IPDR_print.html?v0=' + vals[1];
			                return '&nbsp;&nbsp;&nbsp;' + '<a href="#" style="background-color:#FFBBFF" onclick=\'javascript:window.open("' + curl + '")\'>查看诊断单</a>';
			            }
			        }
			        return val;
			    }
			},
			{ field: 'fa2_filepath', title: '附件路径', width: 100, hidden: true },
			{ field: 'fa2_comment', title: '备注', width: 150 },
			{ field: 'fa2_rgdt', title: '创建时间', hidden: true },
			{ field: 'fa2_rguser', title: '创建人', hidden: true },
		    { field: 'fa2_lmdt', title: '修改时间', hidden: true },
            { field: 'fa2_lmuser', title: '修改人', hidden: true },
            { field: 'fa2_uptno', title: '创建人', hidden: true }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function () {
        },
        onClickRow: function (rowIndex) {
            $(m_SGMXdgId).datagrid('selectRow', rowIndex);
            m_LastIndex = rowIndex;
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {
        },
        toolbar: []
    });
}





/***********************************************************************
 *  
 * 根据URL加载初始数据 
 *  DLY
 *  2014-05-15
 */
function setbillInfoByURL() {
    if (basedata_getUrlParam("v0") == undefined || basedata_getUrlParam("v0") == '') {
        alert('申购单号无效！');
        return false;

    }
    var cPOApplyCode = basedata_getUrlParam("v0");
    //alert(cPOApplyCode);
    //获取主表信息
    var cxml3 = '<CONO>HWA</CONO><DIVI>D01</DIVI><POApplyCode>' + cPOApplyCode + '</POApplyCode>'
    cxml3 = basedata_addROOT(cxml3);
    var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=GetH&XML="
              + encodeURIComponent(cxml3); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                setbillInfo(data.rows[0]);
            }

        }
    })

    //获取从表信息
    cxml3 = '<CONO>HWA</CONO><DIVI>D01</DIVI><POApplyCode>' + cPOApplyCode + '</POApplyCode>'
    cxml3 = basedata_addROOT(cxml3);
    var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=GetD1&XML="
              + encodeURIComponent(cxml3); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));   
            if (data && data.rows && data.rows[0].fa2_id) {
                $(m_SGMXdgId).datagrid('loadData', data.rows);
            }
        }
    })

}

/***********************************************************************
 *  
 * 设置主表信息
 *  DLY
 *  2014-05-15
 */
function setbillInfo(cdata) {
    if (cdata == undefined && cdata == null) {
        return false;
    }

    $('#ID').attr('value', cdata.fa1_id);
    $('#CONO').attr('value', cdata.fa1_cono);
    $('#DIVI').attr('value', cdata.fa1_divi);
    $('#GenusCompanyName').attr('value', cdata.fa1_genuscompanyname);
    $('#ProjectCode').attr('value', cdata.fa1_projectcode);
    $('#AdvancedCode').attr('value', cdata.fa1_advancedcode);
    $('#State').attr('value', basedata_getCodename(m_APPState, cdata.fa1_state, 'ct1_code', 'ct1_codename'));
    $('#POApplyCode').attr('value', cdata.fa1_poapplycode);
    $('#ApplyDt').attr('value', dateUtil_dateFomaterB(new Date(cdata.fa1_applydt), '-'));
    $('#ApplyUser').attr('value', cdata.fa1_applyuser);
    $('#DeptName').attr('value', cdata.fa1_deptname);
    $('#AssetsType').attr('value', basedata_getCodename(m_AssetsType, cdata.fa1_assetstype, 'ct1_code', 'ct1_codename'));
    $('#EmployeeId').attr('value', cdata.fa1_employeeid);
    $('#CenterCode').attr('value', cdata.fa1_centercode);
    $('#BudgetType').attr('value', basedata_getCodename(m_BudgetType, cdata.fa1_budgettype, 'ct1_code', 'ct1_codename'));
    $('#ApplyAmount').attr('value', dataUtil_formatNum(cdata.fa1_applyamount));
    $('#ConfirmAmount').attr('value', dataUtil_formatNum(cdata.fa1_confirmamount));
    $('#Comment').attr('value', decodeURIComponent(cdata.fa1_comment));
    $('#DepartmentDirector').text(cdata.fa1_departmentdirector);
    $('#DivisionManager').text(cdata.fa1_divisionmanager);
    $('#ITDirector').text(cdata.fa1_itdirector);
    $('#PurchaseManager').text(cdata.fa1_purchasemanager);
    $('#ShareServiceCenterDirector').text(cdata.fa1_shareservicecenterdirector);
    $('#FinanceDirector').text(cdata.fa1_financedirector);
}



/*******************
 * 调用打印页
 */
function print() {
    var billcode = $("#POApplyCode").attr("value");
    if (billcode == null || billcode == '' || billcode == '（系统自动生成）') {
        $.messager.alert('提示', '保存生成单号才能打印');
        return;
    }
    window.open("../../../WEB/PE_OA/FA/FA_App_print.html?v0=" + billcode);
}


