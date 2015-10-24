/// JS名：sizeGroup.js
/// 说明：尺码号型维护
/// 创建人：俞佳伟
/// 创建日期：2015-02-27

var m_zt = "";
var m_data = [];
var m_state = [{ ct1_state: '20', name: '启用' }, { ct1_state: '99', name: '禁用' }];
var m_index_group = ""; //尺码组行索引
var m_index_size = "";//尺码行索引

//初始化
$(function () {
    m_zt = $.cookie("compName");
    m_data[0] = { "name": "txtzt", "value": m_zt };
    var url = GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&XML=" + GetFormJson(m_data, 'Get') + "&Where=CT1_Code='";
    InitGridSizeGroup(url + "SDGP'");
});

//加载尺码组数据
function InitGridSizeGroup(url) {
    $('#tabSizeGroup').datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        onSelect: onSelect,
        onDblClickRow: onDblClickRow,
        fit: true,
        sortName: 'ct1_lmdt', //倒序
        sortOrder: 'desc',
        columns: [[
            { field: "ct1_optionsvalues", title: "尺码组编号", width: 100, sortable: true, search: true, editor: 'text', options: { required: true } },
            { field: "ct1_options", title: "尺码组名称", width: 120, sortable: true, search: true, editor: 'text', options: { required: true } },
            { field: "ct1_keyid", title: "号型编号", hidden: true },
            { field: "ct1_keyname", title: "号型名称", hidden: true },
            {
                field: "ct1_state", title: "状态", width: 80, editor: {
                    type: 'combobox',
                    options: {
                        panelHeight: 50,
                        valueField: 'ct1_state',
                        textField: 'name',
                        data: [{ ct1_state: '20', name: '启用' }, { ct1_state: '99', name: '禁用' }],
                        required: true
                    }
                }
            }
        ]],
        toolbar: [
            {
                iconCls: 'icon-add',
                text: '新增',
                handler: function () {
                    //btnSizeGroup("add");
                    btnNew('tabSizeGroup');
                }
            },
            '-',
            {
                iconCls: 'icon-save',
                text: '保存',
                handler: function () {
                    btnSave('tabSizeGroup');
                    //btnSizeGroup("edit")
                }
            }
        ],
        onLoadSuccess: function (data) {
            if (data.rows.length > 0) {
                $('#tabSizeGroup').datagrid('selectRow', 0);
            }
        }
    });
}

//加载尺码数据
function InitGridSize(url) {
    $('#tabSize').datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        sortName: 'ct1_lmdt', //倒序
        sortOrder: 'desc',
        onDblClickRow: onDblClickRow1,
        columns: [[
            { field: "ct1_optionsvalues", title: "尺码编号", width: 100, sortable: true, search: true, editor: 'text', options: { required: true } },
            { field: "ct1_options", title: "尺码名称", width: 100, sortable: true, search: true, editor: 'text', options: { required: true } },
            { field: "ct1_keyid", title: "号型编码", width: 100, sortable: true, search: true, editor: 'text', options: { required: true } },
            { field: "ct1_keyname", title: "号型名称", width: 100, sortable: true, search: true, editor: 'text', options: { required: true } },
            {
                field: "ct1_state", title: "状态", width: 80, editor: {
                    type: 'combobox',
                    options: {
                        panelHeight: 50,
                        valueField: 'ct1_state',
                        textField: 'name',
                        data: [{ ct1_state: '20', name: '启用' }, { ct1_state: '99', name: '禁用' }],
                        required: true
                    }
                }
            }

        ]],
        toolbar: [
            {
                iconCls: 'icon-add',
                text: '新增',
                handler: function () {
                    btnNew("tabSize");
                }
            },
            '-',
            {
                iconCls: 'icon-save',
                text: '保存',
                handler: function () {
                    btnSave('tabSize');
                }
            }
        ]
    });
}

//单击尺码组行,显示该尺码组下的尺码信息
function onSelect(index, row) {
    $('#tabSizeGroup').datagrid('endEdit', m_index_group);
    var fatherID = "";
    if (row.ct1_keyid == "") {
        ClearGrid('#tabSize');
        return;
    }
    else {
        fatherID = row.ct1_id;
    }
    var url = GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&XML=" + GetFormJson(m_data, 'Get') + "&Where=CT1_Code='SIDE' AND CT1_fatherID='" + fatherID + "'";
    InitGridSize(url);
}

//双击行事件——尺码组
function onDblClickRow(index, row) {
    if (m_index_group != index) {
        $('#tabSizeGroup').datagrid('endEdit', m_index_group);
    }    
    $('#tabSizeGroup').datagrid('beginEdit', index);
    m_index_group = index;
    //btnSizeGroup();
}

//双击行事件——尺码
function onDblClickRow1(index, row) {
    if (m_index_size != index) {
        $('#tabSize').datagrid('endEdit', m_index_size);
    }
    $('#tabSize').datagrid('beginEdit', index);
    m_index_size = index;
    //btnSize();
}

//新增 尺码组、尺码
function btnNew(table) {
    var myIndex = "";
    var code = "";
    var codeName = "";
    var fatherID = "";
    if (table == "tabSizeGroup") {
        myIndex = m_index_group;
        code = "SDGP";
        codeName = "尺码组";
        fatherID = "";
    } else {
        myIndex = m_index_size;
        code = "SIDE";
        codeName = "尺码";
        var selectRow = $('#tabSizeGroup').datagrid('getSelected');
        if (selectRow.ct1_id != "") {
            fatherID = selectRow.ct1_id;
        }
        else {
            return;
        }
    }
    
    $('#' + table).datagrid('endEdit', myIndex);
    $('#' + table).datagrid('appendRow', {
        ct1_id: '',
        ct1_cono: 'HYFG',
        ct1_divi: m_zt,
        ct1_code: code,
        ct1_codename:codeName,
        ct1_keyid: '',
        ct1_keyname: '',
        ct1_options: '',
        ct1_optionsvalues: '',
        ct1_state: '20',
        ct1_fatherid: fatherID,

    });
    var lastIndex = $('#' + table).datagrid('getRows').length - 1;
    $('#' + table).datagrid('selectRow', lastIndex);
    $('#' + table).datagrid('beginEdit', lastIndex);
    if (table == "tabSizeGroup") {
        m_index_group = lastIndex;
    }
    else {
        m_index_size = lastIndex;
    }
}

//保存
function btnSave(table) {
    var myIndex = "";
    if (table == "tabSizeGroup") {
        myIndex = m_index_group;
    }
    else {
        myIndex = m_index_size;
    }
    $('#' + table).datagrid('endEdit', myIndex);
    var changeRows = $('#' + table).datagrid('getChanges');
    if (changeRows.length > 0) {
        var insertRow = $('#' + table).datagrid('getChanges', 'inserted');
        var updateRow = $('#' + table).datagrid('getChanges', 'updated');
        var editJSON = GetEditJson(insertRow, updateRow, null);
        var data = [];
        data[data.length] = { "name": "txtct1_divi", "value": m_zt };
        data[data.length] = { "name": "txtdata", "value": editJSON, "specialCharset": true };
        var XMLData = GetFormJson(data, 'Save');
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('09ff9c05-e23e-4d77-a82c-955dbfab0b04'),
            type: 'post',
            async: true, //异步,
            data: { "XML": XMLData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $('#' + table).datagrid('reload');
                        $.messager.progress('close');

                    }
                } catch (ex) {
                    $.messager.progress('close');

                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
        return false;
    }
    else {
        alert('没有需要保存的数据');
    }
}

