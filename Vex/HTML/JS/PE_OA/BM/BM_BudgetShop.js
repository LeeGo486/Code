var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 2000;  //每页显示行数

//用户信息
var m_UserInfo = basedata_getUserInfo();


//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌
var m_Branchs = []; //大区


//预算科目类别数组
var m_DLList = [];
var m_XLList = [];
var m_DLList1 = '\'0\''; // 店铺模板大类codes  筛选大小类用
var m_XLList1 = '\'0\''; // 店铺模板小类codes  筛选大小类用

//状态
var m_States = [{ id: "0", text: "未审核" }, { id: "1", text: "已审核" }];

//CONO
var m_CONOs = [{ "text": "EP" }, { "text": "DL" }];

//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }, { "text": "2016" }, { "text": "2017" }, { "text": "2018" }];
var m_ShopTypes = [{ "text": "自营" }, { "text": "加盟" }, { "text": "全部" }];


// 过滤条件
var m_Filter = '';  //主的条件 
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_Filter3 = ''; //查询条件到品牌
var m_OrderBy = 'BG3_Com, BG3_Branch, BG3_CenterCode'; //排序方式


//主条件切换时，是否放弃数据保存标志， 品牌，大小类，年份切换时用
var m_changeFlag = 0;
var m_Role = 'A'; //操作员身份
var m_EditFlag = 0; //是否可编辑状态


var m_btn3bgcolor = '#28b779';


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        //根据index.html页面的高度设置列表高度 
        $(m_DatagridID).datagrid('resize', {
            width: $(document.body).width()
            //height: getcurheight()
        });
    });

    //确认操作员
    for (var i = 0; i < m_UserInfo.roles.length; i++) {
        var authorization_text = m_UserInfo.roles[i].authorization_name;
        var authorization_id = m_UserInfo.roles[i].authorization_id;
        if (authorization_text == '店铺预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '预算经理') {
            m_Role = 'B';
            break;
        }
    }

    var cxml = '';
    //基础数据获取  
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌
    var Branchid = peoa_GetBDFID(16);//大区
    var DLListid = peoa_GetBDFID(17);//预算科目大类
    var DLListid1 = peoa_GetBDFID(20);//预算科目大类-店铺模板MD3
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + Branchid + '\',' + '\'' + DLListid1 + '\''
             + ') AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) {
            if ((res[i].ct1_fieldvalues1).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                 || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        } else if (f1 == Branchid.toUpperCase()) {
            m_Branchs.push(res[i]);
        } else if (f1 == DLListid1.toUpperCase()) {
            m_XLList1 = m_XLList1 + ',\'' + res[i].ct1_code + '\'';
            if (m_DLList1.indexOf(',\'' + res[i].ct1_codename + '\'') < 0) {
                m_DLList1 = m_DLList1 + ',\'' + res[i].ct1_codename + '\'';
            }
        }
    }

    //根据店铺模板大类code，获取大类
    var cons = ' AND CT1_FatherID = \'' + DLListid + '\''
             + ' AND CT1_State=\'启用\''
             + ' AND CT1_Code in(' + m_DLList1 + ')'; 
    var m_DLList = basedata_getBDCommon('gbd12', cons);

    //品牌选项获取  
    $('#cxBrand').combobox({
        panelWidth: "90",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_code',
        data: m_Brands,
        onSelect: function (record) {
            changeBrand(record.ct1_code);
            searchByCons();
        },
        onShowPanel: function () {
            actContralSave('combo', '#cxBrand');
        }
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
            $("#spanDLCode").html(row.ct1_code);
            //设置小类选择div
            var XLListid = row.ct1_id; //预算科目小类
            var cons = ' AND CT1_FatherID = \'' + XLListid + '\''
                     + ' AND CT1_State=\'启用\''
                     + ' AND CT1_Code in(' + m_XLList1 + ')';
            m_XLList = basedata_getBDCommon('gbd12', cons);
            $("#spanXLCode").html('');
            setXLTypes(m_XLList);
        },
        onShowPanel: function (rowIndex) {
            actContralSave('combo', '#cxDLCode');
        }
    });

    /*
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
            //重新加载数据
            searchByCons();
        },
        onShowPanel: function (rowIndex) {
            actContralSave('combo', '#cxYear');
        }
    });
    */

    //大区选项获取  
    $('#cxBranch').combobox({
        panelWidth: "120",
        panelHeight: "120",
        editable: true,
        multiple: true,
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
        /*
        valueField: 'ct1_codename',
        textField: 'ct1_codename',
        data: m_Branchs,
        onChange: function (record) {
            searchByCons();
        },
        onShowPanel: function () {
            actContralSave('combo', '#cxBranch');
        }
        */
    });

    //店铺类型选项获取  
    $('#cxShopType').combobox({
        panelWidth: "90",
        panelHeight: "90",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_ShopTypes,
        onSelect: function (record) {
            searchByCons();
        },
        onShowPanel: function () {
            actContralSave('combo', '#cxShopType');
        }
    });

    //初始化列表
    actyslbcsh(m_DatagridID);
    //初始化赋值
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    $('#cxBrand').combobox('setValue', '');
    if (m_Brands.length >= 1) {
        changeBrand(m_Brands[0].ct1_code);
        $('#cxBrand').combobox('setValue', m_Brands[0].ct1_code);
    }
    $('#cxDLCode').combogrid('setValue', '');
    searchByCons();




    //鼠标单击后事件设置选中行合计值
    document.onmouseup = function (e) {
        getRowTotal(m_LastIndex, 'dg');
        return true;
    }

});


