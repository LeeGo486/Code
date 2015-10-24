var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 2000;  //每页显示行数

//用户信息
var m_UserInfo = basedata_getUserInfo();


//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌 

//------------


//预算科目类别数组
var m_DLList = [];
var m_XLList = [];

var m_depttree = [];

//状态
var m_States = [{ id: "0", text: "未审核" }, { id: "1", text: "已审核" }];
 

//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }, { "text": "2016" }, { "text": "2017" }, { "text": "2018" }];
  

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_OrderBy = '  '; //排序方式


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
        if (authorization_text == '统一费用预算专员') {
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
    var DLListid = peoa_GetBDFID(21);//预算科目大类
    var cons = ' AND  ( CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + DLListid + '\''
             + ') OR CT1_ID = \'' + DLListid + '\') AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        var f2 = res[i].ct1_id.toUpperCase();
        if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) { 
            if ((res[i].ct1_fieldvalues3).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                 || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        }else if (f1 == DLListid.toUpperCase()) {
            m_XLList.push(res[i]);
        } 
        if (f2 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
        }
    }

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
            changeBrand(newValue);
            searchByCons();
        },
        onShowPanel: function () {
            actContralSave('combo', '#cxBrand');
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

    /*
    //组织架构级联树  
    m_depttree = [];
    var cXML = '<Page>0</Page><Num>0</Num>'
            + '<Cons> AND OZ1_State=\'启用\' </Cons><OrderBy></OrderBy>'
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, '1', "1")
            + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            var data1 = eval('(' + data + ')');
            m_depttree = data1;
        }
    });
    */

    //初始化赋值
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    $('#cxBrand').combobox('setValue', '');
    changeBrand('000');
    setXLTypes(m_XLList);

    //初始化列表
    actyslbcsh(m_DatagridID);

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
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = 1;

    //拼接条件 获取数据集
    var sbrand = $('#cxBrand').combobox('getValue');
    var sdlcode = m_DLList[0].ct1_code;
    var syear = $('#cxYear').combobox('getValue'); 
    var sxlcode = $("#spanXLCode").html();
    var sdeptname = $("#cxDept").val(); 
    var scostcenter = $("#cxCostCenter").val();
    if (sbrand == '' || syear == '') {
        $(m_DatagridID).datagrid('loadData', []);
        return true;
    }
    var cfilter = ' AND bg3_type = \'2\' And isnull(bg3_state,0) = 0';
    cfilter = cfilter + ' AND  bg3_year = \'' + syear + '\'';
    cfilter = cfilter + ' AND  bg3_brand = \'' + sbrand + '\'';
    m_Filter2 = cfilter;
    cfilter = cfilter + ' AND  bg3_dlcode = \'' + sdlcode + '\''; 

    sxlcode = basedata_getCodename(m_XLList, $("#spanXLCode").html(), 'ct1_id', 'ct1_code');
    cfilter = cfilter + ' AND  isnull(bg3_xlcode,\'\') = \'' + sxlcode + '\'';


    if (sdeptname != '') {  
        cfilter = cfilter + ' AND bg3_deptname LIKE \'%' + sdeptname + '%\'';
    }
    if (scostcenter != '') { 
        cfilter = cfilter + ' AND bg3_centercode  LIKE \'%' + scostcenter + '%\'';
    }


    m_Filter1 = cfilter;
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
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetHs&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            $(m_DatagridID).datagrid('loadData', []);
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
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0),'0'));

    // 合计总金额
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + m_Filter + m_Filter2 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetSums&XML=" + encodeURIComponent(cXML); //拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].stotal, '') != '') {
                    $("#spanTatol").html(dataUtil_formatNum1(data.rows[0].stotal, 0));
                }
            }
        }
    })
}


