var m_typeList = [{ "value": "Value_Text", "text": "Value_Text" },
{ "value": "Value_Date", "text": "Value_Date" },
{ "value": "Value_Number", "text": "Value_Number" }];

var m_EditEntity = "";
var m_EditEntity_Name = "";

$(function () {
    $("#treeMainEntity").tree({
        checkbox: false,
        url: GetTreeWSRRURL('ae663f35-f5b9-40c0-863c-0cb6a003e01e'),
        onClick: function (node) {
            reloadGrid(node.id, node.text);
            m_EditEntity = node.id;

        },
        onLoadSuccess: function (node, data) {
            if (data.Error != null) {
                $.messager.alert("提示", data.error, 'error');
            }
        },
        onLoadError: function (arguments) {
            $.messager.alert("提示", arguments, 'error');
        }
    });

});


function reloadGrid(entity, editEntity_Name) {

    $('#dgProperty').datagrid({
        title: editEntity_Name + '_属性列表',
        url: GetWSRRURL('8df6c35b-b105-43aa-9e7e-b95726b6c773'),
        queryParams: { "XML": GetGetJson([{ "实体编号": entity }]) },

        onBeforeLoad: function () {
            $.messager.progress({ title: '请稍后', msg: '数据加载中' });
        },
        onLoadError: function () {
            $.messager.progress("close");
        },
        onLoadSuccess: function () {
            $.messager.progress("close");
        },
        onClickCell: onClickCell
    });

}



$.extend($.fn.datagrid.methods, {
    editCell: function (jq, param) {
        return jq.each(function () {
            var opts = $(this).datagrid('options');
            var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
            for (var i = 0; i < fields.length; i++) {
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor1 = col.editor;
                if (fields[i] != param.field) {
                    col.editor = null;
                }
            }
            $(this).datagrid('beginEdit', param.index);
            for (var i = 0; i < fields.length; i++) {
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor = col.editor1;
            }
        });
    }
});


var editIndex = undefined;
function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#dgProperty').datagrid('validateRow', editIndex)) {
        $('#dgProperty').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}
function onClickCell(index, field) {
    if (endEditing()) {
        startEditing(index, field);
    }
}

function startEditing(index, field) {
    $('#dgProperty').datagrid('selectRow', index).datagrid('editCell', { index: index, field: field });
    editIndex = index;
}

function append() {
    if (endEditing()) {
        $('#dgProperty').datagrid('appendRow', { "字段类型": 'Value_Text', "实体编号": m_EditEntity });
        editIndex = $('#dgProperty').datagrid('getRows').length - 1;
        $('#dgProperty').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
    }
}


function removeit() {
    if (editIndex == undefined) { return }
    $('#dgProperty').datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
    editIndex = undefined;
}
function accept() {
    if (endEditing()) {
        var check = datagridCheckValueRepeat('#dgProperty',
                                            [{ "name": "字段名称" }, { "name": "属性名称" }],
                                            true, true)
        if (check) {
            $dg = $("#dgProperty");

            if ($dg.datagrid('getChanges').length) {
                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = $dg.datagrid('getChanges', "deleted");
                var updated = $dg.datagrid('getChanges', "updated");
                var updateJSON = GetEditJson(inserted, updated, deleted);

                $.messager.progress({ title: '请稍后', msg: '处理中' });

                $.ajax({
                    url: GetWSRRURL('8df6c35b-b105-43aa-9e7e-b95726b6c773'),
                    type: 'post',
                    async: true, //异步,
                    data: { "XML": updateJSON },
                    success: function (result) {
                        try {
                            var result = eval("[" + result + "]");
                            if (result[0].rows[0].result == "False") {
                                $.messager.progress('close');

                                $.messager.alert("提示", result[0].rows[0].message, 'error');
                            }
                            else {
                                //$.messager.progress('close');
                                $('#dgProperty').datagrid("reload");
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
}
function reject() {
    $('#dgProperty').datagrid('rejectChanges');
    editIndex = undefined;
}