/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() {
    $("#spanTatolpage").html('0');
    $("#spanTatol").html('0');
    $("#spanTatolT").html('0');
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = 1;

    //拼接条件 获取数据集
    var syear = $('#cxYear').combobox('getValue');
    var sbrand = $('#cxBrand').combobox('getValue');
    var sdlcode = $('#cxDLCode').combogrid('getValue');
    var sxlcode = $("#spanXLCode").html();
    var sbranchs = $('#cxBranch').combobox('getValues');
    var sshoptype = $('#cxShopType').combobox('getValue');
    if (sbrand == '' || syear == '') {
        $(m_DatagridID).datagrid('loadData', []);
        return true;
    }
    var cfilter = ' AND bg3_type = \'0\' And isnull(bg3_state,0) = 0';
    cfilter = cfilter + ' AND  bg3_year = \'' + syear + '\'';
    cfilter = cfilter + ' AND  bg3_brand = \'' + sbrand + '\'';
    m_Filter3 = cfilter;  // 条件到品牌

    cfilter = cfilter + ' AND  bg3_dlcode = \'' + sdlcode + '\'';
    m_Filter2 = cfilter;  // 条件到大类

    sxlcode = basedata_getCodename(m_XLList, $("#spanXLCode").html(), 'ct1_id', 'ct1_code');
    cfilter = cfilter + ' AND  bg3_xlcode = \'' + sxlcode + '\'';
    if (sbranchs != '') {
        sbranchs = sbranchs.join('\',\'');
        sbranchs = '\'' + sbranchs + '\'';
        cfilter = cfilter + ' AND  bg3_branch in (' + sbranchs + ')';
    }
    if (sshoptype != '' && sshoptype != '全部') {
        cfilter = cfilter + ' AND  bg3_shoptype = \'' + sshoptype + '\'';
    }
    m_Filter1 = cfilter;  // 条件到小类
    actLoadData(m_PageNumber, m_PageSize);

}


/***********************************************************************
 *  刷新列表数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();//拼接url
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
                if (dataUtil_undefinedOrNull(data.rows[0].bg3_id, '') != '') {
                    $(m_DatagridID).datagrid('loadData', data.rows);
                }
            }
        }
    })
    $(m_DatagridID).datagrid("clearSelections");


    // 合计当前页金额  
    var sum = 0;
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        sum = sum * 1 + rows[i].bg3_total * 1;
    }
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));

    // 合计大类金额
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + m_Filter + m_Filter2 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetSums&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $("#spanTatol").html('0');
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].stotal, '') != '') {
                    $("#spanTatol").html(dataUtil_formatNum1(data.rows[0].stotal, '0'));
                }
            }
        }
    })

    // 合计总金额
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + m_Filter + m_Filter3 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetSums&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $("#spanTatolT").html('0');
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].stotal, '') != '') {
                    $("#spanTatolT").html(dataUtil_formatNum1(data.rows[0].stotal, 0));
                }
            }
        }
    })
}


/***********************************************************************
 *  店铺预算列表初始化
 *  DLY 
 */
