var m_DatagridID = '#BaseDatalb'; //列表ID
var m_LastIndex = -1;  //列表最后一次编辑行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 100;  //每页显示行数
  
 

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];
var m_Years = [{ "text": "2014" }, { "text": "2015" }];//年份
var m_Brands = [];//品牌
var m_Coms = [];  //公司 
var m_ShopTypes = [{ "text": "自营" }, { "text": "加盟" }];//店铺类型
//预算科目类别数组
var m_DLList = [];
var m_XLList = [];  //随大类的小类


//用户信息
var m_UserInfo = basedata_getUserInfo();

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = 'bg6_code '; //排序方式


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {
    //基础数据获取   
    var Brandid = peoa_GetBDFID(15);//品牌  
    var Comid = peoa_GetBDFID(14);//公司
    var DLListid = peoa_GetBDFID(17);//预算科目大类
    var cons = ' AND CT1_FatherID IN (\'' + Brandid + '\','
             + '\'' + Comid + '\',' + '\'' + DLListid + '\')'
             + ' AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons); 
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Brandid.toUpperCase()) {
            if ((res[i].ct1_fieldvalues4).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        } else if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        }
        else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]); 
        }
    }

    //年份
    $('#cxYear').combobox({
        panelWidth: "90",
        panelHeight: "80",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_Years,
        onChange: function (data) {
        },
        onSelect: function (record) { 
        }
    });

    //品牌选项获取  
    $('#cxBrand').combobox({
        panelWidth: "90",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_code',
        data: m_Brands,
        onChange: function (newValue, oldValue) {
        },
        onSelect: function (record) { 
        },
        onShowPanel: function () {
        }
    });

    //公司选项获取  
    $('#cxCom').combobox({
        panelWidth: "130",
        panelHeight: "120",
        editable: false,
        multiple: true,
        valueField: 'ct1_codename',
        textField: 'ct1_codename',
        data: m_Coms,
        onChange: function (newValue, oldValue) {
        }
    });

    //大区选项获取  
    $('#cxBranch').combobox({
        panelWidth: "120",
        panelHeight: "120",
        editable: true,
        multiple: false,
        valueField: 'oz1_orgname',
        textField: 'oz1_orgname',
        data: [],
        onShowPanel: function (rowIndex) {
            $('#cxBranch').combobox('loadData', []);
            var sbrand = $('#cxBrand').combobox('getValue');
            if (sbrand == '') {
                alert('请先选择品牌');
            } else {
                var rs = basedata_getBranchByBrand(sbrand);
                $('#cxBranch').combobox('loadData', rs);
            }
        }
    });

    //店铺类型选项获取  
    $('#cxShopType').combobox({
        panelWidth: "90",
        panelHeight: "90",
        editable: true,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_ShopTypes
    });

    //科目大类选项获取  
    $('#cxDLCode').combogrid({
        panelWidth: "200",
        panelHeight: "160",
        editable: false,
        multiple: false,
        idField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_DLList,
        columns: [[
            { field: 'ct1_code', title: '代码', width: 50 },
            { field: 'ct1_codename', title: '大类名称', width: 130 }
        ]],
        onClickRow: function (rowIndex) {
            var row = $('#cxDLCode').combogrid('grid').datagrid('getSelected');
            //设置小类选择div
            var XLListid = row.ct1_id; //预算科目小类 
            var cons = ' AND CT1_FatherID = \'' + XLListid + '\''
                     + ' AND CT1_State=\'启用\'';
            m_XLList = basedata_getBDCommon('gbd12', cons);
            $('#cxXLCode').combogrid('grid').datagrid('loadData', m_XLList); 
        }
    });

    //科目小类选项获取  
    $('#cxXLCode').combogrid({
        panelWidth: "200",
        panelHeight: "160",
        editable: false,
        multiple: false,
        idField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_XLList,
        columns: [[
            { field: 'ct1_code', title: '代码', width: 60 },
            { field: 'ct1_codename', title: '小类名称', width: 130 }
        ]],
        onChange: function (newValue, oldValue) {
        },
        onShowPanel: function () {
        }
    });

    //列表设置
    initdatagrid();

    //初始化查询
    clearText(); 
});
  
 
/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText() {
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    $('#cxBrand').combobox('setValue', '');
    $('#cxCenter').val('');
    $('#cxBranch').combobox('setValue', '');
    $('#cxShopType').combobox('setValue', '');
    $('#cxDLCode').combogrid('setValue', '');
    $('#cxXLCode').combogrid('setValue', ''); 
    $('#cxCom').combobox('setValues', '');
}


