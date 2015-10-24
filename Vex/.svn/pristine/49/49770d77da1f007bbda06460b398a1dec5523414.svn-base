var m_columns = null;
var editIndex;
var m_ViewTableName = "V_0008";

var m_ComList = undefined;

//初始化
$(function () {

    var htmlobj = $.ajax({ url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36'),
        data: "MDMClass=0001&PropertyName=" + escape("公司中文简称"), async: false
    });
    m_ComList = jQuery.parseJSON(htmlobj.responseText);

    htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    InitGird();
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title:'品牌',
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName}]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            fit: true,
            singleSelect: true, //单行选择
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            toolbar: "#tab_toolbar",
            onClickCell: onClickCell,
            onDblClickRow: onDblClickRow
            ,
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
                id: 'btn_Copy',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            },
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete();
                }
            }]
        }
        );

    var $dg = $('#tab_list');
    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid();
}

function onClickCell(rowIndex, field, value) {
    if (rowIndex != editIndex) {
        endEditing();
    }
}


function onDblClickRow(index) {

    if (editIndex != index) {
        endEditing();
        editIndex = index;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

function endEditing() {
    if (editIndex != undefined) {
        $('#tab_list').datagrid('endEdit', editIndex);
        editIndex = undefined;
    }
    return true;
}

function AddNewRow() {
    if (endEditing()) {
        $('#tab_list').datagrid('appendRow', { body_id: '' });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

function Save() {

    if (endEditing()) {
        var check = datagridCheckValueRepeat('#tab_list',
                                            [{ "name": "品牌编号"}],
                                            true, true)
        if (check) {
            $dg = $("#tab_list");

            if ($dg.datagrid('getChanges').length) {
                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = $dg.datagrid('getChanges', "deleted");
                var updated = $dg.datagrid('getChanges', "updated");
                var updateJSON = GetEditJson(inserted, updated, deleted);

                $.messager.progress({ title: '请稍后', msg: '处理中' });

                $.ajax({
                    url: GetWSRRURL('26953670-55c7-47ef-be32-75087af98338'),
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
            data[data.length] = { "name": "txtBody_id", "value": selected.body_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('26953670-55c7-47ef-be32-75087af98338'),
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