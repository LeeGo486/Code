var m_DatagridID = '#BaseDatalb'; //列表ID
var m_LastIndex = -1;  //列表最后一次编辑行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 100;  //每页显示行数
  
var m_DLList = [];  //记录数组 
var m_DLrow ;  //记录编辑行 

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];
var m_Years = [{ "text": "2014" }, { "text": "2015" }];//年份
var m_Brands = [];//品牌

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
    var cons = ' AND CT1_FatherID = \'' + Brandid + '\'' 
             + ' AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons); 
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Brandid.toUpperCase()) {
            if ((res[i].ct1_fieldvalues4).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
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

    //列表设置
    initdatagrid();

    //初始化查询
    clearText(); 
});
 

/***********************************************************************
 *  保存记录
 *  DLY 
 */
function actSave() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        //if (!shopaveCheck()) {
        //    return flag;
        //}
        var gridDataChanges = []; 
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");  
        for (var i = 0; i < updated.length; i++) {
            //保存对象重组，去除所有不可编辑字段 
            var obj = {};
            obj.bg6_id = updated[i].bg6_id;
            obj.bg6_code1 = updated[i].bg6_code1;
            obj.bg6_name = updated[i].bg6_name;
            obj.bg6_remark = updated[i].bg6_remark;
            obj.bg6_type = updated[i].bg6_type;
            obj.bg6_centers = updated[i].bg6_centers;
            obj.bg6_xlcodes = updated[i].bg6_xlcodes; 
            obj.bg6_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            obj.bg6_lmuser = m_UserInfo.UserName;
            obj.bg6_uptno = dataUtil_undefinedOrNull(updated[i].bg6_uptno, 0) * 1 + 1;
            gridDataChanges.push(obj)
        } 
        cXML1 = GetEditJson([], gridDataChanges, []);//json转xml  
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=UpdISRows"; //拼接url 
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson, 
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data)); 
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    flag = true;
                }
            }
        }
    });

    if (flag) {
        alert('保存成功！');
        actLoadData(m_PageNumber, m_PageSize);
    } else {
        alert('保存失败！');
    }
    return flag;
}
 

/***********************************************************************
 * 可保存校验
 *  DLY 
 */
function actSaveCheck(row1, row2) {
    var flag = false; 
    return flag; 
}


/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText() {
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    $('#cxBrand').combobox('setValue', '');
}


/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() { 
    //拼接条件 获取数据集 
    var cfilter = ' ';
    var cxYear = $('#cxYear').combobox('getValue');
    var cxBrand = $('#cxBrand').combobox('getValue'); 
    if (cxYear == '' || cxBrand == '') {
        alert('请选择年份及品牌！');
        return false;
    } 
    cfilter = cfilter + ' AND  bg6_Year = \'' + cxYear + '\'';
    cfilter = cfilter + ' AND  bg6_Brand = \'' + cxBrand + '\''; 
    m_Filter1 = cfilter;  
    actLoadData(m_PageNumber, m_PageSize); 
}


/***********************************************************************
 *  数据加载
 *  DLY 
 */
function actLoadData(page, number) { 
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=ISRows&XML=" + encodeURIComponent(cXML)
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
                totalCount = data.total;
            }
        }
    });

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
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
        height: 470,
        nowrap: false,
        striped: false,
        collapsible: true,
        sortName: 'bg6_code',
        sortOrder: 'asc',
        data: m_DLList,
        remoteSort: false,
        idField: 'bg6_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'bg6_id', title: 'Fid', width: 260, hidden: true },
            { field: 'bg6_cono', title: 'cono', width: 60, hidden: true },
            { field: 'bg6_divi', title: 'divi', width: 60, hidden: true },
            { field: 'bg6_year', title: '年份', width: 60},
            { field: 'bg6_brand', title: '品牌', width: 60},
			{ field: 'bg6_code', title: '系统编码', width: 65, sortable: true },
			{ field: 'bg6_code1', title: '自编号', width: 60, sortable: true, editor: 'text' },
			{ field: 'bg6_name', title: '名称', width: 120, sortable: true },
			{ field: 'bg6_remark', title: '说明', width: 160, editor: 'text' },
			{ field: 'bg6_centers', title: '成本中心', width: 100, editor: 'text' },
			{ field: 'bg6_xlcodes', title: '科目代码', width: 100, editor: 'text' },
			{ field: 'bg6_type', title: '参数类型', width: 80, sortable: true },
            { field: 'bg6_state', title: '状态', width: 50},
			{ field: 'bg6_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg6_rguser', title: '创建人', width: 70 },
		    { field: 'bg6_lmdt', title: '修改时间', width: 105 },
            { field: 'bg6_lmuser', title: '修改人', width: 70 },
            { field: 'bg6_uptno', title: '修改次数', width: 70 }
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
            actLoadData(pageNumber, pageSize);
        },
        buttons: [{ 
            text: '保存',
            iconCls: 'icon-save',
            handler: function () {
                actSave();
            }
        }]

    });

    //系统管理员特殊维护   
    var dg = $(m_DatagridID);
    if (m_UserInfo.UserName == '邓乐韵') { 
        var col1 = dg.datagrid('getColumnOption', 'bg6_type');  //参数类型
        col1.editor = { type: 'validatebox', options: {} };
        var col2 = dg.datagrid('getColumnOption', 'bg6_state');  //状态
        col2.editor = { type: 'validatebox', options: {} };
        var col3 = dg.datagrid('getColumnOption', 'bg6_name');  //名称
        col3.editor = { type: 'validatebox', options: {} };
        
        /*
        $('#cxpager').pagination({
            buttons: [{ 
                    text: '新建',
                    iconCls: 'icon-add',
                    handler: function () {
                        actAdd();
                    }
                }, '-', {
                    text: '保存',
                    iconCls: 'icon-save',
                    handler: function () {
                        actSave();
                    }
                }]
        });
        */
    }
}