function actyslbcsh(dgid) {
    $(dgid).datagrid({
        //title:'预算列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 500,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'bg3_id',
        frozenColumns: [[
        ]],
        columns: [[
            { field: 'bg3_id', title: 'FID', width: 100, hidden: true },
            { field: 'bg3_cono', title: 'cono', width: 40, hidden: true },
            { field: 'bg3_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg3_type', title: '类别', width: 40, hidden: true },
            { field: 'bg3_year', title: '年份', width: 50, hidden: true },
            { field: 'bg3_com', title: '<input id=\"detailcheckbox\" type=\"checkbox\">&nbsp;&nbsp;公司', width: 70 },
            { field: 'bg3_branch', title: '大区', width: 80 },
            { field: 'bg3_shoptype', title: '类型', width: 45 },
            { field: 'bg3_centercode', title: '成本中心', width: 70 },
            { field: 'bg3_deptid', title: '店铺编码', width: 100, hidden: true },
            { field: 'bg3_deptname', title: '店铺名称', width: 120 },
            { field: 'bg3_remark1', title: '说明', width: 150, editor: 'text' },
            {
                field: 'bg3_total', title: '合计', width: 90, align: "right"
				, editor: { type: 'numberbox', options: { disabled: true, precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m1', title: '1月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m2', title: '2月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m3', title: '3月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m4', title: '4月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m5', title: '5月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m6', title: '6月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m7', title: '7月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m8', title: '8月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m9', title: '9月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m10', title: '10月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m11', title: '11月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m12', title: '12月', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
		    { field: 'bg3_state', title: '状态', width: 60, hidden: true },
		    {
		        field: 'bg3_dlname', title: '大类名称', width: 90
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.bg3_dlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_dlcode', title: '大类代码', width: 70 },
		    {
		        field: 'bg3_xlname', title: '小类名称', width: 90
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_xlcode', title: '小类代码', width: 70 },
            { field: 'bg3_brand', title: '品牌', width: 60 },
            { field: 'bg3_remark2', title: '说明2', width: 100, editor: 'text', hidden: true },
			{ field: 'bg3_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg3_rguser', title: '创建人', width: 70, hidden: true },
		    { field: 'bg3_lmdt', title: '修改时间', width: 105 },
            { field: 'bg3_lmuser', title: '修改人', width: 70 },
            { field: 'bg3_uptno', title: '次数', width: 45 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: false,
        onDblClickRow: function (rowIndex) {
            $(m_DatagridID).datagrid("clearSelections");
            $(dgid).datagrid('selectRow', rowIndex);
            if (m_EditFlag == 1) {
                return false;
            } 
            m_LastIndex = rowIndex;
            $(dgid).datagrid('beginEdit', rowIndex);
             
        },
        onClickRow: function (rowIndex) {
            $(dgid).datagrid('endEdit', m_LastIndex);
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        },
        //onRowContextMenu: onRowContextMenu, 
        toolbar: '#tjcxk'
    });
}


//添加右击菜单内容
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();
    //var selected = $("#test").datagrid('getRows'); //获取所有行集合对象
    //selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象
    //$('#mm').menu('show', {
    //    left: e.pageX,
    //    top: e.pageY
    //});
}


/***********************************************************************
 *  合计字段绑定只读事件
 *  DLY 
 */
function bindTotalField(rowIndex) {
    var ed = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg3_total' });
    ed.target.bind('keypress', function () { return false; });
    ed.target.bind('keydown', function () { return false; });
    ed.target.bind('focus', function () { return false; });
    ed.target.bind('mousedown', function (e) {
        if (3 == e.which) {
            alert('该合计字段不可右键操作！');
        }
        return false;
    });
    //ed.target.bind('paste', function (e) { 
    //    return false;
    //});
    //var ed1 = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg3_m1' });
    //ed1.target.bind('paste', function (e) {
    //    var element = this;
    //    setTimeout(function () {
    //        var text = $(element).val();
    //        text = window.clipboardData.getData("text"); 
    //        actCopeToAdd(text);
    //    }, 100); 
    //});


}


/***********************************************************************
 *  设置选中行合计值 或 设置行编辑窗合计
 *  DLY 
 */
function getRowTotal(rowIndex, type) {
    var sum = 0;
    if (type == 'dg') {
        if (rowIndex != undefined && rowIndex >= 0) {
            var edt = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg3_total' });
            if (edt == undefined) {
                return false;
            }
            for (var i = 1; i < 13; i++) {
                var ed = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg3_m' + i });
                if (ed != undefined && !isNaN(ed.target.val())) {
                    sum = sum * 1 + dataUtil_toFixed(ed.target.val(), 2) * 1;
                }
            }
            var sum1 = edt.target.val() * 1;
            if (dataUtil_toFixed(sum1, 2) != dataUtil_toFixed(sum, 2)) {
                edt.target.numberbox('setValue', dataUtil_toFixed(sum, 2) * 1);
            }

        }
    } else if (type == 'dlg') {
        sum = $('#rbg3_m1').numberbox('getValue') * 1 + $('#rbg3_m2').numberbox('getValue') * 1
                 + $('#rbg3_m3').numberbox('getValue') * 1 + $('#rbg3_m4').numberbox('getValue') * 1
                 + $('#rbg3_m5').numberbox('getValue') * 1 + $('#rbg3_m6').numberbox('getValue') * 1
                 + $('#rbg3_m7').numberbox('getValue') * 1 + $('#rbg3_m8').numberbox('getValue') * 1
                 + $('#rbg3_m9').numberbox('getValue') * 1 + $('#rbg3_m10').numberbox('getValue') * 1
                 + $('#rbg3_m11').numberbox('getValue') * 1 + $('#rbg3_m12').numberbox('getValue') * 1;
        $("#spanrowtotal").html(dataUtil_toFixed(sum, 2));
    }
    return sum;
}


/***********************************************************************
 *  excel复制添加事件
 *  DLY 
 */
function actCopeToAdd(text) { 
    var flag = 0;
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    $(m_DatagridID).datagrid("clearSelections");
    var rows = $(m_DatagridID).datagrid('getRows');
    if (text == undefined) {
        if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
            text = window.clipboardData.getData("text");
        } else {
            $('#textexcelcope').val('');
            $('#excelcopedlg').dialog('open');
            return false;
        }
    }
    if (dataUtil_undefinedOrNull(text, '') != '') {
        $('#waitdlg').dialog('open');
        flag = 1;
        setTimeout(function () {
            var reg = new RegExp("本行止\n", "g");
            text = text.replace(reg, '本行止\r\n');
            var reg2 = new RegExp("\"", "g");
            text = text.replace(reg2, '');
            var strlist1 = text.split('\r\n');
            var copyrows = [];
            var updated = $(m_DatagridID).datagrid('getChanges', "updated");
            for (var i = 0; i < strlist1.length; i++) {
                var strlist2 = strlist1[i].split('\t');
                if (strlist2.length >= 17) {
                    for (var j = 0; j < rows.length; j++) {
                        if (rows[j].bg3_centercode == strlist2[2]) {
                            rows[j].bg3_remark1 = strlist2[4];
                            rows[j].bg3_m1 = strlist2[5];
                            rows[j].bg3_m2 = strlist2[6];
                            rows[j].bg3_m3 = strlist2[7];
                            rows[j].bg3_m4 = strlist2[8];
                            rows[j].bg3_m5 = strlist2[9];
                            rows[j].bg3_m6 = strlist2[10];
                            rows[j].bg3_m7 = strlist2[11];
                            rows[j].bg3_m8 = strlist2[12];
                            rows[j].bg3_m9 = strlist2[13];
                            rows[j].bg3_m10 = strlist2[14];
                            rows[j].bg3_m11 = strlist2[15];
                            rows[j].bg3_m12 = strlist2[16];
                            var sum = 0;
                            for (var k = 5; k < 17; k++) {
                                if (!isNaN(strlist2[k])) {
                                    sum = sum * 1 + dataUtil_toFixed(strlist2[k], 2) * 1;
                                }
                            }
                            rows[j].bg3_total = sum;
                            if (strlist1.length <= 20) {
                                var cindex = rows[j].rowindex - 1;
                                $(m_DatagridID).datagrid('updateRow', {
                                    index: cindex,
                                    row: rows[j]
                                });
                                $(m_DatagridID).datagrid('selectRow', cindex);
                            }
                            updated.push(rows[j]);
                            copyrows.push(rows[j]);
                            break;
                        } 
                    }
                } 
                if (i == strlist1.length-1 && strlist1.length > 20) {
                    $(m_DatagridID).datagrid('loadData', rows); 
                    var updated1 = $(m_DatagridID).datagrid('getChanges', "updated");
                    for (var k = 0; k < updated.length; k++) {  
                        updated1.push(updated[k]);
                    }
                }
            } 
        }, 100);
    }
    if (flag == 1) {
        setTimeout(function () {
            $('#waitdlg').dialog('close'); 
        }, 1000);
    }
      
}


/***********************************************************************
 *  excel复制添加事件
 *  DLY 
 */
function actCopeToAdd1(text) {
    var flag = 0;
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    $(m_DatagridID).datagrid("clearSelections");
    var rows = $(m_DatagridID).datagrid('getRows');
    if (text == undefined) {
        if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
            text = window.clipboardData.getData("text");
        } else {
            $('#textexcelcope').val('');
            $('#excelcopedlg').dialog('open');
            return false;
        }
    }
    if (dataUtil_undefinedOrNull(text, '') != '') {
        $('#waitdlg').dialog('open');
        flag = 1;
        setTimeout(function () {
            var reg = new RegExp("本行止\n", "g");
            text = text.replace(reg, '本行止\r\n');
            var reg2 = new RegExp("\"", "g");
            text = text.replace(reg2, '');
            var strlist1 = text.split('\r\n');
            var copyrows = [];
            var updated = $(m_DatagridID).datagrid('getChanges', "updated");
            for (var i = 0; i < strlist1.length; i++) {
                var strlist2 = strlist1[i].split('\t');
                if (strlist2.length >= 17) {
                    for (var j = 0; j < rows.length; j++) {
                        if (rows[j].bg3_centercode == strlist2[2]) {
                            rows[j].bg3_remark1 = strlist2[4];
                            rows[j].bg3_m1 = strlist2[5];
                            rows[j].bg3_m2 = strlist2[6];
                            rows[j].bg3_m3 = strlist2[7];
                            rows[j].bg3_m4 = strlist2[8];
                            rows[j].bg3_m5 = strlist2[9];
                            rows[j].bg3_m6 = strlist2[10];
                            rows[j].bg3_m7 = strlist2[11];
                            rows[j].bg3_m8 = strlist2[12];
                            rows[j].bg3_m9 = strlist2[13];
                            rows[j].bg3_m10 = strlist2[14];
                            rows[j].bg3_m11 = strlist2[15];
                            rows[j].bg3_m12 = strlist2[16];
                            var sum = 0;
                            for (var k = 5; k < 17; k++) {
                                if (!isNaN(strlist2[k])) {
                                    sum = sum * 1 + dataUtil_toFixed(strlist2[k], 2) * 1;
                                }
                            }
                            rows[j].bg3_total = sum;
                            var cindex = rows[j].rowindex - 1;
                            $(m_DatagridID).datagrid('updateRow', {
                                index: cindex,
                                row: rows[j]
                            });
                            $(m_DatagridID).datagrid('selectRow', cindex);
                            updated.push(rows[j]);
                            copyrows.push(rows[j]);
                            break;
                        }

                    }
                }
            }
        }, 100);
    }
    if (flag == 1) {
        setTimeout(function () {
            $('#waitdlg').dialog('close');
        }, 1000);
    }
}


/***********************************************************************
*  导出Excel
*  DLY 
*/
function actToExcel(type) {
    var rows = []
    if (type == 'page') {
        rows = $(m_DatagridID).datagrid('getRows');
    } else if (type == 'choose') {
        rows = $(m_DatagridID).datagrid("getSelections");
        //对选择行排序
        rows.sort(function (a, b) {
            return a.rowindex - b.rowindex;
        });
    }
    if (rows.length > 0) {
        dataExpotToFile('2', rows, m_DLList, m_XLList);
    }
}


/***********************************************************************
 *  保存事件
 *  DLY 
 */
function actSave() {
    var flag = false;

    //合计并结束编辑行
    getRowTotal(m_LastIndex, 'dg');
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);

    var dataRows = $(m_DatagridID).datagrid('getRows');
    var cXML1 = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        //if (!shopaveCheck()) {
        //    return flag;
        //}    
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        //for (var i = 0; i < inserted.length; i++) {
        //    inserted[i]["bg3_total"] = inserted[i]["bg3_total"] * 1;
        //    for (var j = 1; j < 13; j++) {
        //        inserted[i]["bg3_m" + j] = inserted[i]["bg3_m" + j] * 1;
        //    }
        //}
        for (var i = 0; i < updated.length; i++) {
            updated[i]["bg3_total"] = updated[i]["bg3_total"] * 1;
            for (var j = 1; j < 13; j++) {
                updated[i]["bg3_m" + j] = updated[i]["bg3_m" + j] * 1;
            }
            updated[i].bg3_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            updated[i].bg3_lmuser = m_UserInfo.UserName;
            updated[i].bg3_uptno = updated[i].bg3_uptno * 1 + 1;
        }
        //for (var i = 0; i < deleted.length; i++) {
        //    var obj = new Object();
        //    obj.bg3_id = deleted[i].bg3_id;
        //    obj.bg3_state = '9';
        //    updated.push(obj);
        //}
        cXML1 = GetEditJson([], updated, []);//json转xml 不做新增和删除
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=Save" + "&s=" + new Date().getTime();; //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data)); 
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    actLoadData(m_PageNumber, m_PageSize);
                    //修改总金额 begin
                    var rowt = {};
                    rowt.bg4_id = $("#spanbg4_id").html();
                    var reg = new RegExp(",", "g");
                    rowt.bg4_total = $("#spanTatolT").html().replace(reg, '') * 1;
                    var rowInfot = [];
                    rowInfot.push(rowt);
                    var cXMLt = GetEditJson(rowInfot, [], []); //json转xml   
                    var cxmlsJsont = { XML: cXMLt };
                    var curlt = GetWSRRURL(peoa_GetWSRRURL(14));
                    curlt = curlt + "&type=SetApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
                    $.ajax({
                        url: curlt,
                        type: "POST",
                        async: false,
                        data: cxmlsJsont,
                        dataType: "json",
                        success: function (result) {
                            try {
                                //alert(jsonUtil_jsonToStr(result));
                                if (result.Error) {
                                    $.messager.alert("系统错误", result.Error, 'error');
                                } else if (result.rows[0].result == "False") {
                                    $.messager.alert("提示", result.rows[0].message, 'error');
                                } else if (result.rows[0].result == "True") {
                                }
                            } catch (ex) {
                                $.messager.alert("提示", ex, 'error');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "保存总金额失败！", 'error');
                        }
                    })
                    //修改总金额 end
                    flag = true;
                }
            }
        }
    })
    if (flag) {
        alert('保存成功！');
    } else {
        alert('保存失败！');
    }
    return flag;
}