/***********************************************************************
 *  统一费用预算列表初始化
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
            {
                field: 'bg3_com', title: '<input id=\"detailcheckbox\" type=\"checkbox\">&nbsp;&nbsp;公司', width: 80
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename',
                        data: m_Coms, editable: false, panelHeight: "80"
                    }
                }
            },
            { field: 'bg3_branch', title: '大区', width: 80, hidden: true },
            { field: 'bg3_centercode', title: '成本中心', width: 80, editor: 'text' },
           /* { field: 'bg3_deptid', title: '部门', width: 150, editor: 'text'
                , editor: {
                type: 'combotree', options: {
                    idField: 'id', textField: 'text',
                    data: m_depttree, editable: false, panelHeight: "200", panelWidth: "220"
                    , onSelect: function (record) { 
                        var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg3_deptname' });
                        $(ed.target).val(record.text);
                    }
                }}
                , formatter: function (val, row, index) {
                    return row.bg3_deptname;
                }
            },*/
            { field: 'bg3_deptname', title: '部门名称', width: 150, editor: 'text'},
            { field: 'bg3_remark1', title: '说明1', width: 150, editor: 'text' },
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
		    { field: 'bg3_state', title: '状态', width: 60 },
		    { field: 'bg3_dlcode', title: '大类代码', width: 80 },
		    {
		        field: 'bg3_dlname', title: '大类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.bg3_dlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_xlcode', title: '小类代码', width: 80 },
		    {
		        field: 'bg3_xlname', title: '小类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
                }
		    },
            { field: 'bg3_brand', title: '品牌', width: 60 },
            { field: 'bg3_remark2', title: '说明2', width: 100, editor: 'text', hidden: true },
			{ field: 'bg3_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg3_rguser', title: '创建人', width: 70 },
		    { field: 'bg3_lmdt', title: '修改时间', width: 105 },
            { field: 'bg3_lmuser', title: '修改人', width: 70 },
            { field: 'bg3_uptno', title: '修改次数', width: 70 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: false,
        onDblClickRow: function (rowIndex) {
            $(m_DatagridID).datagrid("clearSelections");
            $(dgid).datagrid('selectRow', rowIndex);
            if (m_EditFlag == 1) { // 不可编辑
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
    var gridlength = $(m_DatagridID).datagrid('getRows').length;
    if ($('#cxYear').combobox('getValue') == '') {
        alert('请先选择年份！');
        return false;
    }
    if ($('#cxBrand').combobox('getValue') == '') {
        alert('请先选择品牌！');
        return false;
    }

    if ($("#spanXLCode").html() == '') {
        alert('请先选择小类！');
        return false;
    }
    if (text == undefined) {
        if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
            text = window.clipboardData.getData("text");
        } else {
            $('#textexcelcope').val('');
            $('#excelcopedlg').dialog('open');
            return false;
        }
    }
    //alert(text);
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
            for (var i = 0; i < strlist1.length - 1; i++) {
                var strlist2 = strlist1[i].split('\t');
                //var tu = 0;
                //for (var u = 0; u < m_Coms.length - 1; u++) {
                //    if (strlist2[0] == m_Coms[u].ct1_codename) {
                //        tu = 1;
                //        break;
                //    }
                //}
                if (strlist2.length >= 17 && strlist2[0] != '公司' && strlist2[1] != '成本中心') {
                    var rownew = newRow();
                    rownew.bg3_com = strlist2[0]; 
                    rownew.bg3_centercode = strlist2[1];
                    rownew.bg3_deptid = strlist2[2];
                    rownew.bg3_deptname = strlist2[3];
                    rownew.bg3_remark1 = strlist2[4];
                    rownew.bg3_m1 = strlist2[5];
                    rownew.bg3_m2 = strlist2[6];
                    rownew.bg3_m3 = strlist2[7];
                    rownew.bg3_m4 = strlist2[8];
                    rownew.bg3_m5 = strlist2[9];
                    rownew.bg3_m6 = strlist2[10];
                    rownew.bg3_m7 = strlist2[11];
                    rownew.bg3_m8 = strlist2[12];
                    rownew.bg3_m9 = strlist2[13];
                    rownew.bg3_m10 = strlist2[14];
                    rownew.bg3_m11 = strlist2[15];
                    rownew.bg3_m12 = strlist2[16];
                    var sum = 0;
                    for (var j = 5; j < 17; j++) {
                        if (!isNaN(strlist2[j])) {
                            sum = sum * 1 + dataUtil_toFixed(strlist2[j], 2) * 1;
                        }
                    }
                    rownew.bg3_total = sum;
                    copyrows.push(rownew);
                    actCopeToAdd_append(rownew);

                }
            }
        }, 100);
    }
    m_LastIndex = -1;
    if (flag == 1) {
        setTimeout(function () {
            $('#waitdlg').dialog('close');
        }, 1000);
    }

    function actCopeToAdd_append(appenrow) {
        setTimeout(function () {
            $(m_DatagridID).datagrid('appendRow', appenrow);
            $(m_DatagridID).datagrid('selectRow', gridlength);
            gridlength = gridlength * 1 + 1 * 1;
        }, 100);
    }
}


