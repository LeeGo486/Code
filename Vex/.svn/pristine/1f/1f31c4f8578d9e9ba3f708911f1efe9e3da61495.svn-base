/* 全局变量*/
var m_DatagridID = '#jbpzb';//加班配置表
var m_LastIndex = undefined;  //项目列表最后一次编辑行下标  


//获取用户名
var m_UserInfo = parent.m_UserInfo;

var loginurl = hr_getServUrl(1);

var m_Filter = '';  //主的条件,获取当前用户可查询公司
var m_Filter1 = ''; //查询条件,获取当前用户加班配置的信息
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 
var m_OrderBy = ' HR10_Com, HR10_Type, HR10_Day   '; //排序方式
var m_OrderBy1 = ' HR9_ID '; //排序方式

//当前可查询的公司
var m_Companys;
//类型选择
var m_Types = [{ typeid: '0', typetext: '小时' }, { typeid: '1', typetext: '天' }];   //0-小时，1-天
//宽度设置
var m_widths = [153, 150, 120, 100, 70, 200, 300];

/***********************************************************************
 *  初始化
 *  DLY 
 */
$(function () {
    //滚动条居顶
    parent.sc();
    //获取公司ID和公司名称
    m_Filter1 = ' AND HR9_Type = \'0\' ';
    if(m_UserInfo.actor=='C'){
        m_Filter1 += 'AND HR9_RZEmpCode= \'' + m_UserInfo.empCode + '\'';
    }
    m_Companys = hr_getSYSConfig1(m_Filter1, 1, 10000, m_OrderBy1);

    //设置相关控件
    setDatebox('#day');
    setCombobox('#cxCompany', m_widths[0], m_widths[0], m_widths[1], true, false, 'hr9_ehrorgid', 'hr9_com', m_Companys.rows);
    m_Filter = ' AND HR10_ComID IN (' + m_UserInfo.comIDs + '-2)';
    setDataGrid();
    actLoadData(1, m_PageSize);
});


/***********************************************************************
 *  设置日期控件
 *  DLY 
 */
function setDatebox(field) {
    $(field).datebox({
        width: m_widths[0],
        closeText: '关闭',
        editable: true,
        formatter: function (date) {
            return dateUtil_dateFomaterB(date, '-');
        },
        parser: function (s) {
            var t = Date.parse(s);
            if (!isNaN(t)) {
                return new Date(t);
            } else {
                return new Date();
            }
        },
        onChange: function (newValue, oldValue) {
            if (newValue != oldValue) {
            }
        }
    });
}


/***********************************************************************
 *  设置下拉控件
 *  DLY 
 */