/***********************************************************************
 *  保存费用预算信息
 *  DLY 
 */
function shopaveCheck() {
    var flag = false;
    return flag;
}


/***********************************************************************
 * 结束编辑行
 *  DLY 
 */
function actEndEdit(dgid, index) {
    if (index != undefined && index >= 0) {
        $(dgid).datagrid('endEdit', index);
    }
    return -1;
}
 

/***********************************************************************
 *  设置小类div
 *  DLY 
 */
function setXLTypes(xllist) {
    if (xllist && xllist.length > 0 && xllist[0].ct1_id != '') {
        var shtml = '';
        //for (var i = 0; i < xllist.length; i++) {
        //    if (xllist[i].ct1_code != '' && xllist[i].ct1_codename != '') { 
        //        shtml = shtml + '&nbsp;&nbsp;&nbsp;&nbsp;';
        //        shtml = shtml + '<div id="' + xllist[i].ct1_id + '" class="btn3" onclick="chooseXL(\'' + xllist[i].ct1_id + '\')">'
        //        shtml = shtml + xllist[i].ct1_codename + '( ' + xllist[i].ct1_code + ' )'
        //        shtml = shtml + '</div>'
        //    }
        //}
        for (var i = 0; i < xllist.length; i++) {
            if (xllist[i].ct1_code != '' && xllist[i].ct1_codename != '') {
                var mtitle = xllist[i].ct1_codename + '( ' + xllist[i].ct1_code + ' )';
                var msg = xllist[i].ct1_fieldvalues5;
                shtml = shtml + '&nbsp;&nbsp;&nbsp;&nbsp;';
                shtml = shtml + '<input type="button" id="' + xllist[i].ct1_id
                    + '" value="' + mtitle
                    + '" class="btn3" onclick="basedata_rightClickXL(\'' + mtitle + '\',\'' + msg + '\'); chooseXL(\'' + xllist[i].ct1_id + '\');'
                    + '" oncontextmenu="basedata_rightClickXL(\'' + mtitle + '\',\'' + msg + '\');">';
            }
        }

        $('#cxXLTypes').html(shtml);
    } else {
        $('#cxXLTypes').html('');
    }
    //重新加载数据
    searchByCons();
}
 