/***********************************************************************
*  导出Excel
*  DLY 
*/
function actToExcel(type) {
    var rows = []
    if (type == 'model') {
        dataExpotToFile('5', [], [], []);
        return;
    } 
}
 

/***********************************************************************
 *  添加事件
 *  DLY 
 */
function actAdd() {
    if ($('#cxYear').combobox('getValue') == '') {
        alert('请先选择年份！');
        return false;
    }
    if ($('#cxBrand').combobox('getValue') == '') {
        alert('请先选择品牌！');
        return false;
    } 
    if ($("#spanXLCode").html() == '') {
        alert('请先选择小类！');
        return false;
    }

    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    $(m_DatagridID).datagrid("clearSelections"); 
    m_LastIndex = $(m_DatagridID).datagrid('getRows').length;
    var rownew = newRow();
    $(m_DatagridID).datagrid('appendRow', rownew);
    $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
    $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    /* //插入首行，执行慢, 
        $(m_DatagridID).datagrid('insertRow', {
            index: 0,
            row: rownew
        }); 
    */ 

}


/***********************************************************************
 *  复制事件
 *  DLY 
 */
function actCopy() {
    var insertRowIndex = [];
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    var rows = $(m_DatagridID).datagrid("getSelections");
    var rowsindexs = [];
    for (var i = 0; i < rows.length; i++) {
        var rindex = $(m_DatagridID).datagrid('getRowIndex', rows[i]);
        rowsindexs.push({ r: rindex, row: rows[i] });
    }
    // 借用rowsindexs对选择行排序，便于复制操作
    rowsindexs.sort(function (a, b) {
        return a.r - b.r
    });
    var len = rowsindexs.length;
    $(m_DatagridID).datagrid("clearSelections");
    for (var i = len - 1; i >= 0; i--) {
        var rindex = rowsindexs[i].r;
        //var rownew = rowsindexs[i].row;
        //rownew.bg3_id = dataUtil_NewGuid();
        //rownew.bg3_state = '0'; 
        //rownew.rowindex = rindex*1 + 1;
        var rownew = newRow();
        rownew.bg3_com = rowsindexs[i].row.bg3_com;
        rownew.bg3_branch = rowsindexs[i].row.bg3_branch;
        rownew.bg3_year = rowsindexs[i].row.bg3_year;
        rownew.bg3_brand = rowsindexs[i].row.bg3_brand;
        rownew.bg3_dlcode = rowsindexs[i].row.bg3_dlcode;
        //rownew.bg3_dlname = rowsindexs[i].row.bg3_dlname; 
        rownew.bg3_xlcode = rowsindexs[i].row.bg3_xlcode;
        //rownew.bg3_xlname = rowsindexs[i].row.bg3_xlname; 
        rownew.bg3_centercode = rowsindexs[i].row.bg3_centercode;
        rownew.bg3_deptid = rowsindexs[i].row.bg3_deptid;
        rownew.bg3_deptname = rowsindexs[i].row.bg3_deptname;
        rownew.bg3_remark1 = rowsindexs[i].row.bg3_remark1;
        rownew.bg3_remark2 = rowsindexs[i].row.bg3_remark2;
        rownew.bg3_m1 = rowsindexs[i].row.bg3_m1;
        rownew.bg3_m2 = rowsindexs[i].row.bg3_m2;
        rownew.bg3_m3 = rowsindexs[i].row.bg3_m3;
        rownew.bg3_m4 = rowsindexs[i].row.bg3_m4;
        rownew.bg3_m5 = rowsindexs[i].row.bg3_m5;
        rownew.bg3_m6 = rowsindexs[i].row.bg3_m6;
        rownew.bg3_m7 = rowsindexs[i].row.bg3_m7;
        rownew.bg3_m8 = rowsindexs[i].row.bg3_m8;
        rownew.bg3_m9 = rowsindexs[i].row.bg3_m9;
        rownew.bg3_m10 = rowsindexs[i].row.bg3_m10;
        rownew.bg3_m11 = rowsindexs[i].row.bg3_m11;
        rownew.bg3_m12 = rowsindexs[i].row.bg3_m12;
        rownew.bg3_total = rowsindexs[i].row.bg3_total;
        $(m_DatagridID).datagrid('insertRow', {
            index: rindex * 1 + 1,
            row: rownew
        });
        $(m_DatagridID).datagrid('selectRow', rindex + 1);

        ////追加新增行index
        //insertRowIndex.push(rindex + 1);
        //// 已新增行index+1 
        //for (var j= 0; j < insertRowIndex.length-1; j++) {
        //    insertRowIndex[j] = insertRowIndex[j]*1 + 1;
        //}
    }


    //if (row) {  
    //    var rownew = row;
    //    rownew.bg3_id = dataUtil_NewGuid();
    //    $(m_DatagridID).datagrid('insertRow', {
    //        index: rindex + 1,
    //        row: rownew
    //    });
    //    //m_LastIndex = rindex + 1;
    //    //$(m_DatagridID).datagrid('beginEdit', rindex + 1);
    //    $(m_DatagridID).datagrid('selectRow', rindex + 1);
    //} else {
    //    alert('请先选中被复制行！');
    //} 
}


