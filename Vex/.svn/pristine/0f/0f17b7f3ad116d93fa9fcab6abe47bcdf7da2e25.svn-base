var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数
 

//固定资产类别数组
var m_DLList = [];
var m_XLList = [];

//用户信息
var m_UserInfo = basedata_getUserInfo();

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];

//行动计划
var m_PlanUse = [];

//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }, { "text": "2016" }, { "text": "2017" }, { "text": "2018" }];

//CONO
var m_CONOs = [{ "text": "EP" }, { "text": "DL" }];

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' ORDER BY BG1_CONO, BG1_Years, BG1_CenterCode, BG1_LargeClassCode, BG1_SmallClassCode, BG1_AssetsName '; //排序方式


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () { 
        //根据index.html页面的高度设置列表高度 
        $(m_DatagridID).datagrid('resize', {
            width: $(document.body).width(),
            height: getcurheight()
        });
    }); 

    var cxml = '';

    //基础数据获取
    var PlanUseid = peoa_GetBDFID(6);//行动计划 
    var DLListid = peoa_GetBDFID(13);//资产大类  
    var cons = ' AND CT1_FatherID in ('
             + '\'' + PlanUseid + '\',' + '\'' + DLListid + '\'' 
             + ')';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == PlanUseid.toUpperCase()) {
            m_PlanUse.push(res[i]);
        } else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
        }  
    }

    //行动计划选项获取  
    $('#cxPlanUse').combobox({
        panelWidth: "150",
        panelHeight: "70",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_PlanUse
    }); 

     
    //大类名称
    $('#cxDLMC').combobox({
        panelWidth: "150",
        panelHeight: "100",
        editable: true,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_DLList
    });
    $('#cxDLMC').combobox('loadData', m_DLList);

    //小类名称
    $('#cxXLMC').combobox({
        panelWidth: "150",
        panelHeight: "100",
        editable: true,
        multiple: false,
        valueField: 'codename',
        textField: 'codename',
        onShowPanel: function (rowIndex) {
            //重新小类信息                       
            if ($('#cxDLMC').combobox('getValue') == '') {
                $('#cxXLMC').combobox('loadData', []);
            } else {
                $('#cxXLMC').combobox('loadData', basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
                    , basedata_getCommonData('DIVI'), '2', '启用', 'FAClaseType', $('#cxDLMC').combobox('getValue'), '', ''));
            }
        }
    });

    //所属公司
    $('#cxCONO').combobox({
        panelWidth: "150",
        panelHeight: "100",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_CONOs

    });

    //状态
    $('#cxState').combobox({
        panelWidth: "85",
        panelHeight: "60",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_States

    });

    //年份
    $('#cxYear').combobox({
        panelWidth: "85",
        panelHeight: "60",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_Years

    });

    
    actyslbcsh(m_DatagridID);

    searchByCons();
 
});


/***********************************************************************
 *  清除按钮事件：清除查询条件
 *  DLY
 *  2013-05-25
 */
function clearText() {
    $('#cxCostCenter').attr('value', '');
    $('#cxYear').combobox('setValue', '');
    $('#cxCONO').combobox('setValue', '');
    $('#cxPlanUse').combobox('setValue', '');
    $('#cxState').combobox('setValue', '');
    $('#cxDLMC').combobox('setValue', '');
    $('#cxXLMC').combobox('setValue', '');
}

/***********************************************************************
 *  查询按钮事件：根据条件查询
 *  DLY
 *  2013-06-15
 */
function searchByCons() {
    m_PageNumber = 1;
    var cfilter = '';
    if ($('#cxCostCenter').attr('value') != '') {
        cfilter = cfilter + ' AND bg1_centercode LIKE \'%' + $('#cxCostCenter').attr('value') + '%\'';
    }
    if ($('#cxYear').combobox('getValue') != '') {
        cfilter = cfilter + ' AND bg1_years = \'' + $('#cxYear').combobox('getValue') + '\'';
    }
    if ($('#cxState').combobox('getValue') != '') {
        cfilter = cfilter + ' AND bg1_state = \'' + $('#cxState').combobox('getValue') + '\'';
    }
    if ($('#cxCONO').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_cono = \'' + $('#cxCONO').combobox('getValue') + '\'';
    }
    if ($('#cxPlanUse').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_planuse = \'' + $('#cxPlanUse').combobox('getValue') + '\'';
    }
    if ($('#cxDLMC').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_largeclassname = \'' + $('#cxDLMC').combobox('getText') + '\'';
    }
    if ($('#cxXLMC').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_smallclassname LIKE \'%' + $('#cxXLMC').combobox('getText') + '%\'';
    }

    m_Filter1 = cfilter;
    //alert(m_Filter1);
    actLoadData(m_PageNumber, m_PageSize);
}



/***********************************************************************
 *  刷新列表数据
 *  DLY
 *  2014-05-28
 */