/***********************************************************************
 *  选择小类事件
 *  DLY 
 *  spanXLCode : 存放小类id
 */
function chooseXL(xlid) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    // 切换前提示保存
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        $.messager.defaults = { ok: "保存", cancel: "不保存" }; // 修改按钮
        $.messager.confirm('警示', '当前数据已修改，是否先保存数据？'
            , function (r) {
                $.messager.defaults = { ok: "确定", cancel: "取消" }; // 还原按钮;
                if (r) {  //保存，切换
                    actSave();
                    chooseXLT();
                    flag = false;
                } else {  //不保存，切换
                    chooseXLT();
                }
            });
    } else {  //切换   $.messager 变态，跟其他代码会同步执行，不能控制先后
        chooseXLT();
    }
    function chooseXLT() {
        if (xlid != undefined && xlid != '') {
            if ($('#spanXLCode').html() != '') {
                //$('#' + $('#spanXLCode').html()).css("background-color", '#fff');
                //$('#' + $('#spanXLCode').html()).css("color", '#20609b'); 
                $('#' + $('#spanXLCode').html()).removeClass("btn3_choose");
            }
            //$('#' + xlid).css("background-color", m_btn3bgcolor);
            //$('#' + xlid).css("color", '#fff');
            $('#' + xlid).addClass("btn3_choose");

            //存放小类id
            $('#spanXLCode').html(xlid);
        }
        //重新加载数据
        searchByCons();
    }
}