function setCombobox(field, width, pwidth, pheight, edit, multi, vfield, tfield, data) {
    $(field).combobox({
        width: width,
        panelWidth: pwidth,
        panelHeight: pheight,
        editable: edit,
        multiple: multi,
        valueField: vfield,
        textField: tfield,
        data: data
    });
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'加班权限配置表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 400,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'hr10_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'hr10_id', title: 'FID', width: 80, hidden: true },
            { field: 'hr10_cono', title: '集团编码', width: 70, hidden: true },
            { field: 'hr10_divi', title: '事业体编码', width: 100, hidden: true },
            { field: 'hr10_comid', title: '公司ID', width: 200, hidden: true, editor: 'text' },
            {
                field: 'hr10_com', title: '公司名称', width: 100, editor: {
                    type: 'combobox', options: {
                        valueField: 'hr9_com', textField: 'hr9_com',
                        editable: false, panelHeight: "100",
                        data: m_Companys.rows,
                        onSelect: function (record) {
                            //填充公司编码
                            var ed = $(m_DatagridID).datagrid('getEditor', { index: m_LastIndex, field: 'hr10_comid' });
                            ed.target.val(record.hr9_ehrorgid);
                        }
                    }
                }
            },
            {
                field: 'hr10_day', title: '日期', width: 100, editor: {
                    type: 'datebox', options: {
                        formatter: function (val) {
                            if (val) {
                                return dateUtil_dateFomaterB(new Date(val), '-');
                            }
                        }
                    }
                }
            },
            {
                field: 'hr10_money', title: '金额', width: 80, align: "right"
                , editor: { type: 'numberbox', options: { precision: 0 } }
            },
            {
                field: 'hr10_type', title: '类型', width: 80, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_Types, val, 'typeid', 'typetext');
                }, editor: {
                    type: 'combobox', options: {
                        editable: false,
                        valueField: 'typeid', textField: 'typetext',
                        data: m_Types
                    }
                }
            },
            {
                field: 'hr10_rgdt', title: '创建时间', width: 125,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'hr10_rguser', title: '创建人', width: 80 },
            {
                field: 'hr10_lmdt', title: '修改时间', width: 125,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'hr10_lmuser', title: '修改人', width: 80 },
            { field: 'hr10_uptno', title: '修改次数', width: 60 , align: "center"}
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            if (m_LastIndex != undefined) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            }
            $(m_DatagridID).datagrid('selectRow', rowIndex);
            $(m_DatagridID).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex;
        },
        onClickRow: function (rowIndex) {
            if (m_LastIndex != undefined) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            }
            $(m_DatagridID).datagrid('selectRow', rowIndex);
            m_LastIndex = rowIndex;
        }
    });

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数  
        //pageList: [20, 50, 100, 200],//可以设置每页记录条数的列表  
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
            text: dataUtil_actSetNStr('新增', 1),
            iconCls: 'icon-plus-green',
            handler: function () { actAdd(); }
        },
        {
            text: dataUtil_actSetNStr('复制', 1),
            iconCls: 'icon-design-green',
            handler: function () { actCopy(); }
        },
        {
            text: dataUtil_actSetNStr('保存', 1),
            iconCls: 'icon-save-blue',
            handler: function () { actSave(); }
        },
        {
            text: dataUtil_actSetNStr('&nbsp', 60)
        },
        {
            text: dataUtil_actSetNStr('删除', 1),
            iconCls: 'icon-minus-red',
            handler: function () { actDelete(); }
        }]
    });
}


/***********************************************************************
 *  新增数据行，设置默认值
 *  DLY 
 */
function actAdd() {
    //结束最后一次编辑
    if (m_LastIndex != undefined) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }
    var rowIndex = $(m_DatagridID).datagrid('getRows').length;


    //新增一行,并且设置默认值
    var rownew = {};
    rownew.hr10_id = dataUtil_NewGuid();
    rownew.hr10_cono = hr_getCommonData('CONOT');
    rownew.hr10_divi = hr_getCommonData('DIVI');
    //rownew.hr10_comid = m_Companys.rows[0].hr9_ehrorgid;
    rownew.hr10_com = m_Companys.rows[0].hr9_com;
    //获取当前是日期yyyy-MM-dd
    var date = new Date();
    var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
    var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
    + (date.getMonth() + 1);
    //当前日期
    rownew.hr10_day = date.getFullYear() + '-' + month + '-' + day;
    rownew.hr10_money = 0;
    //默认类型为小时
    rownew.hr10_type = m_Types[0].typeid;
    //新增时，修改次数默认为空
    rownew.hr10_uptno = 0;

    $(m_DatagridID).datagrid('appendRow', rownew);
    $(m_DatagridID).datagrid('selectRow', rowIndex);
    $(m_DatagridID).datagrid('beginEdit', rowIndex);
    m_LastIndex = rowIndex;
}


/***********************************************************************
 *  复制事件
 *  DLY 
 */
function actCopy() {
    if (m_LastIndex != undefined) {
        //复制当前行
        var row = $(m_DatagridID).datagrid('getSelected');
        //结束最后一次编辑
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
        $(m_DatagridID).datagrid("clearSelections");

        var rownew = {};
        rownew.hr10_id = dataUtil_NewGuid();
        rownew.hr10_cono = row.hr10_cono;
        rownew.hr10_divi = row.hr10_divi;
        rownew.hr10_comid = row.hr10_comid;
        rownew.hr10_com = row.hr10_com;
        rownew.hr10_day = row.hr10_day;
        rownew.hr10_money = row.hr10_money;
        rownew.hr10_type = row.hr10_type;
        rownew.hr10_uptno = 0;
        //新增一行
        $(m_DatagridID).datagrid('appendRow', rownew);
        rowIndex = $(m_DatagridID).datagrid('getRows').length - 1;
        $(m_DatagridID).datagrid('selectRow', rowIndex);
        $(m_DatagridID).datagrid('beginEdit', rowIndex);
        m_LastIndex = rowIndex;
    }
    else {
        $.messager.alert('提示', '请选择要复制的记录！', 'warning')
    }

}