function actLoadData(page, number) {
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=Gets&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (dataUtil_undefinedOrNull(data.rows[0].totalnum, 0) == 0) {
                    $(m_DatagridID).datagrid('loadData', []);
                    totalCount = 0;
                } else {
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    totalCount = dataUtil_undefinedOrNull(data.rows[0].totalnum, 0);
                }
            }
        }
    })
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });

}

/***********************************************************************
 *  保存固定资产预算信息
 *  DLY
 *  2014-05-28
 */
function actSave() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    var cXML1 = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        if (!actSaveCheck()) {
            return flag;
        }
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        for (var i = 0; i < inserted.length; i++) {
            inserted[i].otype = 'inserted';
            gridDataChanges.push(inserted[i]);
        }
        for (var i = 0; i < updated.length; i++) {
            updated[i].otype = 'updated';
            updated[i].bg1_lmuser = m_UserInfo.UserName;
            updated[i].bg1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            gridDataChanges.push(updated[i]);
        }
        for (var i = 0; i < deleted.length; i++) {
            var obj = new Object();
            obj.bg1_id = deleted[i].bg1_id;
            obj.otype = 'deleted';
            gridDataChanges.push(obj);
        }
        cXML1 = GetEditJson(gridDataChanges, [], []);//json转xml
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=Save"; //拼接url
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
                if (data.rows[0].flag.toUpperCase == 'TRUE') {
                    flag = true;
                    actLoadData(m_PageNumber, m_PageSize);
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
 *  保存校验固定资产预算信息
 *  DLY
 *  2014-05-28
 */
function actSaveCheck() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    var j = 0;
    for (var i = 0; i < dataRows.length; i++) {
        j = i * 1 + 1;
        flag = false;
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_cono, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“所属公司”必填！');
            $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_years, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“年份”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_centercode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“成本中心”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_cono, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“所属公司必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_largeclassname, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“资产大类”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_largeclassname, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“资产大类”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_largeclasscode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“大类编码不能为空！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_smallclassname, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“资产小类”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_smallclasscode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“小类编码”不能为空！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_number, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“数量”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_price, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“资产单价”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_sureamount, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“总金额”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_planuse, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“行动计划”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_state, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“状态”必填！');
            break;
        }
        flag = true;
    }
    if (!flag) {
        m_LastIndex = j * 1 - 1;
        $(m_DatagridID).datagrid('selectRow', m_LastIndex);
        $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
    }
    return flag;
}

/***********************************************************************
 *  固定资产预算列表初始化
 *  DLY
 *  2014-04-28
 */