/***********************************************************************
 *  调整主条件，防止数据丢失控制
 *  DLY 
 *  m_changeFlag : 0 不可调整， 1 可调整
 */
function actContralSave(type, field1) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    if (type == undefined) {
        m_changeFlag = 0;
    } else if (type == 'combo') {
        if (field1 == '#cxBrand' || field1 == '#cxDLCode' || field1 == '#cxYear'
            || field1 == '#cxBranch' || field1 == '#cxShopType') {
            if (m_changeFlag != 1 && $(m_DatagridID).datagrid('getChanges').length > 0) {
                $.messager.defaults = { ok: "保存", cancel: "不保存" }; // 修改按钮
                $.messager.confirm('警示', '当前数据已修改，是否先保存数据？'
                    , function (r) {
                        $.messager.defaults = { ok: "确定", cancel: "取消" }; // 还原按钮;
                        if (r) {
                            if (field1 == '#cxDLCode') {
                                $(field1).combogrid('hidePanel');
                            } else {
                                $(field1).combobox('hidePanel');
                            }
                            actSave();
                        } else {
                            m_changeFlag = 1; //设置可下拉标志
                            if (field1 == '#cxDLCode') {
                                $(field1).combogrid('showPanel');
                            } else {
                                $(field1).combobox('showPanel');
                            }
                            return;
                        }
                    });
            }
            m_changeFlag = 0;
        }
    }
}