/***********************************************************************
 *  删除事件
 *  DLY 
 */
function actDelete() {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    $.messager.confirm('确认框', '确认删除选中记录吗？', function (r) {
        if (r) {
            var rows = $(m_DatagridID).datagrid("getSelections");
            var rowsindexs = [];
            for (var i = 0; i < rows.length; i++) {
                var rindex = $(m_DatagridID).datagrid('getRowIndex', rows[i]);
                rowsindexs.push(rindex * 1 + 100);
            }
            rowsindexs.sort();  // index 排序
            var len = rowsindexs.length;
            for (var i = len - 1; i >= 0; i--) {
                var index = rowsindexs[i]-100;
                $(m_DatagridID).datagrid('deleteRow', index);	//通过行号移除该行  
            }
        }
    });
}


/***********************************************************************
 *  保存费用预算信息
 *  DLY 
 */
function saveCheck() {
    var flag = true;
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        var j = i * 1 + 1;
        if (dataUtil_undefinedOrNull(rows[i].bg3_com, '') == '') {
            alert('第' + j + '行公司必填！');
            return false;
        }
        if (dataUtil_undefinedOrNull(rows[i].bg3_centercode, '') == '') {
            alert('第' + j + '行成本中心必填！');
            return false;
        }
        /*
        if (dataUtil_undefinedOrNull(rows[i].bg3_deptid, '') == '') {
            alert('第' + j + '行部门必填！');
            return false;
        }
        */
    }
    return flag;
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

    //行信息校验
    if (!saveCheck()) {
        return flag;
    }

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
        for (var i = 0; i < inserted.length; i++) {
            inserted[i]["bg3_total"] = inserted[i]["bg3_total"] * 1;
            for (var j = 1; j < 13; j++) {
                inserted[i]["bg3_m" + j] = inserted[i]["bg3_m" + j] * 1;
            }
            inserted[i].bg3_rguser = m_UserInfo.UserName;
            inserted[i].bg3_uptno = 0;
        }
        for (var i = 0; i < updated.length; i++) {
            updated[i]["bg3_total"] = updated[i]["bg3_total"] * 1;
            for (var j = 1; j < 13; j++) {
                updated[i]["bg3_m" + j] = updated[i]["bg3_m" + j] * 1;
            }
            updated[i].bg3_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            updated[i].bg3_lmuser = m_UserInfo.UserName;
            updated[i].bg3_uptno = updated[i].bg3_uptno * 1 + 1;
        }
        for (var i = 0; i < deleted.length; i++) {
            var obj = new Object();
            obj.bg3_id = deleted[i].bg3_id;
            obj.bg3_state = '9';
            obj.bg3_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            obj.bg3_lmuser = m_UserInfo.UserName;
            obj.bg3_uptno = deleted[i].bg3_uptno * 1 + 1;
            updated.push(obj);
        }
        cXML1 = GetEditJson(inserted, updated, []);//json转xml
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=Save"; //拼接url
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
                    rowt.bg4_total = $("#spanTatol").html().replace(reg, '') * 1;
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
 *  新增行对象
 *  DLY 
 */
