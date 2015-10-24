var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_Depot_CWB";
var m_SelectedRowIndex = null;
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }];
var m_ShopState = [{ "id": 0, "text": "总仓" }, { "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];

//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    InitGird();
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title: '店铺MDM财务管理', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName }]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            frozen: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            toolbar: "#tab_toolbar",
            onDblClickRow: onDblClickRow,
            onBeforeLoad: function () { return endEditing() },
            toolbar: [
            {
                id: 'btn_Copy',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            }
            ]
        });
        


    var $dg = $('#tab_list');
    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid("hideColumn", "body_id_l0011");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id_0008");
    $dg.datagrid("hideColumn", "body_id_l0006");
    $dg.datagrid("hideColumn", "body_id_l0014");


    col = $dg.datagrid('getColumnOption', '店铺型态');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(m_ShopState, value);
        }
    }
    col = $dg.datagrid('getColumnOption', '冻结状态');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(FrozenStus, value);
        }
    }
    col = $dg.datagrid('getColumnOption', '店铺id'); col.editor = {},
    col = $dg.datagrid('getColumnOption', '店铺型态'); col.editor = {},
    col = $dg.datagrid('getColumnOption', '冻结状态'); col.editor = {},
    col = $dg.datagrid('getColumnOption', '店铺名称'); col.editor = {}
    
    $dg.datagrid();

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

function onDblClickRow(index, rowData) {
    BeginEdit(index, rowData);
}

function onClickCell(rowIndex, field, value) {
    if (rowIndex != editIndex) {
        if (!endEditing()) {
            return;
        }
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
function Save() {

    if (endEditing()) {

        $dg = $("#tab_list");

        var inserted = $dg.datagrid('getChanges', "inserted");
        var deleted = $dg.datagrid('getChanges', "deleted");
        var updated = $dg.datagrid('getChanges', "updated");

        var updateJSON = GetEditJson(inserted, updated, deleted);

        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('d8d6c242-1d70-495f-98a8-03844f27db53'),
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