/***********************************************************************
 *  品牌改变事件 
 *  DLY 
 */
function changeBrand(brand) {
    var flag = 0;
    $("#spanbg4_id").html('');
    $('#dnbtn').hide(); // 隐藏驳回按钮
    $('#upbtn').hide(); // 隐藏提交按钮
    m_EditFlag = 1;
    var cons = ' AND BG4_Type = \'0\' AND BG4_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
    cons = cons + ' AND BG4_Brand = \'' + brand + '\' ';
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + cons + '</Cons><OrderBy>' + '' + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApH&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();//拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') {
                    $("#spanbg4_id").html(data.rows[0].bg4_id);
                    $("#cxState").val(data.rows[0].bg4_state);
                    if (data.rows[0].bg4_state == '未提交') {
                        $('#bkbjdiv').hide();
                        $('#bkbjdiv').html('');
                        $('#zbtns').show();
                        $('#upbtn').show();
                        $('#spanbtnUp').html('提交');
                        m_EditFlag = 0;
                    } else if (data.rows[0].bg4_state == '已提交' && m_Role == 'B') { 
                        $('#bkbjdiv').hide();
                        $('#bkbjdiv').html('');
                        $('#zbtns').show();
                        $('#upbtn').show();
                        $('#spanbtnUp').html('审核');
                        $('#dnbtn').show();
                        m_EditFlag = 0;
                    } else {
                        $('#zbtns').hide();
                        $('#bkbjdiv').show();
                        $('#bkbjdiv').html('&nbsp;注意：当前部门预算 ' + data.rows[0].bg4_state + '，不可编辑！');
                        m_EditFlag = 1;
                    }
                } else {
                    $('#zbtns').hide();
                    $('#bkbjdiv').show();
                    $('#bkbjdiv').html('&nbsp;注意：请选择品牌！');
                    m_EditFlag = 1;
                } 
            }
        }
    })
}


