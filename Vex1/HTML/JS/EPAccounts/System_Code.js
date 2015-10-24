var m_columns = null;
var editIndex;


//初始化
$(function () {
    //var htmlobj = $.ajax({
    //    url: GetGridColumnsWSRRURL('d15b4b45-de9a-4683-b0e6-d6ee3bb1ca3d'),
    //    async: false
    //});
    //var Text = jQuery.parseJSON(htmlobj.responseText);
    //m_columns = Text.Col;

    InitGird();
})

//初始化表格
function InitGird() {
    //ClearGrid("#tab_list");

    $('#tab_list').datagrid(
        {
            title: '账号管理系统编号设置_系统列表', //表格标题
            url: GetWSRRURL('d15b4b45-de9a-4683-b0e6-d6ee3bb1ca3d'),
            queryParams: { "XML": GetGetJson([{}]) },

            sortName: 'system_code', //排序字段
            idField: 'system_code', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            //columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数         
            onClickCell: onClickCell,
            onDblClickRow: onDblClickRow,

            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
            { field: 'system_id', title: '系统ID', width: 60, sortable: true },
            { field: 'system_code', title: '系统编号', width: 100, search: true, sortable: true }
            ]],
            columns: [[
                { field: 'system_name', title: '系统名称', width: 200, search: true, sortable: true },
                //{ field: 'rowindex', title: '1212', width: 200, search: true, sortable: true },
                { field: 'system_sn', title: '系统简称', width: 200, search: true, sortable: true }
            ]],
            toolbar: "#tab_toolbar",



            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    AddNewRow();
                }
            },

            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete();
                }
            }
            ,
            {
                id: 'btn_Save',
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {
                    Save();
                }
            }]
        }
        );

    var $dg = $('#tab_list');




    col = $dg.datagrid('getColumnOption', 'system_code');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', 'system_name');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', 'system_sn');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }

    //$dg.datagrid();


}


function onClickCell(rowIndex, field, value) {
    if (rowIndex != editIndex) {
        endEditing();
    }
}


//function onDblClickRow(index) {

//    if (editIndex != index) {
//        endEditing();
//        editIndex = index;
//        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
//    }
//}

function onDblClickRow(index, rowData) {
    BeginEdit(index, rowData);
}

function BeginEdit(index, rowData) {
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;
            $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}



function endEditing() {

    if (editIndex != undefined) {
        if ($('#tab_list').datagrid('validateRow', editIndex)) {
            $('#tab_list').datagrid('endEdit', editIndex);
            editIndex = undefined;
        }
        else {
            return false;
        }
    }

    return true;
}


function AddNewRow() {
    if (endEditing()) {
        $('#tab_list').datagrid('appendRow', { system_id: "系统自动生成" });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}



function Save() {
    var $dg = $('#tab_list');

    if (endEditing()) {
        if ($dg.datagrid('getChanges').length) {
            var inserted = $dg.datagrid('getChanges', "inserted");
            var deleted = $dg.datagrid('getChanges', "deleted");
            var updated = $dg.datagrid('getChanges', "updated");

            var updateJSON = GetEditJson(inserted, updated, deleted);

            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('d15b4b45-de9a-4683-b0e6-d6ee3bb1ca3d'),
                type: 'post',
                async: true, //异步,
                data: { "XML": updateJSON },
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
                            $.messager.progress('close');
                            $('#tab_list').datagrid("unselectAll");
                            $('#tab_list').datagrid("reload");

                            $.messager.alert("提示", result[0].rows[0].message);
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
        }
    }

}





function Delete() {
    if (!endEditing()) {
        return;
    }
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    var updated = $('#tab_list').datagrid('getChanges', "updated");
    if (updated.length > 0) {
        deleteMessage = '删除提交后，之前做的修改将全部被撤消，并且数据无法恢复，你确定要删除吗?';
    }

    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtsystem_id", "value": selected.system_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('d15b4b45-de9a-4683-b0e6-d6ee3bb1ca3d'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $('#tab_list').datagrid("unselectAll");
                            InitGird();
                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    })


}