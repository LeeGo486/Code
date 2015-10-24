var m_columns = null;
var editIndex;
var m_ViewTableName = "V_0001forgqq";

//初始化
$(function () {
    var htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;
    //txtDepotBrand
    $('#txtDepotBrand').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0008&PropertyName=" + escape("品牌名称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird
    });

    //InitGird();
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title: '公司信息', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName}]) },

            idField: 'ws_id', //标识字段,主键
            iconCls: '', //标题左边的图标
            width: '90%', //宽度
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
            }]
        }
        );

    var $dg = $('#tab_list');

    //$('#tab_list').datagrid("hideColumn", "body_id");
    $('#tab_list').datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
  

    
    var col = $dg.datagrid('getColumnOption', '公司中文简称');
    col.editor = {
        type: 'combobox', options: { data: [{ "id": 1, "text": "贝爱" }, { "id": 2, "text": "2" }], required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
    var col = $dg.datagrid('getColumnOption', '公司前缀');
    col.editor = {};

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
                                            [{ "name": "公司简称"}],
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
                    url: GetWSRRURL('611b162c-47d5-4409-891d-731cbbd3f022'),
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