/***********************************************************************
 *  提交事件 
 *  DLY 
 */
function actUp(type) {
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        alert('数据已修改，请先保存！');
        return false;
    }
    var reg = new RegExp(",", "g");
    var curmoney = $("#spanTatolT").html().replace(reg, '') * 1;
    if (curmoney <= 0 && type == 'up') {
        alert('总金额必须大于0！');
        return false;
    }
    var info = '';
    var row = {};
    row.bg4_id = $("#spanbg4_id").html();
    if (type == 'up') {
        if ($("#spanbtnUp").html() == '提交') {
            row.bg4_upper1 = m_UserInfo.UserName;
            row.bg4_updt1 = dateUtil_dateFomaterB(new Date(), '-');
            row.bg4_updt2 = '';
            row.bg4_upper2 = '';
            row.bg4_state = '已提交';
            info = '提交';
        } else if ($("#spanbtnUp").html() == '审核') {
            row.bg4_upper2 = m_UserInfo.UserName;
            row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-');
            row.bg4_state = '已审核';
            info = '审核';
        }
    } else if (type == 'dn') {
        row.bg4_state = '未提交';
        row.bg4_upper2 = m_UserInfo.UserName;
        row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-') + ' (驳回)';
        info = '驳回';
    }


    var curl = GetWSRRURL(peoa_GetWSRRURL(14));
    curl = curl + "&type=SetApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
    var rowInfo = [];
    rowInfo.push(row);
    var cXML = GetEditJson(rowInfo, [], []); //json转xml   
    var cxmlsJson = { XML: cXML };
    $.messager.confirm('确认框', '确认' + info + '吗?', function (r) {
        if (r) {
            $.ajax({
                url: curl,
                type: "POST",
                async: false,
                data: cxmlsJson,
                dataType: "json",
                success: function (result) {
                    try {
                        //alert(jsonUtil_jsonToStr(result));
                        if (result.Error) {
                            $.messager.alert("系统错误", result.Error, 'error');
                        } else if (result.rows[0].result == "False") {
                            $.messager.alert("提示", result.rows[0].message, 'error');
                        } else if (result.rows[0].result == "True") {
                            changeBrand($('#cxBrand').combobox('getValue'));
                            $.messager.alert("提示", info + "成功！");
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", info + "失败！", 'error');
                }
            });
        }
    }); 
}


/*******************
 * 获取列表高度
 */
function getcurheight() {
    return;
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 80;
    return curheight;
}