function newRow() {
    var rownew = {};
    rownew.bg3_id = dataUtil_NewGuid();
    rownew.bg3_type = '2';
    rownew.bg3_state = '0';
    rownew.bg3_year = $('#cxYear').combobox('getValue');
    rownew.bg3_brand = $('#cxBrand').combobox('getValue');
    rownew.bg3_dlcode = m_DLList[0].ct1_code;
    //rownew.bg3_dlname = $('#cxDLCode').combogrid('getText');
    if ($("#spanXLCode").html() == '') {
        rownew.bg3_xlcode = '';
        //rownew.bg3_xlname = '';
    } else {
        rownew.bg3_xlcode = basedata_getCodename(m_XLList, $("#spanXLCode").html(), 'ct1_id', 'ct1_code');
        //rownew.bg3_xlname = basedata_getCodename(m_XLList, $("#spanXLCode").html(), 'ct1_id', 'ct1_codename');
    }
    return rownew;
}
  

/***********************************************************************
 *  设置小类div
 *  DLY 
 */
function setXLTypes(xllist) {
    if (xllist && xllist.length > 0 && xllist[0].ct1_id != '') {
        var shtml = ''; 
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
                if (r) {  //保存，不切换
                    actSave();
                    flag = false;
                } else {  //不保存，切换
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
            });
    } else {  //切换   $.messager 变态，跟其他代码会同步执行，不能控制先后
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
        if (field1 == '#cxBrand' || field1 == '#cxDLCode' || field1 == '#cxYear') {
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
    var cons = ' AND BG4_Type = \'2\' AND BG4_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
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
            if (data.rows && data.rows.length >= 0) {
                flag = 1;
                if (data.rows.length > 0 && dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') {
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
            } else {
                $("#spanbg4_id").html('');
            }
        }
    })
    if (flag == 0) {
        $('#zbtns').hide();
        $('#bkbjdiv').show();
        $('#bkbjdiv').html('&nbsp;注意：审批记录获取失败，请截图与管理员联系！');
        m_EditFlag = 1;
    }  
}


/***********************************************************************
 *  提交事件 
 *  DLY 
 */
function actUp(type) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        alert('数据已修改，请先保存！');
        return false;
    }
    var reg = new RegExp(",", "g");
    var curmoney = $("#spanTatol").html().replace(reg, '') * 1;
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
    $.messager.confirm('确认框', '确认'+info+'吗?', function (r) {
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
                            $.messager.alert("提示", info+"成功！");
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