function actyslbcsh(dgid) { 
    $(dgid).datagrid({
        //title:'预算列表', 
        //width: document.body.clientWidth,
        height: getcurheight(),
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'sid', 
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'sid', title: 'sid', width: 100, hidden: true },
			{ field: 'bg1_id', title: 'FID', width: 100, hidden: true },
            {
                field: 'bg1_cono', title: '所属公司'  
                
            },
            { field: 'bg1_divi', title: 'divi', width: 40 },
            { field: 'bg1_years', title: '年份', width: 50, editor: 'text' },
            { field: 'bg1_centercode', title: '成本中心', width: 60, editor: 'text' },
			{
			    field: 'bg1_largeclassname', title: '资产大类', width: 100
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename',
                        data: m_DLList, editable: false, panelHeight: "100",
                        onShowPanel: function () {
                        },
                        onSelect: function (record) {
                            //填充大类编码 
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_largeclasscode' });
                            ed.target.val(record.ct1_code);
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclasscode' });
                            ed1.target.val('');
                            var ed2 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclassname' });
                            ed2.target.combobox('setValue', '');
                        } 
                    }
                }
			},
			{ field: 'bg1_largeclasscode', title: '大类编码', width: 100, editor: 'text', hidden: true },
			{
			    field: 'bg1_smallclassname', title: '资产小类', width: 100
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'codename', textField: 'codename',
                        data: m_XLList, editable: false, panelHeight: "100",
                        onShowPanel: function () {
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_largeclasscode' });
                            if (dataUtil_undefinedOrNull(ed.target.val(), '') == '') {
                                alert('请先选择资产大类！');
                                return false;
                            }
                            //重新小类信息                          
                            var cxml = '<CONO>HWA</CONO><DIVI>D01</DIVI><Level>2</Level><State>启用</State>'
                                        + '<Code0>FAClaseType</Code0><Code1>'
                                        + ed.target.val()
                                        + '</Code1><Code2></Code2><Order></Order>'
                            m_XLList = basedata_getBD('gbd2', cxml);
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclassname' });
                            ed1.target.combobox('loadData', m_XLList);
                        },
                        onSelect: function (record) {
                            //填充小类编码 
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclasscode' });
                            ed1.target.val(record.code);
                        } 
                    }
                }
			},
			{ field: 'bg1_smallclasscode', title: '小类编码', width: 100, editor: 'text', hidden: true },
            { field: 'bg1_assetsname', title: '资产名称', width: 100, editor: 'text' },
			{
			    field: 'bg1_number', title: '数量', width: 60, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0, min: 0 } }
			},
			{
			    field: 'bg1_price', title: '资产单价', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
           {
               field: 'bg1_sureamount', title: '总金额', width: 100, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum(val); }
           },
		    {
		        field: 'bg1_planuse', title: '行动计划', width: 80
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_code', textField: 'ct1_codename',
                        data: m_PlanUse, editable: false, panelHeight: "70"
                    }
                }
		    },
		    {
		        field: 'bg1_state', title: '状态', width: 50
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'text', textField: 'text',
                        data: m_States, editable: false, panelHeight: "60"
                    }
                }
		    },
            { field: 'bg1_remark', title: '备注', width: 150, editor: 'text' },
			{ field: 'bg1_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg1_rguser', title: '创建人', width: 70 },
		    { field: 'bg1_lmdt', title: '修改时间', width: 105 },
            { field: 'bg1_lmuser', title: '修改人', width: 70 },
            { field: 'bg1_uptno', title: '修改次数', width: 70 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
        },
        onClickRow: function (rowIndex) {
            $(dgid).datagrid('endEdit', m_LastIndex);
            $(dgid).datagrid('selectRow', rowIndex);
            $(dgid).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex;
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        },
        toolbar: '#tjcxk'
    });


    //设置查询分页控件  
    //pager.pagination("options")
    //对象如下：total | pageSize | pageNumber | pageList | loading | buttons | showPageList | showRefresh | onSelectPage 
    //| onBeforeRefresh | onRefresh | onChangePageSize | beforePageText | afterPageText | displayMsg | 

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数，默认为20  
        //pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadData(pageNumber, pageSize);
        },
        buttons: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                $(dgid).datagrid('appendRow', {
                    bg1_id: dataUtil_NewGuid(),
                    bg1_rgdt: dateUtil_dateFomaterA(new Date(), '-'),
                    bg1_rguser: m_UserInfo.UserName,
                    bg1_uptno: 0,
                    bg1_divi: basedata_getCommonData('DIVI'),
                    bg1_state: '启用'
                });
                $(dgid).datagrid('endEdit', m_LastIndex);
                m_LastIndex = $(dgid).datagrid('getRows').length - 1;
                $(dgid).datagrid('selectRow', m_LastIndex);
                $(dgid).datagrid('beginEdit', m_LastIndex);
            }
        }, '-', {
            text: '复制',
            iconCls: 'icon-design',
            handler: function () {
                var row = $(dgid).datagrid('getSelected');
                if (row) {
                    var obj = new Object();
                    obj.bg1_id = dataUtil_NewGuid(),
                    obj.bg1_rgdt = dateUtil_dateFomaterA(new Date(), '-');
                    obj.bg1_rguser = m_UserInfo.UserName;
                    obj.bg1_uptno = 0;
                    obj.bg1_cono = row.bg1_cono;
                    obj.bg1_divi = row.bg1_divi;
                    obj.bg1_years = row.bg1_years;
                    obj.bg1_centercode = row.bg1_centercode;
                    obj.bg1_planuse = row.bg1_planuse;
                    obj.bg1_largeclasscode = row.bg1_largeclasscode;
                    obj.bg1_largeclassname = row.bg1_largeclassname;
                    obj.bg1_smallclassname = row.bg1_smallclassname;
                    obj.bg1_smallclasscode = row.bg1_smallclasscode;
                    obj.bg1_assetsname = row.bg1_assetsname;
                    obj.bg1_number = row.bg1_number;
                    obj.bg1_price = row.bg1_price;
                    obj.bg1_sureamount = row.bg1_sureamount;
                    obj.bg1_remark = row.bg1_remark;
                    obj.bg1_state = row.bg1_state;
                    $(dgid).datagrid('endEdit', m_LastIndex);
                    $(dgid).datagrid('appendRow', obj);
                    m_LastIndex = $(dgid).datagrid('getRows').length - 1;
                    $(dgid).datagrid('selectRow', m_LastIndex);
                    $(dgid).datagrid('beginEdit', m_LastIndex);
                }
            }
        }, '-', {
            text: '删除',
            iconCls: 'icon-remove',
            handler: function () {
                var row = $(dgid).datagrid('getSelected');
                if (row) {
                    $.messager.confirm('确认框', '确认删除此记录吗？', function (r) {
                        if (r) {
                            var index = $(dgid).datagrid('getRowIndex', row);
                            $(dgid).datagrid('deleteRow', index);
                            m_LastIndex = -1;
                        }
                    });
                }
            }
        }, '-', {
            text: '保存',
            iconCls: 'icon-save',
            handler: function () {
                actSave();
            }
        }, '-', {
            text: 'Excel导入',
            iconCls: 'icon-menu',
            handler: function () {
                openYSNGDZCSdlg();
            }
        }]

    });
}
 


/*******************
 * 获取列表高度
 */
function getcurheight() {
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 80;
    return curheight;
}