/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    //拼接条件 获取数据集 
    var cfilter = ' ';
    var cxYear = $('#cxYear').combobox('getValue');
    var cxBrand = $('#cxBrand').combobox('getValue'); 
    if (cxYear == '' || cxBrand == '') {
        alert('请选择年份及品牌！');
        return false;
    }

    var cxCenter = $('#cxCenter').val();
    var cxBranch = $('#cxBranch').combobox('getValue');
    var cxShopType = $('#cxShopType').combobox('getValue');
    var cxDLCode = $('#cxDLCode').combogrid('getValue');
    var cxXLCode = $('#cxXLCode').combogrid('getValue');
    var cxCom = $('#cxCom').combobox('getValues');
    cxCom = cxCom == '' ? '' : ',' + cxCom + ','; //两头加‘，’
    m_Filter1 = '<CONO></CONO><DIVI></DIVI>'
              + '<Year>' + cxYear + '</Year>'
              + '<Brand>' + cxBrand + '</Brand>'
              + '<CostCenter>' + cxCenter + '</CostCenter>'
              + '<Branch>' + cxBranch + '</Branch>'
              + '<ShopType>' + cxShopType + '</ShopType>'
              + '<DLCode>' + cxDLCode + '</DLCode>'
              + '<XLCode>' + cxXLCode + '</XLCode>'
              + '<Com>' + cxCom + '</Com>'
              + '<Dept>' + '' + '</Dept>'
              + '<Project>' + '' + '</Project>'
              + '<State>' + '' + '</State>';
    //alert(m_Filter1);
    var cXML = m_Filter1
             + '<Type>' + '品牌' + '</Type>';
    cXML = basedata_addROOT(cXML);  
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=ISRowsHZ&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) { 
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                $(m_DatagridID).datagrid('loadData', data.rows);
                totalCount = data.rows.length;
            }
        }
    });

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: 1
    }); 
}
  

/***********************************************************************
 *  列表设置
 *  DLY 
 */
function initdatagrid() {
    $(m_DatagridID).datagrid({
        //title:'列表', 
        //width: 500,
        height: 430,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'bg6_code',
        sortOrder: 'asc',
        //data: [],
        remoteSort: false,
        idField: 'bg6_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'bg6_id', title: 'Fid', width: 260, hidden: true }, 
            { field: 'bg6_year', title: '年份', width: 60},
            { field: 'bg6_brand', title: '品牌', width: 60},
			{ field: 'bg6_code', title: '系统编码', width: 65, sortable: true },
			{ field: 'bg6_code1', title: '自编号', width: 60, sortable: true},
			{ field: 'bg6_name', title: '名称', width: 120, sortable: true},
			{ field: 'bg6_remark', title: '说明', width: 150 },
			{
			    field: 'bg6_total', title: '合计', width: 160, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m1', title: '1月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m2', title: '2月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m3', title: '3月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m4', title: '4月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m5', title: '5月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m6', title: '6月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m7', title: '7月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m8', title: '8月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m9', title: '9月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m10', title: '10月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m11', title: '11月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
			{
			    field: 'bg6_m12', title: '12月', width: 120, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			}
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onClickRow: function (rowIndex, data) {
            //结束前一次选中的行，自动调用onAfterEdit
            if (m_LastIndex != undefined && m_LastIndex>=0) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            }
            $(m_DatagridID).datagrid('selectRow', rowIndex); 
            $(m_DatagridID).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex;
        } 
    });
    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数，默认为20  
        //pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) { 
        },
        buttons: [{
            text: '导出当前页',
            iconCls: 'icon-menu',
            handler: function () {
                var rows = $(m_DatagridID).datagrid('getRows');
                dataExpotToFile('10', rows, [], []);
            }
        }]

    }); 
}