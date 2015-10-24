var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0006_FOR_EP_Merchant_NEW";
var m_ComBodyID = null;

//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    //txtCom
    $('#txtCom').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0001&PropertyName=" + escape("公司中文简称") + "&Where=" + escape("公司中文简称") + " in" + escape("('东北','泓雅','华南','华中','维姬','西南','新疆','雅斓','雅莹')"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: function (newValue, oldValue) { InitGird(newValue, oldValue) }
    });
})

//初始化表格
function InitGird(newValue, oldValue) {
    endEditing();
    ClearGrid("#tab_list");

    m_ComBodyID = newValue;
    $('#tab_list').datagrid(
        {
            title: '加盟商信息', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&where=body_id_0001='" + m_ComBodyID + "'",
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName }]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数


            onClickCell: onClickCell,
            onDblClickRow: onDblClickRow,
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
                id: 'btn_Update',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            },
            ]
        }
        );


    var $dg = $('#tab_list');
    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id_0010");
    $dg.datagrid("hideColumn", "公司中文简称");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id");

    var col = $dg.datagrid('getColumnOption', '加盟商编码');
    col.editor = {};

    //col = $dg.datagrid('getColumnOption', '加盟商助记码');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    col = $dg.datagrid('getColumnOption', '加盟商名称');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '加盟商简称');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    //col = $dg.datagrid('getColumnOption', '成本中心代码');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    col = $dg.datagrid('getColumnOption', '父加盟商');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }

    col = $dg.datagrid('getColumnOption', '省份');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }



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
        $('#tab_list').datagrid('appendRow', { body_id: '', body_id_0001: m_ComBodyID ,父加盟商:"-1"});
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

function Save() {

    if (endEditing()) {
        //        var check = datagridCheckValueRepeat('#tab_list',
        //                                            [{ "name": "公司简称"}],
        //                                            true, true)
        var check = true;
        if (check) {
            $dg = $("#tab_list");

            if ($dg.datagrid('getChanges').length) {
                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = $dg.datagrid('getChanges', "deleted");
                var updated = $dg.datagrid('getChanges', "updated");
                var updateJSON = GetEditJson(inserted, updated, deleted);

                $.messager.progress({ title: '请稍后', msg: '处理中' });

                $.ajax({
                    url: GetWSRRURL('fe42fdd6-99cc-459b-b5cd-0e3c22f3551a'),
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