/***********************************************************************
 *  删除事件
 *  DLY 
 */
function actDelete() {
    //结束最后一次编辑项
    if (m_LastIndex != undefined) {
        $.messager.confirm('确认框', '确认删除选中记录吗？', function (r) {
            if (r) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
                var row1 = $(m_DatagridID).datagrid('getSelected');

                $(m_DatagridID).datagrid('cancelEdit', m_LastIndex);
                $(m_DatagridID).datagrid('deleteRow', m_LastIndex);

                $(m_DatagridID).datagrid("clearSelections");
                m_LastIndex = undefined;
            }
        });
    }
    else {
        $.messager.alert('提示', '请选择要删除的记录！', 'warning');
    }

}


/***********************************************************************
 *  保存加班信息校验
 *  DLY 
 */
function saveCheck() {
    var flag = true;
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        var j = i * 1 + 1;
        if (dataUtil_undefinedOrNull(rows[i].hr10_com, '') == '') {
            alert('第' + j + '行公司必填！');
            return false;
        }
        if (dataUtil_undefinedOrNull(rows[i].hr10_type, '') == '1'
            && dataUtil_undefinedOrNull(rows[i].hr10_day, '') == '') {
            alert('第' + j + '行日期必填！');
            return false;
        }else if (dataUtil_undefinedOrNull(rows[i].hr10_type, '') == '0') {
            rows[i].hr10_day = ''; //小时的日期置空
        } 
        if (isNaN(rows[i].hr10_money)) {
            alert('第' + j + '行金额必填且为数字！');
            return false;
        }
        //if (dataUtil_undefinedOrNull(rows[i].hr10_type, '') == '') {
        //    alert('第' + j + '行类型必填！');
        //    return false;
        //}
    }
    return flag;
}


/***********************************************************************
 *  保存事件
 *  DLY 
 */
function actSave() {
    var flag = false;

    //结束编辑行
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);

    //行信息校验
    if (!saveCheck()) {
        return flag;
    }

    var dataRows = $(m_DatagridID).datagrid('getRows');
    var cXML1 = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        for (var i = 0; i < inserted.length; i++) {
            inserted[i].hr10_rgdt = dateUtil_dateFomaterA(new Date(), '-');
            inserted[i].hr10_rguser = m_UserInfo.userName;
            inserted[i].hr10_uptno = 0;
        }
        for (var i = 0; i < updated.length; i++) {
            updated[i].hr10_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            updated[i].hr10_lmuser = m_UserInfo.userName;
            updated[i].hr10_uptno = updated[i].hr10_uptno*1 + 1;
        }
        //for (var i = 0; i < deleted.length; i++) {

        //}
        cXML1 = GetEditJson(inserted, updated, deleted);//json转xml
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveOTSpecialDay&actor="
             + encodeURIComponent(m_UserInfo.userName) + "&s=" + new Date().getTime(); //拼接url
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
                    flag = true;
                }
            }
        }
    });

    if (flag) {
        alert('保存成功！');
        $(m_DatagridID).datagrid("clearSelections");
        m_LastIndex = undefined;
    } else {
        alert('保存失败！');
    }
    return flag;
}



/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条件
    var cons = m_Filter;
    var com = $('#cxCompany').combobox('getValues');
    var day = $('#day').datebox('getValue');
    if (com != '') {
        cons = cons + ' AND ( HR10_ComID LIKE \'%' + com + '%\'';
        cons = cons + '  OR HR10_Com LIKE \'%' + com + '%\' )';
    }
    if (day != '') {
        cons = cons + ' AND ( HR10_Day LIKE \'%' + day + '%\')';
    }
    var res = hr_getOTSpecialDay(cons, page, number, m_OrderBy);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridID).datagrid('loadData', res.rows);
        totalCount = res.total;
    }
    $(m_DatagridID).datagrid("clearSelections");
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });
}


/***********************************************************************
 *  清除
 *  DLY 
 */
function clearText() {
    $('#cxCompany').combobox('setValue', '');
    $('#day').datebox('setValue', '');
}